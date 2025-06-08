; Test taint propagation through function parameters
@sensitive_data = global [100 x i8] zeroinitializer

define void @process_data(i8* %data, i8* %output) {
entry:
  %val = load i8, i8* %data
  store i8 %val, i8* %output
  ret void
}

define i32 @main() {
entry:
  %buffer = alloca [100 x i8], align 1
  %buffer_ptr = getelementptr [100 x i8], [100 x i8]* %buffer, i32 0, i32 0
  %sensitive_ptr = getelementptr [100 x i8], [100 x i8]* @sensitive_data, i32 0, i32 0
  call void @process_data(i8* %sensitive_ptr, i8* %buffer_ptr)
  ret i32 0
} 