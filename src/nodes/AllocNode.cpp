#include "nodes/AllocNode.h"
#include "FieldSensitiveMemModel.h"
#include <cstdint>

namespace llvm
{
    uint64_t AllocNode::getFieldNode(const std::vector<uint64_t> &offsets) const
    {
        if (!fieldModel)
        {
            return UINT64_MAX;
        }
        return fieldModel->getOrCreateFieldNode(this->id, offsets);
    }

    std::unordered_set<uint64_t> AllocNode::getAllFieldNodes() const
    {
        if (!fieldModel)
        {
            return {};
        }
        return fieldModel->getFieldNodes(this->id);
    }

    llvm::Type *AllocNode::getFieldType(const std::vector<uint64_t> &offsets) const
    {
        if (!type || offsets.empty())
        {
            return type;
        }

        Type *currentType = type;
        for (uint64_t offset : offsets)
        {
            if (auto *structType = dyn_cast<StructType>(currentType))
            {
                if (offset < structType->getNumElements())
                {
                    currentType = structType->getElementType(offset);
                }
                else
                {
                    return nullptr; // Invalid offset
                }
            }
            else if (auto *arrayType = dyn_cast<ArrayType>(currentType))
            {
                currentType = arrayType->getElementType();
            }
            else if (currentType->isPointerTy())
            {
                // For pointer dereference, we need more context
                // This is a simplified implementation
                if (auto *allocaInst = dyn_cast<AllocaInst>(value))
                {
                    currentType = allocaInst->getAllocatedType();
                }
                else
                {
                    return nullptr;
                }
            }
            else
            {
                return nullptr; // Cannot access field of this type
            }
        }

        return currentType;
    }

    uint64_t AllocNode::getFieldSize(const std::vector<uint64_t> &offsets) const
    {
        Type *fieldType = getFieldType(offsets);
        if (!fieldType)
        {
            return 0;
        }

        // This is a simplified size calculation
        // In a real implementation, you'd use DataLayout
        if (fieldType->isIntegerTy())
        {
            return cast<IntegerType>(fieldType)->getBitWidth() / 8;
        }
        else if (fieldType->isFloatingPointTy())
        {
            if (fieldType->isFloatTy())
                return 4;
            if (fieldType->isDoubleTy())
                return 8;
        }
        else if (fieldType->isPointerTy())
        {
            return 8; // Assuming 64-bit pointers
        }

        return 1; // Default size
    }

    bool AllocNode::isValidFieldAccess(const std::vector<uint64_t> &offsets) const
    {
        if (!type || offsets.empty())
        {
            return true; // Base access is always valid
        }

        Type *currentType = type;
        for (uint64_t offset : offsets)
        {
            if (auto *structType = dyn_cast<StructType>(currentType))
            {
                if (offset >= structType->getNumElements())
                {
                    return false; // Out of bounds
                }
                currentType = structType->getElementType(offset);
            }
            else if (auto *arrayType = dyn_cast<ArrayType>(currentType))
            {
                // For arrays, we generally allow any offset (dynamic indexing)
                currentType = arrayType->getElementType();
            }
            else if (currentType->isPointerTy())
            {
                // Pointer dereference - continue with pointed-to type
                if (auto *allocaInst = dyn_cast<AllocaInst>(value))
                {
                    currentType = allocaInst->getAllocatedType();
                }
                else
                {
                    return false; // Cannot determine pointed-to type
                }
            }
            else
            {
                return false; // Cannot access field of this type
            }
        }

        return true;
    }

} // namespace llvm