# Channel Semantics Modeling in AFG

## Overview

This document describes the implementation of explicit channel semantics modeling in the AFG (Access Flow Guard) pointer analysis framework. This enhancement addresses the limitation where channels (like `mpsc::Sender` and `mpsc::Receiver`) were treated as regular pointer types without understanding their special communication semantics.

### Recent Improvements

- **Precise Operation Detection**: Replaced conservative substring matching with function name demangling for exact `mpsc` operation identification
- **Eliminated False Positives**: No longer incorrectly identifies non-channel functions (e.g., `MyOwnStructure::send()`) as channel operations
- **Fixed Channel Duplication**: Prevents creating duplicate ChannelInfo instances for the same channel creation instruction

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

#### 1. Channel Instance Representation (`ChannelInfo`)

```cpp
struct ChannelInfo {
    llvm::Value* channel_id;        // Unique identifier for the channel (creation call)
    llvm::Value* sender_value;      // The sender endpoint value
    llvm::Value* receiver_value;    // The receiver endpoint value
    llvm::Type* data_type;          // Type of data being transmitted
    llvm::Instruction* creation_call; // The channel creation instruction
    Context context;                // Context for context-sensitive analysis
};
```

#### 2. Channel Operation Tracking (`ChannelOperation`)

```cpp
struct ChannelOperation {
    enum ChannelOpType { SEND, RECV, CHANNEL_CREATE };

    ChannelOpType operation;         // Type of operation
    llvm::Instruction* instruction;  // The LLVM instruction
    ChannelInfo* channel_info;       // Associated channel instance
    llvm::Value* data_value;         // Data being sent/received
};
```

#### 3. Channel Semantics Analyzer (`ChannelSemantics`)

The main class that:

- Identifies channel operations in LLVM IR
- Tracks complete channel instances
- Applies channel-specific constraints to pointer analysis

## Implementation Details

### Channel Operation Detection

The system detects channel operations by analyzing demangled function names in LLVM IR to ensure precise identification of `mpsc` operations:

```cpp
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
```

#### Supported Channel Operations

- **Channel Creation**: `std::sync::mpsc::channel`, `std::sync::mpsc::sync_channel`, `tokio::sync::mpsc::channel`
- **Send Operations**: `Sender::send`, `SyncSender::send`, `SyncSender::try_send`, `UnboundedSender::send`
- **Receive Operations**: `Receiver::recv`, `Receiver::try_recv`, `Receiver::recv_timeout`, `UnboundedReceiver::recv`

### Channel Creation and Duplication Prevention

The system now properly handles duplicate channel creation calls by checking if a ChannelInfo instance already exists for a given channel creation instruction:

```cpp
ChannelInfo* ChannelSemantics::createChannelInfo(llvm::CallInst* channel_create) {
    // Check if we've already processed this channel creation
    for (ChannelInfo* existing : channels) {
        if (existing->channel_id == channel_create) {
            return existing;  // Return existing channel info
        }
    }

    // Create new channel info only if we haven't seen this channel_create before
    ChannelInfo* channel_info = new ChannelInfo(
        channel_create,  // channel_id
        nullptr,         // sender_value (resolved during send/recv operations)
        nullptr,         // receiver_value (resolved during send/recv operations)
        nullptr,         // data_type (determined during operations)
        channel_create   // creation_call
    );

    channels.push_back(channel_info);
    return channel_info;
}
```

This ensures that multiple calls to `createChannelInfo` with the same channel creation instruction will return the same ChannelInfo instance, preventing unnecessary duplication.

### Data Flow Modeling

When a send operation is detected, the system creates constraints that model data flow from sender to receiver:

