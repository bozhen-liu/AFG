#ifndef POINTER_ANALYSIS_H
#define POINTER_ANALYSIS_H

#include "llvm/IR/Value.h"
#include "llvm/IR/Type.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Instructions.h"
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

    class PointerAnalysis
    {
    public:
        // Debug flag to enable or disable debugging output
        bool DebugMode = false;

        using PointsToMapTy = std::unordered_map<Node *, std::unordered_set<Node *>>;

        void analyze(Module &M);
        const PointsToMapTy &getPointsToMap() const;
        const CallGraph &getCallGraph() const { return callGraph; }
        const std::unordered_map<Node *, std::unordered_set<Node *>> getTaintedObjectToPointersMap() const
        {
            return TaintedObjectToPointersMap;
        }

        const std::unordered_set<Function *> &getVisitedFunctions() const
        {
            return Visited;
        }

        const std::string getOutputFileName() const { return outputFile; }

        const void printStatistics();

        void clear()
        {
            PointsToMap.clear();
            Visited.clear();
            Worklist.clear();
            FunctionWorklist.clear();
            callGraph.clear();
        }

    protected:
        int nextNodeId = 0;     // Monotonically increasing node ID
        llvm::Function *mainFn; // Real main function, not the one "main" for rust

        PointsToMapTy PointsToMap;
        llvm::CallGraph callGraph;                      // Call graph to track caller-callee relationships
        std::unordered_set<Function *> Visited;         // visited functions
        std::unordered_map<Function *, int> VisitCount; // Track the number of visits for each function
        std::vector<Function *> FunctionWorklist;       // Worklist for new functions to visit

        std::unordered_map<std::pair<llvm::Value *, Context>, Node *> ValueContextToNodeMap; // Map to track Value and context pairs to Node

        void processInstruction(Instruction &I, Context context = Everywhere);
        void solveConstraints();

    private:
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

        std::string inputDir;          // Directory containing the JSON file
        std::string taintJsonFile;     // JSON file name
        std::string outputFile;        // Output file name
        bool parseInputDir(Module &M); // Parse the input directory from the module

        llvm::Function *parseMainFn(Module &M); // Parse the main function from the module
        void onthefly();                        // On-the-fly analysis

        std::unordered_set<std::string> TaggedStrings;                                     // tagged objects from json
        std::unordered_set<Value *> TaintedObjects;                                        // tainted objects from LLVM IR
        std::unordered_map<Node *, std::unordered_set<Node *>> TaintedObjectToPointersMap; // Map to track tainted objects and the pointers which point to them
        void parseTaintConfig();
        void processGlobalVar(GlobalVariable &GV);
        void getPtrsPTSIncludeTaintedObjects();

        Node *getOrCreateNode(llvm::Value *value, Context context = Everywhere); // create or find node: ctx == Everywhere
        void AddToFunctionWorklist(Function *callee);
        void processVtable(GlobalVariable &GV);
        void resolveVtable(Value *vtable);
        void visitFunction(Function *F, Context context = Everywhere);

        std::vector<PtrConstraint> Worklist; // Worklist for new constraints to visit
        void handleStore(StoreInst *SI, Context context = Everywhere);
        void handleLoad(LoadInst *LI, Context context = Everywhere);
        void handleAlloca(AllocaInst *AI, Context context = Everywhere);
        void handleBitCast(BitCastInst *BC, Context context = Everywhere);
        void handleGEP(GetElementPtrInst *GEP, Context context = Everywhere);
        void handlePHINode(PHINode *PN, Context context = Everywhere);
        void handleAtomicRMW(AtomicRMWInst *ARMW, Context context = Everywhere);
        void handleAtomicCmpXchg(AtomicCmpXchgInst *ACX, Context context = Everywhere);
        void handleInvokeInst(InvokeInst *II, Instruction &I, Context context = Everywhere);
        void handleCallInst(CallInst *CI, Instruction &I, Context context = Everywhere);
    };

} // namespace llvm

#endif
