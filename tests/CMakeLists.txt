cmake_minimum_required(VERSION 3.13)
project(AFG_Tests)

# Set the C++ standard to match LLVM's requirements
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Enable testing
enable_testing()

# Find required packages
find_package(LLVM 17 REQUIRED CONFIG)
find_package(nlohmann_json REQUIRED)

# Include directories
include_directories(${LLVM_INCLUDE_DIRS} ../include)
add_definitions(${LLVM_DEFINITIONS})

# Test executable
add_executable(afg_tests
    test.cpp
    test_framework.h
    pointer/pointer_tests.cpp
    context/context_tests.cpp
    taint/taint_tests.cpp
    channel/channel_tests.cpp
    integration/integration_tests.cpp
)

# Link libraries
target_link_libraries(afg_tests PRIVATE 
    ${CMAKE_CURRENT_SOURCE_DIR}/../build/libPointerAnalysisCore.a
    LLVM 
    nlohmann_json::nlohmann_json
)

# Add test cases
add_test(NAME pointer_analysis_tests COMMAND afg_tests --category pointer)
add_test(NAME context_analysis_tests COMMAND afg_tests --category context)
add_test(NAME taint_analysis_tests COMMAND afg_tests --category taint)
add_test(NAME channel_analysis_tests COMMAND afg_tests --category channel)
add_test(NAME integration_tests COMMAND afg_tests --category integration)
add_test(NAME all_tests COMMAND afg_tests --category all)

# Set working directory for tests
set_tests_properties(
    pointer_analysis_tests 
    context_analysis_tests 
    taint_analysis_tests 
    channel_analysis_tests 
    integration_tests 
    all_tests
    PROPERTIES WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
)

# Copy test data files
file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/pointer/ DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/pointer/)
file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/context/ DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/context/)
file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/taint/ DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/taint/)
file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/channel/ DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/channel/)
file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/integration/ DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/integration/) 