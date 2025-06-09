#pragma once

#include <cassert>
#include <fstream>
#include <iostream>
#include <memory>
#include <string>
#include <vector>
#include <map>
#include <sstream>

#include "PointerAnalysis.h"
#include "KCallsitePointerAnalysis.h"
#include "OriginPointerAnalysis.h"

#include "llvm/IR/Module.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/CommandLine.h"

using namespace llvm;

// Test framework class
class AFGTestFramework {
private:
    int passed_tests = 0;
    int failed_tests = 0;
    std::string current_category;
    
public:
    // Enhanced test result structure with detailed call graph info
    struct DetailedTestResult {
        bool passed;
        std::string message;
        std::string expected;
        std::string actual;
        
        // Detailed analysis information
        size_t points_to_nodes;
        size_t call_graph_nodes;
        size_t call_graph_edges;
        size_t visited_functions;
        std::map<std::string, int> function_instance_counts;  // Function name -> number of instances
        std::vector<std::string> function_contexts;           // All function contexts found
        std::string raw_output;                               // Complete analysis output for debugging
    };
    
    // Test result structure (backward compatibility)
    struct TestResult {
        bool passed;
        std::string message;
        std::string expected;
        std::string actual;
    };
    
    // Load LLVM IR module from file
    std::unique_ptr<Module> loadModule(const std::string& filename) {
        LLVMContext *context = new LLVMContext();
        SMDiagnostic error;
        auto module = parseIRFile(filename, error, *context);
        if (!module) {
            errs() << "Error loading IR file " << filename << ": " << error.getMessage() << "\n";
            delete context;
            return nullptr;
        }
        // Note: context is leaked here for simplicity in testing
        // In production code, you'd want to manage the context properly
        return module;
    }
    
