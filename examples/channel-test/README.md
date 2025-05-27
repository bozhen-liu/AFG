# Channel Semantics Modeling in AFG

## Overview

This document describes the implementation of explicit channel semantics modeling in the AFG (Access Flow Guard) pointer analysis framework. This enhancement addresses the limitation where channels (like `mpsc::Sender` and `mpsc::Receiver`) were treated as regular pointer types without understanding their special communication semantics.

## Problem Statement

### Before Channel Semantics Modeling

The original pointer analysis had the following limitations:

1. **Missing Data Flow**: When `tx.send(value)` and `rx.recv()` operations occurred, the analysis didn't connect the data flow between sender and receiver.

2. **Incomplete Taint Propagation**: If a tainted value was sent through a channel, the taint might not propagate to the received value.

3. **No Channel-Specific Constraints**: Channel operations were treated as regular function calls, missing the special semantics of inter-thread communication.

### Example Problem

```rust
let (tx, rx) = mpsc::channel();
let tainted_data = get_tainted_value();
tx.send(tainted_data).await.unwrap();    // Send tainted data
let received = rx.recv().await.unwrap(); // Should be tainted but wasn't detected
```

## Solution: Explicit Channel Semantics

### Key Components

#### 1. Channel Endpoint Representation (`ChannelEndpoint`)

```cpp
struct ChannelEndpoint {
    enum Type { SENDER, RECEIVER };

    Type type;                    // SENDER or RECEIVER
    llvm::Value* endpoint_value;  // The sender/receiver value
    llvm::Value* channel_id;      // Unique identifier for the channel pair
    llvm::Type* data_type;        // Type of data being transmitted
};
```

#### 2. Channel Operation Tracking (`ChannelOperation`)

```cpp
struct ChannelOperation {
    enum OpType { SEND, RECV, CHANNEL_CREATE };

    OpType operation;             // Type of operation
    llvm::Instruction* instruction; // The LLVM instruction
    ChannelEndpoint* endpoint;    // Associated endpoint
    llvm::Value* data_value;      // Data being sent/received
};
```

#### 3. Channel Semantics Analyzer (`ChannelSemantics`)

The main class that:

- Identifies channel operations in LLVM IR
- Tracks channel endpoint relationships
- Applies channel-specific constraints to pointer analysis

## Implementation Details

### Channel Operation Detection

The system detects channel operations by analyzing function names in LLVM IR:

```cpp
bool ChannelSemantics::isSendCall(llvm::CallInst* call) {
    Function* func = call->getCalledFunction();
    if (!func) return false;

    std::string funcName = func->getName().str();

    // Look for send operation patterns
    return (funcName.find("send") != std::string::npos ||
            funcName.find("Send") != std::string::npos) &&
           (funcName.find("Sender") != std::string::npos ||
            funcName.find("mpsc") != std::string::npos);
}
```

### Data Flow Modeling

When a send operation is detected, the system creates constraints that model data flow from sender to receiver:

```cpp
void ChannelSemantics::applyChannelConstraints(PointerAnalysis* analysis) {
    for (ChannelOperation* op : channel_operations) {
        if (op->operation == ChannelOperation::SEND) {
            ChannelEndpoint* sender_endpoint = op->endpoint;
            ChannelEndpoint* receiver_endpoint = getCorrespondingEndpoint(sender_endpoint);

            if (receiver_endpoint && op->data_value) {
                // Find all receive operations on the corresponding endpoint
                for (ChannelOperation* recv_op : channel_operations) {
                    if (recv_op->operation == ChannelOperation::RECV &&
                        recv_op->endpoint == receiver_endpoint) {

                        // Create constraint: sent_data -> received_data
                        Node* sendNode = analysis->getOrCreateNode(op->data_value);
                        Node* recvNode = analysis->getOrCreateNode(recv_op->instruction);

                        analysis->Worklist.push_back({Assign, sendNode, recvNode});
                    }
                }
            }
        }
    }
}
```

### Integration with Pointer Analysis

The channel semantics are integrated into the main pointer analysis workflow:

1. **Detection Phase**: During `handleCallInst`, channel operations are detected and recorded
2. **Analysis Phase**: After main pointer analysis, `analyzeChannelOperations()` processes channel relationships
3. **Constraint Integration**: `integrateChannelConstraints()` applies channel-specific constraints
4. **Re-solving**: Constraints are re-solved with the new channel constraints

## Benefits

### 1. Accurate Taint Propagation

```rust
// Before: Taint not propagated through channel
let tainted = get_tainted_data();
tx.send(tainted).await.unwrap();
let received = rx.recv().await.unwrap(); // Not detected as tainted

// After: Taint correctly propagated
let tainted = get_tainted_data();        // Tainted
tx.send(tainted).await.unwrap();         // Send tainted data
let received = rx.recv().await.unwrap(); // Now correctly detected as tainted
```

### 2. Inter-thread Data Flow Analysis

The system can now track data flow across thread boundaries through channels, enabling:

- Detection of data leaks through channels
- Access control policy enforcement across threads
- Better understanding of concurrent program behavior

