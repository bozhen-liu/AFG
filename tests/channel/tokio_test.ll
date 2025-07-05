; Test Tokio channel operations
declare {ptr, ptr} @_ZN5tokio4sync4mpsc7channel17h1234567890abcdefE(i32)
declare void @_ZN5tokio4sync4mpsc6Sender4send17h1234567890abcdefE(ptr, ptr)
declare ptr @_ZN5tokio4sync4mpsc8Receiver4recv17h1234567890abcdefE(ptr)

define void @tokio_async_send() {
entry:
  %channel_result = call {ptr, ptr} @_ZN5tokio4sync4mpsc7channel17h1234567890abcdefE(i32 10)
  %sender = extractvalue {ptr, ptr} %channel_result, 0
  %data = alloca i32, align 4
  store i32 456, ptr %data, align 4
  call void @_ZN5tokio4sync4mpsc6Sender4send17h1234567890abcdefE(ptr %sender, ptr %data)
  ret void
}

define void @tokio_async_recv() {
entry:
  %channel_result = call {ptr, ptr} @_ZN5tokio4sync4mpsc7channel17h1234567890abcdefE(i32 10)
  %receiver = extractvalue {ptr, ptr} %channel_result, 1
  %recv_result = call ptr @_ZN5tokio4sync4mpsc8Receiver4recv17h1234567890abcdefE(ptr %receiver)
  ret void
}

define i32 @main() {
entry:
  call void @tokio_async_send()
  call void @tokio_async_recv()
  ret i32 0
} 