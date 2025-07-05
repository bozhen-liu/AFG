; Test complete channel communication flow
declare {ptr, ptr} @_ZN4mpsc7channel17h1234567890abcdefE()
declare i32 @_ZN4mpsc6Sender4send17h1234567890abcdefE(ptr, ptr)
declare ptr @_ZN4mpsc8Receiver4recv17h1234567890abcdefE(ptr)

define void @sender_thread() {
entry:
  %channel_result = call {ptr, ptr} @_ZN4mpsc7channel17h1234567890abcdefE()
  %sender = extractvalue {ptr, ptr} %channel_result, 0
  %data = alloca i32, align 4
  store i32 123, ptr %data, align 4
  %send_result = call i32 @_ZN4mpsc6Sender4send17h1234567890abcdefE(ptr %sender, ptr %data)
  ret void
}

define void @receiver_thread() {
entry:
  %channel_result = call {ptr, ptr} @_ZN4mpsc7channel17h1234567890abcdefE()
  %receiver = extractvalue {ptr, ptr} %channel_result, 1
  %recv_result = call ptr @_ZN4mpsc8Receiver4recv17h1234567890abcdefE(ptr %receiver)
  ret void
}

define i32 @main() {
entry:
  call void @sender_thread()
  call void @receiver_thread()
  ret i32 0
} 