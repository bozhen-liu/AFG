# AFG Test Framework

This directory contains the comprehensive test framework for the AFG (Access Flow Guard) pointer analysis project. The framework provides automated testing for all analysis modes and channel semantics functionality.

## Architecture

### Test Categories

The test framework is organized into the following categories:

#### 1. **Pointer Analysis Tests** (`tests/pointer/`)

- Basic pointer operations (store, load, alloca)
- Inter-procedural analysis
- Global variable handling
- Function parameter propagation
- Multiple pointer scenarios
- Vtable processing and indirect calls

#### 2. **Context-Sensitive Analysis Tests** (`tests/context/`)

- K-callsite sensitivity with different K values
- Context propagation through call chains
- Recursive function handling
- Function pointer analysis
- Context comparison between analysis modes

#### 3. **Taint Analysis Tests** (`tests/taint/`)

- Taint configuration loading
- Origin context tracking
- Taint propagation through pointers
- Multiple tainted objects
- Context-sensitive taint analysis

#### 4. **Channel Semantics Tests** (`tests/channel/`)

- Channel creation detection
- Send/Receive operation identification
- Data flow through channels
- Channel constraint application
- Tokio and std::sync::mpsc support
- Real Rust mangled function names

#### 5. **Integration Tests** (`tests/integration/`)

- End-to-end analysis comparison
- Complex multi-threaded scenarios
- Real-world Rust simulation
- Performance and scalability
- Error handling and edge cases
- Advanced LLVM instructions (PHI, atomic, invoke, bitcast)
- Output format validation

## Building and Running Tests

### Prerequisites

Ensure you have the following installed:

