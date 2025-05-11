// This file defines the custom macro `afg_monitor!()` for monitoring runtime activities using MadSim.

#[macro_export]
macro_rules! afg_monitor {
    () => {{
        // Capture the current stack trace
        let stack_trace = mad_sim::capture_stack_trace();

        // Log memory accesses
        mad_sim::log_memory_accesses();

        // Output the stack trace for debugging
        println!("Current Stack Trace: {:?}", stack_trace);
    }};
}