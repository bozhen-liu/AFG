#include "PointerAnalysis.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Constants.h"
#include "llvm/Support/raw_ostream.h"
#include <nlohmann/json.hpp> // Include a JSON library like nlohmann/json
#include <fstream>

using json = nlohmann::json;
using namespace llvm;

void PointerAnalysis::analyze(Module &M)
{
    parseTaintConfig(); // once

    // Global variables can store pointers and may be accessed by multiple functions
    for (GlobalVariable &GV : M.globals())
    {
        processGlobalVar(GV);
        processVtable(GV);
    }

    Function *mainFn = M.getFunction("_ZN4demo4main17h3a2356faed25125dE");
    // TODO: locate the real main through M.getFunction("main");
    if (!mainFn || mainFn->isDeclaration())
    {
        errs() << "No main function found or it's only declared.\n";
        return;
    }

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
            visitFunction(F);
        }
        if (DebugMode)
            errs() << "Function worklist size 2: " << FunctionWorklist.size() << "\n";

        // Solve constraints and discover new callees
        solveConstraints();
        if (DebugMode)
            errs() << "Constraints solved.\n";

        // Add newly discovered callees to the worklist
        for (auto &entry : PointsToMap)
        {
            Value *ptr = entry.first;
            auto &targets = entry.second;

            for (Value *target : targets)
            {
                if (Function *callee = dyn_cast<Function>(target))
                {
                    AddToFunctionWorklist(callee);
                }
            }
        }
        if (DebugMode)
            errs() << "Function worklist size 3: " << FunctionWorklist.size() << "\n";
    }

    errs() << "Pointer analysis completed.\n";

    getPtrsPTSIncludeTaintedObjects();
}

void PointerAnalysis::AddToFunctionWorklist(Function *callee)
{
    if (!callee || callee->isDeclaration() || Visited.count(callee))
        return;

    // Only add the function to the worklist if it has been visited fewer than two times
    if (VisitCount[callee] < 2 && !Visited.count(callee))
    {
        if (DebugMode)
            errs() << "Adding function: " << callee->getName() << "\n";

        FunctionWorklist.push_back(callee);
    }
}

void PointerAnalysis::visitFunction(Function *F)
{
    if (!F || F->isDeclaration() || Visited.count(F))
        return;

    // Increment the visit count for the function
    VisitCount[F]++;

    // Skip the function if it has already been visited twice
    if (VisitCount[F] > 2)
        return;

    Visited.insert(F);

    if (DebugMode)
        errs() << "Visiting function: " << F->getName() << "\n";

    for (BasicBlock &BB : *F)
    {
        for (Instruction &I : BB)
        {
            processInstruction(I);
        }
    }
}

