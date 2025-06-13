; Test pointer propagation through parameters
define void @callee(i32* %param) {
entry:
  store i32 100, i32* %param
  ret void
}

define void @caller() {
entry:
  %local = alloca i32, align 4
  call void @callee(i32* %local)
  ret void
}

define i32 @main() {
entry:
  call void @caller()
  ret i32 0
} 