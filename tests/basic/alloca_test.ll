; Simple alloca test

%"std::collections::hash::map::HashMap<alloc::string::String, alloc::string::String>" = type opaque
%"alloc::string::String" = type opaque

define void @test_alloca() {
start:
  %0 = alloca i32, align 4
  %1 = alloca { i8, i8 }, align 1
  %2 = alloca ptr, align 8
  %3 = alloca %"std::collections::hash::map::HashMap<alloc::string::String, alloc::string::String>", align 8
  %4 = alloca %"alloc::string::String", align 8
  ret void
}

define i32 @main() {
start:
  call void @test_alloca()
  ret i32 0
} 