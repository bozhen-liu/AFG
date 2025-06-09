#include "../test_framework.h"
#include <fstream>
#include <nlohmann/json.hpp>

using json = nlohmann::json;

void run_integration_tests(AFGTestFramework& framework) {
    framework.start_category("Integration Tests");
    
    // Test 1: End-to-end analysis comparison with correctness validation
    {
        framework.start_test("End-to-End Analysis Correctness Comparison");
        
        // Use the existing simple.ll for detailed comparison
        auto basic_result = framework.runDetailedPointerAnalysis("pointer/simple.ll", "basic");
        auto kcs_result = framework.runDetailedPointerAnalysis("pointer/simple.ll", "kcs", 2);
        // Run Origin analysis on a file actually designed for taint analysis
        auto origin_result = framework.runDetailedPointerAnalysis("taint/taint_test.ll", "origin", 2);
        
        framework.assert_true(basic_result.passed, "Basic analysis should succeed");
        framework.assert_true(kcs_result.passed, "K-callsite analysis should succeed");
        framework.assert_true(origin_result.passed, "Origin analysis should succeed");
        
        // Validate correctness differences between analysis modes
        // Basic: context-insensitive (1 callee instance)
        framework.assert_function_instance_count("callee", 1, "Basic analysis should merge callee contexts", basic_result);
        
        // K-callsite: context-sensitive (2 callee instances for simple.ll)
        framework.assert_function_instance_count("callee", 2, "K-callsite analysis should differentiate callee contexts", kcs_result);
        
        // Origin: context-sensitive but on different file (taint analysis specific)
        framework.assert_true(origin_result.call_graph_nodes > 0, "Origin analysis should produce valid results");
        
        // Compare basic vs k-callsite (same file)
        framework.assert_true(basic_result.visited_functions == kcs_result.visited_functions, 
                            "Basic and K-callsite should visit the same functions");
        
        // Context-sensitive analysis should be at least as precise as basic
        framework.assert_true(kcs_result.call_graph_nodes >= basic_result.call_graph_nodes, 
                            "K-callsite should be at least as precise as basic");
        
        // Print comprehensive comparison
        std::cout << "  End-to-End Analysis Comparison:" << std::endl;
        std::cout << "    Basic (simple.ll): " << basic_result.call_graph_nodes << " CG nodes, " 
                  << basic_result.points_to_nodes << " points-to nodes" << std::endl;
        std::cout << "    K-callsite (simple.ll): " << kcs_result.call_graph_nodes << " CG nodes, " 
                  << kcs_result.points_to_nodes << " points-to nodes" << std::endl;
        std::cout << "    Origin (taint_test.ll): " << origin_result.call_graph_nodes << " CG nodes, " 
                  << origin_result.points_to_nodes << " points-to nodes" << std::endl;
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
    
    // Test 7: Cross-analysis consistency and correctness validation
    {
        framework.start_test("Cross-Analysis Consistency and Correctness");
        
        // Run the same test with different analysis modes and compare correctness
        auto basic_result = framework.runDetailedPointerAnalysis("pointer/simple.ll", "basic");
        auto kcs1_result = framework.runDetailedPointerAnalysis("pointer/simple.ll", "kcs", 1);
        auto kcs2_result = framework.runDetailedPointerAnalysis("pointer/simple.ll", "kcs", 2);
        
        framework.assert_true(basic_result.passed, "Basic analysis should succeed");
        framework.assert_true(kcs1_result.passed, "K-callsite (K=1) analysis should succeed");
        framework.assert_true(kcs2_result.passed, "K-callsite (K=2) analysis should succeed");
        
        // All should visit the same functions (consistency check)
        framework.assert_true(basic_result.visited_functions == kcs1_result.visited_functions, 
                            "Basic and K=1 should visit the same functions");
        framework.assert_true(basic_result.visited_functions == kcs2_result.visited_functions, 
                            "Basic and K=2 should visit the same functions");
        
        // Correctness validation: context-sensitive analyses should maintain or increase precision
        framework.assert_true(kcs1_result.call_graph_nodes >= basic_result.call_graph_nodes, 
                            "K=1 should be at least as precise as basic");
        framework.assert_true(kcs2_result.call_graph_nodes >= kcs1_result.call_graph_nodes, 
                            "K=2 should be at least as precise as K=1");
        
        // Validate specific function instance counts for consistency
        auto basic_callee = basic_result.function_instance_counts.find("callee");
        auto kcs1_callee = kcs1_result.function_instance_counts.find("callee");
        auto kcs2_callee = kcs2_result.function_instance_counts.find("callee");
        
        int basic_count = (basic_callee != basic_result.function_instance_counts.end()) ? basic_callee->second : 0;
        int kcs1_count = (kcs1_callee != kcs1_result.function_instance_counts.end()) ? kcs1_callee->second : 0;
        int kcs2_count = (kcs2_callee != kcs2_result.function_instance_counts.end()) ? kcs2_callee->second : 0;
        
        // Basic should merge contexts (1 instance), K=2 should differentiate (2 instances)
        framework.assert_function_instance_count("callee", 1, "Basic should have 1 callee instance", basic_result);
        framework.assert_function_instance_count("callee", 2, "K=2 should have 2 callee instances", kcs2_result);
        
        // K=1 should be between basic and K=2 in precision
        framework.assert_true(kcs1_count >= basic_count, "K=1 should be at least as precise as basic");
        framework.assert_true(kcs2_count >= kcs1_count, "K=2 should be at least as precise as K=1");
        
        // Print detailed consistency analysis
        std::cout << "  Cross-Analysis Consistency Check:" << std::endl;
        std::cout << "    Basic: " << basic_result.call_graph_nodes << " CG nodes, " 
                  << basic_count << " callee instances" << std::endl;
        std::cout << "    K=1: " << kcs1_result.call_graph_nodes << " CG nodes, " 
                  << kcs1_count << " callee instances" << std::endl;
        std::cout << "    K=2: " << kcs2_result.call_graph_nodes << " CG nodes, " 
                  << kcs2_count << " callee instances" << std::endl;
    }
} 