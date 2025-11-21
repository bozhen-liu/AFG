#ifndef POINTER_ANALYSIS_H
#define POINTER_ANALYSIS_H

#include "llvm/IR/Value.h"
#include "llvm/IR/Type.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/InstVisitor.h"
#include <unordered_map>
#include <unordered_set>
#include <tuple>
#include <vector>
#include <utility>
#include <functional>
#include <deque>
#include "CallGraph.h"
#include "Flags.h"
#include "nodes/Node.h"
#include "nodes/AllocNode.h"
#include "FieldSensitiveMemModel.h"

namespace std
{
    template <>
    struct hash<std::vector<uint64_t>>
    {
        std::size_t operator()(const std::vector<uint64_t> &v) const noexcept
        {
            std::size_t h = 0;
            for (auto x : v)
                h ^= std::hash<uint64_t>()(x) + 0x9e3779b9 + (h << 6) + (h >> 2);
            return h;
        }
    };

    template <>
    struct hash<std::tuple<llvm::Value *, llvm::Context>>
    {
        std::size_t operator()(const std::tuple<llvm::Value *, llvm::Context> &t) const noexcept
        {
            std::size_t h1 = std::hash<llvm::Value *>()(std::get<0>(t));
            std::size_t h2 = std::hash<llvm::Context>()(std::get<1>(t));
            return h1 ^ (h2 << 1);
        }
    };

    template <>
    struct hash<std::tuple<llvm::Value *, llvm::Context, std::vector<uint64_t>>>
    {
        std::size_t operator()(const std::tuple<llvm::Value *, llvm::Context, std::vector<uint64_t>> &t) const noexcept
        {
            std::size_t h1 = std::hash<llvm::Value *>()(std::get<0>(t));
            std::size_t h2 = std::hash<llvm::Context>()(std::get<1>(t));
            std::size_t h3 = std::hash<std::vector<uint64_t>>()(std::get<2>(t));
            return h1 ^ (h2 << 1) ^ (h3 << 2);
        }
    };

    template <>
    struct hash<std::pair<uint64_t, std::vector<uint64_t>>>
    {
        std::size_t operator()(const std::pair<uint64_t, std::vector<uint64_t>> &p) const
        {
            std::size_t h1 = std::hash<uint64_t>{}(p.first);
            std::size_t h2 = 0;
            for (auto val : p.second)
            {
                h2 ^= std::hash<uint64_t>{}(val) + 0x9e3779b9 + (h2 << 6) + (h2 >> 2);
            }
            return h1 ^ (h2 << 1);
        }
    };
}

namespace llvm
{
    class Instruction;
    class Module;
    class StoreInst;
    class LoadInst;
    class BitCastInst;
    class GetElementPtrInst;
    class AllocaInst;
    class ChannelSemantics;

    enum ConstraintType
    {
        Assign,    // copy
        AddressOf, // address of, e.g., %b = &%a
        Offset,    // offset, e.g., %b = getelementptr %a, 0, 1
        Load,
        Store,
        Invoke, // dynamic dispatch
    };

    struct Constraint // use UINT64_MAX for null
    {
        ConstraintType type;
        uint64_t lhs_id; // Source/LHS Node ID
        uint64_t rhs_id; // Destination/RHS Node ID

        std::vector<uint64_t> offsets; // For field-sensitive analysis, field offsets

        Constraint(ConstraintType t, uint64_t s, uint64_t d, std::vector<uint64_t> idx = {})
            : type(t), lhs_id(s), rhs_id(d), offsets(std::move(idx)) {}

        // Equality operator for unordered_map/unordered_set
        bool operator==(const Constraint &other) const
        {
            return type == other.type && lhs_id == other.lhs_id && rhs_id == other.rhs_id && offsets == other.offsets;
        }

        void print(llvm::raw_ostream &os) const
        {
            const char *typeStr = nullptr;
            switch (type)
            {
            case Assign:
                typeStr = "Assign";
                break;
            case AddressOf:
                typeStr = "AddressOf";
                break;
            case Offset:
                typeStr = "Offset";
                break;
            case Load:
                typeStr = "Load";
                break;
            case Store:
                typeStr = "Store";
                break;
            case Invoke:
                typeStr = "Invoke";
                break;
            default:
                typeStr = "Unknown";
                break;
            }
            os << "\t" << typeStr
               << " src=";
            if (lhs_id != UINT64_MAX)
            {
                os << lhs_id;
            }
            else
            {
                os << "null";
            }
            os << " dst=";
            if (rhs_id != UINT64_MAX)
            {
                os << rhs_id;
            }
            else
            {
                os << "null";
            }
            if (!offsets.empty())
            {
                os << ", offsets=[";
                for (size_t i = 0; i < offsets.size(); ++i)
                {
                    os << offsets[i];
                    if (i + 1 < offsets.size())
                        os << ",";
                }
                os << "]";
            }
        }
    };

