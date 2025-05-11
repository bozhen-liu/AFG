# AFG Rust Monitor

This Rust subproject provides the `afg_monitor!()` macro, which utilizes MadSim to monitor runtime activities in the AFG project. The macro captures the current stack trace and logs memory accesses, allowing for detailed analysis of the program's behavior.

## Features

- **Stack Trace Capture**: Automatically captures the current stack trace when the `afg_monitor!()` macro is invoked.
- **Memory Access Logging**: Logs memory accesses to track how memory is being used during the execution of the program.
- **Integration with MadSim**: Leverages the MadSim library for efficient monitoring and logging.

## Usage

To use the `afg_monitor!()` macro in your code, follow these steps:

1. **Add Dependency**: Ensure that the MadSim library is included in your `Cargo.toml` file.

2. **Import the Macro**: In your Rust file, import the macro using:
   ```rust
   #[macro_use]
   extern crate rust_monitor;
   ```

3. **Invoke the Macro**: Use the macro in your code where you want to monitor runtime activities:
   ```rust
   afg_monitor!();
   ```

## Setup Instructions

1. **Clone the Repository**: Clone the AFG project repository to your local machine.

2. **Navigate to the Rust Monitor Directory**:
   ```bash
   cd afg/rust_monitor
   ```

3. **Build the Project**: Use Cargo to build the Rust subproject:
   ```bash
   cargo build
   ```

4. **Run Tests**: Ensure everything is working correctly by running the tests:
   ```bash
   cargo test
   ```

## Contribution

Contributions to the Rust monitor are welcome! Please follow the standard contribution guidelines for the AFG project.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.