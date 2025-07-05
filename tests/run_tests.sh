#!/bin/bash

# AFG Test Runner Script
# This script helps run the AFG test framework with various options

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if we're in the right directory
if [[ ! -f "../CMakeLists.txt" ]]; then
    echo -e "${RED}Error: Please run this script from the tests/ directory${NC}"
    exit 1
fi

# Check if build directory exists
if [[ ! -d "../build" ]]; then
    echo -e "${YELLOW}Build directory not found. Creating and building...${NC}"
    cd ..
    mkdir -p build
    cd build
    cmake -DLLVM_DIR=$(llvm-config --cmakedir) ..
    make
    cd ../tests
    echo -e "${GREEN}Build completed.${NC}"
fi

# Check if test executable exists
if [[ ! -f "../build/tests/afg_tests" ]]; then
    echo -e "${YELLOW}Test executable not found. Building...${NC}"
    cd ../build
    make
    cd ../tests
    echo -e "${GREEN}Test build completed.${NC}"
fi

# Create necessary directories
mkdir -p pointer context taint channel integration

echo -e "${BLUE}AFG Test Framework Runner${NC}"
echo "=========================="

# Parse command line arguments
CATEGORY="all"
VERBOSE=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -c|--category)
            CATEGORY="$2"
            shift 2
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  -c, --category CATEGORY  Run specific test category (pointer, context, taint, channel, integration, all)"
            echo "  -v, --verbose           Enable verbose output"
            echo "  -h, --help              Show this help message"
            echo ""
            echo "Categories:"
            echo "  pointer      Basic pointer analysis tests"
            echo "  context      Context-sensitive analysis tests"
            echo "  taint        Taint analysis tests"
            echo "  channel      Channel semantics tests"
            echo "  integration  End-to-end integration tests"
            echo "  all          Run all test categories"
            echo ""
            echo "Examples:"
            echo "  $0                           # Run all tests"
            echo "  $0 -c pointer                # Run only pointer tests"
            echo "  $0 -c channel -v             # Run channel tests with verbose output"
            exit 0
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            echo "Use -h or --help for usage information."
            exit 1
            ;;
    esac
done

# Validate category
if [[ ! "$CATEGORY" =~ ^(pointer|context|taint|channel|integration|all)$ ]]; then
    echo -e "${RED}Error: Invalid category '$CATEGORY'${NC}"
    echo "Valid categories: pointer, context, taint, channel, integration, all"
    exit 1
fi

echo -e "Running ${YELLOW}$CATEGORY${NC} tests..."
echo ""

# Set working directory to tests
cd "$(dirname "$0")"

# Run the tests
if [[ "$VERBOSE" == "true" ]]; then
    echo -e "${BLUE}Command: ../build/tests/afg_tests --category $CATEGORY${NC}"
    echo ""
fi

if ../build/tests/afg_tests --category "$CATEGORY"; then
    echo ""
    echo -e "${GREEN}✅ Tests completed successfully!${NC}"
else
    echo ""
    echo -e "${RED}❌ Some tests failed.${NC}"
    exit 1
fi

# Offer to run with different categories if user ran 'all'
if [[ "$CATEGORY" == "all" ]]; then
    echo ""
    echo -e "${BLUE}💡 Tip: You can run specific categories faster:${NC}"
    echo "  ./run_tests.sh -c pointer    # Basic pointer analysis"
    echo "  ./run_tests.sh -c channel    # Channel semantics (your implementation)"
    echo "  ./run_tests.sh -c taint      # Taint analysis"
    echo "  ./run_tests.sh -c context    # Context-sensitive analysis"
    echo "  ./run_tests.sh -c integration # Integration tests"
fi 