void PointerAnalysis::processInstruction(Instruction &I)
{
    // regular instructions
    if (auto *SI = dyn_cast<StoreInst>(&I))
    {
        handleStore(SI);
    }
    else if (auto *LI = dyn_cast<LoadInst>(&I))
    {
        handleLoad(LI);
    }
    else if (auto *AI = dyn_cast<AllocaInst>(&I))
    {
        handleAlloca(AI);
    }
    else if (auto *BC = dyn_cast<BitCastInst>(&I))
    {
        handleBitCast(BC);
    }
    else if (auto *GEP = dyn_cast<GetElementPtrInst>(&I))
    {
        handleGEP(GEP);
    }
    else if (auto *PN = dyn_cast<PHINode>(&I))
    {
        handlePHINode(PN);
    }
    else if (auto *ARMW = dyn_cast<AtomicRMWInst>(&I))
    {
        handleAtomicRMW(ARMW);
    }
    else if (auto *ACX = dyn_cast<AtomicCmpXchgInst>(&I))
    {
        handleAtomicCmpXchg(ACX);
    }
    // // Variadic functions (e.g., printf)
    // else if (auto *VAA = dyn_cast<VAArgInst>(&I))
    // {
    //     if (VAA->getType()->isPointerTy())
    //     {
    //         Worklist.push_back({Assign, VAA->getPointerOperand(), VAA});
    //     }
    // }
    // // Casts between pointers and integers can obscure pointer relationships
    // else if (auto *ITP = dyn_cast<IntToPtrInst>(&I))
    // {
    //     Worklist.push_back({Assign, nullptr, ITP}); // Unknown source
    // }
    // else if (auto *PTI = dyn_cast<PtrToIntInst>(&I))
    // {
    //     // Optional: Handle pointer-to-integer casts if needed
    // }
    else if (auto *II = dyn_cast<InvokeInst>(&I))
    {
        Function *caller = II->getFunction(); // Get the caller function
        Function *calledFn = II->getCalledFunction();
        if (calledFn) // handle direct calls
        {
            // Add to the call graph
            CallGraph[caller].insert(calledFn);

            // Add constraints for parameter passing
            for (unsigned i = 0; i < II->arg_size(); ++i)
            {
                Value *arg = II->getArgOperand(i);
                if (arg->getType()->isPointerTy())
                {
                    Argument *param = calledFn->getArg(i);
                    Worklist.push_back({Assign, arg, param});
                }
            }

            // Visit the callee
            // visitFunction(calledFn);
            AddToFunctionWorklist(calledFn);

            // Add constraints for return value
            if (calledFn->getReturnType()->isPointerTy())
            {
                Worklist.push_back({Assign, calledFn, &I});
            }
        }

        // Handle indirect calls (e.g., via vtable)
        Value *calledValue = II->getCalledOperand();
        if (calledValue->getType()->isPointerTy())
        {
            // Handle indirect calls
            auto &targets = PointsToMap[calledValue];
            for (Value *target : targets)
            {
                if (Function *indirectFn = dyn_cast<Function>(target))
                {
                    // // Debugging: Print II, calledValue, and target
                    // errs() << "InvokeInst: " << *II << "\n";
                    // errs() << "Called Value: " << *calledValue << "\n";
                    // errs() << "Target Function: " << indirectFn->getName() << "\n";

                    // Add to the call graph
                    CallGraph[caller].insert(indirectFn);

                    // Add constraints for parameter passing
                    for (unsigned i = 0; i < II->arg_size(); ++i)
                    {
                        Value *arg = II->getArgOperand(i);
                        if (arg->getType()->isPointerTy())
                        {
                            Argument *param = indirectFn->getArg(i);
                            Worklist.push_back({Assign, arg, param});
                        }
                    }

                    // Visit the indirect callee
                    // visitFunction(indirectFn);
                    AddToFunctionWorklist(calledFn);

                    // Add constraints for return value
                    if (indirectFn->getReturnType()->isPointerTy())
                    {
                        Worklist.push_back({Assign, indirectFn, &I});
                    }
                }
            }
        }
    }
    else if (auto *CI = dyn_cast<CallInst>(&I))
    {
        Function *caller = CI->getFunction(); // Get the caller function
        Function *calledFn = CI->getCalledFunction();
        if (calledFn)
        {
            // Add to the call graph
            CallGraph[caller].insert(calledFn);

            // Add constraints for parameter passing
            for (unsigned i = 0; i < CI->arg_size(); ++i)
            {
                Value *arg = CI->getArgOperand(i);
                if (arg->getType()->isPointerTy())
                {
                    Argument *param = calledFn->getArg(i);
                    Worklist.push_back({Assign, arg, param});
                }
            }

            // Visit the callee
            // visitFunction(calledFn);
            AddToFunctionWorklist(calledFn);

            // Add constraints for return value
            if (calledFn->getReturnType()->isPointerTy())
            {
                Worklist.push_back({Assign, calledFn, &I});
            }
        }
        else if (CI->isInlineAsm())
        {
            // TODO: Conservative handling: assume all pointers may be affected
        }
    }
}

