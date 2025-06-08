; Channel send operation test
; ModuleID = 'send_test'
source_filename = "send_test.rs"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nonlazybind uwtable
define void @test_channel_send() unnamed_addr #0 {
start:
  %channel_result = call {ptr, ptr} @_ZN4mpsc7channel17h1234567890abcdefE()
  %sender = extractvalue {ptr, ptr} %channel_result, 0
  
  ; Create data to send
  %data = alloca i32, align 4
  store i32 123, ptr %data, align 4
  
  ; Perform send operation
  %send_result = call i32 @_ZN4mpsc6Sender4send17h1234567890abcdefE(ptr %sender, ptr %data)
  ret void
}

; Declare functions with proper attributes
declare {ptr, ptr} @_ZN4mpsc7channel17h1234567890abcdefE() unnamed_addr
declare i32 @_ZN4mpsc6Sender4send17h1234567890abcdefE(ptr, ptr) unnamed_addr

define i32 @main() {
entry:
  call void @test_channel_send()
  ret i32 0
}

attributes #0 = { noinline nonlazybind uwtable } 