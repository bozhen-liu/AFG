#include "OriginPointerAnalysis.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/ADT/SmallString.h"
#include "llvm/Support/Path.h"
#include "llvm/Support/FileSystem.h"
#include "Flags.h"
#include <fstream>
#include <nlohmann/json.hpp>
#include "Util.h"

using nlohmann::json;

using namespace llvm;

static bool isThreadRelatedCallInstruction(const Value *callsite)
{
    if (!callsite)
        return false;

    if (isa<AllocaInst>(callsite) || isa<GlobalVariable>(callsite))
    {
        // Ignore allocations and global variables
        if (DebugMode)
            errs() << "Ignoring allocation/global variable as tainted objects: " << *callsite << "\n";
        return false;
    }

    if (const auto *call = dyn_cast<CallBase>(callsite))
    {
        if (const Function *callee = call->getCalledFunction())
        {
            std::string mangledName = callee->getName().str();
            std::string demangled = getDemangledName(mangledName);

            if (DebugMode)
                errs() << "Demangled name: " << demangled << "\n";

            // TODO: Add more thread-related functions if needed
            return (demangled == "std::thread::spawn" ||
                    demangled == "tokio::task::spawn");
        }
    }
    return false;
}

Context OriginPointerAnalysis::getContext(Context context, const Value *newCallSite)
{
    if (isThreadRelatedCallInstruction(newCallSite))
    {
        Context newContext = context;
        newContext.values.push_back(newCallSite);
        if (newContext.values.size() > K)
        {
            newContext.values.pop_front();
        }

        // if (DebugMode)
        errs() << "HIT! New origin context for call site: " << newContext << "\n";

        return newContext;
    }
    return context;
}

void OriginPointerAnalysis::processGlobalVar(GlobalVariable &GV)
{
    // Check if the global variable is a pointer type
    if (GV.getType()->isPointerTy())
    {
        // Convert the GlobalVariable to a string for comparison
        std::string gvStr;
        llvm::raw_string_ostream rso(gvStr);
        GV.print(rso); // Use print to get the full LLVM IR representation
        rso.flush();

        // Check if the GlobalVariable matches a tagged object
        if (TaggedStrings.count(gvStr))
        {
            errs() << "(GlobalVariable) Found tainted string: " << gvStr << "\n";

            // Assign this to the tagged object
            if (TaintedObjects.find(&GV) == TaintedObjects.end())
            {
                TaintedObjects.insert(&GV);
                errs() << "Found tainted object \"" << &GV << "\" to tainted string: " << gvStr << "\n";
            }

            // Use the node (GV) to create constraints
            Node *gvNode = getOrCreateNode(&GV);                  // Use the GlobalVariable as context
            Worklist.push_back({Assign, UINT64_MAX, gvNode->id}); // Points to self

            if (DebugMode)
                errs() << "Added tainted global variable \"" << gvStr << "\" to the worklist.\n";
        }
        else
        {
            // Handle non-tagged global variables
            Node *gvNode = getOrCreateNode(&GV);
            Worklist.push_back({Assign, UINT64_MAX, gvNode->id}); // Points to self

            if (DebugMode)
                errs() << "Added global variable \"" << gvStr << "\" to the worklist.\n";
        }
    }
}

void OriginPointerAnalysis::visitAllocaInst(AllocaInst &AI)
{
    // Convert the alloca to a string for comparison
    std::string aiStr;
    llvm::raw_string_ostream rso(aiStr);
    AI.print(rso); // Use print to get the full LLVM IR representation -> TODO: this has leading or trailing spaces
    rso.flush();

    // Trim leading and trailing spaces
    aiStr = trim(aiStr);

    if (DebugMode)
        errs() << "Processing alloca: " << aiStr << "\n";

    // Check if the alloca matches a tagged object
    if (TaggedStrings.count(aiStr))
    {
        errs() << "(Alloca) Found tainted string: " << aiStr << "\n";
        // Assign this to the tagged object
        if (TaintedObjects.find(&AI) == TaintedObjects.end())
        {
            TaintedObjects.insert(&AI);
            errs() << "Found tainted object \"" << &AI << "\" to tainted string: " << aiStr << "\n";
        }

        Context context = getContext(CurrentContext, &AI); // Use the AllocaInst as context
        Node *aiNode = getOrCreateNode(&AI, context);
        Worklist.push_back({Assign, UINT64_MAX, aiNode->id}); // Points to self
        errs() << "Added alloca \"" << AI << "\" to the worklist with context \"" << context << "\".\n";
    }
    else
    {
        // Handle non-tagged allocas
        Node *aiNode = getOrCreateNode(&AI, getContext(CurrentContext, nullptr));
        Worklist.push_back({Assign, UINT64_MAX, aiNode->id}); // Points to self
    }
}

