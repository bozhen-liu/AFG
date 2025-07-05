; Simple store/load test
define void @test_store_load() {
entry:
  %ptr = alloca i32, align 4
  store i32 42, i32* %ptr
  %val = load i32, i32* %ptr
  ret void
}

define i32 @main() {
entry:
  call void @test_store_load()
  ret i32 0
} 