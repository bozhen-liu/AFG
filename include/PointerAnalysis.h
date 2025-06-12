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
#include "ChannelSemantics.h"

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

    struct Node
    {
        uint64_t id;                      // Unique node ID
        llvm::Value *value;               // The LLVM value
        Context context;                  // The context
        std::vector<uint64_t> offsets;    // For field-sensitive analysis, stores the offsets of the fields
        std::unordered_set<uint64_t> pts; // Points-to set (final)

        // used during solving and propogating
        std::unordered_set<uint64_t> diff; // newly added nodes into points-to set; will be added to pts after propogation and reset for next iteration

        // Constructor
        Node(int nodeId, llvm::Value *v, Context ctx = Everywhere, std::vector<uint64_t> idx = {}) : id(nodeId), value(v), context(ctx), offsets(std::move(idx)) {}

        // Equality operator for unordered_map/unordered_set
        bool operator==(const Node &other) const
        {
            return value == other.value && context == other.context && id == other.id && offsets == other.offsets;
        }

        void print(llvm::raw_ostream &os) const
        {
            os << "[Node id=" << id << ", value=";
            if (value)
            {
                if (auto f = dyn_cast<Function>(value))
                {
                    os << f->getName();
                }
                else
                {
                    value->print(os);
                }
            }
            else
                os << "null";
            os << ", context=";
            os << "[";
            if (context == Everywhere)
            {
                os << "Everywhere";
            }
            else
            {

                for (auto it = context.begin(); it != context.end(); ++it)
                {
                    if (*it)
                        (*it)->print(os);
                    else
                        os << "null";
                    if (std::next(it) != context.end())
                        os << ", ";
                }
            }
            os << "]";
            if (!offsets.empty())
            {
                os << ", indices=["; // or fields
                for (size_t i = 0; i < offsets.size(); ++i)
                {
                    os << offsets[i];
                    if (i + 1 < offsets.size())
                        os << ",";
                }
                os << "]";
            }
            os << ", pts=[";
            if (pts.empty())
            {
                os << "empty";
            }
            else
            {
                for (auto it = pts.begin(); it != pts.end(); ++it)
                {
                    os << *it;
                    if (std::next(it) != pts.end())
                        os << ",";
                }
            }
            os << "]";
            if (!diff.empty())
            {
                os << ", diff=[";
                for (auto it = diff.begin(); it != diff.end(); ++it)
                {
                    os << *it;
                    if (std::next(it) != diff.end())
                        os << ",";
                }
                os << "]";
            }
            os << "]";
        }
    };

    // Overload operator<< for Node as a free function
    inline llvm::raw_ostream &operator<<(llvm::raw_ostream &os, const llvm::Node &node)
    {
        node.print(os);
        return os;
    }

    enum ConstraintType
    {
        Assign,    // copy
        AddressOf, // address of, e.g., %b = &%a
        Offset,    // offset, e.g., %b = getelementptr %a, 0, 1
        Load,
        Store,
        Invoke, // dynamic dispatch
        Channel // used when considering channel ops
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
            case Channel:
                typeStr = "Channel";
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

    class PointerAnalysis : public InstVisitor<PointerAnalysis>
    {
    public:
        // Debug flag to enable or disable debugging output
        bool DebugMode = false;

        virtual void analyze(Module &M);
        const CallGraph &getCallGraph() const { return callGraph; }
        const std::unordered_set<Function *> &getVisitedFunctions() const
        {
            return Visited;
        }
        const std::string getOutputFileName() const { return outputFile; }

        const void printStatistics();
        void printPointsToMap(std::ofstream &os) const;

        void clear()
        {
            idToNodeMap.clear();
            Visited.clear();
            Worklist.clear();
            FunctionWorklist.clear();
            vtableToFunctionMap.clear();
            ValueContextToNodeMap.clear();
            callGraph.clear();
        }

        std::vector<Constraint> Worklist; // Worklist for new constraints to visit

        Node *getOrCreateNode(llvm::Value *value, Context context = Everywhere, std::vector<uint64_t> indices = {}); // create or find node: ctx == Everywhere
        Node *getNodebyID(uint64_t id);                                                                              // Get node by ID
        virtual Context getContext(Context context = Everywhere, const Value *newCallSite = nullptr);
        virtual void processInstruction(Instruction &I, CGNode *cgnode);

        // Visitor methods
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
        void visitInstruction(Instruction &I); // fallback

        void processAssignConstraint(const llvm::Constraint &constraint);
        void processAddressOfConstraint(const llvm::Constraint &constraint);
        void processGEPConstraint(const llvm::Constraint &constraint); // Process GEP constraints
        void processLoadConstraint(const llvm::Constraint &constraint);
        void processStoreConstraint(const llvm::Constraint &constraint);
        void processInvokeConstraints(const llvm::Constraint &constraint);                      // Process constraints for indirect invoke instructions
        void handleDeclaredFunction(CallBase &CI, Function *F, CGNode realCaller = NullCGNode); // Handle certain declared functions: call invoked through vtable needs realCaller

        ChannelSemantics channelSemantics; // Channel semantics integration

    protected:
        uint64_t nextNodeId = 0; // Monotonically increasing node ID
        llvm::Function *mainFn;  // Real main function, not the one "main" for rust

        std::unordered_map<uint64_t, Node *> idToNodeMap; // Map from node ID to Node
        llvm::CallGraph callGraph;                        // Call graph to track caller-callee relationships
        std::unordered_set<Function *> Visited;           // visited functions
        std::unordered_map<CGNode, int> VisitCount;       // Track the number of visits for each function/cgnode
        std::vector<CGNode> FunctionWorklist;             // Worklist for new functions (with context) to visit

        std::unordered_map<std::tuple<llvm::Value *, Context, std::vector<uint64_t>>, Node *> ValueContextToNodeMap; // Map to track Value and context pairs to Node
        std::unordered_map<ConstantAggregate *, std::vector<Function *>> vtableToFunctionMap;                        // Map to track vtable to function mappings

        std::vector<llvm::Function *> getVtable(GlobalVariable *GV); // compute vtable's functions and store to vtableToFunctionMap
        void AddToFunctionWorklist(CGNode *callee);
        virtual void processGlobalVar(GlobalVariable &GV);
        void visitFunction(CGNode *cgnode);

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

        // Channel-specific analysis methods
        bool handleChannelOperation(CallInst &CI);
        bool handleChannelConstraints();
    };

} // namespace llvm

#endif
