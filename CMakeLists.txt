cmake_minimum_required(VERSION 3.13)
project(PointerAnalysisProject)

set(CMAKE_CXX_STANDARD 17)
find_package(LLVM 17 REQUIRED CONFIG)
find_package(nlohmann_json REQUIRED)

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

include_directories(${LLVM_INCLUDE_DIRS} include)
add_definitions(${LLVM_DEFINITIONS})

# Enable testing for CTest support
enable_testing()

# Core analysis library (STATIC for testing)
add_library(PointerAnalysisCore STATIC
  src/PointerAnalysis.cpp
  src/KCallsitePointerAnalysis.cpp
  src/CallGraph.cpp
  src/ChannelSemantics.cpp
  src/OriginPointerAnalysis.cpp
  src/Flags.cpp
)

# Link core library against LLVM and nlohmann_json
target_link_libraries(PointerAnalysisCore PUBLIC LLVM nlohmann_json::nlohmann_json)

# Pass library (MODULE for LLVM plugin loading)
add_library(PointerAnalysisPass MODULE
  src/PointerAnalysisPass.cpp
)

# Link pass against core library
target_link_libraries(PointerAnalysisPass PRIVATE PointerAnalysisCore)

# Add tests subdirectory
add_subdirectory(tests)
