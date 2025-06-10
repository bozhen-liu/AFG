#include "../test_framework.h"

void run_context_tests(AFGTestFramework& framework) {
    framework.start_category("Context-Sensitive Analysis");
    
    // Test 1: Context-Sensitive vs Context-Insensitive Correctness Validation
    {
        framework.start_test("Basic vs K-Callsite Context Differentiation");
        
        // Run basic analysis (context-insensitive)
        auto basic_result = framework.runPointerAnalysis("pointer/simple.ll", "basic");
        framework.assert_true(basic_result.passed, "Basic analysis should complete successfully");
        
        // Run k-callsite analysis with K=1 (limited context)
        auto k1_result = framework.runPointerAnalysis("pointer/simple.ll", "kcs", 1);
        framework.assert_true(k1_result.passed, "K=1 analysis should complete successfully");
        
        // Run k-callsite analysis with K=2 (more context)
        auto k2_result = framework.runPointerAnalysis("pointer/simple.ll", "kcs", 2);
        framework.assert_true(k2_result.passed, "K=2 analysis should complete successfully");
        
        // Validate context sensitivity progression
        // Basic: should merge all contexts (1 callee instance)
        framework.assert_function_instance_count("callee", 1, "Basic analysis should merge all callee contexts", basic_result);
        
        // K=2: should differentiate contexts (2 callee instances)
        framework.assert_function_instance_count("callee", 2, "K=2 analysis should differentiate callee contexts", k2_result);
        
        // Validate that higher K values maintain or increase precision
        auto k1_callee_count = k1_result.function_instance_counts.find("callee");
        auto k2_callee_count = k2_result.function_instance_counts.find("callee");
        
        int k1_count = (k1_callee_count != k1_result.function_instance_counts.end()) ? k1_callee_count->second : 0;
        int k2_count = (k2_callee_count != k2_result.function_instance_counts.end()) ? k2_callee_count->second : 0;
        
        framework.assert_true(k2_count >= k1_count, "Higher K should maintain or increase context precision");
        
        // Print detailed comparison
        std::cout << "  Context Analysis Comparison:" << std::endl;
        std::cout << "    Basic: " << basic_result.callGraph.numNodes() << " CG nodes, callee instances: " 
                  << (basic_result.function_instance_counts.find("callee") != basic_result.function_instance_counts.end() ? 
                      basic_result.function_instance_counts.at("callee") : 0) << std::endl;
        std::cout << "    K=1: " << k1_result.callGraph.numNodes() << " CG nodes, callee instances: " << k1_count << std::endl;
        std::cout << "    K=2: " << k2_result.callGraph.numNodes() << " CG nodes, callee instances: " << k2_count << std::endl;
    }
    
    // Test 2: Context Propagation Validation
    {
        framework.start_test("Context Propagation Through Call Chains");
        
        // Test with depth_test.ll which has a deeper call chain
        auto basic_result = framework.runPointerAnalysis("context/depth_test.ll", "basic");
        auto k2_result = framework.runPointerAnalysis("context/depth_test.ll", "kcs", 2);
        auto k3_result = framework.runPointerAnalysis("context/depth_test.ll", "kcs", 3);
        
        framework.assert_true(basic_result.passed && k2_result.passed && k3_result.passed, 
                            "All context propagation analyses should succeed");
        
        // Deeper call chains should benefit more from higher K values
        framework.assert_true(k3_result.callGraph.numNodes() >= k2_result.callGraph.numNodes(), 
                            "Higher K should capture more call graph precision in deep chains");
        framework.assert_true(k2_result.callGraph.numNodes() >= basic_result.callGraph.numNodes(), 
                            "Context-sensitive analysis should be at least as precise as basic");
        
        std::cout << "  Call Chain Analysis:" << std::endl;
        std::cout << "    Basic: " << basic_result.callGraph.numNodes() << " nodes, " << basic_result.callGraph.numEdges() << " edges" << std::endl;
        std::cout << "    K=2: " << k2_result.callGraph.numNodes() << " nodes, " << k2_result.callGraph.numEdges() << " edges" << std::endl;
        std::cout << "    K=3: " << k3_result.callGraph.numNodes() << " nodes, " << k3_result.callGraph.numEdges() << " edges" << std::endl;
    }
    
    // Test 3: Recursive Function Context Handling Validation
    {
        framework.start_test("Recursive Function Context Correctness");
        
        auto basic_result = framework.runPointerAnalysis("context/recursive_test.ll", "basic");
        auto kcs_result = framework.runPointerAnalysis("context/recursive_test.ll", "kcs", 2);
        
        framework.assert_true(basic_result.passed, "Basic recursive analysis should succeed");
        framework.assert_true(kcs_result.passed, "K-callsite recursive analysis should succeed");
        
        // Should handle recursive calls without infinite expansion
        // Both analyses should visit the same functions but potentially with different contexts
        framework.assert_visited_functions_count(basic_result.visitedFunctions.size(), 
                                                "K-callsite should visit same number of functions as basic", kcs_result);
        
        // K-callsite may create more call graph nodes due to context differentiation
        framework.assert_true(kcs_result.callGraph.numNodes() >= basic_result.callGraph.numNodes(), 
                            "K-callsite should maintain or increase precision for recursive functions");
    }
    
    // Test 4: Function Pointer Context Analysis
    {
        framework.start_test("Function Pointer Context Differentiation");
        
        auto basic_result = framework.runPointerAnalysis("context/func_ptr_test.ll", "basic");
        auto kcs_result = framework.runPointerAnalysis("context/func_ptr_test.ll", "kcs", 2);
        
        framework.assert_true(basic_result.passed, "Basic function pointer analysis should succeed");
        framework.assert_true(kcs_result.passed, "K-callsite function pointer analysis should succeed");
        
        // Function pointer calls should be handled correctly in both modes
        framework.assert_call_graph_edges_count_greater_than(0, "Should detect indirect calls in basic analysis", basic_result);
        framework.assert_call_graph_edges_count_greater_than(0, "Should detect indirect calls in k-callsite analysis", kcs_result);
        
        // K-callsite may distinguish between different calling contexts for the same function pointer
        framework.assert_true(kcs_result.callGraph.numNodes() >= basic_result.callGraph.numNodes(), 
                            "K-callsite should handle function pointers with proper context sensitivity");
    }
    
    // Test 5: Context Size Impact Analysis
    {
        framework.start_test("Context Size Impact on Precision");
        
        // Test the same complex scenario with different K values
        auto k1_result = framework.runPointerAnalysis("context/context_test.ll", "kcs", 1);
        auto k2_result = framework.runPointerAnalysis("context/context_test.ll", "kcs", 2);
        auto k4_result = framework.runPointerAnalysis("context/context_test.ll", "kcs", 4);
        
        framework.assert_true(k1_result.passed && k2_result.passed && k4_result.passed, 
                            "All K-value analyses should succeed");
        
        // Generally, higher K should not decrease precision
        framework.assert_true(k2_result.callGraph.numNodes() >= k1_result.callGraph.numNodes(), 
                            "K=2 should be at least as precise as K=1");
        framework.assert_true(k4_result.callGraph.numNodes() >= k2_result.callGraph.numNodes(), 
                            "K=4 should be at least as precise as K=2");
        
        // Show the progression of precision with K value
        std::cout << "  K-value Precision Progression:" << std::endl;
        std::cout << "    K=1: " << k1_result.callGraph.numNodes() << " nodes, " << k1_result.pointsToMap.size() << " points-to nodes" << std::endl;
        std::cout << "    K=2: " << k2_result.callGraph.numNodes() << " nodes, " << k2_result.pointsToMap.size() << " points-to nodes" << std::endl;
        std::cout << "    K=4: " << k4_result.callGraph.numNodes() << " nodes, " << k4_result.pointsToMap.size() << " points-to nodes" << std::endl;
    }
    
    // Test 6: Context String Format Validation
    {
        framework.start_test("Context String Format and Content Validation");
        
        auto kcs_result = framework.runPointerAnalysis("pointer/simple.ll", "kcs", 2);
        framework.assert_true(kcs_result.passed, "K-callsite analysis should succeed");
        
        // Print detailed analysis to show context formats
        std::cout << "  Detailed Context Analysis:" << std::endl;
        framework.print_detailed_analysis(kcs_result);
        
        // Validate context differentiation for multiple call paths
        std::vector<std::string> expected_context_parts = {"caller1", "caller2"};
        framework.assert_context_differentiation("callee", expected_context_parts, 
                                               "Should create distinct contexts for different call paths to callee", kcs_result);
        
        // Validate that contexts contain the expected call instructions
        bool found_g1_context = false;
        bool found_g2_context = false;
        
        for (const std::string& context : kcs_result.function_contexts) {
            if (context.find("callee") != std::string::npos) {
                if (context.find("@g1") != std::string::npos) found_g1_context = true;
                if (context.find("@g2") != std::string::npos) found_g2_context = true;
            }
        }
        
        framework.assert_true(found_g1_context && found_g2_context, 
                            "Should find both @g1 and @g2 contexts in callee instances");
    }
} 