    // Enhanced pointer analysis with detailed call graph extraction
    DetailedTestResult runDetailedPointerAnalysis(const std::string& ir_file, const std::string& analysis_mode = "basic", unsigned k_value = 1) {
        auto module = loadModule(ir_file);
        if (!module) {
            return {false, "Failed to load IR module", "", "", 0, 0, 0, 0, {}, {}, ""};
        }
        
        std::unique_ptr<PointerAnalysis> PA;
        if (analysis_mode == "kcs") {
            PA = std::make_unique<KCallsitePointerAnalysis>(k_value);
        } else if (analysis_mode == "origin") {
            PA = std::make_unique<OriginPointerAnalysis>(k_value);
        } else {
            PA = std::make_unique<PointerAnalysis>();
        }
        
        PA->DebugMode = false; // Disable debug for cleaner test output
        PA->analyze(*module);
        
        // Capture basic metrics
        const auto& pointsToMap = PA->getPointsToMap();
        const auto& callGraph = PA->getCallGraph();
        
        DetailedTestResult result;
        result.passed = true;
        result.message = "Analysis completed successfully";
        result.points_to_nodes = pointsToMap.size();
        result.call_graph_edges = callGraph.numEdges();
        result.visited_functions = PA->getVisitedFunctions().size();
        
        // Extract detailed call graph information
        std::map<std::string, int> function_counts;
        std::vector<std::string> contexts;
        std::stringstream detailed_output;
        
        detailed_output << "=== Detailed Call Graph Analysis ===\n";
        detailed_output << "Points-to nodes: " << result.points_to_nodes << "\n";
        
        // We need to iterate through ALL nodes, not just those with outgoing edges
        // The graph only contains nodes with outgoing edges, but we want all nodes
        // We'll iterate through all possible node IDs from 0 to find all created nodes
        int maxNodeId = -1;
        const auto& graph = callGraph.getGraph();
        
        // First, find the maximum node ID from the graph edges
        for (const auto& entry : graph) {
            maxNodeId = std::max(maxNodeId, entry.first);
            for (int targetId : entry.second) {
                maxNodeId = std::max(maxNodeId, targetId);
            }
        }
        
        // Now iterate through all possible node IDs to find all nodes
        for (int nodeId = 0; nodeId <= maxNodeId; ++nodeId) {
            const CGNode& node = callGraph.getNode(nodeId);
            
            if (node.function && node.function != nullptr) {
                std::string funcName = node.function->getName().str();
                function_counts[funcName]++;
                
                // Extract context information
                std::string contextStr;
                llvm::raw_string_ostream contextStream(contextStr);
                node.context.print(contextStream);
                contextStream.flush();
                
                std::string fullContext = funcName + " -> " + contextStr;
                contexts.push_back(fullContext);
            }
        }
        
        // Update call graph nodes count based on actual nodes found
        result.call_graph_nodes = function_counts.size();
        
        detailed_output << "Call graph nodes: " << result.call_graph_nodes << "\n";
        detailed_output << "Call graph edges: " << result.call_graph_edges << "\n";
        detailed_output << "Visited functions: " << result.visited_functions << "\n\n";
        
        // Analyze call graph nodes and their contexts
        detailed_output << "=== Call Graph Nodes with Contexts ===\n";
        
        // Re-iterate to print the details
        for (int nodeId = 0; nodeId <= maxNodeId; ++nodeId) {
            const CGNode& node = callGraph.getNode(nodeId);
            
            if (node.function && node.function != nullptr) {
                std::string funcName = node.function->getName().str();
                
                // Extract context information
                std::string contextStr;
                llvm::raw_string_ostream contextStream(contextStr);
                node.context.print(contextStream);
                contextStream.flush();
                
                detailed_output << "Node " << nodeId << ": " << funcName << " with context " << contextStr << "\n";
            }
        }
        
        detailed_output << "\n=== Function Instance Summary ===\n";
        for (const auto& pair : function_counts) {
            detailed_output << pair.first << ": " << pair.second << " instance(s)\n";
        }
        
        result.function_instance_counts = function_counts;
        result.function_contexts = contexts;
        result.raw_output = detailed_output.str();
        
        // Build the summary output for backward compatibility
        std::stringstream summary;
        summary << "PointsToMap: " << result.points_to_nodes << " nodes\n";
        summary << "CallGraph: " << result.call_graph_nodes << " nodes, " << result.call_graph_edges << " edges\n";
        summary << "Visited functions: " << result.visited_functions << "\n";
        
        // Channel semantics info
        std::string channel_info_str;
        llvm::raw_string_ostream channel_info(channel_info_str);
        PA->channelSemantics.printChannelInfo(channel_info);
        summary << "Channels: " << PA->channelSemantics.channels.size() << " instances, ";
        summary << PA->channelSemantics.channel_operations.size() << " operations\n";
        
        result.actual = summary.str();
        
        return result;
    }
    
    // Backward-compatible wrapper
    TestResult runPointerAnalysis(const std::string& ir_file, const std::string& analysis_mode = "basic", unsigned k_value = 1) {
        auto detailed = runDetailedPointerAnalysis(ir_file, analysis_mode, k_value);
        return {detailed.passed, detailed.message, detailed.expected, detailed.actual};
    }
    
    // Enhanced assertion methods for specific call graph analysis
    void assert_call_graph_nodes_count(int expected, const std::string& message, const DetailedTestResult& result) {
        if (result.call_graph_nodes == expected) {
            std::cout << "  ✓ " << message << " (found " << result.call_graph_nodes << " nodes)" << std::endl;
            passed_tests++;
        } else {
            std::cout << "  ✗ " << message << std::endl;
            std::cout << "    Expected: " << expected << " nodes" << std::endl;
            std::cout << "    Actual: " << result.call_graph_nodes << " nodes" << std::endl;
            failed_tests++;
        }
    }
    
    void assert_function_instance_count(const std::string& function_name, int expected_count, const std::string& message, const DetailedTestResult& result) {
        auto it = result.function_instance_counts.find(function_name);
        int actual_count = (it != result.function_instance_counts.end()) ? it->second : 0;
        
        if (actual_count == expected_count) {
            std::cout << "  ✓ " << message << " (found " << actual_count << " instances of " << function_name << ")" << std::endl;
            passed_tests++;
        } else {
            std::cout << "  ✗ " << message << std::endl;
            std::cout << "    Expected: " << expected_count << " instances of " << function_name << std::endl;
            std::cout << "    Actual: " << actual_count << " instances" << std::endl;
            failed_tests++;
        }
    }
    