    // Overload operator<< for Node as a free function
    inline llvm::raw_ostream &operator<<(llvm::raw_ostream &os, const llvm::Constraint &c)
    {
        c.print(os);
        return os;
    }

    // PointerAnalysis class: performs pointer analysis on LLVM IR
    class PointerAnalysis : public InstVisitor<PointerAnalysis>
    {
    public:
        // settings
        bool DebugMode = false;          // Debug flag to enable or disable debugging output
        int MaxVisit = 2;                // Maximum number of times a CGNode can be visited
        bool HandleIndirectCalls = true; // Whether to handle indirect calls
        bool TaintingEnabled = false;    // Enable tainting analysis
        Module &M;

        PointerAnalysis(Module &M) : M(M)
        {
            if (DebugMode)
                llvm::errs() << "PointerAnalysis initialized with module: " << M.getName() << "\n";
        }

        ~PointerAnalysis()
        {
            idToNodeMap.clear();
            Visited.clear();
            Worklist.clear();
            FunctionWorklist.clear();
            vtableToFunctionMap.clear();
            ValueContextToNodeMap.clear();
            ValueContextToAllocNodeMap.clear();
            callGraph.clear();
            DU.clear();

            channelSemantics = nullptr;

            delete fieldModel;
            fieldModel = nullptr;
            AllocNode::fieldModel = nullptr;

            if (DebugMode)
                llvm::errs() << "PointerAnalysis destroyed\n";
        }

        void analyze();
        const CallGraph &getCallGraph() const { return callGraph; }
        const std::unordered_set<Function *> &getVisitedFunctions() const
        {
            return Visited;
        }
        const std::unordered_map<uint64_t, Node *> &getIdToNodeMap() const { return idToNodeMap; }
        const std::string getOutputFileName() const { return outputFile; }

        const void outputToFile(); // Output the results to a file
        const void printStatistics();
        void printPointsToMap(std::ofstream &os) const;

        std::vector<Constraint> Worklist; // Worklist for new constraints to visit
        virtual Context getContext(Context context = Everywhere, const Value *newCallSite = nullptr) { return Everywhere; }
        Node *getNodebyID(uint64_t id);                                                                              // Get node by ID
        Node *getOrCreateNode(llvm::Value *value, Context context = Everywhere, std::vector<uint64_t> indices = {}); // create or find pointer node: ctx == Everywhere
        AllocNode *getOrCreateAllocNode(llvm::Value *value, Context context = Everywhere);                           // create or find alloc node
        AllocType getAllocTypeFromValue(llvm::Value *value);                                                         // Helper function to determine AllocType from llvm::Value

        // Field-sensitive memory model related
        FieldSensitiveMemModel *fieldModel;
        void initializeFieldSensitiveModel();

        // Visitor methods
        virtual void processInstruction(Instruction &I, CGNode *cgnode)
        {
            CurrentCGNode = cgnode;
            CurrentContext = getContext(cgnode->context, &I);
            visit(I); // Will use base class visit* unless overridden here
        }
        void visitStoreInst(StoreInst &I);
        void visitLoadInst(LoadInst &I);
        virtual void visitAllocaInst(AllocaInst &I);
        void visitBitCastInst(BitCastInst &I);
        void visitUnaryOperator(UnaryOperator &UO);
        void visitGetElementPtrInst(GetElementPtrInst &I);
        void visitExtractValueInst(ExtractValueInst &EVI);
        void visitPHINode(PHINode &I);
        void visitAtomicRMWInst(AtomicRMWInst &I);
        void visitAtomicCmpXchgInst(AtomicCmpXchgInst &I);
        virtual void visitInvokeInst(InvokeInst &I);
        virtual void visitCallInst(CallInst &I);
        void visitReturnInst(ReturnInst &I);
        void addConstraintForCall(CallBase &CB, Function *F); // Add constraints for call instructions, including parameters and return value
        void visitInstruction(Instruction &I);                // fallback