### 3. Channel-Specific Security Analysis

- **Use-after-close detection**: Identify attempts to use closed channels
- **Data race analysis**: Detect potential races in channel usage
- **Capacity analysis**: Understand channel buffer behavior

## Building and Testing

### Prerequisites

Ensure you have the required dependencies installed:

- LLVM 17.0.6
- CMake 3.20.0+
- Rust toolchain (for compiling test examples)

### Build Instructions

**Run from project root directory:**

```bash
# Create and enter build directory
mkdir build
cd build

# Configure and build
cmake -DLLVM_DIR=$(llvm-config --cmakedir) ..
make
```

This will generate `libPointerAnalysisPass.so` in the project root directory.

### Testing Channel Semantics

#### Test 1: Manual Channel Test (Recommended)

**Run from build directory:**

```bash
# Test with the manual channel test case
/opt/homebrew/Cellar/llvm@17/17.0.6/bin/opt \
  -load-pass-plugin ./libPointerAnalysisPass.so \
  -passes=pointer-analysis \
  -disable-output \
  ../examples/channel-test/channel-test-manual.ll
```

**Expected Output:**

```
=== Channel Semantics Analysis ===
Channel Endpoints (2):
  RECEIVER - Value: %receiver = extractvalue { ptr, ptr } %channel_result, 1
  SENDER - Value: %sender = extractvalue { ptr, ptr } %channel_result, 0

Channel Operations (3):
  CREATE - Instruction: %channel_result = call { ptr, ptr } @_ZN4mpsc7channel...
  SEND - Instruction: %send_result = call i32 @_ZN4mpsc6Sender4send...
  RECV - Instruction: %recv_result = call ptr @_ZN4mpsc8Receiver4recv...

Channel Pairs (1):
  Channel ID: %channel_result = call { ptr, ptr } @_ZN4mpsc7channel...
```

#### Test 2: Baseline Test (No Channels)

**Run from build directory:**

```bash
# Test with existing demo (should show no channel operations)
/opt/homebrew/Cellar/llvm@17/17.0.6/bin/opt \
  -load-pass-plugin ./libPointerAnalysisPass.so \
  -passes=pointer-analysis \
  -disable-output \
  ../examples/demo/demo-r68_llvm17_map.ll
```

**Expected Output:**

```
=== Channel Semantics Analysis ===
Channel Endpoints (0):
Channel Operations (0):
Channel Pairs (0):
```

#### Test 3: Rust Channel Example (Optional)

If you want to test with the Rust source code:

**Run from build directory:**

```bash
# Compile Rust code to LLVM IR (requires Rust 1.68.0 for compatibility)
cd ../examples/channel-test
cargo rustc -- --emit=llvm-ir
cd ../../build

# Run analysis on generated IR
/opt/homebrew/Cellar/llvm@17/17.0.6/bin/opt \
  -load-pass-plugin ./libPointerAnalysisPass.so \
  -passes=pointer-analysis \
  -disable-output \
  ../examples/channel-test/target/debug/deps/channel_test-*.ll
```

### Verification Checklist

- [x] Build completes successfully with `make`

- [x] `libPointerAnalysisPass.so` is generated in build directory
- [x] Manual channel test shows detected endpoints and operations
- [x] Baseline test shows no channel operations (as expected)
- [x] No compilation errors or warnings

## Usage Example

### Test Case (channel-test-manual.ll)

The manual test case demonstrates:

```llvm
; Mock channel creation
%channel_result = call {ptr, ptr} @_ZN4mpsc7channel17h1234567890abcdefE()

; Mock send operation
%sender = extractvalue {ptr, ptr} %channel_result, 0
%send_result = call i32 @_ZN4mpsc6Sender4send17h1234567890abcdefE(ptr %sender, ptr %data)

; Mock receive operation
%receiver = extractvalue {ptr, ptr} %channel_result, 1
%recv_result = call ptr @_ZN4mpsc8Receiver4recv17h1234567890abcdefE(ptr %receiver)
```

### Rust Source Example (src/main.rs)

```rust
use std::sync::mpsc;
use std::thread;

fn main() {
    let (tx, rx) = mpsc::channel();

    let sender_handle = thread::spawn(move || {
        let data = 42;
        tx.send(data).unwrap();  // SEND operation detected
    });

    let receiver_handle = thread::spawn(move || {
        let received = rx.recv().unwrap();  // RECV operation detected
        received
    });

    sender_handle.join().unwrap();
    let result = receiver_handle.join().unwrap();
}
```

## Future Enhancements

### 1. Advanced Channel Types

- **Oneshot channels**: Single-use channels
- **Broadcast channels**: One-to-many communication
- **Select operations**: Multi-channel operations

### 2. Async/Await Support

Enhanced support for async channel operations:

```rust
async fn async_send(tx: Sender<i32>, data: i32) {
    tx.send(data).await.unwrap();
}
```

### 3. Channel Capacity Analysis

Track channel buffer states and detect:

- Buffer overflow conditions
- Deadlock potential
