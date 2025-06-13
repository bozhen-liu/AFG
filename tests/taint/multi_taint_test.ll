; Test multiple tainted objects
define void @test_multi_taint() {
entry:
  %tainted1 = alloca i32, align 4
  %tainted2 = alloca i64, align 8
  %normal = alloca i32, align 4
  
  store i32 100, i32* %tainted1
  store i64 200, i64* %tainted2
  store i32 300, i32* %normal
  ret void
}

define i32 @main() {
entry:
  call void @test_multi_taint()
  ret i32 0
} 