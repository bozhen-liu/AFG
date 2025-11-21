#ifndef AFG_FIELD_SENSITIVE_MEM_MODEL_H
#define AFG_FIELD_SENSITIVE_MEM_MODEL_H

#include "llvm/IR/Value.h"
#include "llvm/IR/Type.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Support/raw_ostream.h"
#include "CallGraph.h"
#include "Flags.h"
#include <cstdint>
#include <unordered_map>
#include <unordered_set>
#include <vector>

// Custom hash function for std::pair<uint64_t, std::vector<uint64_t>>
struct PairVectorHash
{
    std::size_t operator()(const std::pair<uint64_t, std::vector<uint64_t>> &p) const
    {
        std::size_t h1 = std::hash<uint64_t>{}(p.first);
        std::size_t h2 = 0;
        for (auto val : p.second)
        {
            h2 ^= std::hash<uint64_t>{}(val) + 0x9e3779b9 + (h2 << 6) + (h2 >> 2);
        }
        return h1 ^ (h2 << 1);
    }
};

namespace llvm
{
    // Forward declarations
    class AllocNode;
    class PointerAnalysis;

    // Field-sensitive memory model for AllocNode
    class FieldSensitiveMemModel
    {
    private:
        // Map from (base_node_id, field_offsets) to field_node_id
        std::unordered_map<std::pair<uint64_t, std::vector<uint64_t>>, uint64_t, PairVectorHash>
            fieldMap;

        // Map from node_id to its field nodes
        std::unordered_map<uint64_t, std::unordered_set<uint64_t>> nodeToFields;

        // Reference to the pointer analysis for creating nodes
        PointerAnalysis *analysis;

    public:
        FieldSensitiveMemModel(PointerAnalysis *pa) : analysis(pa) {}

        // Get or create a field node for the given base node and offsets
        uint64_t getOrCreateFieldNode(uint64_t baseNodeId, const std::vector<uint64_t> &offsets);

        // Get all field nodes for a given base node
        std::unordered_set<uint64_t> getFieldNodes(uint64_t baseNodeId) const;

        // Check if a node is a field node
        bool isFieldNode(uint64_t nodeId) const;

        // Get the base node for a field node
        uint64_t getBaseNode(uint64_t fieldNodeId) const;

        // Get the field offsets for a field node
        std::vector<uint64_t> getFieldOffsets(uint64_t fieldNodeId) const;

        void createFieldSensitiveNodesForType(llvm::Value *value, Context context, llvm::Type *type, std::vector<uint64_t> currentOffsets = {});
        std::vector<std::vector<uint64_t>> getAllFieldOffsets(llvm::Type *type, std::vector<uint64_t> currentOffsets = {});

        // Clear all field mappings
        void clear()
        {
            fieldMap.clear();
            nodeToFields.clear();
        }

        // Print debug information
        void printFieldMap() const;
    };

} // namespace llvm

#endif // AFG_FIELD_SENSITIVE_MEM_MODEL_H
