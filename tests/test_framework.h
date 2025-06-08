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
    // Test result structure
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
    
    // Run pointer analysis and capture results
    TestResult runPointerAnalysis(const std::string& ir_file, const std::string& analysis_mode = "basic", unsigned k_value = 1) {
        auto module = loadModule(ir_file);
        if (!module) {
            return {false, "Failed to load IR module", "", ""};
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
        
        // Capture points-to map size and call graph info
        const auto& pointsToMap = PA->getPointsToMap();
        const auto& callGraph = PA->getCallGraph();
        
        std::stringstream result;
        result << "PointsToMap: " << pointsToMap.size() << " nodes\n";
        result << "CallGraph: " << callGraph.numNodes() << " nodes, " << callGraph.numEdges() << " edges\n";
        result << "Visited functions: " << PA->getVisitedFunctions().size() << "\n";
        
        // Channel semantics info
        std::string channel_info_str;
        llvm::raw_string_ostream channel_info(channel_info_str);
        PA->channelSemantics.printChannelInfo(channel_info);
        result << "Channels: " << PA->channelSemantics.channels.size() << " instances, ";
        result << PA->channelSemantics.channel_operations.size() << " operations\n";
        
        return {true, "Analysis completed successfully", "", result.str()};
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