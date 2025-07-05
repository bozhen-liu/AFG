#include "../test_framework.h"

void run_channel_tests(AFGTestFramework& framework) {
    framework.start_category("Channel Semantics");
    
    // Test 1: Channel creation detection with detailed validation
    {
        framework.start_test("Channel Creation Detection Correctness");
        auto basic_result = framework.runPointerAnalysis("channel/channel_create_test.ll", "basic");
        auto kcs_result = framework.runPointerAnalysis("channel/channel_create_test.ll", "kcs", 2);
        
        framework.assert_true(basic_result.passed, "Basic channel creation analysis should succeed");
        framework.assert_true(kcs_result.passed, "K-callsite channel creation analysis should succeed");
        
        // Both should detect the same channel instances, but contexts may differ
        // Channel detection should be consistent across analysis modes
        framework.assert_call_graph_nodes_count_greater_than(0, "Should create call graph nodes for channel operations", basic_result);
        framework.assert_true(kcs_result.callGraph.numNodes() >= basic_result.callGraph.numNodes(), 
                            "Context-sensitive analysis should maintain or increase precision");
        
        std::cout << "  Channel Creation Analysis:" << std::endl;
        std::cout << "    Basic: " << basic_result.idToNodeMap.size() << " points-to nodes, " 
                  << basic_result.callGraph.numNodes() << " CG nodes" << std::endl;
        std::cout << "    K-callsite: " << kcs_result.idToNodeMap.size() << " points-to nodes, " 
                  << kcs_result.callGraph.numNodes() << " CG nodes" << std::endl;
    }
    
    // Test 2: Send operation detection with context sensitivity
    {
        framework.start_test("Channel Send Operation Context Sensitivity");
        auto basic_result = framework.runPointerAnalysis("channel/send_test.ll", "basic");
        auto kcs_result = framework.runPointerAnalysis("channel/send_test.ll", "kcs", 2);
        
        framework.assert_true(basic_result.passed, "Basic send operation analysis should succeed");
        framework.assert_true(kcs_result.passed, "K-callsite send operation analysis should succeed");
        
        // Send operations should be detected consistently
        // Context-sensitive analysis might differentiate send contexts
        framework.assert_true(kcs_result.callGraph.numNodes() >= basic_result.callGraph.numNodes(), 
                            "Context-sensitive analysis should capture send operation contexts");
        
        // Both should visit the same functions but with potentially different contexts
        framework.assert_visited_functions_count(basic_result.visitedFunctions.size(), 
                                                "K-callsite should visit same number of functions as basic", kcs_result);
    }
    
    // Test 3: Receive operation detection with precision comparison
    {
        framework.start_test("Channel Receive Operation Precision Comparison");
        auto basic_result = framework.runPointerAnalysis("channel/recv_test.ll", "basic");
        auto kcs_result = framework.runPointerAnalysis("channel/recv_test.ll", "kcs", 2);
        
        framework.assert_true(basic_result.passed, "Basic receive operation analysis should succeed");
        framework.assert_true(kcs_result.passed, "K-callsite receive operation analysis should succeed");
        
        // Validate that receive operations are properly analyzed
        framework.assert_call_graph_edges_count_greater_than(0, "Should detect function calls in receive operations", basic_result);
        framework.assert_true(kcs_result.callGraph.numEdges() >= basic_result.callGraph.numEdges(), 
                            "Context-sensitive analysis should maintain or increase call graph precision");
    }
    
    // Test 4: Complete channel communication flow with detailed metrics
    {
        framework.start_test("Complete Channel Communication Flow Analysis");
        auto basic_result = framework.runPointerAnalysis("channel/flow_test.ll", "basic");
        auto kcs_result = framework.runPointerAnalysis("channel/flow_test.ll", "kcs", 2);
        
        framework.assert_true(basic_result.passed, "Basic channel flow analysis should succeed");
        framework.assert_true(kcs_result.passed, "K-callsite channel flow analysis should succeed");
        
        // Validate precision progression between analysis modes
        framework.assert_true(kcs_result.callGraph.numNodes() >= basic_result.callGraph.numNodes(), 
                            "K-callsite should be at least as precise as basic");
        framework.assert_true(kcs_result.idToNodeMap.size() >= basic_result.idToNodeMap.size(), 
                            "K-callsite should maintain or increase points-to precision for channel flow");
        
        // Print detailed comparison
        std::cout << "  Channel Flow Analysis Comparison:" << std::endl;
        std::cout << "    Basic: " << basic_result.callGraph.numNodes() << " nodes, " 
                  << basic_result.idToNodeMap.size() << " points-to" << std::endl;
        std::cout << "    K-callsite: " << kcs_result.callGraph.numNodes() << " nodes, " 
                  << kcs_result.idToNodeMap.size() << " points-to" << std::endl;
    }
    
    // Test 5: Channel data flow constraints correctness
    {
        framework.start_test("Channel Data Flow Constraints Correctness");
        auto result = framework.runPointerAnalysis("channel/dataflow_test.ll", "basic");
        framework.assert_true(result.passed, "Channel dataflow analysis should succeed");
        
        // Validate that data flow creates proper constraints
        framework.assert_points_to_map_size_greater_than(0, "Should create data flow constraints", result);
        framework.assert_call_graph_edges_count_greater_than(0, "Should track channel operation calls", result);
        
        // Print detailed analysis for validation
        framework.print_detailed_analysis(result);
    }
    
    // Test 6: Tokio channel operations with context differentiation
    {
        framework.start_test("Tokio Channel Context Differentiation");
        auto basic_result = framework.runPointerAnalysis("channel/tokio_test.ll", "basic");
        auto kcs_result = framework.runPointerAnalysis("channel/tokio_test.ll", "kcs", 2);
        
        framework.assert_true(basic_result.passed, "Basic Tokio analysis should succeed");
        framework.assert_true(kcs_result.passed, "K-callsite Tokio analysis should succeed");
        
        // Tokio channels should be analyzed consistently across modes
        framework.assert_visited_functions_count(basic_result.visitedFunctions.size(), 
                                                "K-callsite should visit same number of Tokio functions as basic", kcs_result);
        
        // Context-sensitive analysis might create more precise async contexts
        framework.assert_true(kcs_result.callGraph.numNodes() >= basic_result.callGraph.numNodes(), 
                            "K-callsite should handle async contexts precisely");
    }
    
    // Test 7: Real Rust mangled names correctness validation
    {
        framework.start_test("Real Rust Mangled Names Correctness");
        auto result = framework.runPointerAnalysis("channel/mangled_test.ll", "basic");
        framework.assert_true(result.passed, "Real mangled names analysis should succeed");
        
        // Should properly process real Rust channel function names
        framework.assert_call_graph_nodes_count_greater_than(0, "Should process Rust mangled function names", result);
        framework.assert_points_to_map_size_greater_than(0, "Should create channel object relationships", result);
        
        // Validate specific function detection for real Rust patterns
        bool found_channel_functions = false;
        for (const auto& func_count : result.function_instance_counts) {
            if (func_count.first.find("channel") != std::string::npos || 
                func_count.first.find("mpsc") != std::string::npos) {
                found_channel_functions = true;
                break;
            }
        }
        framework.assert_true(found_channel_functions, "Should detect real Rust channel function patterns");
    }
    
    // Test 8: Channel constraints integration with cross-analysis validation
    {
        framework.start_test("Channel Constraints Integration Validation");
        auto basic_result = framework.runPointerAnalysis("channel/constraints_test.ll", "basic");
        auto kcs_result = framework.runPointerAnalysis("channel/constraints_test.ll", "kcs", 2);
        
        framework.assert_true(basic_result.passed, "Basic constraints integration should succeed");
        framework.assert_true(kcs_result.passed, "K-callsite constraints integration should succeed");
        
        // Channel constraints should integrate properly with pointer analysis
        framework.assert_points_to_map_size_greater_than(0, "Should integrate channel constraints with pointer analysis", basic_result);
        framework.assert_call_graph_edges_count_greater_than(0, "Should track channel constraint application", basic_result);
        
        // Context-sensitive analysis should maintain constraint validity
        framework.assert_true(kcs_result.idToNodeMap.size() >= basic_result.idToNodeMap.size(), 
                            "Context-sensitive constraints should maintain or increase precision");
        
        std::cout << "  Channel Constraints Integration:" << std::endl;
        std::cout << "    Basic: " << basic_result.idToNodeMap.size() << " constraint nodes" << std::endl;
        std::cout << "    K-callsite: " << kcs_result.idToNodeMap.size() << " constraint nodes" << std::endl;
    }
} 