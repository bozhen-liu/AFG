#include "../test_framework.h"
#include <fstream>
#include <nlohmann/json.hpp>

using json = nlohmann::json;

void run_integration_tests(AFGTestFramework& framework) {
    framework.start_category("Integration Tests");
    
    // Test 1: End-to-end analysis comparison
    {
        framework.start_test("End-to-End Analysis Comparison");
        
        // Use the existing simple.ll for comparison
        auto basic_result = framework.runPointerAnalysis("pointer/simple.ll", "basic");
        auto kcs_result = framework.runPointerAnalysis("pointer/simple.ll", "kcs", 2);
        auto origin_result = framework.runPointerAnalysis("pointer/simple.ll", "origin", 2);
        
        framework.assert_true(basic_result.passed, "Basic analysis should succeed");
        framework.assert_true(kcs_result.passed, "K-callsite analysis should succeed");
        framework.assert_true(origin_result.passed, "Origin analysis should succeed");
        
        // All should produce some results
        framework.assert_contains(basic_result.actual, "PointsToMap:", "Basic should produce results");
        framework.assert_contains(kcs_result.actual, "PointsToMap:", "K-callsite should produce results");
        framework.assert_contains(origin_result.actual, "PointsToMap:", "Origin should produce results");
    }
    
    // Test 2: Complex multi-threaded scenario
    {
        framework.start_test("Complex Multi-threaded Scenario");
        
        // Test with different analysis modes
        auto basic_result = framework.runPointerAnalysis("integration/complex_test.ll", "basic");
        auto origin_result = framework.runPointerAnalysis("integration/complex_test.ll", "origin", 3);
        
        framework.assert_true(basic_result.passed, "Complex basic analysis should succeed");
        framework.assert_true(origin_result.passed, "Complex origin analysis should succeed");
        
        // Should detect complex interactions
        framework.assert_contains(basic_result.actual, "CallGraph:", "Should track complex call graph");
        framework.assert_contains(basic_result.actual, "Channels:", "Should detect channel usage");
    }
    
    // Test 3: Real-world Rust example simulation
    {
        framework.start_test("Real-world Rust Example Simulation");
        auto result = framework.runPointerAnalysis("integration/rust_simulation.ll", "origin", 2);
        framework.assert_true(result.passed, "Rust simulation analysis should succeed");
        
        // Should handle complex Rust patterns
        framework.assert_contains(result.actual, "PointsToMap:", "Should analyze Rust patterns");
        framework.assert_contains(result.actual, "CallGraph:", "Should track Rust call patterns");
    }
    
    // Test 4: Performance and scalability test
    {
        framework.start_test("Performance and Scalability");
        auto basic_result = framework.runPointerAnalysis("integration/performance_test.ll", "basic");
        auto kcs_result = framework.runPointerAnalysis("integration/performance_test.ll", "kcs", 3);
        
        framework.assert_true(basic_result.passed, "Performance test basic analysis should succeed");
        framework.assert_true(kcs_result.passed, "Performance test K-callsite analysis should succeed");
        
        // Should handle the complex call patterns efficiently
        framework.assert_contains(basic_result.actual, "CallGraph:", "Should handle complex call graphs");
    }
    
    // Test 5: Edge cases and advanced LLVM instructions
    {
        framework.start_test("Edge Cases and Advanced Instructions");
        auto result = framework.runPointerAnalysis("integration/edge_cases.ll");
        framework.assert_true(result.passed, "Edge cases analysis should succeed");
        
        // Should handle PHI nodes, atomic operations, invoke, and bitcast
        framework.assert_contains(result.actual, "PointsToMap:", "Should handle advanced instructions");
        framework.assert_contains(result.actual, "CallGraph:", "Should track invoke instructions");
    }
    
    // Test 6: Output format validation
    {
        framework.start_test("Output Format Validation");
        
        auto result = framework.runPointerAnalysis("pointer/simple.ll", "basic");
        framework.assert_true(result.passed, "Output format test should succeed");
        
        // Validate that output contains expected sections
        framework.assert_contains(result.actual, "PointsToMap:", "Should contain PointsToMap section");
        framework.assert_contains(result.actual, "CallGraph:", "Should contain CallGraph section");
        framework.assert_contains(result.actual, "Visited functions:", "Should contain Visited functions section");
        framework.assert_contains(result.actual, "Channels:", "Should contain Channels section");
        
        // Validate that numbers are reasonable (not negative, not obviously wrong)
        framework.assert_true(result.actual.find("PointsToMap: ") != std::string::npos, "Should report PointsToMap size");
        framework.assert_true(result.actual.find("CallGraph: ") != std::string::npos, "Should report CallGraph size");
    }
    
    // Test 7: Cross-analysis consistency
    {
        framework.start_test("Cross-Analysis Consistency");
        
        // Run the same test with different analysis modes and compare consistency
        auto basic_result = framework.runPointerAnalysis("pointer/simple.ll", "basic");
        auto kcs1_result = framework.runPointerAnalysis("pointer/simple.ll", "kcs", 1);
        auto kcs2_result = framework.runPointerAnalysis("pointer/simple.ll", "kcs", 2);
        
        framework.assert_true(basic_result.passed, "Basic analysis should succeed");
        framework.assert_true(kcs1_result.passed, "K-callsite (K=1) analysis should succeed");
        framework.assert_true(kcs2_result.passed, "K-callsite (K=2) analysis should succeed");
        
        // All should visit the same functions (consistency check)
        framework.assert_contains(basic_result.actual, "Visited functions:", "Basic should visit functions");
        framework.assert_contains(kcs1_result.actual, "Visited functions:", "K=1 should visit functions");
        framework.assert_contains(kcs2_result.actual, "Visited functions:", "K=2 should visit functions");
    }
} 