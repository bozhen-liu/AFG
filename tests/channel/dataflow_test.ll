; Test channel data flow constraints
declare {ptr, ptr} @_ZN4mpsc7channel17h1234567890abcdefE()
declare i32 @_ZN4mpsc6Sender4send17h1234567890abcdefE(ptr, ptr)
declare ptr @_ZN4mpsc8Receiver4recv17h1234567890abcdefE(ptr)

@shared_channel = global {ptr, ptr} zeroinitializer

define void @setup_channel() {
entry:
  %channel_result = call {ptr, ptr} @_ZN4mpsc7channel17h1234567890abcdefE()
  store {ptr, ptr} %channel_result, ptr @shared_channel, align 8
  ret void
}

define void @send_data(ptr %data) {
entry:
  %channel = load {ptr, ptr}, ptr @shared_channel, align 8
  %sender = extractvalue {ptr, ptr} %channel, 0
  %send_result = call i32 @_ZN4mpsc6Sender4send17h1234567890abcdefE(ptr %sender, ptr %data)
  ret void
}

define ptr @receive_data() {
entry:
  %channel = load {ptr, ptr}, ptr @shared_channel, align 8
  %receiver = extractvalue {ptr, ptr} %channel, 1
  %recv_result = call ptr @_ZN4mpsc8Receiver4recv17h1234567890abcdefE(ptr %receiver)
  ret ptr %recv_result
}

define i32 @main() {
entry:
  call void @setup_channel()
  %data = alloca i32, align 4
  store i32 999, ptr %data, align 4
  call void @send_data(ptr %data)
  %received = call ptr @receive_data()
  ret i32 0
} 