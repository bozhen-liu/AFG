#ifndef AFG_ALLOC_NODE_H
#define AFG_ALLOC_NODE_H

#include "nodes/Node.h"
#include "llvm/IR/GlobalVariable.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/DerivedTypes.h"
#include "Flags.h"

namespace llvm
{
    // Forward declaration to avoid circular dependency
    class FieldSensitiveMemModel;
    enum AllocType
    {
        StackAlloc,
        HeapAlloc,
        GlobalAlloc,
        FunctionAlloc, // ?
        ChannelAlloc,  // For channels, e.g., std::sync::mpsc::channel
        UnknownAlloc
    };

    class AllocNode : public Node
    {
    public:
        llvm::Type *type;    // allocated type, used for type checking
        AllocType allocType; // type of allocation

        // Field-sensitive memory model
        static FieldSensitiveMemModel *fieldModel;

        // Field access methods
        uint64_t getFieldNode(const std::vector<uint64_t> &offsets) const;
        std::unordered_set<uint64_t> getAllFieldNodes() const;

        // Get the type of a field based on offsets
        llvm::Type *getFieldType(const std::vector<uint64_t> &offsets) const;

        // Get size information for field-sensitive analysis
        uint64_t getFieldSize(const std::vector<uint64_t> &offsets) const;
        bool isValidFieldAccess(const std::vector<uint64_t> &offsets) const;

        // Constructor: call base Node constructor
        AllocNode(int nodeId, llvm::Value *v, Context ctx = Everywhere, std::vector<uint64_t> idx = {})
            : Node(nodeId, v, ctx, std::move(idx)), allocType(UnknownAlloc)
        {
            // Set type and allocType based on the value
            if (auto *allocaInst = dyn_cast<AllocaInst>(v))
            {
                type = allocaInst->getAllocatedType();
                allocType = StackAlloc;
            }
            else if (auto *globalVar = dyn_cast<GlobalVariable>(v))
            {
                type = globalVar->getValueType();
                allocType = GlobalAlloc;
            }
            else if (auto *function = dyn_cast<Function>(v))
            {
                type = function->getType();
                allocType = FunctionAlloc;
            }
            else
            {
                type = v ? v->getType() : nullptr;
                allocType = UnknownAlloc;
            }

            if (DebugMode && type)
            {
                errs() << "AllocNode created with id=" << id << ", value=" << *v << "\n";
                errs() << "AllocType: ";
                switch (allocType)
                {
                case StackAlloc:
                    errs() << "StackAlloc";
                    break;
                case HeapAlloc:
                    errs() << "HeapAlloc";
                    break;
                case GlobalAlloc:
                    errs() << "GlobalAlloc";
                    break;
                case FunctionAlloc:
                    errs() << "FunctionAlloc";
                    break;
                case ChannelAlloc:
                    errs() << "ChannelAlloc";
                    break;
                case UnknownAlloc:
                    errs() << "UnknownAlloc";
                    break;
                }
                errs() << "\n";

                // Print type information for debugging
                if (auto *structType = dyn_cast<StructType>(type))
                {
                    if (structType->hasName())
                    {
                        errs() << "Struct name: " << structType->getName() << "\n";
                        for (unsigned i = 0; i < structType->getNumElements(); ++i)
                        {
                            Type *field = structType->getElementType(i);
                            errs() << "  Field " << i << ": ";
                            field->print(errs());
                            errs() << "\n";
                        }
                    }
                    else
                    {
                        errs() << "Anonymous struct with " << structType->getNumElements() << " elements:\n";
                        for (unsigned i = 0; i < structType->getNumElements(); ++i)
                        {
                            Type *field = structType->getElementType(i);
                            errs() << "  Field " << i << ": ";
                            field->print(errs());
                            errs() << "\n";
                        }
                    }
                }
                else if (auto *arrayType = dyn_cast<ArrayType>(type))
                {
                    errs() << "Array of " << arrayType->getNumElements() << " elements of type: ";
                    arrayType->getElementType()->print(errs());
                    errs() << "\n";
                }
            }
        }

        NodeType getType() const override { return PA_AllocNode; }

        // You can override print to include alloc info
        void print(llvm::raw_ostream &os) const override
        {
            os << "[AllocNode id=" << id << ", value=";
            if (value)
            {
                if (auto f = dyn_cast<Function>(value))
                    os << f->getName();
                else
                    value->print(os);
            }
            else
                os << "null";
            // os << ", type=";
            // if (type)
            //     type->print(os, false);
            // else
            //     os << "null";
            // os << ", ";
            if (auto *inst = llvm::dyn_cast<llvm::Instruction>(value))
            {
                llvm::Function *func = inst->getParent()->getParent();
                if (func)
                {
                    os << " (from function " << func->getName() << ")";
                }
            }
            // else if (auto *arg = llvm::dyn_cast<llvm::Argument>(value))
            // {
            //     if (auto *func = arg->getParent())
            //     {
            //         os << " (arg of function " << func->getName() << ")";
            //     }
            // }
            // else if (auto *func = llvm::dyn_cast<llvm::Function>(value))
            // {
            //     os << " (ret of function " << func->getName() << ")";
            // }
            else
            {
                os << " (no function context)";
            }
            os << ", context=";
            os << "[";
            if (context == Everywhere)
            {
                os << "Everywhere";
            }
            else
            {

                for (auto it = context.begin(); it != context.end(); ++it)
                {
                    if (*it)
                        (*it)->print(os);
                    else
                        os << "null";
                    if (std::next(it) != context.end())
                        os << ", ";
                }
            }
            os << "]";
            if (!offsets.empty())
            {
                os << ", indices=["; // or fields
                for (size_t i = 0; i < offsets.size(); ++i)
                {
                    os << offsets[i];
                    if (i + 1 < offsets.size())
                        os << ",";
                }
                os << "]";
            }
        }
    };

    // Overload operator<< for AllocNode as a free function
    inline llvm::raw_ostream &operator<<(llvm::raw_ostream &os, const llvm::AllocNode &node)
    {
        node.print(os);
        return os;
    }

}

#endif // AFG_ALLOC_NODE_H