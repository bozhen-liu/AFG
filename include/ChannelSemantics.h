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

// Represents a complete channel instance including creation and both endpoints
struct ChannelInfo {
    llvm::Value* channel_id;        // Unique identifier for the channel (creation call)
    llvm::Value* sender_value;      // The sender endpoint value
    llvm::Value* receiver_value;    // The receiver endpoint value
    llvm::Type* data_type;          // Type of data being transmitted
    llvm::Instruction* creation_call; // The channel creation instruction
    
    ChannelInfo(llvm::Value* channel, llvm::Value* sender, llvm::Value* receiver, 
                llvm::Type* dtype, llvm::Instruction* create_call)
        : channel_id(channel), sender_value(sender), receiver_value(receiver), 
          data_type(dtype), creation_call(create_call) {}
    
    bool operator==(const ChannelInfo& other) const {
        return channel_id == other.channel_id && sender_value == other.sender_value && 
               receiver_value == other.receiver_value;
    }
};

// Represents a channel operation (send/recv)
struct ChannelOperation {
    enum ChannelOpType { SEND, RECV, CHANNEL_CREATE };
    
    ChannelOpType operation;
    llvm::Instruction* instruction;  // The call instruction
    ChannelInfo* channel_info;       // Associated channel instance
    llvm::Value* data_value;         // Data being sent/received (null for recv)
    bool is_sender_operation;        // true for send operations, false for recv operations
    
    ChannelOperation(ChannelOpType op, llvm::Instruction* inst, ChannelInfo* channel, 
                     llvm::Value* data = nullptr, bool is_sender = false)
        : operation(op), instruction(inst), channel_info(channel), 
          data_value(data), is_sender_operation(is_sender) {}
};

// Channel semantics analyzer
class ChannelSemantics {
public:
    // Maps to track channel relationships
    std::unordered_map<llvm::Value*, ChannelInfo*> channel_map; // Maps values to their channel info
    std::vector<ChannelInfo*> channels;                        // All channel instances
    std::vector<ChannelOperation*> channel_operations;
    
    // Identify if a value is part of a channel
    bool isChannelValue(llvm::Value* value);
    
    // Identify if a call is a channel operation
    bool isChannelOperation(llvm::CallInst* call);
    
    // Extract channel semantics from a call instruction
    ChannelOperation* analyzeChannelCall(llvm::CallInst* call);
    
    // Create channel info from channel creation
    ChannelInfo* createChannelInfo(llvm::CallInst* channel_create);
    
    // Get the channel info for a given value
    ChannelInfo* getChannelInfo(llvm::Value* value);
    
    // Find channel info by tracing back from a value (e.g., extractvalue instruction)
    ChannelInfo* findChannelInfoForValue(llvm::Value* value);
    
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