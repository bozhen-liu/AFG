; Test case that benefits from context sensitivity
define void @common_callee(i32* %param) {
entry:
  store i32 999, i32* %param
  ret void
}

define void @caller_a() {
entry:
  %local_a = alloca i32, align 4
  call void @common_callee(i32* %local_a)
  ret void
}

define void @caller_b() {
entry:
  %local_b = alloca i32, align 4
  call void @common_callee(i32* %local_b)
  ret void
}

define i32 @main() {
entry:
  call void @caller_a()
  call void @caller_b()
  ret i32 0
} 