; Test context propagation through multiple call levels
define void @level3(i32* %param) {
entry:
  store i32 3, i32* %param
  ret void
}

define void @level2(i32* %param) {
entry:
  call void @level3(i32* %param)
  ret void
}

define void @level1(i32* %param) {
entry:
  call void @level2(i32* %param)
  ret void
}

define i32 @main() {
entry:
  %local = alloca i32, align 4
  call void @level1(i32* %local)
  ret i32 0
} 