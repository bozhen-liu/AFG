#include "PointerAnalysis.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Constants.h"
#include "llvm/Support/raw_ostream.h"
#include <nlohmann/json.hpp> // Include a JSON library like nlohmann/json
#include <fstream>
#include "llvm/Support/Path.h"
#include <llvm/ADT/SmallString.h>
#include "llvm/Support/FileSystem.h"

using json = nlohmann::json;
using namespace llvm;

// Helper function to trim leading and trailing spaces
static inline std::string trim(const std::string &str)
{
    auto start = str.find_first_not_of(" \t");
    auto end = str.find_last_not_of(" \t");
    return (start == std::string::npos) ? "" : str.substr(start, end - start + 1);
}

void PointerAnalysis::analyze(Module &M)
{
    if (!parseInputDir(M))
    {
        errs() << "Error: Could not parse input directory.\n";
        return;
    }

    mainFn = parseMainFn(M);
    if (!mainFn)
    {
        errs() << "Error: Could not find main function.\n";
        return;
    }

    // Global variables can store pointers and may be accessed by multiple functions
    for (GlobalVariable &GV : M.globals())
    {
        processGlobalVar(GV);
        processVtable(GV);
    }

    onthefly();

    errs() << "Pointer analysis completed.\n";

    getPtrsPTSIncludeTaintedObjects();
}

llvm::Function *PointerAnalysis::parseMainFn(Module &M)
{
    Function *mainFn = M.getFunction("main");
    if (!mainFn || mainFn->isDeclaration())
    {
        errs() << "No main function found or it's only declared.\n";
        return nullptr;
    }

    // locate the real main through pattern matching for rust
    Function *realMainFn = nullptr;
    // Get the first basic block of mainFn
    BasicBlock &firstBB = mainFn->front();
    // Use an iterator to access the 3rd instruction
    auto it = firstBB.begin();
    std::advance(it, 2); // Move the iterator to the 3rd instruction (0-based index)
    Instruction &thirdInst = *it;
    errs() << "3rd instruction in the first basic block: " << thirdInst << "\n";
    if (auto *callInst = dyn_cast<CallInst>(&thirdInst))
    {
        // The first argument to lang_start is the real main function
        if (callInst->arg_size() > 0)
        {
            if (auto *realMain = dyn_cast<Function>(callInst->getArgOperand(0)))
            {
                realMainFn = realMain;
            }
            else
            {
                errs() << "The first argument is not a function.\n";
            }
        }
        else
        {
            errs() << "No arguments found for the call instruction.\n";
        }
    }
    else
    {
        errs() << "3rd instruction is not a CallInst.\n";
    }

    if (!realMainFn)
    {
        errs() << "No real main function found.\n";
        return nullptr;
    }
    else
    {
        errs() << "Located real main function: " << realMainFn->getName() << "\n";
        return realMainFn;
    }
}

// Implement on-the-fly analysis logic here
void PointerAnalysis::onthefly()
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
            visitFunction(F);
        }
        if (DebugMode)
            errs() << "Function worklist size 2: " << FunctionWorklist.size() << "\n";

        // Solve constraints and discover new callees
        solveConstraints();
        if (DebugMode)
            errs() << "Constraints solved.\n";

        // // Add newly discovered callees to the worklist -> comment off: does not affect taint analysis result now
        // for (auto &entry : PointsToMap)
        // {
        //     Value *ptr = entry.first->value;
        //     auto &targets = entry.second;

        //     for (Node *target : targets)
        //     {
        //         if (Function *callee = dyn_cast<Function>(target->value))
        //         {
        //             AddToFunctionWorklist(callee);
        //         }
        //     }
        // }
        if (DebugMode)
            errs() << "Function worklist size 3: " << FunctionWorklist.size() << "\n";
    }
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

void PointerAnalysis::visitFunction(Function *F, Context context)
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

Node *PointerAnalysis::getOrCreateNode(llvm::Value *value, Context context)
{
    auto it = ValueContextToNodeMap.find(std::make_pair(value, context));
    if (it != ValueContextToNodeMap.end())
    {
        return it->second;
    }
    Node *node = new Node(nextNodeId++, value, context);
    ValueContextToNodeMap[std::make_pair(value, context)] = node;
    return node;
}