void PointerAnalysis::processVtable(GlobalVariable &GV)
{
    // Check if the global variable name matches the vtable naming pattern
    if (GV.getName().startswith("vtable"))
    {
        if (DebugMode)
            errs() << "Starting to process vtable: " << GV.getName() << "\n";

        if (Constant *initializer = GV.getInitializer())
        {
            // errs() << "Initializer: " << *initializer << "\n";

            if (auto *constStruct = dyn_cast<ConstantStruct>(initializer))
            {
                if (DebugMode)
                    errs() << "Initializer is a ConstantStruct with " << constStruct->getNumOperands() << " operands.\n";
                for (unsigned i = 0; i < constStruct->getNumOperands(); ++i)
                {
                    Value *entry = constStruct->getOperand(i);
                    // errs() << "  Entry " << i << ": " << *entry << "\n";

                    if (Function *fn = dyn_cast<Function>(entry))
                    {
                        PointsToMap[&GV].insert(fn); // Use the Node pointers in PointsToMap

                        if (DebugMode)
                            errs() << "    -> Added function to PointsToMap: " << fn->getName() << "\n";
                    }
                }
            }
            else if (auto *constArray = dyn_cast<ConstantArray>(initializer))
            {
                if (DebugMode)
                    errs() << "Initializer is a ConstantArray with " << constArray->getNumOperands() << " operands.\n";
                for (unsigned i = 0; i < constArray->getNumOperands(); ++i)
                {
                    Value *entry = constArray->getOperand(i);
                    // errs() << "  Entry " << i << ": " << *entry << "\n";

                    if (Function *fn = dyn_cast<Function>(entry))
                    {
                        PointsToMap[&GV].insert(fn); // Use the Node pointers in PointsToMap

                        if (DebugMode)
                            errs() << "    -> Added function to PointsToMap: " << fn->getName() << "\n";
                    }
                }
            }
            else
            {
                errs() << "Unhandled initializer type: " << *initializer << "\n";
            }
        }
        else
        {
            errs() << "  Vtable has no initializer.\n";
        }

        if (DebugMode)
            errs() << "Finished processing vtable: " << GV.getName() << "\n";
    }
}

void PointerAnalysis::processGlobalVar(GlobalVariable &GV)
{
    // Check if the global variable is a pointer type
    if (GV.getType()->isPointerTy())
    {
        // Convert the GlobalVariable to a string for comparison
        std::string gvStr;
        llvm::raw_string_ostream rso(gvStr);
        GV.print(rso); // Use print to get the full LLVM IR representation
        rso.flush();

        // Check if the GlobalVariable matches a tagged object
        if (TaggedStrings.count(gvStr))
        {
            errs() << "(GlobalVariable) Found tainted string: " << gvStr << "\n";

            // Assign this to the tagged object
            if (TaintedObjects.find(&GV) == TaintedObjects.end())
            {
                TaintedObjects.insert(&GV);
                errs() << "Found tainted object \"" << &GV << "\" to tainted string: " << gvStr << "\n";
            }

            // Use the node (GV) to create constraints
            Worklist.push_back({Assign, nullptr, &GV});

            if (DebugMode)
                errs() << "Added tainted global variable \"" << gvStr << "\" to the worklist.\n";
        }
        else
        {
            // Handle non-tagged global variables
            Worklist.push_back({Assign, nullptr, &GV}); // Points to self

            if (DebugMode)
                errs() << "Added global variable \"" << gvStr << "\" to the worklist.\n";
        }
    }
}

void PointerAnalysis::handleStore(StoreInst *SI)
{
    Value *val = SI->getValueOperand();
    Value *ptr = SI->getPointerOperand();
    if (val->getType()->isPointerTy())
    {
        Worklist.push_back({Store, val, ptr});
    }
}

