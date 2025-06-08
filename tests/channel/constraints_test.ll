; Test channel constraints integration with pointer analysis
@global_data = global i32 555

declare {ptr, ptr} @_ZN4mpsc7channel17h1234567890abcdefE()
declare i32 @_ZN4mpsc6Sender4send17h1234567890abcdefE(ptr, ptr)
declare ptr @_ZN4mpsc8Receiver4recv17h1234567890abcdefE(ptr)

define void @send_global_data() {
entry:
  %channel_result = call {ptr, ptr} @_ZN4mpsc7channel17h1234567890abcdefE()
  %sender = extractvalue {ptr, ptr} %channel_result, 0
  ; Send global data through channel
  %send_result = call i32 @_ZN4mpsc6Sender4send17h1234567890abcdefE(ptr %sender, ptr @global_data)
  ret void
}

define void @receive_and_use() {
entry:
  %channel_result = call {ptr, ptr} @_ZN4mpsc7channel17h1234567890abcdefE()
  %receiver = extractvalue {ptr, ptr} %channel_result, 1
  %recv_result = call ptr @_ZN4mpsc8Receiver4recv17h1234567890abcdefE(ptr %receiver)
  ; Use received data
  %val = load i32, ptr %recv_result, align 4
  ret void
}

define i32 @main() {
entry:
  call void @send_global_data()
  call void @receive_and_use()
  ret i32 0
} 