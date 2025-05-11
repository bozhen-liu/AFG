// This file implements the functionality for monitoring runtime activities.
// It includes functions to capture stack traces and log memory accesses,
// which will be invoked by the `afg_monitor!()` macro.

use mad_sim::{self, StackTrace};

pub fn log_memory_access(address: usize) {
    // Log the memory access at the given address
    println!("Memory accessed at address: {:#x}", address);
}

pub fn capture_stack_trace() -> StackTrace {
    // Capture the current stack trace
    let stack_trace = mad_sim::capture_stack_trace();
    println!("Captured stack trace: {:?}", stack_trace);
    stack_trace
}