# AFG: Access Flow Guard

This is the first automated framework to integrate the detections of data leaks and access control policy defects into systematic testing for multi-threaded and event-driven programs.

## pre-requisite for building AFG
install the following compatible versions for this project
- `llvm 17.0.6` 
- `rustc 1.68.0 (2c8cc3432 2023-03-06)`
- `cmake 3.20.0`


## how to build static taint pointer analysis
```bash
mkdir build
cd build
cmake -DLLVM_DIR=$(llvm-config --cmakedir) ..
make
```

## how to compile demo to LLVM IR
```bash
cd examples/demo
cargo rustc -- --emit=llvm-ir
```

## how to compile demo to LLVM IR without rust specific debuginfo -> llvm will complain
```bash
cargo rustc --release -- --emit=llvm-ir -C debuginfo=0
```

## how to run the pass with opt after build
```bash
# cd $root_dir, cannot load pass from build dir
cd .. 
opt -load-pass-plugin build/libPointerAnalysisPass.so \
    -passes=pointer-analysis \
    -disable-output \
    examples/demo/demo-r68_llvm17.ll
```


## how to switch rust toolchain (for examples)
```bash
rustup toolchain list
rustup default stable # we use 1.68
rustc --version
```


## how to debug llvm pass
```bash
LD_DEBUG=libs opt -load-pass-plugin ./build/libPointerAnalysisPass.so -passes=pointer-analysis ... 
```



## rust_monitor: dynamic refinement
see [our forked madsim](https://github.com/bozhen-liu/madsim)



## examples
use `rustc 1.84.1 (e71f9a9a9 2025-01-27)` due to compatibility requirement

- demo: `std::thread` + shared hashmap (replacing redis connection)
- tokio-demo: `tokio` + shared hashmap (replacing redis connection)
- madsim-demo: `madsim` + `madsim_tokio` + shared hashmap (replacing redis connection); `mod tests`
- madsim-mpsc: `madsim` + `madsim_tokio` + mspc (channel); `mod tests`



## how to run tests
- build and run tests
```bash
cd $root_proj_dir/tests/pointer
```


## static taint analysis
In LLVM IR for Rust, common user inputs include:
| Source Type         | Example in Rust/LLVM IR                                  |
|---------------------|---------------------------------------------------------|
| Function parameters | `fn process(input: String)`                             |
| CLI args            | `std::env::args()`                                      |
| File input          | `fs::read_to_string(...)`                               |
| Standard input      | `std::io::stdin().read_line(...)`                       |
| HTTP / web inputs   | e.g., from `hyper`, `actix`, `axum`                     |
| FFI pointers        | Unsafe `*const c_char` from C                           |
| IO functions        | Calls to known IO functions                             |


we summarized taint sources (user input) from open-source Rust LPAs [here](rust_input_functions.json). 


In LLVM IR for Rust, dangerous sinks often include:

| Category             | Risk                        | Example LLVM Calls / Rust APIs                        |
|----------------------|-----------------------------|-------------------------------------------------------|
| System commands      | Command injection           | `@system`, `@execvp`, `Command::new()` via FFI        |
| File operations      | Path traversal, data leak   | `@fopen`, `@fwrite`, `std::fs::write`, `std::fs::File::create` |
| Network output       | Data exfiltration           | `@send`, `@write`, `TcpStream::write`                 |
| Unsafe memory use    | Use-after-free, type confusion | load/store of tainted pointers, `@memcpy`, dereferencing tainted raw pointers |
| Logging/debugging    | Info leak                   | `println!`, `log::info!`, `tracing::info!`            |
| Deserialization/Parsing | Code execution / crashes | `serde_json::from_str`, `bincode::deserialize`        |
| FFI calls            | Undefined behavior          | Any `extern "C"` call using tainted data              |
| Indexing / Arithmetic| Panic, overflow, DoS        | Indexing arrays or slicing with tainted index, `%arrayidx`, `%gep` |




