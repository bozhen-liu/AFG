; simple.ll

; A simple function that takes a pointer and stores 42 to it
define void @callee(i32* %p) {
entry:
  store i32 42, i32* %p
  ret void
}

; First caller: calls callee with @g1
define void @caller1() {
entry:
  call void @callee(i32* @g1)
  ret void
}

; Second caller: calls callee with @g2
define void @caller2() {
entry:
  call void @callee(i32* @g2)
  ret void
}

; Global variables
@g1 = global i32 0
@g2 = global i32 0

; Main function calls both callers
define i32 @main() {
entry:
  call void @caller1()
  call void @caller2()
  ret i32 0
}