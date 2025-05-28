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

        auto found = idToNodeMap.find(node.id);
        assert(found == idToNodeMap.end() &&
               ("Node ID already exists in idToNodeMap: id=" + std::to_string(node.id) +
                ", existing function=" + (found != idToNodeMap.end() && found->second.function ? found->second.function->getName().str() : "null"))
                   .c_str());

        idToNodeMap[node.id] = node;
        ValueContextToNodeMap[key] = node;
        return node;
    }

} // namespace llvm
