#pragma once
#include "llvm/IR/Value.h"
#include "PointerAnalysis.h"
#include <deque>
#include "CallGraph.h"

namespace llvm
{

    constexpr unsigned K = 1;

    class KCallsitePointerAnalysis : public PointerAnalysis
    {
    public:
        KCallsitePointerAnalysis();

        void onthefly();

        // Override function visiting to propagate call string
        void visitFunction(Function *F, Context context);

        // Override processInstruction to propagate call string
        void processInstruction(Instruction &I, Context context);
    };

} // namespace llvm