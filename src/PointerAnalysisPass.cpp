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
                PA = std::make_unique<KCallsitePointerAnalysis>(KValue);
                errs() << "Running k-callsite-sensitive pointer analysis with k = " << KValue << "\n";
            }
            else if (AnalysisMode == "origin")
            {
                PA = std::make_unique<OriginPointerAnalysis>(KValue);
                errs() << "Running origin pointer analysis with k = " << KValue << "\n";
            }
            else // Default to context-insensitive analysis
            {
                PA = std::make_unique<PointerAnalysis>();
                errs() << "Running context-insensitive pointer analysis\n";
            }
            PA->DebugMode = DebugMode; // Set the debug mode based on the command line option
            PA->analyze(M);

            // Output the results to a file
            std::ofstream outFile(PA->getOutputFileName()); // Open the output file

            if (outFile.is_open())
            {
                errs() << "Writing pointer analysis results to " << PA->getOutputFileName() << " ...\n";

                if (DebugMode)
                { // Print the names of visited functions
                    outFile << "Visited Functions:\n";
                    for (const auto *func : PA->getVisitedFunctions())
                    {
                        if (func)
                        {
                            outFile << "  - " << func->getName().str() << "\n";
                        }
                    }
                }

                // Print the call graph to the file
                PA->getCallGraph().printCG(outFile);
                // Iterate through the points-to map and print the results
                PA->printPointsToMap(outFile);
                // Print the taint result map
                PA->printTaintedObjects(outFile);

                outFile.close(); // Close the file after writing
            }
            else
            {
                errs() << "Error: Could not open file for writing results.\n";
            }

            PA->printStatistics(); // Print statistics to stderr

            PA->clear(); // Clear the analysis results

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
                    if (Name == "pointer-analysis")
                    {
                        MPM.addPass(PointerAnalysisPass());
                        return true;
                    }
                    return false;
                });
        }};
}
