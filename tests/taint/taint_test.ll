; Basic taint analysis test
@secret_data = private unnamed_addr constant <{ [16 x i8] }> <{ [16 x i8] c"sensitive_secret" }>, align 1

define void @test_taint_basic() {
entry:
  %tainted_var = alloca i32, align 4
  store i32 42, ptr %tainted_var, align 4
  
  ; Use the global secret data
  %secret_ptr = getelementptr <{ [16 x i8] }>, ptr @secret_data, i32 0, i32 0
  
  ret void
}

define i32 @main() {
entry:
  call void @test_taint_basic()
  ret i32 0
} 