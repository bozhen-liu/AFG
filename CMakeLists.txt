cmake_minimum_required(VERSION 3.13)
project(PointerAnalysisProject)

set(CMAKE_CXX_STANDARD 17)
find_package(LLVM 17 REQUIRED CONFIG)

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

include_directories(${LLVM_INCLUDE_DIRS} include)
add_definitions(${LLVM_DEFINITIONS})

# Sources
add_library(PointerAnalysisPass MODULE
  src/PointerAnalysis.cpp
  src/PointerAnalysisPass.cpp
  src/KCallsitePointerAnalysis.cpp
  src/CallGraph.cpp
)

# Link against LLVM libraries
target_link_libraries(PointerAnalysisPass PRIVATE LLVM)
