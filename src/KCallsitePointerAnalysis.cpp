#include "KCallsitePointerAnalysis.h"
#include <utility>

using namespace llvm;

KCallsitePointerAnalysis::KCallsitePointerAnalysis() : PointerAnalysis() {}

void KCallsitePointerAnalysis::processInstruction(Instruction &I, CGNode *cgnode)
{
    if (auto *II = dyn_cast<InvokeInst>(&I))
    {
        handleInvokeInst(II, I, cgnode);
    }
    else if (auto *CI = dyn_cast<CallInst>(&I))
    {
        handleCallInst(CI, I, cgnode);
    }
    else
    {
        // call base logic (optionally pass context if needed)
        PointerAnalysis::processInstruction(I, cgnode); // or copy logic and use context
    }
}

// Create a new context by appending the new call site, keeping only the most recent K call sites
Context KCallsitePointerAnalysis::getContext(Context context, const Value *newCallSite)
{
    Context newContext = context;
    newContext.values.push_back(newCallSite);
    if (newContext.values.size() > K)
    {
        newContext.values.pop_front();
    }

    if (DebugMode)
        errs() << "New context for call site: " << newContext << "\n";

    return newContext;
}

void KCallsitePointerAnalysis::handleInvokeInst(InvokeInst *II, Instruction &I, CGNode *cgnode)
{
    Function *calledFn = II->getCalledFunction();
    if (calledFn) // handle direct calls
    {
        // Add to the call graph
        CGNode callee = callGraph.getOrCreateNode(calledFn, getContext(cgnode->context, II));
        callGraph.addEdge(*cgnode, callee);

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
        AddToFunctionWorklist(&callee);

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
                CGNode indirectCallee = callGraph.getOrCreateNode(indirectFn, getContext(cgnode->context, II));
                callGraph.addEdge(*cgnode, indirectCallee);

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
                AddToFunctionWorklist(&indirectCallee);

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

void KCallsitePointerAnalysis::handleCallInst(CallInst *CI, Instruction &I, CGNode *cgnode)
{
    Function *calledFn = CI->getCalledFunction();
    if (calledFn)
    {
        // Add to the call graph
        CGNode callee = callGraph.getOrCreateNode(calledFn, getContext(cgnode->context, CI));
        callGraph.addEdge(*cgnode, callee);

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
        AddToFunctionWorklist(&callee);

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
        errs() << "TODO: Inline assembly call found: " << *CI << "\n";
    }
}