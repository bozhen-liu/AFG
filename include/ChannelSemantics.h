#ifndef CHANNEL_SEMANTICS_H
#define CHANNEL_SEMANTICS_H

#include "llvm/IR/Value.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Support/raw_ostream.h"
#include <unordered_map>
#include <unordered_set>
#include <vector>
#include <utility>

namespace llvm {

// Represents a channel endpoint (sender or receiver)
struct ChannelEndpoint {
    enum Type { SENDER, RECEIVER };
    
    Type type;
    llvm::Value* endpoint_value;  // The sender/receiver value
    llvm::Value* channel_id;      // Unique identifier for the channel pair
    llvm::Type* data_type;        // Type of data being transmitted
    
    ChannelEndpoint(Type t, llvm::Value* endpoint, llvm::Value* channel, llvm::Type* dtype)
        : type(t), endpoint_value(endpoint), channel_id(channel), data_type(dtype) {}
    
    bool operator==(const ChannelEndpoint& other) const {
        return type == other.type && endpoint_value == other.endpoint_value && 
               channel_id == other.channel_id;
    }
};

// Represents a channel operation (send/recv)
struct ChannelOperation {
    enum ChannelOpType { SEND, RECV, CHANNEL_CREATE };
    
    ChannelOpType operation;
    llvm::Instruction* instruction;  // The call instruction
    ChannelEndpoint* endpoint;       // Associated endpoint
    llvm::Value* data_value;         // Data being sent/received (null for recv)
    
    ChannelOperation(ChannelOpType op, llvm::Instruction* inst, ChannelEndpoint* ep, llvm::Value* data = nullptr)
        : operation(op), instruction(inst), endpoint(ep), data_value(data) {}
};

// Channel semantics analyzer
class ChannelSemantics {
public:
    // Maps to track channel relationships
    std::unordered_map<llvm::Value*, ChannelEndpoint*> endpoint_map;
    std::unordered_map<llvm::Value*, std::pair<ChannelEndpoint*, ChannelEndpoint*>> channel_pairs;
    std::vector<ChannelOperation*> channel_operations;
    
    // Identify if a value is a channel endpoint
    bool isChannelEndpoint(llvm::Value* value);
    
    // Identify if a call is a channel operation
    bool isChannelOperation(llvm::CallInst* call);
    
    // Extract channel semantics from a call instruction
    ChannelOperation* analyzeChannelCall(llvm::CallInst* call);
    
    // Create channel endpoint from channel creation
    std::pair<ChannelEndpoint*, ChannelEndpoint*> createChannelPair(llvm::CallInst* channel_create);
    
    // Get the corresponding endpoint for a channel endpoint
    ChannelEndpoint* getCorrespondingEndpoint(ChannelEndpoint* endpoint);
    
    // Apply channel-specific constraints to pointer analysis
    void applyChannelConstraints(class PointerAnalysis* analysis);
    
    // Debug printing
    void printChannelInfo(llvm::raw_ostream& os);
    
private:
    // Helper functions to identify channel types and operations
    bool isChannelCreateCall(llvm::CallInst* call);
    bool isSendCall(llvm::CallInst* call);
    bool isRecvCall(llvm::CallInst* call);
    
    // Extract channel information from function names
    std::string extractChannelType(llvm::Function* func);
};

} // namespace llvm

#endif // CHANNEL_SEMANTICS_H 