bool OriginPointerAnalysis::parseTaintConfig(Module &M)
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
        errs() << "Taint config file does NOT exist at " << taintJsonFile << "\n";
        return false;
    }

    // Load the taint configuration from taint_config.json
    std::ifstream configFile(taintJsonFile);
    if (configFile.is_open())
    {
        json config;
        configFile >> config;

        // Parse the "tagged_objects" array
        for (const auto &obj : config["tagged_objects"])
        {
            TaggedStrings.insert(obj.get<std::string>());
        }
    }
    else
    {
        errs() << "Warning: Could not open taint_config.json.\n";
        return false;
    }

    if (DebugMode)
    {
        errs() << "Parsed TaggedStrings contents:\n";
        for (const auto &tag : TaggedStrings)
        {
            errs() << "  - " << tag << "\n";
        }
    }

    return true;
}

void OriginPointerAnalysis::getPtrsPTSIncludeTaintedObjects()
{
    TaintedObjectToPointersMap.clear(); // Clear the result map before populating it

    errs() << "Tainted Objects (not printing full LLVM IRs):\n";
    for (const auto &taggedObject : TaintedObjects)
    {
        // Convert to a string for printing
        std::string taggedObjectStr;
        llvm::raw_string_ostream rso(taggedObjectStr);
        taggedObject->printAsOperand(rso, false);
        rso.flush();

        // Print the tainted object
        errs() << "  - " << taggedObjectStr << "\n";
    }

    errs() << "Starting to get pointers that point to tainted objects.\n";
    // Iterate through the points-to map
    for (const auto &entry : idToNodeMap)
    {
        Node *ptr = entry.second;
        auto &target_ids = entry.second->pts;

        if (DebugMode)
            errs() << "Pointer: " << *ptr << "\n";

        for (auto target_id : target_ids)
        {
            if (DebugMode)
                errs() << "  -> Target: " << target_id << "\n";

            Node *target = nullptr;
            auto it = idToNodeMap.find(target_id);
            if (it != idToNodeMap.end() && it->second)
            {
                target = it->second;
            }
            else
            {
                if (DebugMode)
                    errs() << "    -> Target not found in idToNodeMap for ID: " << target_id << "\n";
                continue; // Skip if target is not found
            }

            // Check if the target is a tainted object
            if (TaintedObjects.find(target->value) != TaintedObjects.end())
            {
                if (DebugMode)
                    errs() << "    -> Found tainted object. \n";

                // Add the pointer to the result map under the tainted object
                TaintedObjectToPointersMap[target].insert(entry.second);
            }
        }
    }
    errs() << "Finished getting pointers that point to tainted objects.\n";
}

void OriginPointerAnalysis::printTaintedObjects(std::ofstream &outFile) const
{
    outFile << "\n\n\n\nTainted Object to Pointers Map:\n";
    const auto &taint_map = getTaintedObjectToPointersMap();
    for (const auto &entry : taint_map)
    {
        Value *taintedObject = entry.first->value;
        const auto &pointers = entry.second;

        outFile << "Tainted Object: ";
        {
            std::string taintedObjectStr;
            llvm::raw_string_ostream rso(taintedObjectStr);
            taintedObject->print(rso);
            rso.flush();
            outFile << taintedObjectStr << "\n";
        }

        for (Node *pointer : pointers)
        {
            outFile << "  -> Points from: ";
            std::string pointerStr;
            llvm::raw_string_ostream rso(pointerStr);
            pointer->print(rso);
            rso.flush();
            outFile << pointerStr << "\n";
        }
    }
}