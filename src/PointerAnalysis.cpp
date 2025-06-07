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

    if (DebugMode)
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
            errs() << "Adding function: " << calleeFn << "\n";

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

Node *PointerAnalysis::getOrCreateNode(llvm::Value *value, Context context)
{
    if (isa<GlobalVariable>(value) || isa<GlobalAlias>(value) || isa<GlobalIFunc>(value))
    {
        context = Everywhere; // Global variables are considered everywhere
    }

    auto it = ValueContextToNodeMap.find(std::make_pair(value, context));
    if (it != ValueContextToNodeMap.end())
    {
        return it->second;
    }
    Node *node = new Node(nextNodeId++, value, context);
    ValueContextToNodeMap[std::make_pair(value, context)] = node;
    return node;
}

Context PointerAnalysis::getContext(Context context = Everywhere, const Value *newCallSite)
{
    return Everywhere; // Default context is Everywhere
}

void PointerAnalysis::processInstruction(Instruction &I, CGNode *cgnode)
{
    CurrentCGNode = cgnode;
    CurrentContext = getContext(Everywhere, &I);
    visit(I); // InstVisitor dispatches to the correct visit* method

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

void PointerAnalysis::visitStoreInst(StoreInst &SI)
{
    Value *val = SI.getValueOperand();
    Value *ptr = SI.getPointerOperand();
    if (val->getType()->isPointerTy())
    {
        Node *valNode = getOrCreateNode(val, getContext());
        Node *ptrNode = getOrCreateNode(ptr, getContext());
        Worklist.push_back({Store, valNode, ptrNode});
    }
}

void PointerAnalysis::visitLoadInst(LoadInst &LI)
{
    Value *ptr = LI.getPointerOperand();
    if (LI.getType()->isPointerTy())
    {
        Node *ptrNode = getOrCreateNode(ptr, getContext());
        Node *loadNode = getOrCreateNode(&LI, getContext());
        Worklist.push_back({Load, ptrNode, loadNode});
    }
}

void PointerAnalysis::visitBitCastInst(BitCastInst &BC)
{
    if (BC.getType()->isPointerTy())
    {
        Value *basePtr = BC.getOperand(0);
        Node *basePtrNode = getOrCreateNode(basePtr, getContext());
        Node *bcNode = getOrCreateNode(&BC, getContext());
        Worklist.push_back({Assign, basePtrNode, bcNode});
    }
}

void PointerAnalysis::visitGetElementPtrInst(GetElementPtrInst &GEP)
{
    if (GEP.getType()->isPointerTy())
    {
        Value *basePtr = GEP.getPointerOperand();
        Node *basePtrNode = getOrCreateNode(basePtr, getContext());
        Node *gepNode = getOrCreateNode(&GEP, getContext());
        Worklist.push_back({Assign, basePtrNode, gepNode});

        // Handle struct field or array access
        for (auto idx = GEP.idx_begin(); idx != GEP.idx_end(); ++idx)
        {
            if (auto *constIdx = dyn_cast<ConstantInt>(idx))
            {
                // errs() << "GEP index: " << constIdx->getValue() << "\n";

                // Generate constraints for array or struct field access
                // For simplicity, treat all derived pointers as pointing to the base
                Node *basePtrNode = getOrCreateNode(basePtr, getContext());
                Node *gepNode = getOrCreateNode(&GEP, getContext());
                Worklist.push_back({Assign, basePtrNode, gepNode});
            }
            else
            {
                // errs() << "GEP index is not a constant.\n";

                // Non-constant index: conservatively assume it may point anywhere
                Node *basePtrNode = getOrCreateNode(basePtr, getContext());
                Node *gepNode = getOrCreateNode(&GEP, getContext());
                Worklist.push_back({Assign, basePtrNode, gepNode});
            }
        }
    }
}

void PointerAnalysis::visitPHINode(PHINode &PN)
{
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
    if (calledValue->getType()->isPointerTy())
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
    Function *calledFn = CI.getCalledFunction();
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

void PointerAnalysis::visitInstruction(Instruction &I)
{
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

const PointerAnalysis::PointsToMapTy &PointerAnalysis::getPointsToMap() const
{
    return pointsToMap;
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

