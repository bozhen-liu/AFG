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
            std::ofstream outFile(PA.getOutputFileName()); // Open the output file

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
                    // entry.first is now a CGNode, entry.second is a set of CGNode
                    const auto caller = callGraph.getNode(entry.first);
                    const auto &callees = entry.second;

                    std::string callerStr;
                    llvm::raw_string_ostream rso(callerStr);
                    rso << caller;
                    rso.flush();
                    outFile << "Caller: " << callerStr << "\n";

                    for (const auto &callee_id : callees)
                    {
                        const auto callee = callGraph.getNode(callee_id);
                        std::string calleeStr;
                        llvm::raw_string_ostream rso(calleeStr);
                        rso << callee;
                        rso.flush();
                        outFile << "  -> Callee: " << calleeStr << "\n";
                    }
                }

                // Iterate through the points-to map and print the results
                outFile << "\n\n\n\nPointer Analysis Results:\n";
                const auto &ptm = PA.getPointsToMap();
                for (const auto &entry : ptm)
                {
                    std::string pointerStr;
                    llvm::raw_string_ostream pointerStream(pointerStr);
                    pointerStream << *entry.first; // Use LLVM's raw_ostream to print the pointer
                    pointerStream.flush();

                    // skip printing function pointers
                    if (entry.first->value->getType()->isFunctionTy())
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

                // Print the taint result map
                outFile << "\n\n\n\nTainted Object to Pointers Map:\n";
                const auto &taint_map = PA.getTaintedObjectToPointersMap();
                for (const auto &entry : taint_map)
                {
                    Value *taintedObject = entry.first->value;
                    const auto &pointers = entry.second;

                    outFile << "Tainted Object: ";
                    {
                        std::string taintedObjectStr;
                        llvm::raw_string_ostream rso(taintedObjectStr);
                        taintedObject->print(rso);
                        rso.flush();
                        outFile << taintedObjectStr << "\n";
                    }

                    for (Node *pointer : pointers)
                    {
                        outFile << "  -> Points from: ";
                        std::string pointerStr;
                        llvm::raw_string_ostream rso(pointerStr);
                        pointer->print(rso);
                        rso.flush();
                        outFile << pointerStr << "\n";
                    }
                }

                outFile.close(); // Close the file after writing
            }
            else
            {
                errs() << "Error: Could not open file for writing results.\n";
            }

            PA.printStatistics(); // Print statistics to stderr

            PA.clear(); // Clear the analysis results

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
