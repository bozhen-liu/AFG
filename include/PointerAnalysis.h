#ifndef POINTER_ANALYSIS_H
#define POINTER_ANALYSIS_H

#include "llvm/IR/Value.h"
#include "llvm/IR/Type.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/InstVisitor.h"
#include <unordered_map>
#include <unordered_set>
#include <vector>
#include <utility>
#include <deque>
#include "CallGraph.h"

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
        int id;             // Unique node ID
        llvm::Value *value; // The LLVM value
        Context context;    // The context

        // Constructor
        Node(int nodeId, llvm::Value *v, Context ctx = Everywhere) : id(nodeId), value(v), context(ctx) {}

        // Equality operator for unordered_map/unordered_set
        bool operator==(const Node &other) const
        {
            return value == other.value && context == other.context && id == other.id;
        }

        void print(llvm::raw_ostream &os) const
        {
            os << "[Node id=" << id << ", value=";
            if (value)
                value->print(os);
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
        Store
    };

    struct PtrConstraint
    {
        ConstraintType type;
        Node *src; // Source value
        Node *dst; // Destination value
    };

    class PointerAnalysis : public InstVisitor<PointerAnalysis>
    {
    public:
        // Debug flag to enable or disable debugging output
        bool DebugMode = false;

        using PointsToMapTy = std::unordered_map<Node *, std::unordered_set<Node *>>;

        virtual void analyze(Module &M);
        const PointsToMapTy &getPointsToMap() const;
        const CallGraph &getCallGraph() const { return callGraph; }
        const std::unordered_set<Function *> &getVisitedFunctions() const
        {
            return Visited;
        }

        const std::string getOutputFileName() const { return outputFile; }

        const void printStatistics();

        void clear()
        {
            pointsToMap.clear();
            Visited.clear();
            Worklist.clear();
            FunctionWorklist.clear();
            callGraph.clear();
        }

        virtual Context getContext(Context context, const Value *newCallSite = nullptr);
        virtual void processInstruction(Instruction &I, CGNode *cgnode);

        // Visitor methods
        void visitStoreInst(StoreInst &I);
        void visitLoadInst(LoadInst &I);
        virtual void visitAllocaInst(AllocaInst &I);
        void visitBitCastInst(BitCastInst &I);
        void visitGetElementPtrInst(GetElementPtrInst &I);
        void visitPHINode(PHINode &I);
        void visitAtomicRMWInst(AtomicRMWInst &I);
        void visitAtomicCmpXchgInst(AtomicCmpXchgInst &I);
        virtual void visitInvokeInst(InvokeInst &I);
        virtual void visitCallInst(CallInst &I);
        void visitInstruction(Instruction &I); // fallback

        void printPointsToMap(std::ofstream &os) const;

    protected:
        int nextNodeId = 0;     // Monotonically increasing node ID
        llvm::Function *mainFn; // Real main function, not the one "main" for rust

        PointsToMapTy pointsToMap;
        llvm::CallGraph callGraph;                  // Call graph to track caller-callee relationships
        std::unordered_set<Function *> Visited;     // visited functions
        std::unordered_map<CGNode, int> VisitCount; // Track the number of visits for each function/cgnode
        std::vector<CGNode> FunctionWorklist;       // Worklist for new functions (with context) to visit

        std::unordered_map<std::pair<llvm::Value *, Context>, Node *> ValueContextToNodeMap; // Map to track Value and context pairs to Node

        Node *getOrCreateNode(llvm::Value *value, Context context = Everywhere); // create or find node: ctx == Everywhere
        void AddToFunctionWorklist(CGNode *callee);
        void processVtable(GlobalVariable &GV);
        virtual void processGlobalVar(GlobalVariable &GV);
        void resolveVtable(Value *vtable);
        void visitFunction(CGNode *cgnode);

        // used to track the current context and CGNode during analysis
        CGNode *CurrentCGNode = nullptr;
        Context CurrentContext;

        std::vector<PtrConstraint> Worklist; // Worklist for new constraints to visit
        void solveConstraints();

        std::string inputDir;          // Directory containing the JSON file
        std::string outputFile;        // Output file name
        bool parseInputDir(Module &M); // Parse the input directory from the module
        bool parseOutputDir(Module &M); // Parse the output file path from the module

        llvm::Function *parseMainFn(Module &M); // Parse the main function from the module
        void onthefly(Module &M);               // On-the-fly analysis
    };

} // namespace llvm

#endif
