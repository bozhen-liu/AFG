#pragma once
#include "KCallsitePointerAnalysis.h"
#include <deque>
#include "CallGraph.h"

namespace llvm
{

    class OriginPointerAnalysis : public KCallsitePointerAnalysis
    {
    public:
        OriginPointerAnalysis(unsigned k) : KCallsitePointerAnalysis(k) {}

        const std::unordered_map<Node *, std::unordered_set<Node *>> getTaintedObjectToPointersMap() const
        {
            return TaintedObjectToPointersMap;
        }
        void printTaintedObjects(std::ofstream &os) const;
        void getPtrsPTSIncludeTaintedObjects();

        void analyze(Module &M) override
        {
            // Parse the taint configuration file to get tagged strings and tainted objects
            if (!parseTaintConfig(M)) {
                return;
            }

            // Call the base class analyze method
            KCallsitePointerAnalysis::analyze(M);
            getPtrsPTSIncludeTaintedObjects();
        }

        // Override getContext to only use thread creation and tokio::task::spawn as context
        Context getContext(Context context, const Value *newCallSite) override;

        void processInstruction(Instruction &I, CGNode *cgnode) override
        {
            CurrentCGNode = cgnode;
            CurrentContext = getContext(cgnode->context, &I);
            visit(I); // Will use base class visit* unless overridden here
        }

        // // Override call instruction handlers to propagate call string
        // void visitInvokeInst(InvokeInst &II) override;
        // void visitCallInst(CallInst &CI) override;
        void processGlobalVar(GlobalVariable &GV) override;
        void visitAllocaInst(AllocaInst &AI) override;

    protected:
        // the following for tainted input
        std::string taintJsonFile;     // JSON file name
        std::unordered_set<std::string> TaggedStrings;                                     // tagged objects from json
        std::unordered_set<Value *> TaintedObjects;                                        // tainted objects from LLVM IR
        std::unordered_map<Node *, std::unordered_set<Node *>> TaintedObjectToPointersMap; // Map to track tainted objects and the pointers which point to them
        bool parseTaintConfig(Module &M);

    };

} // namespace llvm
