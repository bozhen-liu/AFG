#include "PointerAnalysis.h"
#include "KCallsitePointerAnalysis.h"
#include "OriginPointerAnalysis.h"
#include "llvm/IR/Module.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Support/raw_ostream.h"
#include "Flags.h"
#include <sstream>
#include <fstream>
#include <chrono>

using namespace llvm;

namespace
{
    class PointerAnalysisPass : public PassInfoMixin<PointerAnalysisPass>
    {
    public:
        PreservedAnalyses run(Module &M, ModuleAnalysisManager &)
        {
            std::unique_ptr<PointerAnalysis> PA;
            if (AnalysisMode == "kcs")
            {
                PA = std::make_unique<KCallsitePointerAnalysis>(KValue, M);
                errs() << "Running k-callsite-sensitive pointer analysis with k = " << KValue << "\n";
            }
            else if (AnalysisMode == "origin")
            {
                PA = std::make_unique<OriginPointerAnalysis>(KValue, M);
                errs() << "Running origin pointer analysis with k = " << KValue << "\n";
            }
            else // Default to context-insensitive analysis
            {
                PA = std::make_unique<PointerAnalysis>(M);
                errs() << "Running context-insensitive pointer analysis\n";
            }
            PA->DebugMode = DebugMode;                     // Set the debug mode based on the command line option
            PA->MaxVisit = MaxVisit;                       // Set the maximum visit count
            PA->HandleIndirectCalls = HandleIndirectCalls; // Set whether to handle indirect calls

            auto start = std::chrono::high_resolution_clock::now(); // Start timing

            PA->analyze();

            auto end = std::chrono::high_resolution_clock::now(); // End timing
            std::chrono::duration<double> elapsed = end - start;

            if (OutputToFile)
            {
                PA->outputToFile(); // Output the results to a file
            }

            errs() << "=== Pointer Analysis Time ===\n"
                   << elapsed.count() << " seconds\n";

            PA->printStatistics(); // Print statistics to stderr

            // Indicate that the pass does not modify the IR
            return PreservedAnalyses::all();
        }
    };
} // namespace

// Register the pass with the new pass manager
extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo llvmGetPassPluginInfo()
{
    return {
        LLVM_PLUGIN_API_VERSION, "PointerAnalysisPass", "v0.1",
        [](PassBuilder &PB)
        {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, ModulePassManager &MPM, ArrayRef<PassBuilder::PipelineElement>)
                {
                    if (Name == "pap")
                    {
                        MPM.addPass(PointerAnalysisPass());
                        return true;
                    }
                    return false;
                });
        }};
}
