#include "KCallsitePointerAnalysis.h"
#include <utility>

using namespace llvm;

KCallsitePointerAnalysis::KCallsitePointerAnalysis() : PointerAnalysis() {}

void KCallsitePointerAnalysis::onthefly()
{
    FunctionWorklist.push_back(mainFn);
    while (!FunctionWorklist.empty())
    {
        if (DebugMode)
            errs() << "Function worklist size 1: " << FunctionWorklist.size() << "\n";

        while (!FunctionWorklist.empty())
        {
            // Get the next function to visit
            Function *F = FunctionWorklist.back();
            FunctionWorklist.pop_back();

            if (DebugMode)
                errs() << "Visiting function: " << F->getName() << "\n";

            // Visit the function
            visitFunction(F, Everywhere);
        }
        if (DebugMode)
            errs() << "Function worklist size 2: " << FunctionWorklist.size() << "\n";

        // Solve constraints and discover new callees
        solveConstraints();
        if (DebugMode)
            errs() << "Constraints solved.\n";

        if (DebugMode)
            errs() << "Function worklist size 3: " << FunctionWorklist.size() << "\n";
    }
}

void KCallsitePointerAnalysis::visitFunction(Function *F, Context context)
{
    if (!F || F->isDeclaration() || Visited.count(F))
        return;
    VisitCount[F]++;
    if (VisitCount[F] > 2)
        return;
    Visited.insert(F);
    for (BasicBlock &BB : *F)
        for (Instruction &I : BB)
            processInstruction(I, context);
}

void KCallsitePointerAnalysis::processInstruction(Instruction &I, Context context)
{
    // call base logic (optionally pass context if needed)
    PointerAnalysis::processInstruction(I); // or copy logic and use context
}
