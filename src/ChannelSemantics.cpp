#include "ChannelSemantics.h"
#include "PointerAnalysis.h"
#include "llvm/IR/Function.h"
#include "llvm/Support/raw_ostream.h"
#include <regex>
#include "llvm/IR/Instructions.h"
#include "llvm/Demangle/Demangle.h"

using namespace llvm;

// Helper function to get demangled function name without hash suffix
static std::string getDemangledFunctionName(llvm::Function* func) {
    if (!func) return "";
    
    std::string mangledName = func->getName().str();
    std::string demangled = llvm::demangle(mangledName);
    
    // Remove hash suffix: keep up to the last "::"
    size_t last_colon = demangled.rfind("::");
    if (last_colon != std::string::npos) {
        demangled = demangled.substr(0, last_colon);
    }
    
    return demangled;
}

bool ChannelSemantics::isChannelValue(llvm::Value* value) {
    // Check if the value is part of any channel
    return channel_map.find(value) != channel_map.end();
}

bool ChannelSemantics::isChannelOperation(llvm::CallInst* call) {
    return isChannelCreateCall(call) || isSendCall(call) || isRecvCall(call);
}

bool ChannelSemantics::isChannelCreateCall(llvm::CallInst* call) {
    Function* func = call->getCalledFunction();
    if (!func) return false;
    
    std::string demangledName = getDemangledFunctionName(func);
    
    // Check for exact mpsc channel creation functions
    return (demangledName == "std::sync::mpsc::channel" ||
            demangledName == "std::sync::mpsc::sync_channel" ||
            demangledName == "tokio::sync::mpsc::channel" ||
            demangledName == "tokio::sync::mpsc::unbounded_channel" ||
            // Also check for test/mock versions without full std path
            demangledName == "mpsc::channel");
}

bool ChannelSemantics::isSendCall(llvm::CallInst* call) {
    Function* func = call->getCalledFunction();
    if (!func) return false;
    
    std::string demangledName = getDemangledFunctionName(func);
    
    // Check for exact mpsc sender functions
    return (demangledName == "std::sync::mpsc::Sender::send" ||
            demangledName == "std::sync::mpsc::SyncSender::send" ||
            demangledName == "std::sync::mpsc::SyncSender::try_send" ||
            demangledName == "tokio::sync::mpsc::Sender::send" ||
            demangledName == "tokio::sync::mpsc::UnboundedSender::send" ||
            // Also check for test/mock versions without full std path
            demangledName == "mpsc::Sender::send");
}

bool ChannelSemantics::isRecvCall(llvm::CallInst* call) {
    Function* func = call->getCalledFunction();
    if (!func) return false;
    
    std::string demangledName = getDemangledFunctionName(func);
    
    // Check for exact mpsc receiver functions
    return (demangledName == "std::sync::mpsc::Receiver::recv" ||
            demangledName == "std::sync::mpsc::Receiver::try_recv" ||
            demangledName == "std::sync::mpsc::Receiver::recv_timeout" ||
            demangledName == "tokio::sync::mpsc::Receiver::recv" ||
            demangledName == "tokio::sync::mpsc::UnboundedReceiver::recv" ||
            // Also check for test/mock versions without full std path
            demangledName == "mpsc::Receiver::recv");
}

