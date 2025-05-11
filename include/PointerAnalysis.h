#ifndef POINTER_ANALYSIS_H
#define POINTER_ANALYSIS_H

#include "llvm/IR/Value.h"
#include "llvm/IR/Type.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Instructions.h"
#include <unordered_map>
#include <unordered_set>
#include <vector>

namespace llvm
{
    class Instruction;
    class Module;
    class StoreInst;
    class LoadInst;
    class BitCastInst;
    class GetElementPtrInst;
    class AllocaInst;

    class PointerAnalysis
    {
    public:
        // Debug flag to enable or disable debugging output
        bool DebugMode = false;

        using PointsToMapTy = std::unordered_map<Value *, std::unordered_set<Value *>>;
        using CallGraphTy = std::unordered_map<Function *, std::unordered_set<Function *>>;

        void analyze(Module &M);
        const PointsToMapTy &getPointsToMap() const;
        const CallGraphTy &getCallGraph() const { return CallGraph; }

        const std::unordered_set<Function *> &getVisitedFunctions() const
        {
            return Visited;
        }

        void clear()
        {
            PointsToMap.clear();
            Visited.clear();
            Worklist.clear();
            FunctionWorklist.clear();
            CallGraph.clear();
        }

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
            Value *src; // Source value
            Value *dst; // Destination value
        };

        std::vector<PtrConstraint> Worklist;      // Worklist for new constraints to visit
        std::vector<Function *> FunctionWorklist; // Worklist for new functions to visit
        PointsToMapTy PointsToMap;
        CallGraphTy CallGraph;                          // Call graph to track caller-callee relationships
        std::unordered_set<Function *> Visited;         // visited functions
        std::unordered_map<Function *, int> VisitCount; // Track the number of visits for each function

        void AddToFunctionWorklist(Function *callee);
        void processVtable(GlobalVariable &GV);
        void visitFunction(Function *F);
        void processInstruction(Instruction &I);
        void handleStore(StoreInst *SI);
        void handleLoad(LoadInst *LI);
        void handleAlloca(AllocaInst *AI);
        void handleBitCast(BitCastInst *BC);
        void handleGEP(GetElementPtrInst *GEP);
        void handlePHINode(PHINode *PN);
        void handleAtomicRMW(AtomicRMWInst *ARMW);
        void handleAtomicCmpXchg(AtomicCmpXchgInst *ACX);
        void resolveVtable(Value *vtable);
        void solveConstraints();

        std::unordered_set<std::string> TaggedStrings;                                       // tagged objects from json
        std::unordered_set<Value *> TaintedObjects;                                          // tainted objects from LLVM IR
        std::unordered_map<Value *, std::unordered_set<Value *>> TaintedObjectToPointersMap; // Map to track tainted objects and the pointers which point to them
        void parseTaintConfig();
        void processGlobalVar(GlobalVariable &GV);
        void getPtrsPTSIncludeTaintedObjects();
    };

} // namespace llvm

#endif
