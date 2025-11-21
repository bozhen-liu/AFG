; Test channel receive operation detection
declare {ptr, ptr} @_ZN4mpsc7channel17h1234567890abcdefE()
declare ptr @_ZN4mpsc8Receiver4recv17h1234567890abcdefE(ptr)

define void @test_recv() {
entry:
  %channel_result = call {ptr, ptr} @_ZN4mpsc7channel17h1234567890abcdefE()
  %receiver = extractvalue {ptr, ptr} %channel_result, 1
  %recv_result = call ptr @_ZN4mpsc8Receiver4recv17h1234567890abcdefE(ptr %receiver)
  ret void
}

define i32 @main() {
entry:
  call void @test_recv()
  ret i32 0
} 