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

        // Override getContext to only use thread creation and tokio::task::spawn as context
        Context getContext(Context context, const Value *newCallSite);

        void processInstruction(Instruction &I, CGNode *cgnode) override
        {
            CurrentCGNode = cgnode;
            CurrentContext = getContext(cgnode->context, &I);
            visit(I); // Will use base class visit* unless overridden here
        }

        // // Override call instruction handlers to propagate call string
        // void visitInvokeInst(InvokeInst &II) override;
        // void visitCallInst(CallInst &CI) override;
    };

} // namespace llvm
