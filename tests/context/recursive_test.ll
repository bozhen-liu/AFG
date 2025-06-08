; Test recursive function handling with context sensitivity
define void @recursive_func(i32 %depth, i32* %ptr) {
entry:
  %cmp = icmp eq i32 %depth, 0
  br i1 %cmp, label %base, label %recurse

base:
  store i32 42, i32* %ptr
  ret void

recurse:
  %next_depth = sub i32 %depth, 1
  call void @recursive_func(i32 %next_depth, i32* %ptr)
  ret void
}

define i32 @main() {
entry:
  %local = alloca i32, align 4
  call void @recursive_func(i32 3, i32* %local)
  ret i32 0
} 