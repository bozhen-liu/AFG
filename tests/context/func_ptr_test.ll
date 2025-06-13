; Test function pointer handling with context sensitivity
define void @target_func_a(i32* %param) {
entry:
  store i32 100, i32* %param
  ret void
}

define void @target_func_b(i32* %param) {
entry:
  store i32 200, i32* %param
  ret void
}

define void @caller_with_func_ptr(void (i32*)* %func_ptr, i32* %data) {
entry:
  call void %func_ptr(i32* %data)
  ret void
}

define i32 @main() {
entry:
  %local = alloca i32, align 4
  call void @caller_with_func_ptr(void (i32*)* @target_func_a, i32* %local)
  call void @caller_with_func_ptr(void (i32*)* @target_func_b, i32* %local)
  ret i32 0
} 