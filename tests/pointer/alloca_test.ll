; Simple alloca test
define void @test_alloca() {
entry:
  %ptr1 = alloca i32, align 4
  %ptr2 = alloca i64, align 8
  %ptr3 = alloca ptr, align 8
  ret void
}

define i32 @main() {
entry:
  call void @test_alloca()
  ret i32 0
} 