; Test context-sensitive taint analysis
define void @use_secret_in_context(i32* %param) {
entry:
  %secret = alloca i32, align 4
  store i32 42, i32* %secret
  %val = load i32, i32* %secret
  store i32 %val, i32* %param
  ret void
}

define void @context_a() {
entry:
  %local_a = alloca i32, align 4
  call void @use_secret_in_context(i32* %local_a)
  ret void
}

define void @context_b() {
entry:
  %local_b = alloca i32, align 4
  call void @use_secret_in_context(i32* %local_b)
  ret void
}

define i32 @main() {
entry:
  call void @context_a()
  call void @context_b()
  ret i32 0
} 