; Test channel creation detection - matches examples/channel-test patterns
; ModuleID = 'channel_create_test'
source_filename = "channel_create_test.rs"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function similar to examples/channel-test/channel-test-manual.ll
define void @test_channel_creation() unnamed_addr {
start:
  ; Channel creation - matches the pattern from examples
  %channel_result = call {ptr, ptr} @_ZN4mpsc7channel17h1234567890abcdefE()
  
  ; Extract sender and receiver like in the manual example
  %sender = extractvalue {ptr, ptr} %channel_result, 0
  %receiver = extractvalue {ptr, ptr} %channel_result, 1
  
  ret void
}

; Mock channel creation function (matches examples pattern)
declare {ptr, ptr} @_ZN4mpsc7channel17h1234567890abcdefE() unnamed_addr

; Main function wrapper (similar to Rust's structure in examples)
define i32 @main(i32 %0, ptr %1) unnamed_addr {
top:
  call void @test_channel_creation()
  ret i32 0
} 