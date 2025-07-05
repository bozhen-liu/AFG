#include "test_framework.h"

// Command line options
static cl::opt<std::string> TestCategory("category", cl::desc("Test category to run"), cl::value_desc("category"));

int main(int argc, char** argv) {
    cl::ParseCommandLineOptions(argc, argv, "AFG Test Framework\n");
    
    AFGTestFramework framework;
    
    std::string category = TestCategory.getValue();
    if (category.empty()) {
        category = "all";
    }
    
    std::cout << "AFG Test Framework" << std::endl;
    std::cout << "==================" << std::endl;
    std::cout << "Running category: " << category << std::endl;
    
    if (category == "all" || category == "pointer") {
        run_pointer_tests(framework);
    }
    
    if (category == "all" || category == "context") {
        run_context_tests(framework);
    }
    
    if (category == "all" || category == "taint") {
        run_taint_tests(framework);
    }
    
    if (category == "all" || category == "channel") {
        run_channel_tests(framework);
    }
    
    if (category == "all" || category == "integration") {
        run_integration_tests(framework);
    }
    
    framework.print_summary();
    return framework.get_exit_code();
} 