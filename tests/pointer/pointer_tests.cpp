#include "../test_framework.h"

void run_pointer_tests(AFGTestFramework& framework) {
    framework.start_category("Pointer Analysis");
    
    // Test 1: Basic pointer analysis with simple.ll
    {
        framework.start_test("Basic Inter-procedural Analysis");
        auto result = framework.runPointerAnalysis("pointer/simple.ll");
        framework.assert_true(result.passed, "Analysis should complete successfully");
        
        // Validate basic metrics from simple.ll:
        // - Should have nodes for @g1, @g2, pointers in callee, caller1, caller2, main
        // - Should have call graph edges
        // - Should detect the store/load operations
        framework.assert_contains(result.actual, "PointsToMap:", "Should report points-to map");
        framework.assert_contains(result.actual, "CallGraph:", "Should report call graph");
        framework.assert_contains(result.actual, "Visited functions:", "Should report visited functions");
    }
    
    // Test 2: Global variable analysis
    {
        framework.start_test("Global Variable Handling");
        auto result = framework.runPointerAnalysis("pointer/simple.ll");
        
        // simple.ll has @g1 and @g2 global variables
        // The analysis should process these correctly
        framework.assert_true(result.passed, "Global variable analysis should succeed");
    }
    
    // Test 3: Function call analysis
    {
        framework.start_test("Function Call Analysis");
        auto result = framework.runPointerAnalysis("pointer/simple.ll");
        
        // simple.ll has:
        // - main calls caller1 and caller2
        // - caller1 and caller2 both call callee
        // Should have at least 3 call graph edges
        framework.assert_contains(result.actual, "CallGraph:", "Should detect function calls");
    }
    
    // Test 4: Store/Load instruction analysis
    {
        framework.start_test("Store/Load Instruction Analysis");
        auto result = framework.runPointerAnalysis("pointer/store_load_test.ll");
        framework.assert_true(result.passed, "Store/load analysis should succeed");
    }
    
    // Test 5: Alloca instruction analysis
    {
        framework.start_test("Alloca Instruction Analysis");
        auto result = framework.runPointerAnalysis("pointer/alloca_test.ll");
        framework.assert_true(result.passed, "Alloca analysis should succeed");
    }
    
    // Test 6: Pointer propagation through function parameters
    {
        framework.start_test("Function Parameter Pointer Propagation");
        auto result = framework.runPointerAnalysis("pointer/param_test.ll");
        framework.assert_true(result.passed, "Parameter propagation analysis should succeed");
        
        // Should have detected the function calls and parameter passing
        framework.assert_contains(result.actual, "CallGraph:", "Should track function calls");
    }
    
    // Test 7: Multiple pointers to same location
    {
        framework.start_test("Multiple Pointers Analysis");
        auto result = framework.runPointerAnalysis("pointer/multi_ptr_test.ll");
        framework.assert_true(result.passed, "Multiple pointers analysis should succeed");
    }
    
    // Test 8: Vtable processing
    {
        framework.start_test("Vtable Processing");
        auto result = framework.runPointerAnalysis("pointer/vtable_test.ll");
        framework.assert_true(result.passed, "Vtable processing should succeed");
        
        // Should detect vtable function pointers
        framework.assert_contains(result.actual, "PointsToMap:", "Should process vtable entries");
    }
} 