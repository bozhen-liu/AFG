#include "FieldSensitiveMemModel.h"
#include "nodes/AllocNode.h"
#include "PointerAnalysis.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/GlobalVariable.h"

namespace llvm
{
    // Static member initialization
    FieldSensitiveMemModel *AllocNode::fieldModel = nullptr;

    // FieldSensitiveMemModel implementation
    uint64_t FieldSensitiveMemModel::getOrCreateFieldNode(uint64_t baseNodeId, const std::vector<uint64_t> &offsets)
    {
        if (offsets.empty())
        {
            return baseNodeId; // No field access, return base node
        }

        auto key = std::make_pair(baseNodeId, offsets);
        auto it = fieldMap.find(key);
        if (it != fieldMap.end())
        {
            return it->second; // Field node already exists
        }

        // Create new field node
        Node *baseNode = analysis->getNodebyID(baseNodeId);
        if (!baseNode)
        {
            return UINT64_MAX; // Invalid base node
        }

        // Create field node with offsets
        Node *fieldNode = analysis->getOrCreateNode(baseNode->value, baseNode->context, offsets);
        if (!fieldNode)
        {
            return UINT64_MAX; // Failed to create field node
        }

        // Store mapping
        fieldMap[key] = fieldNode->id;
        nodeToFields[baseNodeId].insert(fieldNode->id);

        return fieldNode->id;
    }

    std::unordered_set<uint64_t> FieldSensitiveMemModel::getFieldNodes(uint64_t baseNodeId) const
    {
        auto it = nodeToFields.find(baseNodeId);
        if (it != nodeToFields.end())
        {
            return it->second;
        }
        return {};
    }

    bool FieldSensitiveMemModel::isFieldNode(uint64_t nodeId) const
    {
        for (const auto &entry : fieldMap)
        {
            if (entry.second == nodeId)
            {
                return true;
            }
        }
        return false;
    }

    uint64_t FieldSensitiveMemModel::getBaseNode(uint64_t fieldNodeId) const
    {
        for (const auto &entry : fieldMap)
        {
            if (entry.second == fieldNodeId)
            {
                return entry.first.first;
            }
        }
        return UINT64_MAX; // Not found
    }

    std::vector<uint64_t> FieldSensitiveMemModel::getFieldOffsets(uint64_t fieldNodeId) const
    {
        for (const auto &entry : fieldMap)
        {
            if (entry.second == fieldNodeId)
            {
                return entry.first.second;
            }
        }
        return {}; // Not found
    }

    void FieldSensitiveMemModel::createFieldSensitiveNodesForType(llvm::Value *value, Context context, llvm::Type *type, std::vector<uint64_t> currentOffsets)
    {
        if (!type)
        {
            if (DebugMode)
                errs() << "Field model not initialized or type is null.\n";
            return;
        }

        // For struct types, create nodes for each field
        if (auto *structType = dyn_cast<StructType>(type))
        {
            for (unsigned i = 0; i < structType->getNumElements(); ++i)
            {
                std::vector<uint64_t> fieldOffsets = currentOffsets;
                fieldOffsets.push_back(i);

                // Create field node using the field-sensitive model
                AllocNode *baseNode = analysis->getOrCreateAllocNode(value, context);
                if (baseNode)
                {
                    uint64_t fieldNodeId = getOrCreateFieldNode(baseNode->id, fieldOffsets);

                    if (DebugMode && fieldNodeId != UINT64_MAX)
                    {
                        errs() << "Created field node for struct field " << i << " at offsets [";
                        for (size_t j = 0; j < fieldOffsets.size(); ++j)
                        {
                            errs() << fieldOffsets[j];
                            if (j + 1 < fieldOffsets.size())
                                errs() << ", ";
                        }
                        errs() << "]\n";
                    }

                    // Recursively handle nested structures
                    Type *fieldType = structType->getElementType(i);
                    if (isa<StructType>(fieldType) || isa<ArrayType>(fieldType))
                    {
                        createFieldSensitiveNodesForType(value, context, fieldType, fieldOffsets);
                    }
                }
            }
        }
        // For array types, create nodes for element access patterns
        else if (auto *arrayType = dyn_cast<ArrayType>(type))
        {
            // For arrays, we typically create a representative element node
            // Using offset 0 to represent array element access
            std::vector<uint64_t> elementOffsets = currentOffsets;
            elementOffsets.push_back(0); // Array element at index 0

            AllocNode *baseNode = analysis->getOrCreateAllocNode(value, context);
            if (baseNode)
            {
                uint64_t elementNodeId = getOrCreateFieldNode(baseNode->id, elementOffsets);

                if (DebugMode && elementNodeId != UINT64_MAX)
                {
                    errs() << "Created array element node at offsets [";
                    for (size_t j = 0; j < elementOffsets.size(); ++j)
                    {
                        errs() << elementOffsets[j];
                        if (j + 1 < elementOffsets.size())
                            errs() << ", ";
                    }
                    errs() << "]\n";
                }

                // Recursively handle nested structures in array elements
                Type *elementType = arrayType->getElementType();
                if (isa<StructType>(elementType) || isa<ArrayType>(elementType))
                {
                    createFieldSensitiveNodesForType(value, context, elementType, elementOffsets);
                }
            }
        }
    }

    // Helper method to get all possible field offsets for a type
    std::vector<std::vector<uint64_t>> FieldSensitiveMemModel::getAllFieldOffsets(llvm::Type *type, std::vector<uint64_t> currentOffsets)
    {
        std::vector<std::vector<uint64_t>> allOffsets;

        if (!type)
        {
            return allOffsets;
        }

        // Add current offset path
        if (!currentOffsets.empty())
        {
            allOffsets.push_back(currentOffsets);
        }

        // For struct types, get offsets for each field
        if (auto *structType = dyn_cast<StructType>(type))
        {
            for (unsigned i = 0; i < structType->getNumElements(); ++i)
            {
                std::vector<uint64_t> fieldOffsets = currentOffsets;
                fieldOffsets.push_back(i);

                // Recursively get offsets for nested types
                Type *fieldType = structType->getElementType(i);
                auto nestedOffsets = getAllFieldOffsets(fieldType, fieldOffsets);
                allOffsets.insert(allOffsets.end(), nestedOffsets.begin(), nestedOffsets.end());
            }
        }
        // For array types
        else if (auto *arrayType = dyn_cast<ArrayType>(type))
        {
            std::vector<uint64_t> elementOffsets = currentOffsets;
            elementOffsets.push_back(0); // Representative element

            Type *elementType = arrayType->getElementType();
            auto nestedOffsets = getAllFieldOffsets(elementType, elementOffsets);
            allOffsets.insert(allOffsets.end(), nestedOffsets.begin(), nestedOffsets.end());
        }

        return allOffsets;
    }

    void FieldSensitiveMemModel::printFieldMap() const
    {
        errs() << "=== Field-Sensitive Memory Model ===\n";
        for (const auto &entry : fieldMap)
        {
            errs() << "Base Node " << entry.first.first << " + offsets [";
            for (size_t i = 0; i < entry.first.second.size(); ++i)
            {
                errs() << entry.first.second[i];
                if (i + 1 < entry.first.second.size())
                    errs() << ",";
            }
            errs() << "] -> Field Node " << entry.second << "\n";
        }
        errs() << "=====================================\n";
    }

} // namespace llvm
