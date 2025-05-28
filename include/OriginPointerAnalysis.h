#pragma once
#include "KCallsitePointerAnalysis.h"
#include <deque>
#include "CallGraph.h"

namespace llvm
{

    class OriginPointerAnalysis : public KCallsitePointerAnalysis
    {
    public:
        OriginPointerAnalysis() : KCallsitePointerAnalysis() {}

        // Override getContext to only use thread creation and tokio::task::spawn as context
        Context getContext(Context context, const Instruction *I);

        void processInstruction(Instruction &I, CGNode *cgnode);
    };

} // namespace llvm