void PointerAnalysis::handleLoad(LoadInst *LI)
{
    Value *ptr = LI->getPointerOperand();
    if (LI->getType()->isPointerTy())
    {
        Worklist.push_back({Load, ptr, LI});
    }
}

// Helper function to trim leading and trailing spaces
static inline std::string trim(const std::string &str)
{
    auto start = str.find_first_not_of(" \t");
    auto end = str.find_last_not_of(" \t");
    return (start == std::string::npos) ? "" : str.substr(start, end - start + 1);
}

void PointerAnalysis::handleAlloca(AllocaInst *AI)
{
    // Convert the alloca to a string for comparison
    std::string aiStr;
    llvm::raw_string_ostream rso(aiStr);
    AI->print(rso); // Use print to get the full LLVM IR representation -> TODO: this has leading or trailing spaces
    rso.flush();

    // Trim leading and trailing spaces
    aiStr = trim(aiStr);

    if (DebugMode)
        errs() << "Processing alloca: " << aiStr << "\n";

    // Check if the alloca matches a tagged object
    if (TaggedStrings.count(aiStr))
    {
        errs() << "(Alloca) Found tainted string: " << aiStr << "\n";
        // Assign this to the tagged object
        if (TaintedObjects.find(AI) == TaintedObjects.end())
        {
            TaintedObjects.insert(AI);
            errs() << "Found tainted object \"" << AI << "\" to tainted string: " << aiStr << "\n";
        }

        Worklist.push_back({Assign, nullptr, AI}); // Points to self
        errs() << "Added alloca \"" << AI << "\" to the worklist with context \"" << AI << "\".\n";
    }
    else
    {
        // Handle non-tagged allocas
        Worklist.push_back({Assign, nullptr, AI}); // Points to self
    }
}

void PointerAnalysis::handleBitCast(BitCastInst *BC)
{
    if (BC->getType()->isPointerTy())
    {
        Worklist.push_back({Assign, BC->getOperand(0), BC});
    }
}

void PointerAnalysis::handleGEP(GetElementPtrInst *GEP)
{
    if (GEP->getType()->isPointerTy())
    {
        Value *basePtr = GEP->getPointerOperand();
        Worklist.push_back({Assign, basePtr, GEP});

        // Handle struct field or array access
        for (auto idx = GEP->idx_begin(); idx != GEP->idx_end(); ++idx)
        {
            if (auto *constIdx = dyn_cast<ConstantInt>(idx))
            {
                // errs() << "GEP index: " << constIdx->getValue() << "\n";

                // Generate constraints for array or struct field access
                // For simplicity, treat all derived pointers as pointing to the base
                Worklist.push_back({Assign, basePtr, GEP});
            }
            else
            {
                // errs() << "GEP index is not a constant.\n";

                // Non-constant index: conservatively assume it may point anywhere
                Worklist.push_back({Assign, basePtr, GEP});
            }
        }
    }
}

void PointerAnalysis::handlePHINode(PHINode *PN)
{
    if (PN->getType()->isPointerTy())
    {
        for (unsigned i = 0; i < PN->getNumIncomingValues(); ++i)
        {
            Value *incoming = PN->getIncomingValue(i);
            Worklist.push_back({Assign, incoming, PN});
        }
    }
}

void PointerAnalysis::handleAtomicRMW(AtomicRMWInst *ARMW)
{
    Value *ptr = ARMW->getPointerOperand();
    if (ptr->getType()->isPointerTy())
    {
        Worklist.push_back({Store, ARMW->getValOperand(), ptr});
    }
}

void PointerAnalysis::handleAtomicCmpXchg(AtomicCmpXchgInst *ACX)
{
    Value *ptr = ACX->getPointerOperand();
    if (ptr->getType()->isPointerTy())
    {
        Worklist.push_back({Store, ACX->getNewValOperand(), ptr});
    }
}

