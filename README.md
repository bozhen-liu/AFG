# AFG: Access Flow Guard

This is the first automated framework to integrate the detections of data leaks and access control policy defects into systematic testing for multi-threaded and event-driven programs.

## how to build static taint analysis
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


## rust_monitor
see `rust_monitor`