ChannelOperation* ChannelSemantics::analyzeChannelCall(llvm::CallInst* call, Context context) {
    if (!isChannelOperation(call)) {
        return nullptr;
    }
    
    if (isChannelCreateCall(call)) {
        // Handle channel creation: let (tx, rx) = mpsc::channel(1);
        ChannelInfo* channel_info = createChannelInfo(call, context);
        
        // The channel creation call doesn't reference a specific channel info yet
        return new ChannelOperation(ChannelOperation::CHANNEL_CREATE, call, channel_info);
        
    } else if (isSendCall(call)) {
        // Handle send operation: tx.send(value).await
        // First operand is typically the sender (self)
        // Second operand is the data being sent
        
        Value* sender = call->getArgOperand(0);  // self (sender)
        Value* data = call->getArgOperand(1);    // data being sent
        
        ChannelInfo* channel_info = getChannelInfo(sender);
        if (!channel_info) {
            // Try to find the channel creation call that this sender came from
            channel_info = findChannelInfoForValue(sender);
            if (channel_info) {
                // Register this sender with the found channel
                channel_map[sender] = channel_info;
                // Update the channel info to include this sender
                if (!channel_info->sender_value) {
                    channel_info->sender_value = sender;
                }
            }
        }
        
        return new ChannelOperation(ChannelOperation::SEND, call, channel_info, data);
        
    } else if (isRecvCall(call)) {
        // Handle receive operation: rx.recv().await
        // First operand is typically the receiver (self)
        
        Value* receiver = call->getArgOperand(0);  // self (receiver)
        
        ChannelInfo* channel_info = getChannelInfo(receiver);
        if (!channel_info) {
            // Try to find the channel creation call that this receiver came from
            channel_info = findChannelInfoForValue(receiver);
            if (channel_info) {
                // Register this receiver with the found channel
                channel_map[receiver] = channel_info;
                // Update the channel info to include this receiver
                if (!channel_info->receiver_value) {
                    channel_info->receiver_value = receiver;
                }
            }
        }
        
        return new ChannelOperation(ChannelOperation::RECV, call, channel_info, nullptr);
    }
    
    return nullptr;
}

ChannelInfo* ChannelSemantics::createChannelInfo(llvm::CallInst* channel_create, Context context) {
    // Check if we've already processed this channel creation
    for (ChannelInfo* existing : channels) {
        if (existing->channel_id == channel_create) {
            return existing;  // Return existing channel info
        }
    }
    
    // Create a unique channel ID based on the call instruction
    Value* channel_id = channel_create;
    
    // Create new channel info only if we haven't seen this channel_create before
    // Use placeholder values for sender and receiver (will be resolved during actual send/recv operations)
    ChannelInfo* channel_info = new ChannelInfo(
        channel_id,      // channel_id
        nullptr,         // sender_value (placeholder)
        nullptr,         // receiver_value (placeholder)
        nullptr,         // data_type (will be determined later)
        channel_create,  // creation_call
        context          // context
    );
    
    // Store the channel instance
    channels.push_back(channel_info);
    
    return channel_info;
}

ChannelInfo* ChannelSemantics::getChannelInfo(llvm::Value* value) {
    auto it = channel_map.find(value);
    if (it != channel_map.end()) {
        return it->second;
    }
    return nullptr;
}

void ChannelSemantics::applyChannelConstraints(PointerAnalysis* analysis) {
    // Apply channel-specific constraints to the pointer analysis
    
    for (ChannelOperation* op : channel_operations) {
        if (op->operation == ChannelOperation::SEND) {
            // For send operations, create a constraint that data flows from
            // the sent value to the corresponding receiver
            
            ChannelInfo* channel_info = op->channel_info;
            
            if (channel_info && op->data_value) {
                // Find all receive operations on the same channel
                for (ChannelOperation* recv_op : channel_operations) {
                    if (recv_op->operation == ChannelOperation::RECV && 
                        recv_op->channel_info == channel_info) {
                        
                        // Create constraint: op->data_value flows to recv_op->instruction
                        Node* sendNode = analysis->getOrCreateNode(op->data_value);
                        Node* recvNode = analysis->getOrCreateNode(recv_op->instruction);
                        
                        // Add to worklist as an assignment constraint
                        analysis->Worklist.push_back({Assign, sendNode, recvNode});
                    }
                }
            }
            
        } else if (op->operation == ChannelOperation::RECV) {
            // Receive operations are handled when processing send operations
            // But we could add additional constraints here if needed
        }
    }
}

