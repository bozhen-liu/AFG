; Test taint propagation through pointer assignments
define void @test_propagation() {
entry:
  %source = alloca i32, align 4
  %ptr1 = alloca i32*, align 8
  %ptr2 = alloca i32*, align 8
  
  store i32* %source, i32** %ptr1
  %temp = load i32*, i32** %ptr1
  store i32* %temp, i32** %ptr2
  ret void
}

define i32 @main() {
entry:
  call void @test_propagation()
  ret i32 0
} 