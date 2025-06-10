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
        std::vector<uint64_t> indices;    // For field-sensitive analysis, stores the indices of the fields
        std::unordered_set<uint64_t> pts; // Points-to set

        // Constructor
        Node(int nodeId, llvm::Value *v, Context ctx = Everywhere, std::vector<uint64_t> idx = {}) : id(nodeId), value(v), context(ctx), indices(std::move(idx)) {}

        // Equality operator for unordered_map/unordered_set
        bool operator==(const Node &other) const
        {
            return value == other.value && context == other.context && id == other.id && indices == other.indices;
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
            if (!indices.empty())
            {
                os << ", indices=["; // or fields
                for (size_t i = 0; i < indices.size(); ++i)
                {
                    os << indices[i];
                    if (i + 1 < indices.size())
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
        Assign,
        Load,
        Store,
        Channel // used when considering channel ops
    };

    struct PtrConstraint // use UINT64_MAX for null
    {
        ConstraintType type;
        uint64_t src_id; // Source Node ID
        uint64_t dst_id; // Destination Node ID

        PtrConstraint(ConstraintType t, uint64_t s, uint64_t d)
            : type(t), src_id(s), dst_id(d) {}
    };

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
        const std::unordered_map<uint64_t, Node *> &getIdToNodeMap() const { return idToNodeMap; }
        const std::string getOutputFileName() const { return outputFile; }

        const void printStatistics();
        void printPointsToMap(std::ofstream &os) const;

        void clear()
        {
            idToNodeMap.clear();
            Visited.clear();
            Worklist.clear();
            FunctionWorklist.clear();
            callGraph.clear();
        }

        std::vector<PtrConstraint> Worklist;   // Worklist for new constraints to visit
        const void printLastConstraint() const // Print the last constraint added to the worklist
        {
            if (!Worklist.empty())
            {
                const PtrConstraint &last = Worklist.back();
                const char *typeStr = nullptr;
                switch (last.type)
                {
                case Assign:
                    typeStr = "Assign";
                    break;
                case Load:
                    typeStr = "Load";
                    break;
                case Store:
                    typeStr = "Store";
                    break;
                case Channel:
                    typeStr = "Channel";
                    break;
                default:
                    typeStr = "Unknown";
                    break;
                }
                errs() << "\t Added constraint: " << typeStr
                       << " src=";
                if (last.src_id != UINT64_MAX)
                {
                    errs() << last.src_id;
                    auto it = idToNodeMap.find(last.src_id);
                    auto src = it->second;
                    if (it != idToNodeMap.end() && src && !src->indices.empty())
                    {
                        errs() << " (indices=[";
                        for (size_t i = 0; i < src->indices.size(); ++i)
                        {
                            errs() << src->indices[i];
                            if (i + 1 < src->indices.size())
                                errs() << ",";
                        }
                        errs() << "])";
                    }
                }
                else
                {
                    errs() << "null";
                }
                errs() << " dst=";
                if (last.dst_id != UINT64_MAX)
                {
                    errs() << last.src_id;
                    auto it = idToNodeMap.find(last.dst_id);
                    auto dst = it->second;
                    if (it != idToNodeMap.end() && dst && !dst->indices.empty())
                    {
                        errs() << " (indices=[";
                        for (size_t i = 0; i < dst->indices.size(); ++i)
                        {
                            errs() << dst->indices[i];
                            if (i + 1 < dst->indices.size())
                                errs() << ",";
                        }
                        errs() << "])";
                    }
                }
                else
                {
                    errs() << "null";
                }
                errs() << "\n";
            }
            else
            {
                llvm::errs() << "No constraints in the worklist.\n";
            }
        }

        Node *getOrCreateNode(llvm::Value *value, Context context = Everywhere, std::vector<uint64_t> indices = {}); // create or find node: ctx == Everywhere
        virtual Context getContext(Context context = Everywhere, const Value *newCallSite = nullptr);
        virtual void processInstruction(Instruction &I, CGNode *cgnode);

        // Visitor methods
        void visitStoreInst(StoreInst &I);
        void visitLoadInst(LoadInst &I);
        virtual void visitAllocaInst(AllocaInst &I);
        void visitBitCastInst(BitCastInst &I);
        void visitGetElementPtrInst(GetElementPtrInst &I);
        void visitExtractValueInst(ExtractValueInst &EVI);
        void visitPHINode(PHINode &I);
        void visitAtomicRMWInst(AtomicRMWInst &I);
        void visitAtomicCmpXchgInst(AtomicCmpXchgInst &I);
        virtual void visitInvokeInst(InvokeInst &I);
        virtual void visitCallInst(CallInst &I);
        void visitInstruction(Instruction &I); // fallback

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

        void AddToFunctionWorklist(CGNode *callee);
        void processVtable(GlobalVariable &GV);
        virtual void processGlobalVar(GlobalVariable &GV);
        void resolveVtable(Value *vtable);
        void visitFunction(CGNode *cgnode);

        // used to track the current context and CGNode during analysis
        CGNode *CurrentCGNode = nullptr;
        Context CurrentContext;

        void solveConstraints();
        void processConstraintsUntilFixedPoint();

        std::string inputDir;           // Directory containing the JSON file
        std::string outputFile;         // Output file name
        bool parseInputDir(Module &M);  // Parse the input directory from the module
        bool parseOutputDir(Module &M); // Parse the output file path from the module

        llvm::Function *parseMainFn(Module &M); // Parse the main function from the module
        void onthefly(Module &M);               // On-the-fly analysis

        // Channel-specific analysis methods
        void handleChannelOperation(CallInst &CI);
        bool handleChannelConstraints();
    };

} // namespace llvm

#endif
