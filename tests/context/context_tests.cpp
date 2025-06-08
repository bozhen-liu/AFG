#include "../test_framework.h"

void run_context_tests(AFGTestFramework& framework) {
    framework.start_category("Context-Sensitive Analysis");
    
    // Test 1: K-callsite analysis with K=1
    {
        framework.start_test("K-Callsite Analysis (K=1)");
        auto result = framework.runPointerAnalysis("pointer/simple.ll", "kcs", 1);
        framework.assert_true(result.passed, "K-callsite analysis (K=1) should succeed");
        framework.assert_contains(result.actual, "PointsToMap:", "Should report points-to map");
    }
    
    // Test 2: K-callsite analysis with K=2
    {
        framework.start_test("K-Callsite Analysis (K=2)");
        auto result = framework.runPointerAnalysis("pointer/simple.ll", "kcs", 2);
        framework.assert_true(result.passed, "K-callsite analysis (K=2) should succeed");
        framework.assert_contains(result.actual, "PointsToMap:", "Should report points-to map");
    }
    
    // Test 3: Context comparison - basic vs K-callsite
    {
        framework.start_test("Context Sensitivity Comparison");
        
        // Run with basic analysis
        auto basic_result = framework.runPointerAnalysis("context/context_test.ll", "basic");
        framework.assert_true(basic_result.passed, "Basic analysis should succeed");
        
        // Run with K-callsite analysis
        auto kcs_result = framework.runPointerAnalysis("context/context_test.ll", "kcs", 2);
        framework.assert_true(kcs_result.passed, "K-callsite analysis should succeed");
        
        // Both should work, but may have different precision
        framework.assert_contains(basic_result.actual, "PointsToMap:", "Basic analysis should report results");
        framework.assert_contains(kcs_result.actual, "PointsToMap:", "K-callsite analysis should report results");
    }
    
    // Test 4: Recursive function handling
    {
        framework.start_test("Recursive Function Context Handling");
        auto result = framework.runPointerAnalysis("context/recursive_test.ll", "kcs", 2);
        framework.assert_true(result.passed, "Recursive function context analysis should succeed");
        
        // Should handle the recursive calls without infinite loops
        framework.assert_contains(result.actual, "CallGraph:", "Should track recursive calls");
    }
    
    // Test 5: Context propagation depth test
    {
        framework.start_test("Context Propagation Depth");
        
        // Test with different K values
        auto k1_result = framework.runPointerAnalysis("context/depth_test.ll", "kcs", 1);
        auto k3_result = framework.runPointerAnalysis("context/depth_test.ll", "kcs", 3);
        
        framework.assert_true(k1_result.passed, "K=1 analysis should succeed");
        framework.assert_true(k3_result.passed, "K=3 analysis should succeed");
        
        // Both should detect the call chain
        framework.assert_contains(k1_result.actual, "CallGraph:", "K=1 should track calls");
        framework.assert_contains(k3_result.actual, "CallGraph:", "K=3 should track calls");
    }
    
    // Test 6: Function pointer context handling
    {
        framework.start_test("Function Pointer Context Analysis");
        auto result = framework.runPointerAnalysis("context/func_ptr_test.ll", "kcs", 2);
        framework.assert_true(result.passed, "Function pointer context analysis should succeed");
        
        // Should handle indirect calls through function pointers
        framework.assert_contains(result.actual, "CallGraph:", "Should track function pointer calls");
    }
} 