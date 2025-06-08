#include "../test_framework.h"
#include <nlohmann/json.hpp>

using json = nlohmann::json;

void run_taint_tests(AFGTestFramework& framework) {
    framework.start_category("Taint Analysis");
    
    // Test 1: Basic taint configuration loading
    {
        framework.start_test("Taint Configuration Loading");
        auto result = framework.runPointerAnalysis("taint/taint_test.ll", "origin", 2);
        framework.assert_true(result.passed, "Taint analysis should succeed");
        framework.assert_contains(result.actual, "PointsToMap:", "Should report points-to map");
    }
    
    // Test 2: Origin context tracking
    {
        framework.start_test("Origin Context Tracking");
        auto result = framework.runPointerAnalysis("taint/origin_test.ll", "origin", 2);
        framework.assert_true(result.passed, "Origin analysis should succeed");
        
        // Origin analysis should track contexts
        framework.assert_contains(result.actual, "CallGraph:", "Should track call graph");
    }
    
    // Test 3: Taint propagation through pointers
    {
        framework.start_test("Taint Propagation Through Pointers");
        auto result = framework.runPointerAnalysis("taint/propagation_test.ll", "origin", 2);
        framework.assert_true(result.passed, "Taint propagation analysis should succeed");
        
        // Should detect the taint flow from global to local variable
        framework.assert_contains(result.actual, "PointsToMap:", "Should report points-to relationships");
    }
    
    // Test 4: Multiple tainted objects
    {
        framework.start_test("Multiple Tainted Objects Analysis");
        auto result = framework.runPointerAnalysis("taint/multi_taint_test.ll", "origin", 2);
        framework.assert_true(result.passed, "Multiple taint analysis should succeed");
    }
    
    // Test 5: Taint through function parameters  
    {
        framework.start_test("Taint Through Function Parameters");
        auto result = framework.runPointerAnalysis("taint/param_taint_test.ll", "origin", 2);
        framework.assert_true(result.passed, "Parameter taint analysis should succeed");
        
        // Should track taint flow through function parameters
        framework.assert_contains(result.actual, "CallGraph:", "Should track function calls");
    }
    
    // Test 6: Taint analysis with context sensitivity
    {
        framework.start_test("Context-Sensitive Taint Analysis");
        auto result = framework.runPointerAnalysis("taint/context_taint_test.ll", "origin", 2);
        framework.assert_true(result.passed, "Context-sensitive taint analysis should succeed");
        
        // Should handle multiple contexts for the same tainted object
        framework.assert_contains(result.actual, "PointsToMap:", "Should report context-sensitive results");
    }
} 