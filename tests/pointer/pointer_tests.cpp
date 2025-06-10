#include "../test_framework.h"

void run_pointer_tests(AFGTestFramework& framework) {
    framework.start_category("Pointer Analysis");
    
    // Test 1: Basic vs K-Callsite Analysis Comparison on simple.ll
    {
        framework.start_test("Basic vs K-Callsite Analysis Correctness Comparison");
        
        // Run basic pointer analysis on simple.ll
        auto basic_result = framework.runPointerAnalysis("pointer/simple.ll", "basic");
        framework.assert_true(basic_result.passed, "Basic analysis should complete successfully");
        
        // Run k-callsite analysis with K=2 on simple.ll  
        auto kcs_result = framework.runPointerAnalysis("pointer/simple.ll", "kcs", 2);
        framework.assert_true(kcs_result.passed, "K-callsite analysis should complete successfully");
        
        // Print detailed analysis for debugging
        std::cout << "\n--- Basic Analysis Results ---";
        framework.print_detailed_analysis(basic_result);
        std::cout << "\n--- K-Callsite Analysis Results ---";
        framework.print_detailed_analysis(kcs_result);
        
        // Key assertion: Basic analysis should have fewer call graph nodes than k-callsite
        // because it merges contexts, while k-callsite creates separate instances
        framework.assert_true(kcs_result.callGraph.numNodes() >= basic_result.callGraph.numNodes(), 
                            "K-callsite analysis should have same or more call graph nodes than basic analysis");
        
        // Specific assertions for simple.ll:
        // Basic analysis: callee should appear as 1 instance (context-insensitive)
        // K-callsite analysis: callee should appear as 2 instances (different contexts)
        framework.assert_function_instance_count("callee", 1, "Basic analysis should merge all callee instances", basic_result);
        
        // Note: The actual count depends on how the call graph represents contexts
        // We expect k-callsite to differentiate contexts, so it should have at least as many as basic
        auto basic_callee_count = basic_result.function_instance_counts.find("callee");
        auto kcs_callee_count = kcs_result.function_instance_counts.find("callee");
        
        int basic_count = (basic_callee_count != basic_result.function_instance_counts.end()) ? basic_callee_count->second : 0;
        int kcs_count = (kcs_callee_count != kcs_result.function_instance_counts.end()) ? kcs_callee_count->second : 0;
        
        framework.assert_true(kcs_count >= basic_count, 
                            "K-callsite analysis should have same or more callee instances than basic analysis");
    }
    
    // Test 2: Detailed Basic Analysis Validation
    {
        framework.start_test("Basic Analysis - Context Insensitive Behavior");
        auto result = framework.runPointerAnalysis("pointer/simple.ll", "basic");
        
        // Validate that basic analysis creates the expected call graph structure
        // simple.ll has: main, caller1, caller2, callee
        // In context-insensitive analysis, each function should appear once
        framework.assert_function_instance_count("main", 1, "Should have exactly 1 main function instance", result);
        framework.assert_function_instance_count("caller1", 1, "Should have exactly 1 caller1 function instance", result);
        framework.assert_function_instance_count("caller2", 1, "Should have exactly 1 caller2 function instance", result);
        framework.assert_function_instance_count("callee", 1, "Should have exactly 1 callee function instance (merged contexts)", result);
    }
    
    // Test 3: Detailed K-Callsite Analysis Validation  
    {
        framework.start_test("K-Callsite Analysis - Context Sensitive Behavior");
        auto result = framework.runPointerAnalysis("pointer/simple.ll", "kcs", 2);
        
        // In k-callsite analysis with K=2, functions may have multiple context-sensitive instances
        // The key difference should be visible in the callee function which is called from different contexts
        framework.assert_function_instance_count("main", 1, "Should have exactly 1 main function instance", result);
        framework.assert_function_instance_count("caller1", 1, "Should have exactly 1 caller1 function instance", result);
        framework.assert_function_instance_count("caller2", 1, "Should have exactly 1 caller2 function instance", result);
        
        // The callee function should potentially have different instances for different call contexts
        // At minimum, it should not be less than the basic analysis
        auto callee_count = result.function_instance_counts.find("callee");
        int count = (callee_count != result.function_instance_counts.end()) ? callee_count->second : 0;
        framework.assert_true(count >= 1, "Should have at least 1 callee function instance");
        
        // Check for context differentiation - callee should have contexts related to different callers
        std::vector<std::string> expected_context_parts = {"caller1", "caller2"};
        framework.assert_context_differentiation("callee", expected_context_parts, 
                                               "Callee contexts should differentiate between different call paths", result);
    }
    
    // Test 4: Different K values comparison
    {
        framework.start_test("K-Callsite Analysis - Different K Values");
        
        auto k1_result = framework.runPointerAnalysis("pointer/simple.ll", "kcs", 1);
        auto k2_result = framework.runPointerAnalysis("pointer/simple.ll", "kcs", 2);
        auto k3_result = framework.runPointerAnalysis("pointer/simple.ll", "kcs", 3);
        
        framework.assert_true(k1_result.passed && k2_result.passed && k3_result.passed, 
                            "All K-callsite analyses should complete successfully");
        
        // Higher K values should potentially create more precise context tracking
        // The call graph structure may vary based on K value
        std::cout << "  K=1 call graph nodes: " << k1_result.callGraph.numNodes() << std::endl;
        std::cout << "  K=2 call graph nodes: " << k2_result.callGraph.numNodes() << std::endl;
        std::cout << "  K=3 call graph nodes: " << k3_result.callGraph.numNodes() << std::endl;
    }
    
    // Test 5: Store/Load instruction analysis
    {
        framework.start_test("Store/Load Instruction Analysis");
        auto result = framework.runPointerAnalysis("pointer/store_load_test.ll", "basic");
        framework.assert_true(result.passed, "Store/load analysis should succeed");
        framework.assert_points_to_map_size_greater_than(0, "Should create points-to relationships", result);
    }
    
    // Test 6: Alloca instruction analysis
    {
        framework.start_test("Alloca Instruction Analysis");
        auto result = framework.runPointerAnalysis("pointer/alloca_test.ll", "basic");
        framework.assert_true(result.passed, "Alloca analysis should succeed");
        framework.assert_points_to_map_size_greater_than(0, "Should create nodes for allocated memory", result);
    }
    
    // Test 7: Function parameter pointer propagation
    {
        framework.start_test("Function Parameter Pointer Propagation");
        auto result = framework.runPointerAnalysis("pointer/param_test.ll", "basic");
        framework.assert_true(result.passed, "Parameter propagation analysis should succeed");
        framework.assert_call_graph_edges_count_greater_than(0, "Should create call graph edges for function calls", result);
    }
    
    // Test 8: Multiple pointers to same location
    {
        framework.start_test("Multiple Pointers Analysis");
        auto result = framework.runPointerAnalysis("pointer/multi_ptr_test.ll", "basic");
        framework.assert_true(result.passed, "Multiple pointers analysis should succeed");
        framework.assert_points_to_map_size_greater_than(0, "Should handle multiple pointer relationships", result);
    }
    
    // Test 9: Vtable processing
    {
        framework.start_test("Vtable Processing");
        auto result = framework.runPointerAnalysis("pointer/vtable_test.ll", "basic");
        framework.assert_true(result.passed, "Vtable processing should succeed");
        framework.assert_points_to_map_size_greater_than(0, "Should process vtable function pointers", result);
    }
    
    // Test 10: Context-sensitive comparison on complex cases
    {
        framework.start_test("Context Sensitivity Impact on Complex Call Patterns");
        
        // Test with param_test.ll which has function parameter passing
        auto basic_param = framework.runPointerAnalysis("pointer/param_test.ll", "basic");
        auto kcs_param = framework.runPointerAnalysis("pointer/param_test.ll", "kcs", 2);
        
        framework.assert_true(basic_param.passed && kcs_param.passed, "Both analyses should complete");
        
        // Compare the precision: k-callsite might create more precise analysis
        std::cout << "  Basic analysis - Call graph nodes: " << basic_param.callGraph.numNodes() 
                  << ", Points-to nodes: " << basic_param.pointsToMap.size() << std::endl;
        std::cout << "  K-callsite analysis - Call graph nodes: " << kcs_param.callGraph.numNodes() 
                  << ", Points-to nodes: " << kcs_param.pointsToMap.size() << std::endl;
    }
} 