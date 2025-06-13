; Performance test with multiple functions and complex patterns
define void @utility_func_1(ptr %param) {
entry:
  %local = alloca i32, align 4
  store i32 1, ptr %local, align 4
  ret void
}

define void @utility_func_2(ptr %param) {
entry:
  %local = alloca i32, align 4
  store i32 2, ptr %local, align 4
  call void @utility_func_1(ptr %local)
  ret void
}

define void @utility_func_3(ptr %param) {
entry:
  %local = alloca i32, align 4
  store i32 3, ptr %local, align 4
  call void @utility_func_2(ptr %local)
  ret void
}

define void @worker_thread_1() {
entry:
  %data = alloca i32, align 4
  call void @utility_func_1(ptr %data)
  call void @utility_func_2(ptr %data)
  call void @utility_func_3(ptr %data)
  ret void
}

define void @worker_thread_2() {
entry:
  %data = alloca i32, align 4
  call void @utility_func_3(ptr %data)
  call void @utility_func_1(ptr %data)
  call void @utility_func_2(ptr %data)
  ret void
}

define void @coordinator() {
entry:
  call void @worker_thread_1()
  call void @worker_thread_2()
  call void @worker_thread_1()
  call void @worker_thread_2()
  ret void
}

define i32 @main() {
entry:
  call void @coordinator()
  ret i32 0
} 