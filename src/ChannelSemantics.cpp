#include "ChannelSemantics.h"
#include "PointerAnalysis.h"
#include "llvm/IR/Function.h"
#include "llvm/Support/raw_ostream.h"
#include <regex>

using namespace llvm;

bool ChannelSemantics::isChannelEndpoint(llvm::Value* value) {
    // Check if the value is already registered as a channel endpoint
    return endpoint_map.find(value) != endpoint_map.end();
}

bool ChannelSemantics::isChannelOperation(llvm::CallInst* call) {
    if (!call || !call->getCalledFunction()) {
        return false;
    }
    
    return isChannelCreateCall(call) || isSendCall(call) || isRecvCall(call);
}

bool ChannelSemantics::isChannelCreateCall(llvm::CallInst* call) {
    Function* func = call->getCalledFunction();
    if (!func) return false;
    
    std::string funcName = func->getName().str();
    
    // Look for channel creation patterns in function names
    // Examples: mpsc::channel, tokio::sync::mpsc::channel, etc.
    return funcName.find("mpsc") != std::string::npos && 
           funcName.find("channel") != std::string::npos;
}

bool ChannelSemantics::isSendCall(llvm::CallInst* call) {
    Function* func = call->getCalledFunction();
    if (!func) return false;
    
    std::string funcName = func->getName().str();
    
    // Look for send operation patterns
    // Examples: Sender::send, mpsc::Sender::send, etc.
    return (funcName.find("send") != std::string::npos || 
            funcName.find("Send") != std::string::npos) &&
           (funcName.find("Sender") != std::string::npos ||
            funcName.find("mpsc") != std::string::npos);
}

bool ChannelSemantics::isRecvCall(llvm::CallInst* call) {
    Function* func = call->getCalledFunction();
    if (!func) return false;
    
    std::string funcName = func->getName().str();
    
    // Look for receive operation patterns
    // Examples: Receiver::recv, mpsc::Receiver::recv, etc.
    return (funcName.find("recv") != std::string::npos || 
            funcName.find("Recv") != std::string::npos) &&
           (funcName.find("Receiver") != std::string::npos ||
            funcName.find("mpsc") != std::string::npos);
}

ChannelOperation* ChannelSemantics::analyzeChannelCall(llvm::CallInst* call) {
    if (!isChannelOperation(call)) {
        return nullptr;
    }
    
    if (isChannelCreateCall(call)) {
        // Handle channel creation: let (tx, rx) = mpsc::channel(1);
        auto endpoints = createChannelPair(call);
        
        // The channel creation call itself doesn't have an endpoint
        return new ChannelOperation(ChannelOperation::CHANNEL_CREATE, call, nullptr);
        
    } else if (isSendCall(call)) {
        // Handle send operation: tx.send(value).await
        // First operand is typically the sender (self)
        // Second operand is the data being sent
        
        Value* sender = call->getArgOperand(0);  // self (sender)
        Value* data = call->getArgOperand(1);    // data being sent
        
        ChannelEndpoint* endpoint = endpoint_map[sender];
        if (!endpoint) {
            // Create endpoint if not exists (might happen with complex IR)
            endpoint = new ChannelEndpoint(ChannelEndpoint::SENDER, sender, sender, data->getType());
            endpoint_map[sender] = endpoint;
        }
        
        return new ChannelOperation(ChannelOperation::SEND, call, endpoint, data);
        
    } else if (isRecvCall(call)) {
        // Handle receive operation: rx.recv().await
        // First operand is typically the receiver (self)
        
        Value* receiver = call->getArgOperand(0);  // self (receiver)
        
        ChannelEndpoint* endpoint = endpoint_map[receiver];
        if (!endpoint) {
            // Create endpoint if not exists
            endpoint = new ChannelEndpoint(ChannelEndpoint::RECEIVER, receiver, receiver, call->getType());
            endpoint_map[receiver] = endpoint;
        }
        
        return new ChannelOperation(ChannelOperation::RECV, call, endpoint);
    }
    
    return nullptr;
}

std::pair<ChannelEndpoint*, ChannelEndpoint*> ChannelSemantics::createChannelPair(llvm::CallInst* channel_create) {
    // For channel creation, we need to identify where the returned tuple is used
    // This is complex in LLVM IR as tuples are often destructured immediately
    
    // Create a unique channel ID based on the call instruction
    Value* channel_id = channel_create;
    
    // We'll need to analyze the users of this call to find the sender and receiver
    // For now, create placeholder endpoints
    ChannelEndpoint* sender = new ChannelEndpoint(ChannelEndpoint::SENDER, nullptr, channel_id, nullptr);
    ChannelEndpoint* receiver = new ChannelEndpoint(ChannelEndpoint::RECEIVER, nullptr, channel_id, nullptr);
    
    // Store the channel pair
    channel_pairs[channel_id] = std::make_pair(sender, receiver);
    
    return std::make_pair(sender, receiver);
}

ChannelEndpoint* ChannelSemantics::getCorrespondingEndpoint(ChannelEndpoint* endpoint) {
    // Find the channel pair this endpoint belongs to
    for (auto& pair : channel_pairs) {
        if (pair.second.first == endpoint) {
            return pair.second.second;  // Return receiver for sender
        } else if (pair.second.second == endpoint) {
            return pair.second.first;   // Return sender for receiver
        }
    }
    return nullptr;
}

void ChannelSemantics::applyChannelConstraints(PointerAnalysis* analysis) {
    // Apply channel-specific constraints to the pointer analysis
    
    for (ChannelOperation* op : channel_operations) {
        if (op->operation == ChannelOperation::SEND) {
            // For send operations, create a constraint that data flows from
            // the sent value to the corresponding receiver
            
            ChannelEndpoint* sender_endpoint = op->endpoint;
            ChannelEndpoint* receiver_endpoint = getCorrespondingEndpoint(sender_endpoint);
            
            if (receiver_endpoint && op->data_value) {
                // Create a flow constraint: sent_data -> received_data
                // This would integrate with the existing constraint system
                
                // Find all receive operations on the corresponding endpoint
                for (ChannelOperation* recv_op : channel_operations) {
                    if (recv_op->operation == ChannelOperation::RECV && 
                        recv_op->endpoint == receiver_endpoint) {
                        
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
    
    os << "Channel Endpoints (" << endpoint_map.size() << "):\n";
    for (auto& pair : endpoint_map) {
        ChannelEndpoint* endpoint = pair.second;
        os << "  " << (endpoint->type == ChannelEndpoint::SENDER ? "SENDER" : "RECEIVER");
        os << " - Value: ";
        if (endpoint->endpoint_value) {
            endpoint->endpoint_value->print(os);
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
    
    os << "\nChannel Pairs (" << channel_pairs.size() << "):\n";
    for (auto& pair : channel_pairs) {
        os << "  Channel ID: ";
        pair.first->print(os);
        os << "\n";
    }
}

std::string ChannelSemantics::extractChannelType(llvm::Function* func) {
    if (!func) return "";
    
    std::string funcName = func->getName().str();
    
    // Extract channel type information from mangled function names
    // This is a simplified version - real implementation would need
    // more sophisticated demangling
    
    if (funcName.find("mpsc") != std::string::npos) {
        return "mpsc";
    } else if (funcName.find("oneshot") != std::string::npos) {
        return "oneshot";
    } else if (funcName.find("broadcast") != std::string::npos) {
        return "broadcast";
    }
    
    return "unknown";
} 