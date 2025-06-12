#pragma once

#include "llvm/Demangle/Demangle.h"
#include <string>
#include <algorithm>

// Helper function to trim leading and trailing spaces
inline std::string trim(const std::string &str)
{
    auto start = str.find_first_not_of(" \t");
    auto end = str.find_last_not_of(" \t");
    return (start == std::string::npos) ? "" : str.substr(start, end - start + 1);
}

inline std::string getDemangledName(std::string mangledName)
{
    std::string demangled = llvm::demangle(mangledName); // the output looks like "std::thread::spawn::hc6f148c1a1888888"
    // Remove hash suffix: keep up to the last "::"
    size_t last_colon = demangled.rfind("::");
    if (last_colon != std::string::npos)
    {
        demangled = demangled.substr(0, last_colon);
    }

    return demangled;
}