void PointerAnalysis::processInstruction(Instruction &I, Context context)
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
        handleInvokeInst(II, I);
    }
    else if (auto *CI = dyn_cast<CallInst>(&I))
    {
        handleCallInst(CI, I);
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
                        Node *gvNode = getOrCreateNode(&GV);
                        Node *fnNode = getOrCreateNode(fn);
                        PointsToMap[gvNode].insert(fnNode); // Use the Node pointers in PointsToMap

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
                        Node *gvNode = getOrCreateNode(&GV);
                        Node *fnNode = getOrCreateNode(fn);
                        PointsToMap[gvNode].insert(fnNode); // Use the Node pointers in PointsToMap

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
            Node *gvNode = getOrCreateNode(&GV);           // Use the GlobalVariable as context
            Worklist.push_back({Assign, nullptr, gvNode}); // Points to self

            if (DebugMode)
                errs() << "Added tainted global variable \"" << gvStr << "\" to the worklist.\n";
        }
        else
        {
            // Handle non-tagged global variables
            Node *gvNode = getOrCreateNode(&GV);
            Worklist.push_back({Assign, nullptr, gvNode}); // Points to self

            if (DebugMode)
                errs() << "Added global variable \"" << gvStr << "\" to the worklist.\n";
        }
    }
}

void PointerAnalysis::handleAlloca(AllocaInst *AI, Context context)
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

        Node *aiNode = getOrCreateNode(AI);            // Use the AllocaInst as context
        Worklist.push_back({Assign, nullptr, aiNode}); // Points to self
        errs() << "Added alloca \"" << AI << "\" to the worklist with context \"" << AI << "\".\n";
    }
    else
    {
        // Handle non-tagged allocas
        Node *aiNode = getOrCreateNode(AI);
        Worklist.push_back({Assign, nullptr, aiNode}); // Points to self
    }
}

void PointerAnalysis::handleStore(StoreInst *SI, Context context)
{
    Value *val = SI->getValueOperand();
    Value *ptr = SI->getPointerOperand();
    if (val->getType()->isPointerTy())
    {
        Node *valNode = getOrCreateNode(val);
        Node *ptrNode = getOrCreateNode(ptr);
        Worklist.push_back({Store, valNode, ptrNode});
    }
}

void PointerAnalysis::handleLoad(LoadInst *LI, Context context)
{
    Value *ptr = LI->getPointerOperand();
    if (LI->getType()->isPointerTy())
    {
        Node *ptrNode = getOrCreateNode(ptr);
        Node *loadNode = getOrCreateNode(LI);
        Worklist.push_back({Load, ptrNode, loadNode});
    }
}

void PointerAnalysis::handleBitCast(BitCastInst *BC, Context context)
{
    if (BC->getType()->isPointerTy())
    {
        Value *basePtr = BC->getOperand(0);
        Node *basePtrNode = getOrCreateNode(basePtr);
        Node *bcNode = getOrCreateNode(BC);
        Worklist.push_back({Assign, basePtrNode, bcNode});
    }
}

void PointerAnalysis::handleGEP(GetElementPtrInst *GEP, Context context)
{
    if (GEP->getType()->isPointerTy())
    {
        Value *basePtr = GEP->getPointerOperand();
        Node *basePtrNode = getOrCreateNode(basePtr);
        Node *gepNode = getOrCreateNode(GEP);
        Worklist.push_back({Assign, basePtrNode, gepNode});

        // Handle struct field or array access
        for (auto idx = GEP->idx_begin(); idx != GEP->idx_end(); ++idx)
        {
            if (auto *constIdx = dyn_cast<ConstantInt>(idx))
            {
                // errs() << "GEP index: " << constIdx->getValue() << "\n";

                // Generate constraints for array or struct field access
                // For simplicity, treat all derived pointers as pointing to the base
                Node *basePtrNode = getOrCreateNode(basePtr);
                Node *gepNode = getOrCreateNode(GEP);
                Worklist.push_back({Assign, basePtrNode, gepNode});
            }
            else
            {
                // errs() << "GEP index is not a constant.\n";

                // Non-constant index: conservatively assume it may point anywhere
                Node *basePtrNode = getOrCreateNode(basePtr);
                Node *gepNode = getOrCreateNode(GEP);
                Worklist.push_back({Assign, basePtrNode, gepNode});
            }
        }
    }
}

