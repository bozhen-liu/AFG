; Origin analysis test with thread spawn
declare void @_ZN3std6thread5spawn17h1234567890abcdefE()

define void @test_origin() {
entry:
  %tainted_data = alloca i32, align 4
  call void @_ZN3std6thread5spawn17h1234567890abcdefE()  
  store i32 999, i32* %tainted_data
  ret void
}

define i32 @main() {
entry:
  call void @test_origin()
  ret i32 0
} 