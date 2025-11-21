#ifndef AFG_NODE_H
#define AFG_NODE_H

#include "llvm/IR/Value.h"
#include "llvm/IR/Type.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/Constants.h"
#include "llvm/Support/raw_ostream.h"
#include "CallGraph.h"
#include <unordered_set>
#include <vector>
#include <unordered_map>

namespace llvm
{
    enum NodeType
    {
        PA_Node,
        PA_AllocNode /*, ... other kinds ... */
    };

    class Node
    {
    public:
        uint64_t id;                      // Unique node ID
        llvm::Value *value;               // The LLVM value
        Context context;                  // The context
        std::vector<uint64_t> offsets;    // For field-sensitive analysis, stores the offsets of the fields
        std::unordered_set<uint64_t> pts; // Points-to set (final)

        llvm::Type *type; // type of the value (or the type the pointer can hold), used for type checking

        // used during solving and propogating
        std::unordered_set<uint64_t> diff; // newly added nodes into points-to set; will be added to pts after propogation and reset for next iteration
        Node *alias = nullptr;             // Union-find for aliasing: used when actual parameter is used as return value with GEP, store and memcpy, only happens on the 1st param e.g.,
        // define internal void @"_ZN3std4sync4mpmc4list16Channel$LT$T$GT$3new17h9fbe3e677e1b4f13E"(ptr sret(%"std::sync::mpmc::list::Channel<i32>") %0) ...
        //   %7 = getelementptr inbounds %"std::sync::mpmc::list::Channel<i32>", ptr %0, i32 0, i32 2, !dbg !5323
        //   call void @llvm.memcpy.p0.p0.i64(ptr align 128 %7, ptr align 128 %_6, i64 128, i1 false), !dbg !5323

        Node *findAliasRoot()
        {
            if (!alias)
                return this;
            return alias = alias->findAliasRoot();
        }

        void unionAlias(Node *other)
        {
            Node *root1 = this->findAliasRoot();
            Node *root2 = other->findAliasRoot();
            if (root1 == root2)
                return; // Prevents cycles!
            root2->alias = root1;
            // Merge points-to sets as needed
        }

        // Constructor
        Node(int nodeId, llvm::Value *v, Context ctx = Everywhere, std::vector<uint64_t> idx = {}) : id(nodeId), value(v), type(v ? v->getType() : nullptr), context(ctx), offsets(std::move(idx)) {}

        // Equality operator for unordered_map/unordered_set
        bool operator==(const Node &other) const
        {
            return id == other.id && value == other.value && context == other.context && offsets == other.offsets;
        }

        virtual NodeType getType() const { return PA_Node; }

        virtual void print(llvm::raw_ostream &os) const
        {
            os << "[Node id=" << id << ", value=";
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
            else if (auto *arg = llvm::dyn_cast<llvm::Argument>(value))
            {
                if (auto *func = arg->getParent())
                {
                    os << " (arg of function " << func->getName() << ")";
                }
            }
            else if (auto *func = llvm::dyn_cast<llvm::Function>(value))
            {
                os << " (ret of function " << func->getName() << ")";
            }
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
            os << ", pts=[";
            if (pts.empty())
            {
                os << "empty";
            }
            else
            {
                for (auto it = pts.begin(); it != pts.end(); ++it)
                {
                    os << *it;
                    if (std::next(it) != pts.end())
                        os << ",";
                }
            }
            os << "]";
            if (!diff.empty())
            {
                os << ", diff=[";
                for (auto it = diff.begin(); it != diff.end(); ++it)
                {
                    os << *it;
                    if (std::next(it) != diff.end())
                        os << ",";
                }
                os << "]";
            }
            os << "]";
        }
    };

    // Overload operator<< for Node as a free function
    inline llvm::raw_ostream &operator<<(llvm::raw_ostream &os, const llvm::Node &node)
    {
        node.print(os);
        return os;
    }

} // namespace llvm

#endif // AFG_NODE_H