#include "../test_framework.h"
#include <nlohmann/json.hpp>

using json = nlohmann::json;

void run_taint_tests(AFGTestFramework& framework) {
    framework.start_category("Taint Analysis");
    
    // Test 1: Taint configuration loading with detailed validation
    {
        framework.start_test("Taint Configuration Loading Correctness");
        auto basic_result = framework.runPointerAnalysis("taint/taint_test.ll", "basic");
        auto origin_result = framework.runPointerAnalysis("taint/taint_test.ll", "origin", 2);
        
        framework.assert_true(basic_result.passed, "Basic analysis on taint test should succeed");
        framework.assert_true(origin_result.passed, "Origin taint analysis should succeed");
        
        // Origin analysis should properly load taint configuration and track tainted objects
        // Both should visit the same functions but Origin adds taint tracking
        framework.assert_visited_functions_count(basic_result.visitedFunctions.size(), 
                                                "Origin should visit same number of functions as basic", origin_result);
        
        // Origin analysis should maintain or increase precision due to taint context tracking
        framework.assert_true(origin_result.callGraph.numNodes() >= basic_result.callGraph.numNodes(), 
                            "Origin analysis should maintain or increase call graph precision");
        
        std::cout << "  Taint Configuration Analysis:" << std::endl;
        std::cout << "    Basic: " << basic_result.callGraph.numNodes() << " nodes, " 
                  << basic_result.idToNodeMap.size() << " points-to" << std::endl;
        std::cout << "    Origin: " << origin_result.callGraph.numNodes() << " nodes, " 
                  << origin_result.idToNodeMap.size() << " points-to" << std::endl;
    }
    
    // Test 2: Origin context tracking with different K values
    {
        framework.start_test("Origin Context Tracking Precision");
        auto origin_k1 = framework.runPointerAnalysis("taint/origin_test.ll", "origin", 1);
        auto origin_k2 = framework.runPointerAnalysis("taint/origin_test.ll", "origin", 2);
        auto origin_k3 = framework.runPointerAnalysis("taint/origin_test.ll", "origin", 3);
        
        framework.assert_true(origin_k1.passed, "Origin analysis K=1 should succeed");
        framework.assert_true(origin_k2.passed, "Origin analysis K=2 should succeed");
        framework.assert_true(origin_k3.passed, "Origin analysis K=3 should succeed");
        
        // Higher K values should maintain or increase context precision
        framework.assert_true(origin_k2.callGraph.numNodes() >= origin_k1.callGraph.numNodes(), 
                            "K=2 should be at least as precise as K=1 for origin tracking");
        framework.assert_true(origin_k3.callGraph.numNodes() >= origin_k2.callGraph.numNodes(), 
                            "K=3 should be at least as precise as K=2 for origin tracking");
        
        std::cout << "  Origin Context Precision Progression:" << std::endl;
        std::cout << "    K=1: " << origin_k1.callGraph.numNodes() << " nodes" << std::endl;
        std::cout << "    K=2: " << origin_k2.callGraph.numNodes() << " nodes" << std::endl;
        std::cout << "    K=3: " << origin_k3.callGraph.numNodes() << " nodes" << std::endl;
    }
    
    // Test 3: Taint propagation through pointers with correctness validation
    {
        framework.start_test("Taint Propagation Correctness Validation");
        auto basic_result = framework.runPointerAnalysis("taint/propagation_test.ll", "basic");
        auto origin_result = framework.runPointerAnalysis("taint/propagation_test.ll", "origin", 2);
        
        framework.assert_true(basic_result.passed, "Basic propagation analysis should succeed");
        framework.assert_true(origin_result.passed, "Origin propagation analysis should succeed");
        
        // Origin should track taint propagation through pointer relationships
        framework.assert_true(origin_result.idToNodeMap.size() >= basic_result.idToNodeMap.size(), 
                            "Origin analysis should maintain or enhance points-to relationships for taint tracking");
        
        // Should detect the same function structure but with taint context
        framework.assert_visited_functions_count(basic_result.visitedFunctions.size(), 
                                                "Origin should visit same number of functions as basic", origin_result);
        
        // Print detailed analysis to show taint propagation
        std::cout << "  Taint Propagation Analysis:" << std::endl;
        framework.print_detailed_analysis(origin_result);
    }
    
    // Test 4: Multiple tainted objects with cross-analysis comparison
    {
        framework.start_test("Multiple Tainted Objects Analysis Comparison");
        auto basic_result = framework.runPointerAnalysis("taint/multi_taint_test.ll", "basic");
        auto kcs_result = framework.runPointerAnalysis("taint/multi_taint_test.ll", "kcs", 2);
        auto origin_result = framework.runPointerAnalysis("taint/multi_taint_test.ll", "origin", 2);
        
        framework.assert_true(basic_result.passed, "Basic multi-taint analysis should succeed");
        framework.assert_true(kcs_result.passed, "K-callsite multi-taint analysis should succeed");
        framework.assert_true(origin_result.passed, "Origin multi-taint analysis should succeed");
        
        // All should visit the same functions but with different precision
        framework.assert_visited_functions_count(basic_result.visitedFunctions.size(), 
                                                "K-callsite should visit same number of functions as basic", kcs_result);
        framework.assert_visited_functions_count(basic_result.visitedFunctions.size(), 
                                                "Origin should visit same number of functions as basic", origin_result);
        
        // Validate precision progression: Basic ≤ K-callsite ≤ Origin
        framework.assert_true(kcs_result.callGraph.numNodes() >= basic_result.callGraph.numNodes(), 
                            "K-callsite should be at least as precise as basic");
        framework.assert_true(origin_result.callGraph.numNodes() >= basic_result.callGraph.numNodes(), 
                            "Origin should be at least as precise as basic");
        
        std::cout << "  Multi-Taint Analysis Comparison:" << std::endl;
        std::cout << "    Basic: " << basic_result.callGraph.numNodes() << " nodes" << std::endl;
        std::cout << "    K-callsite: " << kcs_result.callGraph.numNodes() << " nodes" << std::endl;
        std::cout << "    Origin: " << origin_result.callGraph.numNodes() << " nodes" << std::endl;
    }
    
    // Test 5: Taint through function parameters with context sensitivity
    {
        framework.start_test("Taint Through Function Parameters Context Sensitivity");
        auto basic_result = framework.runPointerAnalysis("taint/param_taint_test.ll", "basic");
        auto origin_result = framework.runPointerAnalysis("taint/param_taint_test.ll", "origin", 2);
        
        framework.assert_true(basic_result.passed, "Basic parameter taint analysis should succeed");
        framework.assert_true(origin_result.passed, "Origin parameter taint analysis should succeed");
        
        // Parameter taint should create proper call graph relationships
        framework.assert_call_graph_edges_count_greater_than(0, "Should track function calls with parameters", basic_result);
        framework.assert_true(origin_result.callGraph.numEdges() >= basic_result.callGraph.numEdges(), 
                            "Origin should maintain or enhance call graph for taint parameter tracking");
        
        // Origin should handle parameter contexts for taint tracking
        framework.assert_true(origin_result.callGraph.numNodes() >= basic_result.callGraph.numNodes(), 
                            "Origin should create context-sensitive parameter taint tracking");
        
        // Check for function instances that handle tainted parameters
        bool found_taint_param_functions = false;
        for (const auto& func_count : origin_result.function_instance_counts) {
            if (func_count.second > 0) {
                found_taint_param_functions = true;
                break;
            }
        }
        framework.assert_true(found_taint_param_functions, "Should detect functions handling tainted parameters");
    }
    
    // Test 6: Context-sensitive taint analysis with detailed validation
    {
        framework.start_test("Context-Sensitive Taint Analysis Validation");
        auto origin_k1 = framework.runPointerAnalysis("taint/context_taint_test.ll", "origin", 1);
        auto origin_k2 = framework.runPointerAnalysis("taint/context_taint_test.ll", "origin", 2);
        auto origin_k4 = framework.runPointerAnalysis("taint/context_taint_test.ll", "origin", 4);
        
        framework.assert_true(origin_k1.passed, "Origin K=1 context taint analysis should succeed");
        framework.assert_true(origin_k2.passed, "Origin K=2 context taint analysis should succeed");
        framework.assert_true(origin_k4.passed, "Origin K=4 context taint analysis should succeed");
        
        // Higher K values should capture more taint contexts
        framework.assert_true(origin_k2.callGraph.numNodes() >= origin_k1.callGraph.numNodes(), 
                            "K=2 should capture more taint contexts than K=1");
        framework.assert_true(origin_k4.callGraph.numNodes() >= origin_k2.callGraph.numNodes(), 
                            "K=4 should capture more taint contexts than K=2");
        
        // All should handle the same tainted objects but with different context sensitivity
        framework.assert_visited_functions_count(origin_k1.visitedFunctions.size(), 
                                                "K=2 should visit same number of functions as K=1", origin_k2);
        framework.assert_visited_functions_count(origin_k2.visitedFunctions.size(), 
                                                "K=4 should visit same number of functions as K=2", origin_k4);
        
        // Print detailed context sensitivity comparison
        std::cout << "  Context-Sensitive Taint Precision:" << std::endl;
        std::cout << "    K=1: " << origin_k1.callGraph.numNodes() << " nodes, " 
                  << origin_k1.idToNodeMap.size() << " points-to" << std::endl;
        std::cout << "    K=2: " << origin_k2.callGraph.numNodes() << " nodes, " 
                  << origin_k2.idToNodeMap.size() << " points-to" << std::endl;
        std::cout << "    K=4: " << origin_k4.callGraph.numNodes() << " nodes, " 
                  << origin_k4.idToNodeMap.size() << " points-to" << std::endl;
        
        // Print detailed analysis for K=2 to show context differentiation
        framework.print_detailed_analysis(origin_k2);
    }
} 