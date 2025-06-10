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

void PointerAnalysis::analyze(Module &M)
{
    if (!parseOutputDir(M))
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

    onthefly(M);

    errs() << "Pointer analysis completed.\n";
}

llvm::Function *PointerAnalysis::parseMainFn(Module &M)
{
    Function *mainFn = M.getFunction("main");
    if (!mainFn || mainFn->isDeclaration())
    {
        errs() << "No main function found, looking for alternative entry points.\n";

        // Look for other possible entry points
        for (Function &F : M)
        {
            if (!F.isDeclaration() && F.hasName())
            {
                StringRef name = F.getName();
                // Look for Rust main functions
                if (name.contains("main") && !name.contains("lang_start"))
                {
                    errs() << "Using alternative entry point: " << name << "\n";
                    return &F;
                }
            }
        }

        // If no main-like function found, just pick the first non-declaration function
        for (Function &F : M)
        {
            if (!F.isDeclaration())
            {
                errs() << "Using first available function as entry point: " << F.getName() << "\n";
                return &F;
            }
        }

        return nullptr;
    }

    // locate the real main through pattern matching for rust
    Function *realMainFn = nullptr;
    // Get the first basic block of mainFn
    BasicBlock &firstBB = mainFn->front();

    // Look for the lang_start call in the first few instructions
    // Instead of hardcoding the 3rd instruction, search through the first several instructions
    auto it = firstBB.begin();
    auto end = firstBB.end();
    int instructionCount = 0;
    const int maxInstructionsToCheck = 5; // Check first 5 instructions

    while (it != end && instructionCount < maxInstructionsToCheck)
    {
        Instruction &inst = *it;

        if (DebugMode)
            errs() << "Instruction " << (instructionCount + 1) << ": " << inst << "\n";

        if (auto *callInst = dyn_cast<CallInst>(&inst))
        {
            Function *calledFunc = callInst->getCalledFunction();
            if (calledFunc && calledFunc->getName().contains("lang_start"))
            {
                errs() << "Found lang_start call at instruction " << (instructionCount + 1) << "\n";

                // The first argument to lang_start is the real main function
                if (callInst->arg_size() > 0)
                {
                    if (auto *realMain = dyn_cast<Function>(callInst->getArgOperand(0)))
                    {
                        realMainFn = realMain;
                        break;
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
        }

        ++it;
        ++instructionCount;
    }

    if (!realMainFn)
    {
        errs() << "No real main function found through lang_start pattern.\n";
        errs() << "Falling back to looking for any function with 'main' in the name.\n";

        // Fallback: look for any function with "main" in the name
        for (Function &F : M)
        {
            if (!F.isDeclaration() && F.hasName())
            {
                StringRef name = F.getName();
                if (name.contains("main") && !name.contains("lang_start"))
                {
                    errs() << "Using fallback main function: " << name << "\n";
                    return &F;
                }
            }
        }

        return nullptr;
    }
    else
    {
        errs() << "Located real main function: " << realMainFn->getName() << "\n";
        return realMainFn;
    }
}

// Implement on-the-fly analysis logic here
void PointerAnalysis::onthefly(Module &M)
{
    // Global variables can store pointers and may be accessed by multiple functions
    for (GlobalVariable &GV : M.globals())
    {
        processGlobalVar(GV);
        processVtable(GV);
    }

    // Process functions
    CGNode mainNode = callGraph.getOrCreateNode(mainFn, Everywhere);
    FunctionWorklist.push_back(mainNode);
    while (!FunctionWorklist.empty())
    {
        if (DebugMode)
            errs() << "Function worklist size 1: " << FunctionWorklist.size() << "\n";

        while (!FunctionWorklist.empty())
        {
            // Get the next function to visit
            CGNode cgnode = FunctionWorklist.back();
            FunctionWorklist.pop_back();

            if (DebugMode)
                errs() << "Visiting function: " << cgnode << "\n";

            // Visit the function
            visitFunction(&cgnode);
        }
        if (DebugMode)
            errs() << "Function worklist size 2: " << FunctionWorklist.size() << "\n";

        // Add channel constraint to trigger channel processing
        if (!channelSemantics.channel_operations.empty())
        {
            Worklist.push_back({Channel, nullptr, nullptr});
        }

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

void PointerAnalysis::AddToFunctionWorklist(CGNode *callee)
{
    Function *calleeFn = callee->function;
    if (!callee || calleeFn->isDeclaration() || Visited.count(calleeFn))
        return;

    // Only add the function to the worklist if it has been visited fewer than two times
    if (VisitCount[*callee] < 2 && !Visited.count(calleeFn))
    {
        if (DebugMode)
            errs() << "Adding function: " << calleeFn->getFunction().getName() << "\n";

        FunctionWorklist.push_back(*callee);
    }
}

void PointerAnalysis::visitFunction(CGNode *cgnode)
{
    Function *F = cgnode->function;
    if (!F || F->isDeclaration() || Visited.count(F))
        return;

    // Increment the visit count for the function
    VisitCount[*cgnode]++;
    if (VisitCount[*cgnode] > 2) // Skip the function if it has already been visited twice
        return;

    Visited.insert(F);

    if (DebugMode)
        errs() << "Visiting function: " << F->getName() << "\n";

    for (BasicBlock &BB : *F)
    {
        for (Instruction &I : BB)
        {
            processInstruction(I, cgnode);
        }
    }
}

Node *PointerAnalysis::getOrCreateNode(llvm::Value *value, Context context, std::vector<uint64_t> indices)
{
    if (isa<GlobalVariable>(value) || isa<GlobalAlias>(value) || isa<GlobalIFunc>(value))
    {
        context = Everywhere; // Global variables are considered everywhere
    }
    if (isa<GetElementPtrInst>(value) && indices.empty())
    {
        errs() << "Warning: getOrCreateNode called with GetElementPtrInst without indices. This may lead to incorrect analysis.\n"
               << "\t Value: " << *value << "\n";
    }

    auto it = ValueContextToNodeMap.find(std::make_tuple(value, context, indices));
    if (it != ValueContextToNodeMap.end())
    {
        return it->second;
    }
    Node *node = new Node(nextNodeId++, value, context, indices);
    ValueContextToNodeMap[std::make_tuple(value, context, indices)] = node;
    return node;
}

Context PointerAnalysis::getContext(Context context, const Value *newCallSite)
{
    return Everywhere; // Default context is Everywhere
}

void PointerAnalysis::processInstruction(Instruction &I, CGNode *cgnode)
{
    CurrentCGNode = cgnode;
    CurrentContext = getContext(Everywhere, &I);
    visit(I); // InstVisitor dispatches to the correct visit* method

    // // Casts between pointers and integers can obscure pointer relationships
    // else if (auto *ITP = dyn_cast<IntToPtrInst>(&I))
    // {
    //     Worklist.push_back({Assign, nullptr, ITP}); // Unknown source
    // }
    // else if (auto *PTI = dyn_cast<PtrToIntInst>(&I))
    // {
    //     // Optional: Handle pointer-to-integer casts if needed
    // }
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
                        pointsToMap[gvNode].insert(fnNode); // Use the Node pointers in PointsToMap

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
                        pointsToMap[gvNode].insert(fnNode); // Use the Node pointers in PointsToMap

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
        Node *gvNode = getOrCreateNode(&GV);
        Worklist.push_back({Assign, nullptr, gvNode}); // Points to self

        if (DebugMode)
            errs() << "Added global variable \"" << gvNode << "\" to the worklist.\n";
    }
}

void PointerAnalysis::visitAllocaInst(AllocaInst &AI)
{
    if (DebugMode)
        errs() << "Processing alloca: " << AI << "\n";

    // Handle non-tagged allocas
    Node *aiNode = getOrCreateNode(&AI, getContext());
    Worklist.push_back({Assign, nullptr, aiNode}); // Points to self
}

void PointerAnalysis::visitBitCastInst(BitCastInst &BC)
{
    if (DebugMode)
        errs() << "Processing bitcast: " << BC << "\n";

    if (BC.getType()->isPointerTy())
    {
        Value *basePtr = BC.getOperand(0);
        Node *basePtrNode = getOrCreateNode(basePtr, getContext());
        Node *bcNode = getOrCreateNode(&BC, getContext());
        Worklist.push_back({Assign, basePtrNode, bcNode});
    }
}

void PointerAnalysis::visitStoreInst(StoreInst &SI)
{
    if (DebugMode)
        errs() << "Processing store: " << SI << "\n";

    Value *val = SI.getValueOperand();
    Value *ptr = SI.getPointerOperand();

    // Field-sensitive: extract indices if ptr is a GEP
    std::vector<uint64_t> indices;
    if (auto *gep = dyn_cast<GetElementPtrInst>(ptr))
    {
        for (auto idx = gep->idx_begin(); idx != gep->idx_end(); ++idx)
        {
            if (auto *constIdx = dyn_cast<ConstantInt>(idx))
                indices.push_back(constIdx->getZExtValue());
            else
                indices.push_back(~0ULL); // Unknown index
        }
    }

    if (val->getType()->isPointerTy())
    {
        Node *valNode = getOrCreateNode(val, getContext());
        Node *ptrNode = getOrCreateNode(ptr, getContext(), indices);
        Worklist.push_back({Store, valNode, ptrNode});

        if (DebugMode)
            printLastConstraint();
    }
}

void PointerAnalysis::visitLoadInst(LoadInst &LI)
{
    if (DebugMode)
        errs() << "Processing load: " << LI << "\n";

    Value *ptr = LI.getPointerOperand();

    // Field-sensitive: extract indices if ptr is a GEP
    std::vector<uint64_t> indices;
    if (auto *gep = dyn_cast<GetElementPtrInst>(ptr))
    {
        for (auto idx = gep->idx_begin(); idx != gep->idx_end(); ++idx)
        {
            if (auto *constIdx = dyn_cast<ConstantInt>(idx))
                indices.push_back(constIdx->getZExtValue());
            else
                indices.push_back(~0ULL); // Unknown index
        }
    }

    if (LI.getType()->isPointerTy())
    {
        Node *ptrNode = getOrCreateNode(ptr, getContext(), indices);
        Node *loadNode = getOrCreateNode(&LI, getContext());
        Worklist.push_back({Load, ptrNode, loadNode});

        if (DebugMode)
            printLastConstraint();
    }
}

void PointerAnalysis::visitGetElementPtrInst(GetElementPtrInst &GEP)
{
    if (DebugMode)
        errs() << "Processing GEP: " << GEP << "\n";

    if (GEP.getType()->isPointerTy())
    {
        Value *basePtr = GEP.getPointerOperand();
        // Handle struct field or array access
        std::vector<uint64_t> indices;
        for (auto idx = GEP.idx_begin(); idx != GEP.idx_end(); ++idx)
        {
            if (auto *constIdx = dyn_cast<ConstantInt>(idx))
                indices.push_back(constIdx->getZExtValue());
            else
                indices.push_back(~0ULL); // Unknown index
        }
        Node *basePtrNode = getOrCreateNode(basePtr, getContext());
        Node *gepNode = getOrCreateNode(&GEP, getContext(), indices);
        Worklist.push_back({Assign, basePtrNode, gepNode});

        if (DebugMode)
            printLastConstraint();
    }
}

void PointerAnalysis::visitExtractValueInst(ExtractValueInst &EVI)
{
    if (DebugMode)
        errs() << "Processing extractvalue: " << EVI << "\n";

    if (EVI.getType()->isPointerTy())
    {
        Value *aggregate = EVI.getAggregateOperand();
        Node *aggNode = getOrCreateNode(aggregate, getContext());
        Node *resultNode = getOrCreateNode(&EVI, getContext());
        Worklist.push_back({Assign, aggNode, resultNode});

        if (DebugMode)
            printLastConstraint();
    }
}

void PointerAnalysis::visitPHINode(PHINode &PN)
{
    if (DebugMode)
        errs() << "Processing PHINode: " << PN << "\n";

    if (PN.getType()->isPointerTy())
    {
        for (unsigned i = 0; i < PN.getNumIncomingValues(); ++i)
        {
            Value *incoming = PN.getIncomingValue(i);
            Node *incomingNode = getOrCreateNode(incoming, getContext());
            Node *PNNode = getOrCreateNode(&PN, getContext());
            Worklist.push_back({Assign, incomingNode, PNNode});
        }
    }
}

void PointerAnalysis::visitAtomicRMWInst(AtomicRMWInst &ARMW)
{
    if (DebugMode)
        errs() << "Processing atomic RMW: " << ARMW << "\n";

    Value *ptr = ARMW.getPointerOperand();
    if (ptr->getType()->isPointerTy())
    {
        Node *ptrNode = getOrCreateNode(ptr, getContext());
        Node *valNode = getOrCreateNode(ARMW.getValOperand(), getContext());
        Worklist.push_back({Store, valNode, ptrNode});
    }
}

void PointerAnalysis::visitAtomicCmpXchgInst(AtomicCmpXchgInst &ACX)
{
    if (DebugMode)
        errs() << "Processing atomic compare-and-swap: " << ACX << "\n";

    Value *ptr = ACX.getPointerOperand();
    if (ptr->getType()->isPointerTy())
    {
        Node *ptrNode = getOrCreateNode(ptr, getContext());
        Node *newValNode = getOrCreateNode(ACX.getNewValOperand(), getContext());
        Worklist.push_back({Store, newValNode, ptrNode});
    }
}

void PointerAnalysis::visitInvokeInst(InvokeInst &II)
{
    if (DebugMode)
        errs() << "Processing invoke: " << II << "\n";

    Function *calledFn = II.getCalledFunction();
    if (calledFn) // handle direct calls
    {
        // Add to the call graph
        CGNode callee = callGraph.getOrCreateNode(calledFn, CurrentContext);
        callGraph.addEdge(*CurrentCGNode, callee);

        // Add constraints for parameter passing
        for (unsigned i = 0; i < II.arg_size(); ++i)
        {
            Value *arg = II.getArgOperand(i);
            if (arg->getType()->isPointerTy())
            {
                Node *argNode = getOrCreateNode(arg, CurrentContext);
                Argument *param = calledFn->getArg(i);
                Node *paramNode = getOrCreateNode(param, CurrentContext);
                Worklist.push_back({Assign, argNode, paramNode});
            }
        }

        // Visit the callee
        // visitFunction(calledFn);
        AddToFunctionWorklist(&callee);

        // Add constraints for return value
        if (calledFn->getReturnType()->isPointerTy())
        {
            Node *calledFnNode = getOrCreateNode(calledFn, CurrentContext);
            Node *returnNode = getOrCreateNode(&II, CurrentContext);
            Worklist.push_back({Assign, calledFnNode, returnNode});
        }
    }

    // Handle indirect calls (e.g., via vtable)
    Value *calledValue = II.getCalledOperand();
    if (!calledFn && calledValue->getType()->isPointerTy())
    {
        // Handle indirect calls
        Node *calledValueNode = getOrCreateNode(calledValue, CurrentContext);
        auto &targets = pointsToMap[calledValueNode];
        for (Node *target : targets)
        {
            if (Function *indirectFn = dyn_cast<Function>(target->value))
            {
                // // Debugging: Print II, calledValue, and target
                // errs() << "InvokeInst: " << *II << "\n";
                // errs() << "Called Value: " << *calledValue << "\n";
                // errs() << "Target Function: " << indirectFn->getName() << "\n";

                // Add to the call graph
                CGNode indirectCallee = callGraph.getOrCreateNode(indirectFn, CurrentContext);
                callGraph.addEdge(*CurrentCGNode, indirectCallee);

                // Add constraints for parameter passing
                for (unsigned i = 0; i < II.arg_size(); ++i)
                {
                    Value *arg = II.getArgOperand(i);
                    if (arg->getType()->isPointerTy())
                    {
                        Node *argNode = getOrCreateNode(arg, CurrentContext);
                        Argument *param = indirectFn->getArg(i);
                        Node *paramNode = getOrCreateNode(param, CurrentContext);
                        Worklist.push_back({Assign, argNode, paramNode});
                    }
                }

                // Visit the indirect callee
                // visitFunction(indirectFn);
                AddToFunctionWorklist(&indirectCallee);

                // Add constraints for return value
                if (indirectFn->getReturnType()->isPointerTy())
                {
                    Node *indirectFnNode = getOrCreateNode(indirectFn, CurrentContext);
                    Node *returnNode = getOrCreateNode(&II, CurrentContext);
                    Worklist.push_back({Assign, indirectFnNode, returnNode});
                }
            }
        }
    }
}

void PointerAnalysis::visitCallInst(CallInst &CI)
{
    if (DebugMode)
        errs() << "Processing call: " << CI << "\n";

    Function *calledFn = CI.getCalledFunction();

    // Handle channel operations first
    handleChannelOperation(CI);

    if (calledFn)
    {
        // Add to the call graph
        CGNode callee = callGraph.getOrCreateNode(calledFn, CurrentContext);
        callGraph.addEdge(*CurrentCGNode, callee);

        // Add constraints for parameter passing
        for (unsigned i = 0; i < CI.arg_size(); ++i)
        {
            Value *arg = CI.getArgOperand(i);
            if (arg->getType()->isPointerTy())
            {
                Node *argNode = getOrCreateNode(arg, CurrentContext);
                Argument *param = calledFn->getArg(i);
                Node *paramNode = getOrCreateNode(param, CurrentContext);
                Worklist.push_back({Assign, argNode, paramNode});
            }
        }

        // Visit the callee
        AddToFunctionWorklist(&callee);

        // Add constraints for return value
        if (calledFn->getReturnType()->isPointerTy())
        {
            Node *calledFnNode = getOrCreateNode(calledFn, CurrentContext);
            Node *returnNode = getOrCreateNode(&CI, CurrentContext);
            Worklist.push_back({Assign, calledFnNode, returnNode});
        }
    }
    else if (CI.isInlineAsm())
    {
        // TODO: Conservative handling: assume all pointers may be affected
        if (DebugMode)
            errs() << "TODO: CallInst is InlineAsm: " << CI << "\n";
    }
}

void PointerAnalysis::handleChannelOperation(CallInst &CI)
{
    // Check if this is a channel operation first
    if (channelSemantics.isChannelOperation(&CI))
    {
        if (DebugMode)
            errs() << "Processing channel operation: " << CI << "\n";

        ChannelOperation *channelOp = channelSemantics.analyzeChannelCall(&CI, CurrentContext);
        if (channelOp)
        {
            channelSemantics.channel_operations.push_back(channelOp);

            if (DebugMode)
            {
                Function *caller = CI.getFunction(); // Get the caller function
                errs() << "Detected channel operation: ";
                switch (channelOp->operation)
                {
                case ChannelOperation::SEND:
                    errs() << "SEND";
                    break;
                case ChannelOperation::RECV:
                    errs() << "RECV";
                    break;
                case ChannelOperation::CHANNEL_CREATE:
                    errs() << "CREATE";
                    break;
                }
                errs() << " in function: " << caller->getName() << "\n";
            }
        }
    }
}

void PointerAnalysis::visitInstruction(Instruction &I)
{

    if (isa<LandingPadInst>(&I) || isa<TruncInst>(&I) || isa<ZExtInst>(&I) ||
        isa<SExtInst>(&I) || isa<FPTruncInst>(&I) || isa<FPExtInst>(&I) ||
        isa<UIToFPInst>(&I) || isa<SIToFPInst>(&I) || isa<FPToUIInst>(&I) ||
        isa<FPToSIInst>(&I) || isa<IntToPtrInst>(&I) || isa<PtrToIntInst>(&I) ||
        isa<BranchInst>(&I) || isa<SwitchInst>(&I) || isa<ReturnInst>(&I) ||
        isa<CmpInst>(&I) || isa<SelectInst>(&I) || isa<InsertValueInst>(&I) ||
        isa<ExtractElementInst>(&I) || isa<InsertElementInst>(&I) || isa<UnreachableInst>(&I) || isa<ResumeInst>(&I))
    { // Ignore these instructions for pointer analysis
        return;
    }

    // fallback for unhandled instructions
    if (DebugMode)
        errs() << "Unhandled instruction: " << I << "\n";
}

void PointerAnalysis::solveConstraints()
{
    bool changed = true;
    while (changed)
    {
        changed = false;

        // Process all constraints in the worklist
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
                    if (pointsToMap[constraint.dst].insert(constraint.dst).second)
                        changed = true;
                }
                else
                {
                    // Propagate: dst may point to whatever src points to
                    auto &srcSet = pointsToMap[constraint.src];
                    auto &dstSet = pointsToMap[constraint.dst];

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
                    auto &srcSet = pointsToMap[constraint.src];
                    auto &dstSet = pointsToMap[constraint.dst];

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
                    auto &srcSet = pointsToMap[constraint.src];
                    auto &dstSet = pointsToMap[constraint.dst];

                    for (Node *target : srcSet)
                    {
                        if (dstSet.insert(target).second)
                            changed = true;
                    }
                }
                break;

            case Channel:
                if (handleChannelConstraints())
                {
                    changed = true;
                }
                break;
            }
        }
    }
}

bool PointerAnalysis::handleChannelConstraints()
{
    // Channel operations have already been collected during the main analysis
    // in visitCallInst. This function processes and applies channel constraints.

    if (DebugMode)
    {
        errs() << "=== Processing Channel Constraints ===\n";
        errs() << "Found " << channelSemantics.channel_operations.size()
               << " channel operations\n";
        errs() << "Found " << channelSemantics.channel_map.size()
               << " channel mappings\n";
        errs() << "Found " << channelSemantics.channels.size()
               << " channel instances\n";
    }

    // Apply channel-specific constraints to the pointer analysis
    // This function returns whether any new constraints were added
    size_t oldWorklistSize = Worklist.size();
    channelSemantics.applyChannelConstraints(this);

    bool constraintsAdded = (Worklist.size() > oldWorklistSize);

    if (DebugMode && constraintsAdded)
    {
        errs() << "Added " << (Worklist.size() - oldWorklistSize)
               << " channel constraints to worklist\n";
    }

    return constraintsAdded;
}

bool PointerAnalysis::parseInputDir(Module &M)
{
    // get the input file path
    std::string inputFile = M.getModuleIdentifier();
    errs() << "Input file path: " << inputFile << "\n";
    llvm::SmallString<256> dirPath(inputFile);
    llvm::sys::path::remove_filename(dirPath); // Remove the filename, leaving the directory
    inputDir = std::string(dirPath.c_str());
    return true;
}

bool PointerAnalysis::parseOutputDir(Module &M)
{
    if (inputDir.empty())
    {
        parseInputDir(M); // Ensure inputDir is set
    }

    // Construct output.txt path
    llvm::SmallString<256> outputPath(inputDir);
    llvm::sys::path::append(outputPath, "output.txt");
    outputFile = std::string(outputPath.c_str());
    errs() << "Output file path: " << outputFile << "\n";

    return true;
}

const void PointerAnalysis::printStatistics()
{
    // PointsToMap statistics
    size_t numNodes = pointsToMap.size();
    size_t numEdges = 0;
    for (const auto &entry : pointsToMap)
    {
        numEdges += entry.second.size();
    }

    // Visited functions
    size_t numVisitedFunctions = Visited.size();

    errs() << "=== PointerAnalysis Statistics ===\n";
    errs() << "PointsToMap: " << numNodes << " nodes, " << numEdges << " edges\n";
    errs() << "CallGraph: " << callGraph.numNodes() << " nodes, " << callGraph.numEdges() << " edges\n";
    errs() << "Visited functions: " << numVisitedFunctions << "\n";

    // Print channel semantics statistics
    channelSemantics.printChannelInfo(errs());

    errs() << "==================================\n";
}

// Iterate through the points-to map and print the results
void PointerAnalysis::printPointsToMap(std::ofstream &outFile) const
{
    outFile << "\n\n\n\nPointer Analysis Results:\n";
    const auto &ptm = getPointsToMap();
    for (const auto &entry : ptm)
    {
        std::string pointerStr;
        llvm::raw_string_ostream pointerStream(pointerStr);
        pointerStream << *entry.first; // Use LLVM's raw_ostream to print the pointer
        pointerStream.flush();

        // skip printing function pointers
        if (entry.first->value->getType()->isFunctionTy())
        {
            outFile << "Skipping function pointer: " << pointerStr << "\n";
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
}
