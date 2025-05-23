#include "CallGraph.h"

namespace llvm
{

    CGNode CallGraph::getOrCreateNode(llvm::Function *func, Context ctx)
    {
        auto key = std::make_pair(func, ctx);
        auto it = ValueContextToNodeMap.find(key);
        if (it != ValueContextToNodeMap.end())
        {
            return it->second;
        }
        CGNode node = CGNode(nextNodeId++, func, ctx);
        idToNodeMap[node.id] = node;
        ValueContextToNodeMap[key] = node;
        return node;
    }

    void CallGraph::createNodeAndAddEdge(llvm::Function *caller, llvm::Function *callee)
    {
        CGNode callerNode = getOrCreateNode(caller);
        CGNode calleeNode = getOrCreateNode(callee);
        addEdge(callerNode, calleeNode);
    }

} // namespace llvm