- LLVM 17.0.6
- CMake 3.20.0+
- [nlohmann/json](https://github.com/nlohmann/json) library
- C++17 compiler

### Build Instructions

1. **Build the main project first:**

   ```bash
   # From the AFG root directory
   mkdir build
   cd build
   cmake -DLLVM_DIR=$(llvm-config --cmakedir) ..
   make
   ```

2. **Build the test framework:**

   ```bash
   # From the AFG root directory
   cd tests
   mkdir -p build
   cd build
   cmake ..
   make
   ```

   The test framework has its own build system and will link against the main project's libraries.

### Running Tests

From the `tests/build/` directory:

```bash
# Build tests first
cd tests/build
make

# Run all tests
./afg_tests

# Run specific test categories
./afg_tests --category pointer
./afg_tests --category context
./afg_tests --category taint
./afg_tests --category channel
./afg_tests --category integration

# Alternative: Using CMake/CTest from main build directory
cd ../../build
ctest

# Run specific test suites
ctest -R pointer_analysis_tests
ctest -R channel_analysis_tests
```

### Test Framework Features

#### Programmatic Testing

- **Automatic LLVM IR loading** from test files
- **Analysis execution** with different modes (basic, kcs, origin)
- **Result validation** with assertions
- **Output capture** and analysis
- **Detailed call graph analysis** with function instance tracking
- **Context differentiation validation** for correctness testing

#### Test Assertions

##### Basic Assertions

```cpp
framework.assert_true(condition, "message");
framework.assert_equals(expected, actual, "message");
framework.assert_contains(text, substring, "message");
framework.assert_greater_than(actual, expected, "message");
```

##### Advanced Correctness Assertions

```cpp
// Direct data structure access assertions
framework.assert_points_to_map_size(expected_size, "message", result);
framework.assert_call_graph_nodes_count(expected_nodes, "message", result);
framework.assert_call_graph_edges_count(expected_edges, "message", result);
framework.assert_visited_functions_count(expected_count, "message", result);

// Comparative assertions
framework.assert_points_to_map_size_greater_than(threshold, "message", result);
framework.assert_call_graph_nodes_count_greater_than(threshold, "message", result);
framework.assert_call_graph_edges_count_greater_than(threshold, "message", result);

// Function presence validation
framework.assert_function_in_call_graph("function_name", "message", result);
framework.assert_function_in_visited_set("function_name", "message", result);

// Legacy assertion methods (still available)
framework.assert_function_instance_count("function_name", expected_count, "message", result);
framework.assert_context_differentiation("function_name", {"context1", "context2"}, "message", result);

// Print detailed analysis breakdown for debugging
framework.print_detailed_analysis(result);
```

#### Detailed Analysis Results

The framework provides comprehensive analysis details with direct access to analysis data structures:

```cpp
struct TestResult {
    bool passed;
    std::string message;
    std::string expected;
    std::string actual;
    
    // Direct access to analysis data structures
    std::unordered_map<uint64_t, Node *> idToNodeMap;    // Direct access to node map
    CallGraph callGraph;                                  // Direct access to call graph
    std::unordered_set<Function *> visitedFunctions;     // Direct access to visited functions
    
    // Derived information computed from analysis data structures
    std::map<std::string, int> function_instance_counts;  // Function name -> number of instances
    std::vector<std::string> function_contexts;           // All function contexts found
    std::string raw_output;                               // Complete analysis output for debugging
};
```

## Test Examples

### Basic Pointer Analysis Test

```cpp
framework.start_test("Basic Store/Load Analysis");
auto result = framework.runPointerAnalysis("pointer/simple.ll");
framework.assert_true(result.passed, "Analysis should complete");
framework.assert_points_to_map_size_greater_than(0, "Should create points-to relationships", result);
framework.assert_call_graph_nodes_count_greater_than(0, "Should create call graph nodes", result);
```

### Channel Semantics Test

```cpp
framework.start_test("Channel Creation Detection");
auto result = framework.runPointerAnalysis("channel/channel_create_test.ll");
framework.assert_true(result.passed, "Channel creation analysis should succeed");
framework.assert_call_graph_nodes_count_greater_than(0, "Should create call graph nodes for channel operations", result);
framework.assert_contains(result.actual, "Channels:", "Should detect channel instances");
```

### Context-Sensitive Correctness Validation

```cpp
framework.start_test("Basic vs K-Callsite Correctness Comparison");

// Run both analysis modes on the same input
auto basic_result = framework.runPointerAnalysis("pointer/simple.ll", "basic");
auto kcs_result = framework.runPointerAnalysis("pointer/simple.ll", "kcs", 2);

// Validate correctness differences using direct data structure access
framework.assert_function_instance_count("callee", 1, "Basic analysis should merge all callee instances", basic_result);
framework.assert_function_instance_count("callee", 2, "K=2 analysis should differentiate callee contexts", kcs_result);

// Validate precision using direct access to call graph
framework.assert_true(kcs_result.callGraph.numNodes() >= basic_result.callGraph.numNodes(),
                     "K-callsite should maintain or increase call graph precision");

// Validate that functions are present in call graph
framework.assert_function_in_call_graph("callee", "Callee should be in call graph", kcs_result);
framework.assert_function_in_visited_set("callee", "Callee should be visited", kcs_result);

// Validate context differentiation
std::vector<std::string> expected_contexts = {"caller1", "caller2"};
framework.assert_context_differentiation("callee", expected_contexts,
                                       "Should create distinct contexts for different call paths", kcs_result);

// Print detailed analysis for inspection
framework.print_detailed_analysis(kcs_result);
```

### Advanced Analysis Comparison

```cpp
framework.start_test("Cross-Analysis Consistency Validation");

auto basic_result = framework.runPointerAnalysis("test.ll", "basic");
auto kcs_result = framework.runPointerAnalysis("test.ll", "kcs", 2);

// Validate consistency using direct data structure access
framework.assert_visited_functions_count(basic_result.visitedFunctions.size(),
                                        "K-callsite should visit same number of functions as basic", kcs_result);

// Validate precision improvement using direct access
framework.assert_true(kcs_result.callGraph.numNodes() >= basic_result.callGraph.numNodes(),
                    "Context-sensitive analysis should maintain or increase precision");

// Additional direct validations
framework.assert_points_to_map_size_greater_than(0, "Should create points-to relationships", kcs_result);
framework.assert_call_graph_edges_count_greater_than(0, "Should create call graph edges", kcs_result);
```

## Expected Output Format

The test framework validates that analysis results contain:

```
PointsToMap: X nodes
CallGraph: Y nodes, Z edges
Visited functions: N
Channels: M instances, P operations
```

## Adding New Tests

### 1. Create LLVM IR Test Files

Create `.ll` files in the appropriate category directory:

```llvm
; tests/category/new_test.ll
; Description of what this test validates
define void @test_function() {
entry:
  ; Test case implementation
  %ptr = alloca i32, align 4
  store i32 42, ptr %ptr, align 4
  ret void
}

define i32 @main() {
entry:
  call void @test_function()
  ret i32 0
}
```

### 2. Add Test Functions

Add new test functions to the appropriate category file:

```cpp
// In tests/category/category_tests.cpp
void run_category_tests(AFGTestFramework& framework) {
    framework.start_category("Category Name");

    {
        framework.start_test("New Test Name");
        auto result = framework.runPointerAnalysis("category/new_test.ll", "basic");
        framework.assert_true(result.passed, "Should succeed");
        framework.assert_contains(result.actual, "PointsToMap:", "Should report results");
    }
}
```

### 3. Create Configuration Files (if needed)

For taint analysis tests, create corresponding JSON files:

```json
// tests/category/new_test_config.json
{
  "tagged_objects": ["%tainted_var = alloca i32, align 4"]
}
```

### 4. Update CMakeLists.txt

If adding a new category, update `tests/CMakeLists.txt`:

```cmake
add_executable(afg_tests
    test.cpp
    pointer/pointer_tests.cpp
    context/context_tests.cpp
    taint/taint_tests.cpp
    channel/channel_tests.cpp
    integration/integration_tests.cpp
    new_category/new_category_tests.cpp  # Add new category
)

add_test(NAME new_category_tests COMMAND afg_tests --category new_category)

# Copy test data files (including new category)
file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/new_category/ DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/new_category/)
```

## Test Validation

### Channel Semantics Validation

The framework validates that your channel implementation correctly:

1. **Detects Channel Operations**:

   - `std::sync::mpsc::channel()` creation
   - `Sender::send()` operations
   - `Receiver::recv()` operations
   - Tokio async variants

2. **Creates Proper Constraints**:

   - Data flow from send to receive
   - Channel instance tracking
   - Sender/receiver endpoint mapping

3. **Integrates with Pointer Analysis**:
   - Channel constraints in constraint solver
   - Proper points-to relationships
   - Context-sensitive channel handling

### Taint Analysis Validation

For taint analysis tests:

1. **Configuration Loading**: JSON taint config parsing
2. **Taint Propagation**: Through pointers and function calls
3. **Origin Tracking**: Context-sensitive taint tracking
4. **Tagged Object Detection**: Matching LLVM IR to config

### Context-Sensitive Analysis Correctness Validation

The framework now includes comprehensive correctness validation for pointer analysis modes:

1. **Function Instance Counting**: Validates that context-sensitive analysis correctly differentiates function instances:

   - Basic analysis: context-insensitive (merges all contexts)
   - K-callsite analysis: context-sensitive (separates different call contexts)

2. **Context Differentiation Testing**:

   - Validates that different call paths create distinct contexts
   - Verifies context string format and content
   - Ensures proper context propagation through call chains

3. **Cross-Analysis Consistency**:

   - Compares results between analysis modes for consistency
   - Validates that context-sensitive analysis maintains or improves precision
   - Ensures all modes visit the same set of functions

4. **Specific Correctness Assertions**:
   ```cpp
   // Example: simple.ll with callee called from caller1 and caller2
   framework.assert_function_instance_count("callee", 1, "Basic should merge contexts", basic_result);
   framework.assert_function_instance_count("callee", 2, "K=2 should differentiate contexts", kcs_result);
   ```

### Debug Mode

Enable debug output for detailed analysis information:

```cpp
PA->DebugMode = true;  // In test framework
```

## Test Coverage Achievements

The AFG test framework provides **complete coverage** of all functionality:

### **LLVM Instruction Coverage**

- ✅ Basic instructions: `alloca`, `store`, `load`, `call`
- ✅ Control flow: `PHI` nodes, branching, loops
- ✅ Memory operations: `getelementptr`, `bitcast`
- ✅ Advanced operations: `atomicrmw`, `cmpxchg`, `invoke`
- ✅ Function calls: Direct, indirect, and vtable-based

### **Analysis Mode Coverage**

- ✅ Basic pointer analysis
- ✅ K-callsite context sensitivity (K=1,2,3+)
- ✅ Origin-based taint tracking
- ✅ Channel semantics integration

### **Real-world Pattern Alignment**

- ✅ Rust mangled function names
- ✅ Complex multi-threading scenarios
- ✅ Production-level complexity matching examples
- ✅ Error handling and edge cases

**Result: All tests passing with enhanced correctness validation**

The test framework now provides rigorous correctness validation specifically designed to differentiate between context-sensitive and context-insensitive pointer analysis behavior, ensuring accurate implementation of both basic and K-callsite analysis modes.