void PointerAnalysis::handlePHINode(PHINode *PN, Context context)
{
    if (PN->getType()->isPointerTy())
    {
        for (unsigned i = 0; i < PN->getNumIncomingValues(); ++i)
        {
            Value *incoming = PN->getIncomingValue(i);
            Node *incomingNode = getOrCreateNode(incoming);
            Node *PNNode = getOrCreateNode(PN);
            Worklist.push_back({Assign, incomingNode, PNNode});
        }
    }
}

void PointerAnalysis::handleAtomicRMW(AtomicRMWInst *ARMW, Context context)
{
    Value *ptr = ARMW->getPointerOperand();
    if (ptr->getType()->isPointerTy())
    {
        Node *ptrNode = getOrCreateNode(ptr);
        Node *valNode = getOrCreateNode(ARMW->getValOperand());
        Worklist.push_back({Store, valNode, ptrNode});
    }
}

void PointerAnalysis::handleAtomicCmpXchg(AtomicCmpXchgInst *ACX, Context context)
{
    Value *ptr = ACX->getPointerOperand();
    if (ptr->getType()->isPointerTy())
    {
        Node *ptrNode = getOrCreateNode(ptr);
        Node *newValNode = getOrCreateNode(ACX->getNewValOperand());
        Worklist.push_back({Store, newValNode, ptrNode});
    }
}

void PointerAnalysis::handleInvokeInst(InvokeInst *II, Instruction &I, Context context)
{
    Function *caller = II->getFunction(); // Get the caller function
    Function *calledFn = II->getCalledFunction();
    if (calledFn) // handle direct calls
    {
        // Add to the call graph
        callGraph.createNodeAndAddEdge(caller, calledFn);

        // Add constraints for parameter passing
        for (unsigned i = 0; i < II->arg_size(); ++i)
        {
            Value *arg = II->getArgOperand(i);
            if (arg->getType()->isPointerTy())
            {
                Node *argNode = getOrCreateNode(arg);
                Argument *param = calledFn->getArg(i);
                Node *paramNode = getOrCreateNode(param);
                Worklist.push_back({Assign, argNode, paramNode});
            }
        }

        // Visit the callee
        // visitFunction(calledFn);
        AddToFunctionWorklist(calledFn);

        // Add constraints for return value
        if (calledFn->getReturnType()->isPointerTy())
        {
            Node *calledFnNode = getOrCreateNode(calledFn);
            Node *returnNode = getOrCreateNode(&I);
            Worklist.push_back({Assign, calledFnNode, returnNode});
        }
    }

    // Handle indirect calls (e.g., via vtable)
    Value *calledValue = II->getCalledOperand();
    if (calledValue->getType()->isPointerTy())
    {
        // Handle indirect calls
        Node *calledValueNode = getOrCreateNode(calledValue);
        auto &targets = PointsToMap[calledValueNode];
        for (Node *target : targets)
        {
            if (Function *indirectFn = dyn_cast<Function>(target->value))
            {
                // // Debugging: Print II, calledValue, and target
                // errs() << "InvokeInst: " << *II << "\n";
                // errs() << "Called Value: " << *calledValue << "\n";
                // errs() << "Target Function: " << indirectFn->getName() << "\n";

                // Add to the call graph
                callGraph.createNodeAndAddEdge(caller, indirectFn);

                // Add constraints for parameter passing
                for (unsigned i = 0; i < II->arg_size(); ++i)
                {
                    Value *arg = II->getArgOperand(i);
                    if (arg->getType()->isPointerTy())
                    {
                        Node *argNode = getOrCreateNode(arg);
                        Argument *param = indirectFn->getArg(i);
                        Node *paramNode = getOrCreateNode(param);
                        Worklist.push_back({Assign, argNode, paramNode});
                    }
                }

                // Visit the indirect callee
                // visitFunction(indirectFn);
                AddToFunctionWorklist(calledFn);

                // Add constraints for return value
                if (indirectFn->getReturnType()->isPointerTy())
                {
                    Node *indirectFnNode = getOrCreateNode(indirectFn);
                    Node *returnNode = getOrCreateNode(&I);
                    Worklist.push_back({Assign, indirectFnNode, returnNode});
                }
            }
        }
    }
}

