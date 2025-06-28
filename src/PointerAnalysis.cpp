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
#include <queue>
#include <set>
#include "Util.h"

using json = nlohmann::json;
using namespace llvm;

void PointerAnalysis::analyze(Module &M)
{
    if (!parseOutputDir(M))
    {
        errs() << "Error: Could not parse input directory.\n";
        return;
    }

    // Parse the taint configuration file to get tagged strings and tainted objects if exists
    if (parseTaintConfig(M))
        TaintingEnabled = true;

    channelSemantics = new ChannelSemantics(this); // Initialize channel semantics
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
            errs() << "(parseMainFn) Instruction " << (instructionCount + 1) << ": " << inst << "\n";

        if (auto *callInst = dyn_cast<CallInst>(&inst))
        {
            Function *calledFunc = callInst->getCalledFunction();
            if (calledFunc && calledFunc->getName().contains("lang_start"))
            {
                if (DebugMode)
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
    }

    // Process functions
    CGNode mainNode = callGraph.getOrCreateNode(mainFn, Everywhere);
    FunctionWorklist.push_back(mainNode);
    while (!FunctionWorklist.empty())
    {
        if (DebugMode)
            errs() << "Function worklist size (loc1): " << FunctionWorklist.size() << "\n";

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
            errs() << "Function worklist size (loc2): " << FunctionWorklist.size() << "\n";

        // Solve constraints and discover new callees
        solveConstraints();
        if (DebugMode)
            errs() << "Constraints solved.\n"
                   << "Function worklist size (loc3): " << FunctionWorklist.size() << "\n";
    }
}

// Exclude standard math/string functions (update accordingly)
static const std::set<std::string> excludedStdFuncs = {
    "memset", "bzero", "strlen", "strcmp", "sin", "cos", "sqrt", "exit", "abort", "panic"};

// TODO: update accordingly.
// NOTE: do not exclude MaybeDangling container functions, e.g., for the function which name contains "MaybeDangling",
// do not exclude core::ptr::drop_in_place, e.g., <std::sync::mpmc::Sender<T> as core::ops::drop::Drop>::drop
bool PointerAnalysis::excludeFunctionFromAnalysis(Function *F)
{
    if (!F)
        return true;
    StringRef name = F->getName();

    // Exclude LLVM intrinsics and debug/info functions
    if (name.startswith("llvm.dbg.") ||
        name.startswith("llvm.lifetime.") ||
        name.startswith("llvm.assume") ||
        name.startswith("llvm.expect") ||
        name.startswith("llvm.stackprotector.") ||
        name.startswith("llvm.va_") ||
        name.startswith("llvm.trap") ||
        name.startswith("llvm.ubsan.") ||
        name.startswith("llvm.donothing") ||
        name.startswith("llvm.invariant.") ||
        name.startswith("llvm.prefetch") ||
        name.startswith("llvm.objectsize.") ||
        name.startswith("core::panicking") ||
        name.startswith("core::hint::unreachable_unchecked") ||
        name.startswith("__asan_") ||
        name.startswith("__tsan_") ||
        name.startswith("__msan_") ||
        name.startswith("__cxa_") ||
        name.startswith("__rust_probestack") ||
        name.startswith("__rust_alloc") || // may need to model the following rust functions
        name.startswith("__rust_alloc_zeroed") ||
        name.startswith("__rust_alloc_extern") ||
        name.startswith("__rust_dealloc") ||
        name.startswith("__rust_realloc"))
    {
        if (DebugMode)
            errs() << "Excluding function from analysis: " << name << "\n";
        return true;
    }

    if (excludedStdFuncs.count(name.str()))
    {
        if (DebugMode)
            errs() << "Excluding standard function from analysis: " << name << "\n";
        return true;
    }

    return false;
}

void PointerAnalysis::AddToFunctionWorklist(CGNode *callee)
{
    Function *calleeFn = callee->function;
    if (!callee || calleeFn->isDeclaration() || Visited.count(calleeFn))
        return;

    // Only add the function to the worklist if it has been visited fewer than MaxVisit times
    if (VisitCount[*callee] <= MaxVisit && !Visited.count(calleeFn))
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
    if (VisitCount[*cgnode] > MaxVisit) // Skip the function if it has already been visited MaxVisit times
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

Node *PointerAnalysis::getOrCreateNode(llvm::Value *value, Context context, std::vector<uint64_t> offsets)
{
    // Ignore pointers with .dbg. in their name (e.g., %ret.dbg.spill), which are for debug purposes only
    if (isDbgPointer(value))
    {
        if (DebugMode)
            errs() << "Ignoring dbg pointer: " << value->getName() << "\n";
        return nullptr;
    }

    if (isa<GlobalVariable>(value) || isa<GlobalAlias>(value) || isa<GlobalIFunc>(value))
    {
        context = Everywhere; // Global variables are considered everywhere
    }

    // Check if the node already exists in the map
    auto it = ValueContextToNodeMap.find(std::make_tuple(value, context, offsets));
    if (it != ValueContextToNodeMap.end())
    {
        return it->second;
    }
    Node *node = new Node(nextNodeId++, value, context, offsets);
    idToNodeMap[node->id] = node;
    ValueContextToNodeMap[std::make_tuple(value, context, offsets)] = node;
    return node;
}

Node *PointerAnalysis::getNodebyID(uint64_t id)
{
    auto it = idToNodeMap.find(id);
    if (it == idToNodeMap.end())
    {
        errs() << "Warning: Target ID " << id << " not found in idToNodeMap.\n";
        return nullptr; // Skip if target not found
    }
    return it->second;
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
    //     addConstraint({Assign, nullptr, ITP}); // Unknown source
    // }
    // else if (auto *PTI = dyn_cast<PtrToIntInst>(&I))
    // {
    //     // Optional: Handle pointer-to-integer casts if needed
    // }
}

std::vector<llvm::Function *> PointerAnalysis::getVtable(GlobalVariable *GV)
{
    // Check if the global variable name matches the vtable naming pattern
    if (GV->getName().startswith("vtable"))
    {
        if (DebugMode)
            errs() << "Starting to process vtable: " << GV->getName() << "\n";

        if (Constant *initializer = GV->getInitializer())
        {
            if (auto *constStruct = dyn_cast<ConstantStruct>(initializer))
            {
                auto it = vtableToFunctionMap.find(constStruct);
                if (it != vtableToFunctionMap.end())
                {
                    if (DebugMode)
                        errs() << "Vtable already processed: " << GV->getName() << "\n";
                    return it->second; // Return the existing mapping if already processed
                }

                if (DebugMode)
                    errs() << "Initializer is a ConstantStruct with " << constStruct->getNumOperands() << " operands.\n";

                for (unsigned i = 0; i < constStruct->getNumOperands(); ++i)
                {
                    Value *entry = constStruct->getOperand(i);
                    if (Function *fn = dyn_cast<Function>(entry))
                    {
                        vtableToFunctionMap[constStruct].push_back(fn); // Store the mapping from vtable to functions

                        if (DebugMode)
                            errs() << "    -> Added function to vtableToFunctionMap: " << fn->getName() << "\n";
                    }
                }

                return vtableToFunctionMap[constStruct];
            }
            else if (auto *constArray = dyn_cast<ConstantArray>(initializer))
            {
                auto it = vtableToFunctionMap.find(constArray);
                if (it != vtableToFunctionMap.end())
                {
                    if (DebugMode)
                        errs() << "Vtable already processed: " << GV->getName() << "\n";
                    return it->second; // Return the existing mapping if already processed
                }

                if (DebugMode)
                    errs() << "Initializer is a ConstantArray with " << constArray->getNumOperands() << " operands.\n";

                for (unsigned i = 0; i < constArray->getNumOperands(); ++i)
                {
                    Value *entry = constArray->getOperand(i);
                    if (Function *fn = dyn_cast<Function>(entry))
                    {
                        vtableToFunctionMap[constArray].push_back(fn); // Store the mapping from vtable to functions

                        if (DebugMode)
                            errs() << "    -> Added function to vtableToFunctionMap: " << fn->getName() << "\n";
                    }
                }

                return vtableToFunctionMap[constArray];
            }
            else
            {
                if (DebugMode)
                    errs() << "Unhandled initializer type: " << *initializer << "\n";
            }
        }
        else
        {
            if (DebugMode)
                errs() << "Vtable has no initializer.\n";
        }
    }

    return {}; // Return an empty vector if no vtable functions are found
}

void PointerAnalysis::processGlobalVar(GlobalVariable &GV)
{
    // Check if the global variable is a pointer type
    if (GV.getType()->isPointerTy())
    {
        Node *gvNode = getOrCreateNode(&GV);
        addConstraint({Assign, UINT64_MAX, gvNode->id}); // Points to self

        if (DebugMode)
            errs() << "Added global variable \"" << *gvNode << "\" to the worklist.\n";

        for (const User *U : GV.users())
        {
            if (const Instruction *I = dyn_cast<Instruction>(U))
            {
                if (I->getType()->isPointerTy())
                {
                    Node *useNode = getOrCreateNode(const_cast<Instruction *>(I), getContext());
                    addConstraint({AddressOf, gvNode->id, useNode->id});
                }
            }
        }
    }
}

void PointerAnalysis::visitAllocaInst(AllocaInst &AI)
{
    if (DebugMode)
        errs() << "Processing alloca: " << AI << "\n";

    Node *aiNode = getOrCreateNode(&AI, getContext());
    if (!aiNode)
        return;

    addConstraint({Assign, UINT64_MAX, aiNode->id}); // Points to self

    if (channelSemantics->isChannelAlloc(AI))
    {
        channelSemantics->createChannelInfo(&AI, aiNode);
    }

    // Generate AddressOf constraints for uses of this alloca
    for (const User *U : AI.users())
    {
        if (const Instruction *I = dyn_cast<Instruction>(U))
        {
            // If the use is a pointer-typed instruction (e.g., bitcast, GEP, etc.)
            if (I->getType()->isPointerTy())
            {
                Node *useNode = getOrCreateNode(const_cast<Instruction *>(I), getContext());
                if (!useNode)
                    continue;
                addConstraint({AddressOf, aiNode->id, useNode->id});
            }
        }
    }
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
        if (!basePtrNode || !bcNode)
            return;
        addConstraint({Assign, basePtrNode->id, bcNode->id});
    }
}

void PointerAnalysis::visitStoreInst(StoreInst &SI)
{
    if (DebugMode)
        errs() << "Processing store: " << SI << "\n";

    Value *val = SI.getValueOperand();
    Value *ptr = SI.getPointerOperand();
    if (val->getType()->isPointerTy())
    {
        // src -store-> dst (offsets)
        Node *valNode = getOrCreateNode(val, getContext());
        Node *ptrNode = getOrCreateNode(ptr, getContext());
        if (!valNode || !ptrNode)
            return;

        // Field-sensitive: extract offsets if ptr is a GEP
        std::vector<uint64_t> offsets;
        if (auto *gep = dyn_cast<GetElementPtrInst>(ptr))
        {
            for (auto idx = gep->idx_begin(); idx != gep->idx_end(); ++idx)
            {
                if (auto *constIdx = dyn_cast<ConstantInt>(idx))
                    offsets.push_back(constIdx->getZExtValue());
                else
                    offsets.push_back(~0ULL); // Unknown index
            }
        }

        addConstraint({Store, valNode->id, ptrNode->id, offsets});
    }
}

void PointerAnalysis::visitLoadInst(LoadInst &LI)
{
    if (DebugMode)
        errs() << "Processing load: " << LI << "\n";

    Value *ptr = LI.getPointerOperand();
    if (LI.getType()->isPointerTy())
    {
        // src (offsets) -load-> dst
        Node *ptrNode = getOrCreateNode(ptr, getContext());
        Node *loadNode = getOrCreateNode(&LI, getContext());
        if (!ptrNode || !loadNode)
            return;

        // Field-sensitive: extract offsets if ptr is a GEP
        std::vector<uint64_t> offsets;
        if (auto *gep = dyn_cast<GetElementPtrInst>(ptr))
        {
            for (auto idx = gep->idx_begin(); idx != gep->idx_end(); ++idx)
            {
                if (auto *constIdx = dyn_cast<ConstantInt>(idx))
                    offsets.push_back(constIdx->getZExtValue());
                else
                    offsets.push_back(~0ULL); // Unknown index
            }
        }

        addConstraint({Load, ptrNode->id, loadNode->id, offsets});
    }
}

void PointerAnalysis::visitGetElementPtrInst(GetElementPtrInst &GEP)
{
    if (DebugMode)
        errs() << "Processing GEP: " << GEP << "\n";

    if (GEP.getType()->isPointerTy())
    {
        Value *basePtr = GEP.getPointerOperand();
        Node *basePtrNode = getOrCreateNode(basePtr, getContext());
        Node *gepNode = getOrCreateNode(&GEP, getContext());
        if (!basePtrNode || !gepNode)
            return;

        // Handle struct field or array access
        std::vector<uint64_t> offsets;
        for (auto idx = GEP.idx_begin(); idx != GEP.idx_end(); ++idx)
        {
            if (auto *constIdx = dyn_cast<ConstantInt>(idx))
                offsets.push_back(constIdx->getZExtValue());
            else
                offsets.push_back(~0ULL); // Unknown index, e.g., variable
        }

        addConstraint({Offset, basePtrNode->id, gepNode->id, offsets});
    }
}

// TODO: handle other pointer-producing unary ops here if needed
void PointerAnalysis::visitUnaryOperator(UnaryOperator &UO)
{
    if (isa<AddrSpaceCastInst>(&UO)) // Handle address-of operator (&)
    {
        if (UO.getType()->isPointerTy())
        {
            Node *srcNode = getOrCreateNode(UO.getOperand(0), getContext());
            Node *dstNode = getOrCreateNode(&UO, getContext());
            if (!srcNode || !dstNode)
                return;
            addConstraint({AddressOf, srcNode->id, dstNode->id});
        }
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
        if (!aggNode || !resultNode)
            return;
        addConstraint({Assign, aggNode->id, resultNode->id});
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
            if (!incomingNode || !PNNode)
                return;
            addConstraint({Assign, incomingNode->id, PNNode->id});
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
        if (!ptrNode || !valNode)
            return;
        addConstraint({Store, valNode->id, ptrNode->id});
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
        if (!ptrNode || !newValNode)
            return;
        addConstraint({Store, newValNode->id, ptrNode->id});
    }
}

void PointerAnalysis::visitInvokeInst(InvokeInst &II)
{
    if (excludeFunctionFromAnalysis(II.getCalledFunction()))
    {
        return;
    }

    if (DebugMode)
        errs() << "Processing invoke: " << II << "\n";

    // Handle channel operations if applicable
    channelSemantics->handleChannelOperation(II, CurrentContext);

    Function *calledFn = II.getCalledFunction();
    if (calledFn) // handle direct calls
    {
        if (DebugMode)
            errs() << "Direct call to function: " << calledFn->getName() << "\n";

        // Add to the call graph
        CGNode callee = callGraph.getOrCreateNode(calledFn, CurrentContext);
        callGraph.addEdge(*CurrentCGNode, callee);

        if (calledFn->isDeclaration())
        {
            handleDeclaredFunction(II, calledFn, callee);
            return; // Skip declarations
        }

        addConstraintForCall(II, calledFn);

        // Visit the callee
        AddToFunctionWorklist(&callee);
        return;
    }

    // Handle indirect calls (e.g., via vtable)
    Value *calledValue = II.getCalledOperand();
    if (HandleIndirectCalls && !calledFn && calledValue->getType()->isPointerTy())
    {
        if (DebugMode)
            errs() << "Indirect call to value: " << *calledValue << "\n";

        // Handle indirect calls
        // usually the first argument in the invoke or call when calling a virtual or trait method.
        Node *basePtrNode = getOrCreateNode(II.getArgOperand(0), CurrentContext);
        Node *callNode = getOrCreateNode(&II, CurrentContext);
        if (!basePtrNode || !callNode)
            return; // Skip if nodes cannot be created
        addConstraint({Invoke, basePtrNode->id, callNode->id});
    }
}

void PointerAnalysis::visitCallInst(CallInst &CI)
{
    if (excludeFunctionFromAnalysis(CI.getCalledFunction()))
    {
        return;
    }

    if (DebugMode)
        errs() << "Processing call: " << CI << "\n";

    // Handle channel operations if applicable
    channelSemantics->handleChannelOperation(CI, CurrentContext);

    // Handle function calls
    Function *calledFn = CI.getCalledFunction();
    if (calledFn)
    {
        if (handleRustTry(CI, calledFn))
        {
            return; // done processing for __rust_try
        }

        // Add to the call graph
        CGNode callee = callGraph.getOrCreateNode(calledFn, CurrentContext);
        callGraph.addEdge(*CurrentCGNode, callee);

        if (calledFn->isDeclaration())
        {
            handleDeclaredFunction(CI, calledFn, callee);
            return; // done processing for declarations
        }

        addConstraintForCall(CI, calledFn);

        // Visit the callee
        AddToFunctionWorklist(&callee);
    }
    else if (HandleIndirectCalls && !calledFn && CI.getCalledOperand()->getType()->isPointerTy())
    {
        // Handle indirect calls
        // usually the first argument in the invoke or call when calling a virtual or trait method.
        Node *basePtrNode = getOrCreateNode(CI.getCalledOperand(), CurrentContext);
        Node *callNode = getOrCreateNode(&CI, CurrentContext);
        if (!basePtrNode || !callNode)
            return; // Skip if nodes cannot be created
        addConstraint({Invoke, basePtrNode->id, callNode->id});
    }
    else if (CI.isInlineAsm())
    {
        // TODO: Conservative handling: assume all pointers may be affected
        if (DebugMode)
            errs() << "TODO: CallInst is InlineAsm: " << CI << "\n";
    }
}

void PointerAnalysis::addConstraintForCall(CallBase &CB, Function *callee)
{
    bool taint = (TaintingEnabled && isTaintedFunction(CB));

    // Add constraints for parameter passing
    for (unsigned i = 0; i < CB.arg_size(); ++i)
    {
        Value *arg = CB.getArgOperand(i);
        if (arg->getType()->isPointerTy())
        {
            Node *argNode = getOrCreateNode(arg, CurrentContext);
            Argument *param = callee->getArg(i);
            Node *paramNode = getOrCreateNode(param, CurrentContext);
            if (!argNode || !paramNode)
                continue; // Skip if nodes cannot be created
            addConstraint({Assign, argNode->id, paramNode->id});
            if (i == 0 && useParamAsReturnValue(param))
                argNode->unionAlias(paramNode);

            // find taint source from parameters
            if (taint && !param->hasStructRetAttr())
            {
                // if (DebugMode)
                errs() << "Found Taint Source (parameter): " << *paramNode << "\n";

                TaintedNodeIDs.insert(paramNode->id); // Mark parameter as tainted

                llvm::errs() << "-> Tainting node " << argNode->id << " from " << paramNode->id << "\n";
                TaintedNodeIDs.insert(argNode->id); // Mark argument as tainted
            }
        }
    }

    // Add constraints for return value
    if (callee->getReturnType()->isPointerTy())
    {
        Node *calleeNode = getOrCreateNode(callee, CurrentContext);
        Node *returnNode = getOrCreateNode(&CB, CurrentContext);
        if (!calleeNode || !returnNode)
            return; // Skip if nodes cannot be created
        addConstraint({Assign, calleeNode->id, returnNode->id});

        if (taint)
        {
            // If the function is tainted, mark the return value as tainted
            if (DebugMode)
                errs() << "Found Taint Source (return value): " << *returnNode << "\n";

            TaintedNodeIDs.insert(returnNode->id); // Mark return value as tainted
        }
    }
}

// see llvm::Node::alias for detail
bool PointerAnalysis::useParamAsReturnValue(Argument *param)
{
    if (!param->getType()->isPointerTy() ||               // Only check pointer parameters
        !param->getParent()->getReturnType()->isVoidTy()) // If the function has no return value, the parameter might be used as a return value
        return false;

    if (param->hasStructRetAttr())
        return true; // If the parameter has a struct return attribute, it is used as a return value, e.g., sret

    // Check if the parameter is used as a return value in the function
    for (const User *U : param->users())
    {
        if (const GetElementPtrInst *GEP = dyn_cast<GetElementPtrInst>(U))
        {
            for (const User *gepUser : GEP->users())
            {
                if (isa<StoreInst>(gepUser) || isa<GetElementPtrInst>(gepUser) || isa<LoadInst>(gepUser))
                {
                    if (DebugMode)
                        errs() << "Parameter " << *param << " is used as a return value in function " << param->getParent()->getName() << "\n";
                    return true; // The parameter is used as a return value
                }
                else if (const CallBase *call = dyn_cast<CallBase>(gepUser))
                {
                    // Check if the call is to a function is llvm.memcpy.p0.p0.i64
                    Function *calledFunc = call->getCalledFunction();
                    if (calledFunc && calledFunc->getName() == "llvm.memcpy.p0.p0.i64")
                    {
                        if (DebugMode)
                            errs() << "Parameter " << *param << " is used as a return value (memcpy) in function " << param->getParent()->getName() << "\n";
                        return true; // The parameter is used in a memcpy call
                    }
                }
            }
        }
        else if (const CallBase *call = dyn_cast<CallBase>(U))
        { // to be conservative, we assume that the parameter might be used as a return value, since it might be passed to the callee and received updates there
            if (DebugMode)
                errs() << "Parameter " << *param << " might be used as a return value in function " << param->getParent()->getName() << "\n";
            return true; // The parameter is used as a return value
        }
    }

    if (DebugMode)
        errs() << "Parameter " << *param << " is not used as a return value in function " << param->getParent()->getName() << "\n";
    return false; // Not used as a return value
}

// handle __rust_try:
// define internal i32 @__rust_try(ptr %0, ptr %1, ptr %2) ... {
//     invoke void %0(ptr %1) // we directly link to the function pointed by %0 with data pointer %1
// }
// return true if handled, false if not
// TODO: we may see __rust_try_resume
bool PointerAnalysis::handleRustTry(CallBase &CB, Function *F)
{
    // Check if the function is __rust_try
    if (F->getName() == "__rust_try")
    {
        if (DebugMode)
            errs() << "Handling __rust_try call: " << CB << "\n";

        // Get the arguments: 3rd is for catch -> not important, ignore it
        Value *arg1 = CB.getArgOperand(0);
        Value *arg2 = CB.getArgOperand(1);

        if (Function *realCallee = dyn_cast<Function>(arg1))
        {
            if (DebugMode)
                errs() << "Found __rust_try with direct function call: " << realCallee->getName() << "\n";

            // Handle direct calls to a function
            // Add to the call graph
            CGNode callee = callGraph.getOrCreateNode(realCallee, CurrentContext);
            callGraph.addEdge(*CurrentCGNode, callee); // skip __rust_try here

            // Add constraints for parameter passing
            if (arg2->getType()->isPointerTy())
            {
                Node *dataPtrNode = getOrCreateNode(arg2, CurrentContext);
                Argument *param = realCallee->getArg(0);
                Node *paramNode = getOrCreateNode(param, CurrentContext);
                if (!dataPtrNode || !paramNode)
                    return false; // Skip if nodes cannot be created
                addConstraint({Assign, dataPtrNode->id, paramNode->id});
            }

            // from __rust_try: ret i32 0 or ret i32 1 -> not important, ignore return value
            AddToFunctionWorklist(&callee);
        }
        return true;
    }

    return false;
}

// TODO: more declarations to handle, e.g., locks
// no need to add to worklist, F is a library function, already simulate the constraints here
void PointerAnalysis::handleDeclaredFunction(CallBase &CB, Function *F, CGNode realCaller)
{
    std::string name = F->getName().str(); // original name

    if (DebugMode)
        errs() << "Handling declared function: " << F->getName() << "\n";

    if (name == "llvm.memcpy.p0.p0.i64") // declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #8
    {
        if (DebugMode)
            errs() << "Processing declared function: " << name << "\n";

        // declare void @llvm.memcpy.*(dest, src, size, is_volatile)
        Value *arg1 = CB.getArgOperand(0); // writeonly
        Value *arg2 = CB.getArgOperand(1); // readonly
        if (arg1->getType()->isPointerTy() && arg2->getType()->isPointerTy())
        {
            Node *srcNode = getOrCreateNode(arg2, CurrentContext);
            Node *dstNode = getOrCreateNode(arg1, CurrentContext);
            if (!srcNode || !dstNode)
                return; // Skip if nodes cannot be created
            addConstraint({Assign, srcNode->id, dstNode->id});
        }
        return;
    }

    std::string demangledName = getDemangledName(F->getName().str());

    if (DebugMode)
        errs() << "Demangled name: " << demangledName << "\n";

    if (demangledName == "std::sys::unix::thread::Thread::new")
    {
        if (DebugMode)
            errs() << "Processing declared function: " << demangledName << "\n";

        // the IR pattern can be found in channel-test-full.ll and demo-r68_llvm17_map.ll in examples folder
        Value *dataPtr = CB.getArgOperand(2); // 3rd: dataPtr
        Value *vtable = CB.getArgOperand(3);  // 4th: invoked fn through vtable
        if (dataPtr->getType()->isPointerTy() && vtable->getType()->isPointerTy())
        {
            // Handle indirect calls: add constraints for vtable
            Node *vtableNode = getOrCreateNode(vtable, CurrentContext);
            Node *callNode = getOrCreateNode(&CB, CurrentContext);
            addConstraint({Invoke, vtableNode->id, callNode->id});
        }
    }
}

void PointerAnalysis::visitInstruction(Instruction &I)
{
    if (isa<LandingPadInst>(&I) || isa<TruncInst>(&I) || isa<ZExtInst>(&I) ||
        isa<SExtInst>(&I) || isa<FPTruncInst>(&I) || isa<FPExtInst>(&I) ||
        isa<UIToFPInst>(&I) || isa<SIToFPInst>(&I) || isa<FPToUIInst>(&I) ||
        isa<FPToSIInst>(&I) || isa<IntToPtrInst>(&I) || isa<PtrToIntInst>(&I) || // TODO: maybe handle these
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

void PointerAnalysis::addConstraint(const Constraint &constraint)
{
    if (DebugMode)
    {
        errs() << "\t Adding constraint: " << constraint << "\n";
    }
    Worklist.push_back(constraint);

    // update def-use
    switch (constraint.type)
    {
    case Assign:
        if (constraint.lhs_id != UINT64_MAX)
            DU[constraint.lhs_id].push_back(constraint);
        break;

    case AddressOf:
    case Offset:
    case Load:
    case Invoke:
        DU[constraint.lhs_id].push_back(constraint);
        break;
    case Store: // rhs is the base ptr
        DU[constraint.rhs_id].push_back(constraint);
        break;

    default:
        if (DebugMode)
            errs() << "Unknown constraint type: " << static_cast<int>(constraint.type) << "\n";
        // Handle unknown constraint types gracefully
        assert(false && "Unknown constraint type encountered");
        break;
    }
}

// Sort the constraints in the worklist: sort the constraints using rhs_id in topological order
// this exclude channel constraints
void PointerAnalysis::sortConstraints()
{
    if (DebugMode)
    {
        errs() << "=== Sorting Constraints ===\n";
    }

    // Build dependency graph: lhs_id -> rhs_id
    std::unordered_map<uint64_t, std::unordered_set<uint64_t>> graph;
    std::unordered_map<uint64_t, int> inDegree;

    // Initialize inDegree for all nodes
    for (const auto &constraint : Worklist)
    {
        if (constraint.lhs_id != UINT64_MAX && constraint.rhs_id != UINT64_MAX)
        {
            graph[constraint.lhs_id].insert(constraint.rhs_id);
            inDegree[constraint.rhs_id]++;
            // Ensure lhs_id is in inDegree map
            if (inDegree.find(constraint.lhs_id) == inDegree.end())
                inDegree[constraint.lhs_id] = 0;
        }
    }

    // Kahn's algorithm for topological sort
    std::queue<uint64_t> q;
    for (const auto &kv : inDegree)
    {
        if (kv.second == 0)
            q.push(kv.first);
    }

    std::vector<uint64_t> topoOrder;
    while (!q.empty())
    {
        uint64_t node = q.front();
        q.pop();
        topoOrder.push_back(node);
        for (uint64_t succ : graph[node])
        {
            if (--inDegree[succ] == 0)
                q.push(succ);
        }
    }

    // Map node id to its order
    std::unordered_map<uint64_t, size_t> nodeOrder;
    for (size_t i = 0; i < topoOrder.size(); ++i)
        nodeOrder[topoOrder[i]] = i;

    // Sort constraints: those with rhs_id earlier in topoOrder come first
    std::sort(Worklist.begin(), Worklist.end(),
              [&nodeOrder](const Constraint &a, const Constraint &b)
              {
                  size_t aOrder = nodeOrder.count(a.rhs_id) ? nodeOrder[a.rhs_id] : SIZE_MAX;
                  size_t bOrder = nodeOrder.count(b.rhs_id) ? nodeOrder[b.rhs_id] : SIZE_MAX;
                  return aOrder < bOrder;
              });
}

void PointerAnalysis::solveConstraints()
{
    if (DebugMode)
    {
        errs() << "=== Solving Constraints ===\n";
    }

    int iteration = 0;
    std::vector<Constraint> tmpWorklist;
    while (!Worklist.empty())
    {
        // if (DebugMode)
        {
            errs() << iteration << ": Worklist size: " << Worklist.size() << "\n";
        }
        iteration++;

        sortConstraints(); // Sort constraints before solving
        // copy Worklist to tmpWorklist to avoid modifying the original worklist during processing
        for (const auto &constraint : Worklist)
        {
            tmpWorklist.push_back(constraint);
        }
        Worklist.clear(); // Clear the original worklist, prepare for next iteration

        // Process all constraints in the worklist
        for (const auto &constraint : tmpWorklist)
        {
            if (constraint.rhs_id == UINT64_MAX)
                continue;

            switch (constraint.type)
            {
            case Assign:
                processAssignConstraint(constraint);
                break;

            case AddressOf:
                processAddressOfConstraint(constraint);
                break;

            case Offset:
                processGEPConstraint(constraint);
                break;

            case Store:
                processStoreConstraint(constraint);
                break;

            case Load:
                processLoadConstraint(constraint);
                break;

            case Invoke:
                processInvokeConstraints(constraint);
                break;
            }
        }

        tmpWorklist.clear();
    }

    // After processing all constraints, reset diff
    for (auto &entry : idToNodeMap)
    {
        entry.second->diff.clear();
    }
}

void PointerAnalysis::processAssignConstraint(const llvm::Constraint &constraint)
{
    if (DebugMode)
    {
        errs() << "Processing Assign constraint: " << constraint << "\n";
    }

    bool changed = false;
    auto &dst = idToNodeMap[constraint.rhs_id];
    if (constraint.lhs_id == UINT64_MAX)
    {
        // Allocate: Points to self
        if (dst->pts.insert(constraint.rhs_id).second)
        {
            dst->diff.insert(constraint.rhs_id);
            changed = true; // Mark that we made a change
        }
    }
    else
    {
        auto &src = idToNodeMap[constraint.lhs_id];
        std::unordered_set<uint64_t> cmp = src->diff.empty() ? src->pts : src->diff;
        for (auto target_id : cmp)
        {
            if (dst->pts.insert(target_id).second)
            {
                // new id into dst->pts
                dst->diff.insert(target_id); // Mark as changed
                changed = true;              // Mark that we made a change
            }
        }
    }

    if (changed)
    {
        if (DebugMode)
        {
            errs() << "\t Assign constraint changed for node: " << *dst->value << "\n";
            errs() << "\t New pts: ";
            for (auto id : dst->pts)
            {
                errs() << id << " ";
            }
            errs() << "\t  New diff : ";
            for (auto id : dst->diff)
            {
                errs() << id << " ";
            }
            errs() << "\n";
        }

        dst->pts.insert(dst->diff.begin(), dst->diff.end()); // Ensure pts contains all diff ids
        propagateDiff(constraint.rhs_id);
    }

    if (TaintingEnabled && TaintedNodeIDs.count(constraint.lhs_id))
    { // If the source node is tainted, mark the destination node as tainted
        if (DebugMode)
            llvm::errs() << "-> Tainting node " << constraint.rhs_id << " from assign " << constraint.lhs_id << "\n";

        TaintedNodeIDs.insert(constraint.rhs_id);
    }
}

// dst points to src (address-of)
void PointerAnalysis::processAddressOfConstraint(const llvm::Constraint &constraint)
{
    if (DebugMode)
    {
        errs() << "Processing AddressOf constraint: " << constraint << "\n";
    }

    if (constraint.lhs_id == UINT64_MAX)
    {
        return;
    }

    bool changed = false;
    auto &dst = idToNodeMap[constraint.rhs_id];
    if (dst->pts.insert(constraint.lhs_id).second)
    {
        dst->diff.insert(constraint.lhs_id); // Mark as changed
        changed = true;                      // Mark that we made a change
    }

    if (changed)
    {
        dst->pts.insert(dst->diff.begin(), dst->diff.end()); // Ensure pts contains all diff ids
        propagateDiff(constraint.rhs_id);
    }

    if (TaintingEnabled && TaintedNodeIDs.count(constraint.lhs_id))
    { // If the source node is tainted, mark the destination node as tainted
        if (DebugMode)
            llvm::errs() << "-> Tainting node " << constraint.rhs_id << " from address of " << constraint.lhs_id << "\n";

        TaintedNodeIDs.insert(constraint.rhs_id);
    }
}

void PointerAnalysis::processGEPConstraint(const llvm::Constraint &constraint)
{
    if (DebugMode)
    {
        errs() << "Processing GEP (Offset) constraint: " << constraint << "\n";
    }

    // dst points to whatever src points to (field-sensitive GEP)
    // src is the base pointer, dst is the GEP result
    auto &src = idToNodeMap[constraint.lhs_id];
    auto &dst = idToNodeMap[constraint.rhs_id];
    std::unordered_set<uint64_t> cmp = src->diff.empty() ? src->pts : src->diff;
    for (auto obj_id : cmp)
    {
        Node *objNode = getNodebyID(obj_id);
        if (!objNode)
        {
            continue; // Skip if target not found
        }
        Node *fieldPtrNode = getOrCreateNode(objNode->value, objNode->context, constraint.offsets);
        if (!fieldPtrNode)
            continue;
        addConstraint({Assign, fieldPtrNode->id, dst->id});

        // --- Taint propagation: if base pointer is tainted, taint the GEP result ---
        if (TaintingEnabled && TaintedNodeIDs.count(src->id))
        {
            if (DebugMode)
                errs() << "-> Tainting node " << dst->id << " and " << fieldPtrNode->id << " from GEP base " << src->id << "\n";

            TaintedNodeIDs.insert(dst->id);
            TaintedNodeIDs.insert(fieldPtrNode->id); // Also taint the field pointer node
        }
    }
}

void PointerAnalysis::processLoadConstraint(const llvm::Constraint &constraint)
{
    if (DebugMode)
    {
        errs() << "Processing Load constraint: " << constraint << "\n";
    }

    // src is the base pointer
    auto &src = idToNodeMap[constraint.lhs_id];
    auto &dst = idToNodeMap[constraint.rhs_id];
    std::unordered_set<uint64_t> cmp = src->diff.empty() ? src->pts : src->diff;
    // src (offsets) -load-> dst
    for (auto obj_id : cmp)
    {
        Node *objNode = getNodebyID(obj_id);
        if (!objNode)
        {
            continue; // Skip if target not found
        }
        Node *fieldPtrNode = getOrCreateNode(objNode->value, objNode->context, constraint.offsets);
        if (!fieldPtrNode)
            continue; // Skip if node cannot be created
        addConstraint({Assign, fieldPtrNode->id, dst->id});

        // --- Taint propagation: if the field is tainted, taint the load result ---
        if (TaintingEnabled && TaintedNodeIDs.count(fieldPtrNode->id))
        {
            if (DebugMode)
                llvm::errs() << "-> Tainting node " << dst->id << " from field " << fieldPtrNode->id << "\n";

            TaintedNodeIDs.insert(dst->id);
        }
    }
}

void PointerAnalysis::processStoreConstraint(const llvm::Constraint &constraint)
{
    if (DebugMode)
    {
        errs() << "Processing Store constraint: " << constraint << "\n";
    }

    auto &src = idToNodeMap[constraint.lhs_id];
    auto &dst = idToNodeMap[constraint.rhs_id];
    std::unordered_set<uint64_t> cmp = dst->diff.empty() ? dst->pts : dst->diff;
    // src -store-> dst (offsets)
    for (auto obj_id : cmp)
    {
        Node *objNode = getNodebyID(obj_id);
        if (!objNode)
            continue; // Skip if target not found
        Node *fieldPtrNode = getOrCreateNode(objNode->value, objNode->context, constraint.offsets);
        if (!fieldPtrNode)
            continue; // Skip if node cannot be created
        addConstraint({Assign, src->id, fieldPtrNode->id});

        // --- Taint propagation: If the source node is tainted, mark the destination node as tainted ---
        if (TaintingEnabled && TaintedNodeIDs.count(src->id))
        {
            if (DebugMode)
                llvm::errs() << "-> Tainting node " << fieldPtrNode->id << " from " << src->id << "\n";

            TaintedNodeIDs.insert(fieldPtrNode->id);
        }
    }
}

void PointerAnalysis::processInvokeConstraints(const llvm::Constraint &constraint)
{
    if (DebugMode)
    {
        errs() << "Processing Invoke constraint: " << constraint << "\n";
    }

    // lhs_id: base node (base pointer or vtable), has the correct context
    // rhs_id: call/invoke instruction node
    Node *baseNode = idToNodeMap[constraint.lhs_id];
    Node *callNode = idToNodeMap[constraint.rhs_id];
    std::unordered_set<uint64_t> cmp = baseNode->diff.empty() ? baseNode->pts : baseNode->diff;

    if (DebugMode)
    {
        errs() << "\t(solver) Base node: " << *baseNode << "\n";
        // print out cmp
        errs() << "\t(solver) diff = ";
        for (uint64_t id : cmp)
        {
            Node *node = getNodebyID(id);
            if (node)
            {
                errs() << *node << ", ";
            }
            else
            {
                errs() << "Unknown ID: " << id << " ";
            }
        }
        errs() << "\n";
    }

    for (uint64_t target_id : cmp)
    {
        Node *targetNode = getNodebyID(target_id);
        if (!targetNode)
            continue;

        Value *targetValue = targetNode->value;

        if (DebugMode)
            errs() << "\t(solver) Processing target value: " << *targetValue << "\n";

        // TODO: other cases?
        // Case 1: Direct function pointer
        if (Function *indirectFn = dyn_cast<Function>(targetValue))
        {
            if (DebugMode)
                errs() << "(solver) Processing indirect function call to: " << indirectFn->getName() << "\n";

            Context ctx = baseNode->context;
            // Dispatch to the function directly
            CGNode callee = callGraph.getOrCreateNode(indirectFn, ctx);
            callGraph.addEdge(*CurrentCGNode, callee);

            // Add constraints for parameter passing
            if (CallBase *CB = dyn_cast<CallBase>(callNode->value))
                addConstraintForCall(*CB, indirectFn);

            AddToFunctionWorklist(&callee);
        }
        // Case 2: Vtable from GlobalVariable (Rust trait object)
        else if (GlobalVariable *gv = dyn_cast<GlobalVariable>(targetValue))
        {
            std::vector<Function *> fns = getVtable(gv);
            if (fns.empty())
            {
                if (DebugMode)
                    errs() << "(solver) No vtable functions found for: " << *gv << "\n";
                continue; // No vtable functions found, skip
            }

            // Select the correct function slot for the method being called.
            if (CallBase *CB = dyn_cast<CallBase>(callNode->value))
            {
                Function *F = CB->getCalledFunction();
                std::string demangledName = getDemangledName(F->getName().str());

                if (DebugMode)
                    errs() << "Demangled name: " << demangledName << "\n";

                if (demangledName == "std::sys::unix::thread::Thread::new")
                {
                    if (DebugMode)
                        errs() << "(solver) Processing vtable function: " << demangledName << "\n";

                    // the IR pattern can be found in channel-test-full.ll and demo-r68_llvm17_map.ll in examples folder
                    Value *dataPtr = CB->getArgOperand(2); // 3rd: dataPtr
                    Value *vtable = CB->getArgOperand(3);  // 4th: invoked fn through vtable
                    if (dataPtr->getType()->isPointerTy() && vtable->getType()->isPointerTy())
                    {
                        Context ctx = baseNode->context;
                        CGNode realCaller = callGraph.getOrCreateNode(F, ctx);
                        Node *dataPtrNode = getOrCreateNode(dataPtr, ctx);
                        Node *vtableNode = getOrCreateNode(vtable, ctx);

                        auto target_ids = vtableNode->pts;
                        for (uint64_t target_id : target_ids)
                        {
                            auto target = getNodebyID(target_id);
                            if (!target)
                            {
                                continue; // Skip if target not found
                            }

                            // the following numbers should match with demangledName function
                            assert(fns.size() == 2 && "Expected exactly two functions in vtable");
                            Function *calledFn = fns.at(1); // Assume the second function is the one for success run

                            // Add to the call graph
                            CGNode callee = callGraph.getOrCreateNode(calledFn, ctx);
                            callGraph.addEdge(realCaller, callee);

                            // Add constraints for parameter passing
                            assert((calledFn->arg_size() == 1) && "Expected exactly one argument for the called function");
                            Argument *param = calledFn->getArg(0);
                            Node *paramNode = getOrCreateNode(param, ctx);
                            addConstraint({Assign, dataPtrNode->id, paramNode->id});

                            // Visit the callee
                            if (DebugMode)
                                errs() << "(solver) Adding callee to worklist: " << calledFn->getName() << "\n";
                            AddToFunctionWorklist(&callee);
                        }
                    }
                }
                else
                {
                    if (DebugMode)
                        errs() << "(solver) TODO: Processing vtable function: " << demangledName << "\n";
                }
            }
        }
    }
}

// not used: no need to do so
// Process channel constraints after all other constraints
bool PointerAnalysis::handleChannelConstraints()
{
    // Channel operations have already been collected during the main analysis
    // in visitCallInst. This function processes and applies channel constraints.
    if (DebugMode)
    {
        errs() << "=== Processing Channel Constraints ===\n";
        errs() << "Found " << channelSemantics->channel2info.size()
               << " channel info\n";
    }

    // Apply channel-specific constraints to the pointer analysis
    // This function returns whether any new constraints were added
    size_t oldWorklistSize = Worklist.size();
    channelSemantics->applyChannelConstraints();

    bool constraintsAdded = (Worklist.size() > oldWorklistSize);

    if (DebugMode && constraintsAdded)
    {
        errs() << "Added " << (Worklist.size() - oldWorklistSize)
               << " channel constraints to worklist\n";
    }

    return constraintsAdded;
}

void PointerAnalysis::propagateDiff(uint64_t id)
{
    for (const auto &c : DU[id])
    {
        if (DebugMode)
        {
            errs() << "\t Propagating diff for id: " << id << ", constraint: " << c << "\n";
        }
        Worklist.push_back(c);
    }

    auto it = idToNodeMap.find(id);
    if (it != idToNodeMap.end())
    {
        Node *node = it->second;
        // check if DU[id] has aliases, if so, propagate to aliases
        if (node->alias)
        {
            // propagate to alias
            auto aliasNode = getNodebyID(node->alias->id);
            if (!aliasNode) // Skip if alias node not found
                return;
            aliasNode->diff.insert(node->diff.begin(), node->diff.end()); // propagate diff to alias
            aliasNode->pts.insert(node->pts.begin(), node->pts.end());    // propagate pts to alias
            for (const auto &c : DU[aliasNode->id])
            {
                Worklist.push_back(c);
                if (DebugMode)
                {
                    errs() << "\t Propagating diff to alias id: " << aliasNode->id << ", constraint: " << c << "\n";
                }
            }
        }

        // check if channel dangling operations need to be matched
        if (!channelSemantics->channel2DanglingOperations.empty())
        {
            if (DebugMode)
            {
                errs() << "Checking for channel dangling operations to match...\n";
            }
            // Match dangling operations with the current id
            channelSemantics->matchDanglingOperations(node);
        }
    }
}

bool PointerAnalysis::isTaintedFunction(const CallBase &callsite)
{
    if (const Function *callee = callsite.getCalledFunction())
    {
        std::string demangledName = getDemangledName(callee->getName().str());

        if (DebugMode)
        {
            errs() << "Checking if function is tainted: " << demangledName << "\n"
                   << *callee->getReturnType() << "\n"
                   << callee->getParent()->getName().str() << "\n"; // file path
            // print out parameter types
            for (const auto &arg : callee->args())
            {
                errs() << "  - " << *arg.getType() << "\n";
            }
        }

        // Check if the function matches any tainted function signature
        for (const auto &signature : TaintedFnSignatures)
        {
            if (signature->fn_name == demangledName &&
                ((signature->returnType == "void" && callee->getReturnType()->isVoidTy()) ||
                 (signature->returnType == getTypeAsString(callee->getReturnType()))) &&
                signature->args.size() <= callee->arg_size())
            {
                // if (DebugMode)
                errs() << "Found tainted function: " << demangledName << "\n";
                return true;
            }
        }
    }

    return false;
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

// parse the json file to get function signatures and stored at TaintedFnSignatures
bool PointerAnalysis::parseTaintConfig(Module &M)
{
    if (inputDir.empty())
    {
        parseInputDir(M); // Ensure inputDir is set
    }

    // Construct taint_config.json path
    llvm::SmallString<256> taintConfigPath(inputDir);
    llvm::sys::path::append(taintConfigPath, "taint_config.json");
    taintJsonFile = std::string(taintConfigPath.c_str());
    errs() << "Taint config file path: " << taintJsonFile << "\n";

    // Check if the taint config file exists
    if (llvm::sys::fs::exists(taintJsonFile))
    {
        if (DebugMode)
            errs() << "Taint config file exists. Continuing with analysis...\n";
    }
    else
    {
        errs() << "Taint config file does NOT exist at " << taintJsonFile << "\n Continue without taint analysis ...\n";
        return false;
    }

    // Load the taint configuration from taint_config.json
    std::ifstream configFile(taintJsonFile);
    if (configFile.is_open())
    {
        json config;
        configFile >> config;

        // Parse the "taint" array
        for (const auto &obj : config["taint"])
        {
            std::string fn_name = obj["fn_name"].get<std::string>();
            std::string return_type = obj["return_type"].get<std::string>();
            std::vector<std::string> parameter_type = obj["parameter_type"].get<std::vector<std::string>>();

            // Create a new function signature and add it to the set
            FnSignature *signature = new FnSignature{fn_name, parameter_type, return_type};
            TaintedFnSignatures.insert(signature);
        }
    }
    else
    {
        errs() << "Warning: Could not open taint_config.json.\n";
        return false;
    }

    // if (DebugMode)
    {
        errs() << "Parsed TaintedFnSignatures contents:\n";
        for (const auto &sig : TaintedFnSignatures)
        {
            errs() << "  - " << sig->returnType << " " << sig->fn_name << "(";
            for (const auto &arg : sig->args)
            {
                errs() << arg << ", ";
            }
            errs() << ")" << "\n";
        }
    }

    return true;
}

const void PointerAnalysis::printStatistics()
{
    errs() << "=== Pointer Analysis Statistics ===\n";
    // PointsToMap statistics
    // errs() << "Nodes which pts has Node id = 4119: " << "\n"; // debug purpose
    size_t numNodes = idToNodeMap.size();
    size_t numEdges = 0;
    for (const auto &entry : idToNodeMap)
    {
        numEdges += entry.second->pts.size();
        // if (entry.second->pts.count(4119))
        // {
        //     errs() << "Node ID: " << entry.second->id << ", Value: " << *entry.second << "\n";
        // }
    }

    // Visited functions
    size_t numVisitedFunctions = Visited.size();

    errs() << "PointsToMap: " << numNodes << " nodes, " << numEdges << " edges\n"; // TODO: edge should be how many unique constraints we created during this process ...
    errs() << "CallGraph: " << callGraph.numNodes() << " nodes, " << callGraph.numEdges() << " edges\n";
    errs() << "Visited functions: " << numVisitedFunctions << "\n";

    // Print channel semantics statistics
    channelSemantics->printChannelInfo(errs());

    errs() << "==================================\n";
}

// Iterate through the points-to map and print the results: full version
void PointerAnalysis::printPointsToMap(std::ofstream &outFile) const
{
    outFile << "\n\n\n\nPointer Analysis Results:\n";
    for (const auto &entry : idToNodeMap)
    {
        std::string pointerStr;
        llvm::raw_string_ostream pointerStream(pointerStr);
        pointerStream << *entry.second; // Use LLVM's raw_ostream to print the pointer
        pointerStream.flush();

        // skip printing function pointers
        if (entry.second->value->getType()->isFunctionTy())
        {
            outFile << "Skipping function pointer: " << pointerStr << "\n";
            continue;
        }

        outFile << "Pointer: " << pointerStr << "\n";
        for (auto target_id : entry.second->pts)
        {
            std::string targetStr;
            llvm::raw_string_ostream targetStream(targetStr);
            auto it = idToNodeMap.find(target_id);
            if (it != idToNodeMap.end() && it->second)
            {
                targetStream << *(it->second);
                targetStream.flush();
                outFile << "  -> " << targetStr << "\n";
            }
            else
            {
                outFile << "  -> [Unknown Node id=" << target_id << "]\n";
            }
            targetStream.flush();
        }
    }
}

void PointerAnalysis::printTaintedNodes(std::ofstream &outFile)
{
    outFile << "\n\n\n\nTainted Nodes (# = " << TaintedNodeIDs.size() << "/" << idToNodeMap.size() << "):\n";
    for (auto id : TaintedNodeIDs)
    {
        Node *node = getNodebyID(id);
        if (!node)
        {
            outFile << "\tNode ID: " << id << " (not found)\n";
            continue;
        }
        // i dont want to print the pts of each node, but the remaining information
        outFile << "\tNode ID=" << node->id << ", Value=" << node->value << "\n";

        // // the following prints out the full information of the node
        // std::string s;
        // llvm::raw_string_ostream rso(s);
        // rso << *node;
        // rso.flush();
        // outFile << s << "\n";
    }
}