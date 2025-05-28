#pragma once
#include "llvm/IR/Value.h"
#include "PointerAnalysis.h"
#include <deque>
#include "CallGraph.h"

namespace llvm
{

    class KCallsitePointerAnalysis : public PointerAnalysis
    {
    public:
        unsigned K = 1; // Number of call sites to track for each function

        KCallsitePointerAnalysis();

        // Override processInstruction to propagate call string
        void processInstruction(Instruction &I, CGNode *cgnode);

        // Override call instruction handlers to propagate call string
        void handleInvokeInst(InvokeInst *II, Instruction &I, CGNode *cgnode);
        void handleCallInst(CallInst *CI, Instruction &I, CGNode *cgnode);

        // context related methods: context is from caller, value is the new callsite, return a new context
        virtual Context getContext(Context context, const Value *newCallSite);
    };

} // namespace llvm