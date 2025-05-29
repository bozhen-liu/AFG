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