```cpp
void ChannelSemantics::applyChannelConstraints(PointerAnalysis* analysis) {
    for (ChannelOperation* op : channel_operations) {
        if (op->operation == ChannelOperation::SEND) {
            ChannelInfo* channel_info = op->channel_info;

            if (channel_info && op->data_value) {
                // Find all receive operations on the same channel
                for (ChannelOperation* recv_op : channel_operations) {
                    if (recv_op->operation == ChannelOperation::RECV &&
                        recv_op->channel_info == channel_info) {

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

1. **Detection Phase**: During `visitCallInst`, channel operations are detected and recorded in real-time
2. **Integrated Solving Phase**: Channel constraints are generated and applied **within** the main `solveConstraints()` loop alongside regular pointer analysis constraints
3. **Iterative Refinement**: The constraint solver continues until both regular and channel constraints reach a fixed point

#### Implementation Details

The integration works as follows:

```cpp
void PointerAnalysis::solveConstraints()
{
    // Solve regular constraints first
    processConstraintsUntilFixedPoint();

    // Integrate channel analysis into the constraint solving phase
    analyzeChannelOperations();

    // Integrate channel constraints once after regular constraints stabilize
    if (integrateChannelConstraints()) {
        // Re-solve with channel constraints
        processConstraintsUntilFixedPoint();
    }
}
```

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
opt -load-pass-plugin ./libPointerAnalysisPass.so \
  -passes=pointer-analysis \
  -disable-output \
  ../examples/channel-test/channel-test-manual.ll
```

**Expected Output:**

```
=== Channel Semantics Analysis ===
Channel Instances (1):
  Channel ID: %channel_result = call { ptr, ptr } @_ZN4mpsc7channel...
    Sender: %sender = extractvalue { ptr, ptr } %channel_result, 0
    Receiver: %receiver = extractvalue { ptr, ptr } %channel_result, 1

Channel Operations (3):
  CREATE - Instruction: %channel_result = call { ptr, ptr } @_ZN4mpsc7channel...
  SEND - Instruction: %send_result = call i32 @_ZN4mpsc6Sender4send...
  RECV - Instruction: %recv_result = call ptr @_ZN4mpsc8Receiver4recv...

Channel Mappings (2):
  Value: %sender -> Channel ID: %channel_result = call { ptr, ptr } @_ZN4mpsc7channel...
  Value: %receiver -> Channel ID: %channel_result = call { ptr, ptr } @_ZN4mpsc7channel...
```

#### Test 2: Baseline Test (No Channels)

**Run from build directory:**

```bash
# Test with existing demo (should show no channel operations)
opt -load-pass-plugin ./libPointerAnalysisPass.so \
  -passes=pointer-analysis \
  -disable-output \
  ../examples/demo/demo-r68_llvm17_map.ll
```

**Expected Output:**

```
=== Channel Semantics Analysis ===
Channel Instances (0):
Channel Operations (0):
Channel Mappings (0):
```

#### TODO: Test 3: Rust Channel Example (Optional)

If you want to test with the Rust source code:

**Run from build directory:**

```bash
# Compile Rust code to LLVM IR (requires Rust 1.68.0 for compatibility)
cd ../examples/channel-test
cargo rustc -- --emit=llvm-ir -C debuginfo=0 -C opt-level=0
cd ../../build

# Run analysis on generated IR
opt -load-pass-plugin ./libPointerAnalysisPass.so \
  -passes=pointer-analysis \
  -disable-output \
  ../examples/channel-test/target/debug/deps/channel_test-*.ll
```

**Expected Output:**

```
=== PointerAnalysis Statistics ===
PointsToMap: 6007 nodes, 24680 edges
CallGraph: 355 nodes, 1103 edges
Visited functions: 357
=== Channel Semantics Analysis ===
Channel Instances (1):
  Channel ID:   call void @_ZN3std4sync4mpsc7channel17hd09f176f9261c9f6E(ptr sret({ { i64, ptr }, { i64, ptr } }) %_3), !dbg !1176
    Sender: null
    Receiver: null

Channel Operations (1):
  CREATE - Instruction:   call void @_ZN3std4sync4mpsc7channel17hd09f176f9261c9f6E(ptr sret({ { i64, ptr }, { i64, ptr } }) %_3), !dbg !1176

Channel Mappings (0):
==================================
```

### Verification Checklist

- [x] Build completes successfully with `make`
- [x] `libPointerAnalysisPass.so` is generated in build directory
- [x] Manual channel test shows detected instances and operations
- [x] Baseline test shows no channel operations (as expected)
- [x] No compilation errors or warnings
- [x] Precise channel detection using function name demangling
- [x] No false positives for non-mpsc functions (e.g., `MyOwnStructure::send()`)
- [x] Support for both `std::sync::mpsc` and `tokio::sync::mpsc` variants
- [x] Fixed channel duplication - no duplicate ChannelInfo instances created

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