void PointerAnalysis::handleCallInst(CallInst *CI, Instruction &I, Context context)
{
    Function *caller = CI->getFunction(); // Get the caller function
    Function *calledFn = CI->getCalledFunction();
    if (calledFn)
    {
        // Add to the call graph
        callGraph.createNodeAndAddEdge(caller, calledFn);

        // Add constraints for parameter passing
        for (unsigned i = 0; i < CI->arg_size(); ++i)
        {
            Value *arg = CI->getArgOperand(i);
            if (arg->getType()->isPointerTy())
            {
                Node *argNode = getOrCreateNode(arg);
                Argument *param = calledFn->getArg(i);
                Node *paramNode = getOrCreateNode(param);
                Worklist.push_back({Assign, argNode, paramNode});
            }
        }

        // Visit the callee
        AddToFunctionWorklist(calledFn);

        // Add constraints for return value
        if (calledFn->getReturnType()->isPointerTy())
        {
            Node *calledFnNode = getOrCreateNode(calledFn);
            Node *returnNode = getOrCreateNode(&I);
            Worklist.push_back({Assign, calledFnNode, returnNode});
        }
    }
    else if (CI->isInlineAsm())
    {
        // TODO: Conservative handling: assume all pointers may be affected
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

                    for (Node *target : srcSet)
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

                    for (Node *target : srcSet)
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

                    for (Node *target : srcSet)
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

bool PointerAnalysis::parseInputDir(Module &M)
{
    // get the input file path
    std::string inputFile = M.getModuleIdentifier();
    errs() << "Input file path: " << inputFile << "\n";
    llvm::SmallString<256> dirPath(inputFile);
    llvm::sys::path::remove_filename(dirPath); // Remove the filename, leaving the directory

    // Construct taint_config.json path
    llvm::SmallString<256> taintConfigPath(dirPath);
    llvm::sys::path::append(taintConfigPath, "taint_config.json");
    taintJsonFile = std::string(taintConfigPath.c_str());
    errs() << "Taint config file path: " << taintJsonFile << "\n";

    // Construct output.txt path
    llvm::SmallString<256> outputPath(dirPath);
    llvm::sys::path::append(outputPath, "output.txt");
    outputFile = std::string(outputPath.c_str());
    errs() << "Output file path: " << outputFile << "\n";

    // Check if the taint config file exists
    if (llvm::sys::fs::exists(taintJsonFile))
    {
        errs() << "Taint config file exists.\n";
        parseTaintConfig(); // once
        return true;
    }
    else
    {
        errs() << "Taint config file does NOT exist.\n";
        return false;
    }
}

void PointerAnalysis::parseTaintConfig()
{
    // Load the taint configuration from taint_config.json
    std::ifstream configFile(taintJsonFile);
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
        Node *ptr = entry.first;
        auto &targets = entry.second;

        if (DebugMode)
            errs() << "Pointer: " << *ptr << "\n";

        for (Node *target : targets)
        {
            if (DebugMode)
                errs() << "  -> Target: " << target << "\n";

            // Check if the target is a tainted object
            if (TaintedObjects.find(target->value) != TaintedObjects.end())
            {
                if (DebugMode)
                    errs() << "    -> Found tainted object. \n";

                // Add the pointer to the result map under the tainted object
                TaintedObjectToPointersMap[target].insert(entry.first);
            }
        }
    }
    errs() << "Finished getting pointers that point to tainted objects.\n";
}

const PointerAnalysis::PointsToMapTy &PointerAnalysis::getPointsToMap() const
{
    return PointsToMap;
}

const void PointerAnalysis::printStatistics()
{
    // PointsToMap statistics
    size_t numNodes = PointsToMap.size();
    size_t numEdges = 0;
    for (const auto &entry : PointsToMap)
    {
        numEdges += entry.second.size();
    }

    // Visited functions
    size_t numVisitedFunctions = Visited.size();

    errs() << "=== PointerAnalysis Statistics ===\n";
    errs() << "PointsToMap: " << numNodes << " nodes, " << numEdges << " edges\n";
    errs() << "CallGraph: " << callGraph.numNodes() << " nodes, " << callGraph.numEdges() << " edges\n";
    errs() << "Visited functions: " << numVisitedFunctions << "\n";
    errs() << "==================================\n";
}