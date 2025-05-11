#include "PointerAnalysis.h"
#include "llvm/IR/Module.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Support/raw_ostream.h"
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
            PointerAnalysis PA;
            PA.analyze(M);

            // Output the results to a file
            std::ofstream outFile("output.txt"); // Open the output file

            if (outFile.is_open())
            {
                // Print the names of visited functions
                outFile << "Visited Functions:\n";
                for (const auto *func : PA.getVisitedFunctions())
                {
                    if (func)
                    {
                        outFile << "  - " << func->getName().str() << "\n";
                    }
                }

                outFile << "\n\n\n\nCall Graph:\n";
                const auto &callGraph = PA.getCallGraph();
                for (const auto &entry : callGraph)
                {
                    Function *caller = entry.first;
                    const auto &callees = entry.second;

                    outFile << "Caller: " << caller->getName().str() << "\n";
                    for (Function *callee : callees)
                    {
                        outFile << "  -> Callee: " << callee->getName().str() << "\n";
                    }
                }

                // Iterate through the points-to map and print the results
                outFile << "\n\n\n\nPointer Analysis Results:\n";
                const auto &map = PA.getPointsToMap();
                for (const auto &entry : map)
                {
                    std::string pointerStr;
                    llvm::raw_string_ostream pointerStream(pointerStr);
                    pointerStream << *entry.first; // Use LLVM's raw_ostream to print the pointer
                    pointerStream.flush();

                    // skip printing function pointers
                    if (entry.first->getType()->isFunctionTy())
                    {
                        continue;
                    }

                    outFile << "Pointer: " << pointerStr << "\n";

                    for (auto *target : entry.second)
                    {
                        std::string targetStr;
                        llvm::raw_string_ostream targetStream(targetStr);
                        targetStream << *target; // Use LLVM's raw_ostream to print the target
                        targetStream.flush();

                        outFile << "  -> " << targetStr << "\n";
                    }
                }
                outFile.close(); // Close the file after writing
            }
            else
            {
                errs() << "Error: Could not open file for writing results.\n";
            }

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
