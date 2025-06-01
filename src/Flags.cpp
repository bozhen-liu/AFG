#include "Flags.h"

using namespace llvm;

// global command-line options
cl::opt<std::string> AnalysisMode(
    "pa-mode",
    cl::desc("Pointer analysis mode: 'ci' (context-insensitive) or 'kcs' (k-callsite-sensitive) or 'origin' (origin pointer analysis)"),
    cl::init("ci"));

cl::opt<unsigned> KValue(
    "k",
    cl::desc("Value of k for k-callsite-sensitive analysis"),
    cl::init(1));

cl::opt<bool> DebugMode(
    "debug",
    cl::desc("Enable debug mode"),
    cl::init(false));