        void processAssignConstraint(const llvm::Constraint &constraint);
        void processAddressOfConstraint(const llvm::Constraint &constraint);
        void processGEPConstraint(const llvm::Constraint &constraint); // Process GEP constraints
        void processLoadConstraint(const llvm::Constraint &constraint);
        void processStoreConstraint(const llvm::Constraint &constraint);
        void processInvokeConstraints(const llvm::Constraint &constraint);                             // Process constraints for indirect invoke instructions
        bool handleRustTry(CallBase &CB, Function *F);                                                 // handle __rust_try
        void handleSpecialDeclaredFunction(CallBase &CI, Function *F, CGNode realCaller = NullCGNode); // Handle certain declared functions: call invoked through vtable needs realCaller

        // Channel semantics integration
        ChannelSemantics *channelSemantics;
        void initializeChannelSemantics();

        void printTaintedNodes(std::ofstream &outFile);

    protected:
        uint64_t nextNodeId = 0; // Monotonically increasing node ID
        llvm::Function *mainFn;  // Real main function, not the one "main" for rust

        std::unordered_map<uint64_t, Node *> idToNodeMap; // Map from node ID to Node
        llvm::CallGraph callGraph;                        // Call graph to track caller-callee relationships
        std::unordered_set<Function *> Visited;           // visited functions
        std::unordered_map<CGNode, int> VisitCount;       // Track the number of visits for each function/cgnode
        std::vector<CGNode> FunctionWorklist;             // Worklist for new functions (with context) to visit

        std::unordered_map<std::tuple<llvm::Value *, Context, std::vector<uint64_t>>, Node *> ValueContextToNodeMap; // Map to track Value and context pairs to Node
        std::unordered_map<std::tuple<llvm::Value *, Context>, AllocNode *> ValueContextToAllocNodeMap;              // Map to track Value and context pairs to AllocNode
        std::unordered_map<ConstantAggregate *, std::vector<Function *>> vtableToFunctionMap;                        // Map to track vtable to function mappings

        std::vector<llvm::Function *> getVtable(GlobalVariable *GV); // compute vtable's functions and store to vtableToFunctionMap
        bool excludeFunctionFromAnalysis(Function *F);               // Exclude certain functions from analysis, e.g., llvm.dbg.declare
        void AddToFunctionWorklist(CGNode *callee);
        virtual void processGlobalVar(GlobalVariable &GV);
        void visitFunction(CGNode *cgnode);
        bool useParamAsReturnValue(Argument *param); // Check if the first parameter is used as a return value

        // used to track the current context and CGNode during analysis
        CGNode *CurrentCGNode = nullptr;
        Context CurrentContext;

        std::unordered_map<uint64_t, std::vector<Constraint>> DU; // def-use constraints
        void addConstraint(const Constraint &constraint);         // Add a constraint to the worklist and update def-use map
        void sortConstraints();
        void solveConstraints();
        void propagateDiff(uint64_t id); // Propagate the diff set: for all constraints that use dst, push them to Worklist

        std::string inputDir;           // Directory containing the JSON file
        std::string outputFile;         // Output file name
        bool parseInputDir(Module &M);  // Parse the input directory from the module
        bool parseOutputDir(Module &M); // Parse the output file path from the module

        llvm::Function *parseMainFn(Module &M); // Parse the main function from the module
        void onthefly(Module &M);               // On-the-fly analysis

        bool isTypeCompatible(Type *ptrType, Type *allocaType); // Check if the pointer type is compatible with the alloca type

        // Channel-specific analysis methods
        bool handleChannelConstraints();

        // the following for taint analysis
        struct FnSignature
        {
            std::string fn_name;           // package name::function name
            std::vector<std::string> args; // argument types -> impossible to match due to pointer and compiler optimizations
            std::string returnType;        // return type
        };

        std::string taintJsonFile;                             // JSON file name
        std::unordered_set<FnSignature *> TaintedFnSignatures; // tainted function signatures from JSON
        std::unordered_set<uint64_t> TaintedNodeIDs;           // node ids that are tainted
        bool parseTaintConfig(Module &M);
        bool isTaintedFunction(const CallBase &callsite);

        // the following for handling tokio tasks with less constraints
        std::unordered_map<std::string, llvm::Node *> fnName2TaskNodeMap; // Map from function name to task node, e.g., _ZN4demo16spawn_user_query17he2469db56cab90c3E -> sret(%"[async fn body@src/main.rs:14:3: 36:2]") %0 in examples/tokio-demo/src/main.rs
        bool handleTokioTask(CallBase &CB, Function *calledFn);
        bool handleTokioRawVtable(CallBase &CB, Function *F); // handle tokio raw vtable functions
    };

} // namespace llvm

#endif // POINTER_ANALYSIS_H