void PointerAnalysis::solveConstraints()
{
    bool changed = true;
    while (changed)
    {
        changed = false;
        for (const auto &constraint : Worklist)
        {
            if (!constraint.dst)
                continue;

            switch (constraint.type)
            {
            case Assign:
                if (constraint.src == nullptr)
                {
                    // Allocate: Points to self
                    if (PointsToMap[constraint.dst].insert(constraint.dst).second)
                        changed = true;
                }
                else
                {
                    // Propagate: dst may point to whatever src points to
                    auto &srcSet = PointsToMap[constraint.src];
                    auto &dstSet = PointsToMap[constraint.dst];

                    for (Value *target : srcSet)
                    {
                        if (dstSet.insert(target).second)
                            changed = true;
                    }
                }
                break;

            case Store:
                if (constraint.src)
                {
                    auto &srcSet = PointsToMap[constraint.src];
                    auto &dstSet = PointsToMap[constraint.dst];

                    for (Value *target : srcSet)
                    {
                        if (dstSet.insert(target).second)
                            changed = true;
                    }
                }
                break;

            case Load:
                if (constraint.src)
                {
                    auto &srcSet = PointsToMap[constraint.src];
                    auto &dstSet = PointsToMap[constraint.dst];

                    for (Value *target : srcSet)
                    {
                        if (dstSet.insert(target).second)
                            changed = true;
                    }
                }
                break;
            }
        }
    }
}

void PointerAnalysis::parseTaintConfig()
{
    // Load the taint configuration from taint_config.json
    std::ifstream configFile("taint_config.json");
    if (configFile.is_open())
    {
        json config;
        configFile >> config;

        // Parse the "tagged_objects" array
        for (const auto &obj : config["tagged_objects"])
        {
            TaggedStrings.insert(obj.get<std::string>());
        }
    }
    else
    {
        errs() << "Warning: Could not open taint_config.json.\n";
    }

    if (DebugMode)
    {
        errs() << "Parsed TaggedStrings contents:\n";
        for (const auto &tag : TaggedStrings)
        {
            errs() << "  - " << tag << "\n";
        }
    }
}

void PointerAnalysis::getPtrsPTSIncludeTaintedObjects()
{
    TaintedObjectToPointersMap.clear(); // Clear the result map before populating it

    errs() << "Tainted Objects (not printing full LLVM IRs):\n";
    for (const auto &taggedObject : TaintedObjects)
    {
        // Convert to a string for printing
        std::string taggedObjectStr;
        llvm::raw_string_ostream rso(taggedObjectStr);
        taggedObject->printAsOperand(rso, false);
        rso.flush();

        // Print the tainted object
        errs() << "  - " << taggedObjectStr << "\n";
    }

    errs() << "Starting to get pointers that point to tainted objects.\n";
    // Iterate through the points-to map
    for (const auto &entry : PointsToMap)
    {
        Value *ptr = entry.first;
        auto &targets = entry.second;

        if (DebugMode)
            errs() << "Pointer: " << *ptr << "\n";

        for (Value *target : targets)
        {
            if (DebugMode)
                errs() << "  -> Target: " << target->getName().str() << "\n";

            // Check if the target is a tainted object
            if (TaintedObjects.find(target) != TaintedObjects.end())
            {
                if (DebugMode)
                    errs() << "    -> Found tainted object. \n";

                // Add the pointer to the result map under the tainted object
                TaintedObjectToPointersMap[target].insert(ptr);
            }
        }
    }

    // Print the entire result map
    errs() << "\nTainted Object to Pointers Map:\n";
    for (const auto &entry : TaintedObjectToPointersMap)
    {
        Value *taintedObject = entry.first;
        const auto &pointers = entry.second;

        errs() << "Tainted Object: " << *taintedObject << "\n";
        for (Value *pointer : pointers)
        {
            errs() << "  -> Points from: " << *pointer << "\n";
        }
    }
}

const PointerAnalysis::PointsToMapTy &PointerAnalysis::getPointsToMap() const
{
    return PointsToMap;
}
