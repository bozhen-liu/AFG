#include "../test_framework.h"

void run_channel_tests(AFGTestFramework& framework) {
    framework.start_category("Channel Semantics");
    
    // Test 1: Channel creation detection
    {
        framework.start_test("Channel Creation Detection");
        auto result = framework.runPointerAnalysis("channel/channel_create_test.ll");
        framework.assert_true(result.passed, "Channel creation analysis should succeed");
        
        // Should detect channel instances and operations
        framework.assert_contains(result.actual, "Channels:", "Should detect channel instances");
    }
    
    // Test 2: Send operation detection
    {
        framework.start_test("Channel Send Operation Detection");
        auto result = framework.runPointerAnalysis("channel/send_test.ll");
        framework.assert_true(result.passed, "Send operation analysis should succeed");
        
        // Should detect channel operations
        framework.assert_contains(result.actual, "Channels:", "Should detect channel operations");
    }
    
    // Test 3: Receive operation detection
    {
        framework.start_test("Channel Receive Operation Detection");
        auto result = framework.runPointerAnalysis("channel/recv_test.ll");
        framework.assert_true(result.passed, "Receive operation analysis should succeed");
        
        // Should detect channel operations
        framework.assert_contains(result.actual, "Channels:", "Should detect channel operations");
    }
    
    // Test 4: Complete channel communication flow
    {
        framework.start_test("Complete Channel Communication Flow");
        auto result = framework.runPointerAnalysis("channel/flow_test.ll");
        framework.assert_true(result.passed, "Channel flow analysis should succeed");
        
        // Should detect multiple channel operations
        framework.assert_contains(result.actual, "Channels:", "Should detect channel flow");
    }
    
    // Test 5: Channel data flow constraints
    {
        framework.start_test("Channel Data Flow Constraints");
        auto result = framework.runPointerAnalysis("channel/dataflow_test.ll");
        framework.assert_true(result.passed, "Channel dataflow analysis should succeed");
        
        // Should create data flow constraints between send and receive
        framework.assert_contains(result.actual, "PointsToMap:", "Should create pointer constraints");
    }
    
    // Test 6: Tokio channel operations
    {
        framework.start_test("Tokio Channel Operations");
        auto result = framework.runPointerAnalysis("channel/tokio_test.ll");
        framework.assert_true(result.passed, "Tokio channel analysis should succeed");
        
        // Should detect Tokio channel operations
        framework.assert_contains(result.actual, "Channels:", "Should detect Tokio channels");
    }
    
    // Test 7: Channel operation with real Rust mangled names
    {
        framework.start_test("Real Rust Mangled Channel Names");
        auto result = framework.runPointerAnalysis("channel/mangled_test.ll");
        framework.assert_true(result.passed, "Real mangled names analysis should succeed");
        
        // Should properly demangle and detect Rust channel operations
        framework.assert_contains(result.actual, "Channels:", "Should detect real Rust channels");
    }
    
    // Test 8: Channel constraints integration
    {
        framework.start_test("Channel Constraints Integration");
        auto result = framework.runPointerAnalysis("channel/constraints_test.ll");
        framework.assert_true(result.passed, "Channel constraints integration should succeed");
        
        // Should integrate channel constraints with regular pointer analysis
        framework.assert_contains(result.actual, "PointsToMap:", "Should integrate with pointer analysis");
        framework.assert_contains(result.actual, "Channels:", "Should apply channel constraints");
    }
} 