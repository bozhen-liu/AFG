; Test multiple pointers pointing to same location
@global_var = global i32 0

define void @test_multi_pointers() {
entry:
  %ptr1 = alloca i32*, align 8
  %ptr2 = alloca i32*, align 8
  store i32* @global_var, i32** %ptr1
  store i32* @global_var, i32** %ptr2
  ret void
}

define i32 @main() {
entry:
  call void @test_multi_pointers()
  ret i32 0
} 