; Test vtable processing from PointerAnalysis.cpp
@vtable.0 = private unnamed_addr constant <{ ptr, ptr, ptr }> <{ 
  ptr @function_a, 
  ptr @function_b, 
  ptr @function_c 
}>, align 8

declare void @function_a()
declare void @function_b() 
declare void @function_c()

define void @test_vtable_usage() {
entry:
  ; Load function pointer from vtable
  %func_ptr = getelementptr <{ ptr, ptr, ptr }>, ptr @vtable.0, i32 0, i32 0
  %func = load ptr, ptr %func_ptr, align 8
  
  ; Call through vtable
  call void %func()
  
  ret void
}

define i32 @main() {
entry:
  call void @test_vtable_usage()
  ret i32 0
} 