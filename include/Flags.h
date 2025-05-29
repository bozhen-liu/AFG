#pragma once
#include "llvm/Support/CommandLine.h"
#include <string>

extern llvm::cl::opt<std::string> AnalysisMode;
extern llvm::cl::opt<unsigned> KValue;
extern llvm::cl::opt<bool> DebugMode;