    void assert_context_differentiation(const std::string& function_name, const std::vector<std::string>& expected_context_parts, const std::string& message, const DetailedTestResult& result) {
        int contexts_found = 0;
        std::vector<std::string> found_contexts;
        
        for (const std::string& context : result.function_contexts) {
            if (context.find(function_name) != std::string::npos) {
                found_contexts.push_back(context);
                for (const std::string& expected_part : expected_context_parts) {
                    if (context.find(expected_part) != std::string::npos) {
                        contexts_found++;
                        break;
                    }
                }
            }
        }
        
        if (contexts_found == expected_context_parts.size()) {
            std::cout << "  ✓ " << message << " (found " << contexts_found << " distinct contexts)" << std::endl;
            passed_tests++;
        } else {
            std::cout << "  ✗ " << message << std::endl;
            std::cout << "    Expected contexts containing: ";
            for (const auto& part : expected_context_parts) {
                std::cout << "'" << part << "' ";
            }
            std::cout << std::endl;
            std::cout << "    Found contexts:" << std::endl;
            for (const auto& ctx : found_contexts) {
                std::cout << "      " << ctx << std::endl;
            }
            failed_tests++;
        }
    }
    
    void print_detailed_analysis(const DetailedTestResult& result) {
        std::cout << "\n" << result.raw_output << std::endl;
    }
    
    // Assert helper functions
    void assert_true(bool condition, const std::string& message) {
        if (condition) {
            std::cout << "  ✓ " << message << std::endl;
            passed_tests++;
        } else {
            std::cout << "  ✗ " << message << std::endl;
            failed_tests++;
        }
    }
    
    void assert_equals(const std::string& expected, const std::string& actual, const std::string& message) {
        if (expected == actual) {
            std::cout << "  ✓ " << message << std::endl;
            passed_tests++;
        } else {
            std::cout << "  ✗ " << message << std::endl;
            std::cout << "    Expected: " << expected << std::endl;
            std::cout << "    Actual: " << actual << std::endl;
            failed_tests++;
        }
    }
    
    void assert_contains(const std::string& text, const std::string& substring, const std::string& message) {
        if (text.find(substring) != std::string::npos) {
            std::cout << "  ✓ " << message << std::endl;
            passed_tests++;
        } else {
            std::cout << "  ✗ " << message << std::endl;
            std::cout << "    Expected substring: " << substring << std::endl;
            std::cout << "    In text: " << text << std::endl;
            failed_tests++;
        }
    }
    
    void assert_greater_than(int actual, int expected, const std::string& message) {
        if (actual > expected) {
            std::cout << "  ✓ " << message << " (" << actual << " > " << expected << ")" << std::endl;
            passed_tests++;
        } else {
            std::cout << "  ✗ " << message << " (" << actual << " <= " << expected << ")" << std::endl;
            failed_tests++;
        }
    }
    
    // Test category management
    void start_category(const std::string& category) {
        current_category = category;
        std::cout << "\n=== " << category << " Tests ===" << std::endl;
    }
    
    void start_test(const std::string& test_name) {
        std::cout << "\nRunning: " << test_name << std::endl;
    }
    
    // Summary reporting
    void print_summary() {
        std::cout << "\n=== Test Summary ===" << std::endl;
        std::cout << "Passed: " << passed_tests << std::endl;
        std::cout << "Failed: " << failed_tests << std::endl;
        std::cout << "Total: " << (passed_tests + failed_tests) << std::endl;
        
        if (failed_tests == 0) {
            std::cout << "🎉 All tests passed!" << std::endl;
        } else {
            std::cout << "❌ " << failed_tests << " test(s) failed" << std::endl;
        }
    }
    
    int get_exit_code() {
        return failed_tests > 0 ? 1 : 0;
    }
};

// Forward declarations for test functions
void run_pointer_tests(AFGTestFramework& framework);
void run_context_tests(AFGTestFramework& framework);
void run_taint_tests(AFGTestFramework& framework);
void run_channel_tests(AFGTestFramework& framework);
void run_integration_tests(AFGTestFramework& framework); 