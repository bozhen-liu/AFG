#include "OriginPointerAnalysis.h"
#include "llvm/Demangle/Demangle.h"
#include "Flags.h"

using namespace llvm;

static bool isThreadRelatedCallInstruction(const Value *callsite)
{
    if (const auto *call = dyn_cast<CallBase>(callsite))
    {
        if (const Function *callee = call->getCalledFunction())
        {
            std::string mangledName = callee->getName().str();
            std::string demangled = llvm::demangle(mangledName); // the output looks like "std::thread::spawn::hc6f148c1a1888888"
            // Remove hash suffix: keep up to the last "::"
            size_t last_colon = demangled.rfind("::");
            if (last_colon != std::string::npos)
            {
                demangled = demangled.substr(0, last_colon);
            }

            if (DebugMode)
                errs() << "Demangled name: " << demangled << "\n";

            return (demangled == "std::thread::spawn" ||
                    demangled == "tokio::task::spawn");
        }
    }
    return false;
}

Context OriginPointerAnalysis::getContext(Context context, const Value *newCallSite)
{
    if (isThreadRelatedCallInstruction(newCallSite))
    {
        errs() << "hit\n";
        Context newContext = context;
        newContext.values.push_back(newCallSite);
        if (newContext.values.size() > K)
        {
            newContext.values.pop_front();
        }

        // if (DebugMode)
        errs() << "New origin context for call site: " << newContext << "\n";

        return newContext;
    }
    return context;
}
