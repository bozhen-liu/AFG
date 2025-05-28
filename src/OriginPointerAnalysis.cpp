#include "OriginPointerAnalysis.h"
#include "llvm/Demangle/Demangle.h"

using namespace llvm;

static bool isThreadRelatedCallInstruction(const Instruction &I)
{
    if (const auto *call = dyn_cast<CallBase>(&I))
    {
        if (const Function *callee = call->getCalledFunction())
        {
            std::string mangledName = callee->getName().str();
            std::string demangled = llvm::demangle(mangledName);
            errs() << "Demangled name: " << demangled << "\n";
            return (demangled.find("std::thread::spawn") != std::string::npos ||
                    demangled.find("tokio::task::spawn") != std::string::npos);
        }
    }
    return false;
}

Context OriginPointerAnalysis::getContext(Context context, const Instruction *I)
{
    if (isThreadRelatedCallInstruction(*I))
    {
        Context newContext = context;
        newContext.values.push_back(I);
        if (newContext.values.size() > K)
        {
            newContext.values.pop_front();
        }

        if (DebugMode)
            errs() << "New origin context for call site: " << newContext << "\n";

        return newContext;
    }
    return context;
}

void OriginPointerAnalysis::processInstruction(Instruction &I, CGNode *cgnode)
{
    Context context = getContext(cgnode->context, &I);

    if (auto *SI = dyn_cast<StoreInst>(&I))
    {
        handleStore(SI, context);
    }
    else if (auto *LI = dyn_cast<LoadInst>(&I))
    {
        handleLoad(LI, context);
    }
    else if (auto *AI = dyn_cast<AllocaInst>(&I))
    {
        handleAlloca(AI, context);
    }
    else if (auto *BC = dyn_cast<BitCastInst>(&I))
    {
        handleBitCast(BC, context);
    }
    else if (auto *GEP = dyn_cast<GetElementPtrInst>(&I))
    {
        handleGEP(GEP, context);
    }
    else if (auto *PN = dyn_cast<PHINode>(&I))
    {
        handlePHINode(PN, context);
    }
    else if (auto *ARMW = dyn_cast<AtomicRMWInst>(&I))
    {
        handleAtomicRMW(ARMW, context);
    }
    else if (auto *ACX = dyn_cast<AtomicCmpXchgInst>(&I))
    {
        handleAtomicCmpXchg(ACX, context);
    }
    else if (auto *II = dyn_cast<InvokeInst>(&I))
    {
        handleInvokeInst(II, I, cgnode);
    }
    else if (auto *CI = dyn_cast<CallInst>(&I))
    {
        handleCallInst(CI, I, cgnode);
    }
}