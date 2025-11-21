#include "../test_framework.h"

void run_basic_tests(AFGTestFramework &framework)
{
    framework.start_category("Pointer Analysis");

    // Test 6: Alloca instruction analysis
    {
        framework.start_test("Alloca Instruction Analysis");
        auto result = framework.runPointerAnalysis("basic/alloca_test.ll", "basic");
        framework.assert_true(result.passed, "Alloca analysis should succeed");

        // iterate result.idToNodeMap and collect the number of Node and AllocNode instances
        int allocNodeCount = 0;
        int nodeCount = 0;
        for (const auto &entry : result.idToNodeMap)
        {
            if (entry.second->getType() == PA_AllocNode)
                allocNodeCount++;
            else if (entry.second->getType() == PA_Node)
                nodeCount++;
        }
        framework.assert_equals(allocNodeCount, 5, "There should be exactly 5 AllocNodes");
        framework.assert_equals(nodeCount, 5, "There should be exactly 5 Nodes");
    }

    // Test 5: Store/Load instruction analysis
    {
        framework.start_test("Store/Load Instruction Analysis");
        auto result = framework.runPointerAnalysis("basic/store_load_test.ll", "basic");
        framework.assert_true(result.passed, "Store/load analysis should succeed");
    }

    // // Test 7: Function parameter pointer propagation
    // {
    //     framework.start_test("Function Parameter Pointer Propagation");
    //     auto result = framework.runPointerAnalysis("basic/param_test.ll", "basic");
    //     framework.assert_true(result.passed, "Parameter propagation analysis should succeed");
    //     framework.assert_call_graph_edges_count_greater_than(0, "Should create call graph edges for function calls", result);
    // }

    // // Test 8: Multiple pointers to same location
    // {
    //     framework.start_test("Multiple Pointers Analysis");
    //     auto result = framework.runPointerAnalysis("basic/multi_ptr_test.ll", "basic");
    //     framework.assert_true(result.passed, "Multiple pointers analysis should succeed");
    //     framework.assert_points_to_map_size_greater_than(0, "Should handle multiple pointer relationships", result);
    // }

    // // Test 9: Vtable processing
    // {
    //     framework.start_test("Vtable Processing");
    //     auto result = framework.runPointerAnalysis("basic/vtable_test.ll", "basic");
    //     framework.assert_true(result.passed, "Vtable processing should succeed");
    //     framework.assert_points_to_map_size_greater_than(0, "Should process vtable function pointers", result);
    // }

    // // Test 10: Context-sensitive comparison on complex cases
    // {
    //     framework.start_test("Context Sensitivity Impact on Complex Call Patterns");

    //     // Test with param_test.ll which has function parameter passing
    //     auto basic_param = framework.runPointerAnalysis("basic/param_test.ll", "basic");
    //     auto kcs_param = framework.runPointerAnalysis("basic/param_test.ll", "kcs", 2);

    //     framework.assert_true(basic_param.passed && kcs_param.passed, "Both analyses should complete");

    //     // Compare the precision: k-callsite might create more precise analysis
    //     std::cout << "  Basic analysis - Call graph nodes: " << basic_param.callGraph.numNodes()
    //               << ", Points-to nodes: " << basic_param.idToNodeMap.size() << std::endl;
    //     std::cout << "  K-callsite analysis - Call graph nodes: " << kcs_param.callGraph.numNodes()
    //               << ", Points-to nodes: " << kcs_param.idToNodeMap.size() << std::endl;
    // }
}