void ChannelSemantics::printChannelInfo(llvm::raw_ostream& os) {
    os << "=== Channel Semantics Analysis ===\n";
    
    os << "Channel Instances (" << channels.size() << "):\n";
    for (ChannelInfo* channel : channels) {
        os << "  Channel ID: ";
        if (channel->channel_id) {
            channel->channel_id->print(os);
        } else {
            os << "null";
        }
        os << "\n";
        
        os << "    Sender: ";
        if (channel->sender_value) {
            channel->sender_value->print(os);
        } else {
            os << "null";
        }
        os << "\n";
        
        os << "    Receiver: ";
        if (channel->receiver_value) {
            channel->receiver_value->print(os);
        } else {
            os << "null";
        }
        os << "\n";
    }
    
    os << "\nChannel Operations (" << channel_operations.size() << "):\n";
    for (ChannelOperation* op : channel_operations) {
        os << "  ";
        switch (op->operation) {
            case ChannelOperation::SEND:
                os << "SEND";
                break;
            case ChannelOperation::RECV:
                os << "RECV";
                break;
            case ChannelOperation::CHANNEL_CREATE:
                os << "CREATE";
                break;
        }
        os << " - Instruction: ";
        if (op->instruction) {
            op->instruction->print(os);
        }
        os << "\n";
    }
    
    os << "\nChannel Mappings (" << channel_map.size() << "):\n";
    for (auto& pair : channel_map) {
        os << "  Value: ";
        pair.first->print(os);
        os << " -> Channel ID: ";
        if (pair.second->channel_id) {
            pair.second->channel_id->print(os);
        }
        os << "\n";
    }
}

std::string ChannelSemantics::extractChannelType(llvm::Function* func) {
    if (!func) return "";
    
    std::string demangledName = getDemangledFunctionName(func);
    
    // Check for exact mpsc channel functions
    if (demangledName == "std::sync::mpsc::channel" ||
        demangledName == "std::sync::mpsc::sync_channel" ||
        demangledName == "std::sync::mpsc::Sender::send" ||
        demangledName == "std::sync::mpsc::SyncSender::send" ||
        demangledName == "std::sync::mpsc::SyncSender::try_send" ||
        demangledName == "std::sync::mpsc::Receiver::recv" ||
        demangledName == "std::sync::mpsc::Receiver::try_recv" ||
        demangledName == "std::sync::mpsc::Receiver::recv_timeout" ||
        demangledName == "tokio::sync::mpsc::channel" ||
        demangledName == "tokio::sync::mpsc::unbounded_channel" ||
        demangledName == "tokio::sync::mpsc::Sender::send" ||
        demangledName == "tokio::sync::mpsc::UnboundedSender::send" ||
        demangledName == "tokio::sync::mpsc::Receiver::recv" ||
        demangledName == "tokio::sync::mpsc::UnboundedReceiver::recv" ||
        // Also check for test/mock versions without full std path
        demangledName == "mpsc::channel" ||
        demangledName == "mpsc::Sender::send" ||
        demangledName == "mpsc::Receiver::recv") {
        return "mpsc";
    }
    
    // Check for exact oneshot channel functions
    if (demangledName == "tokio::sync::oneshot::channel" ||
        demangledName == "tokio::sync::oneshot::Sender::send" ||
        demangledName == "tokio::sync::oneshot::Receiver::recv" ||
        demangledName == "oneshot::channel" ||
        demangledName == "oneshot::Sender::send" ||
        demangledName == "oneshot::Receiver::recv") {
        return "oneshot";
    }
    
    // Check for exact broadcast channel functions  
    if (demangledName == "tokio::sync::broadcast::channel" ||
        demangledName == "tokio::sync::broadcast::Sender::send" ||
        demangledName == "tokio::sync::broadcast::Receiver::recv" ||
        demangledName == "broadcast::channel" ||
        demangledName == "broadcast::Sender::send" ||
        demangledName == "broadcast::Receiver::recv") {
        return "broadcast";
    }
    
    return "unknown";
}

ChannelInfo* ChannelSemantics::findChannelInfoForValue(llvm::Value* value) {
    // Try to trace back this value to see if it came from a channel creation
    if (auto* extract = dyn_cast<ExtractValueInst>(value)) {
        // This value is an extractvalue instruction, check what it's extracting from
        Value* source = extract->getAggregateOperand();
        if (auto* call = dyn_cast<CallInst>(source)) {
            // The source is a call instruction, check if it's a channel creation
            if (isChannelCreateCall(call)) {
                // Find the existing channel info for this creation call
                for (ChannelInfo* existing : channels) {
                    if (existing->channel_id == call) {
                        return existing;
                    }
                }
            }
        }
    }
    return nullptr;
} 