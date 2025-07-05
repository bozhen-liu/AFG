; Test with real Rust mangled function names
declare {ptr, ptr} @_ZN3std4sync4mpsc7channel17h12345678abcdef90E()
declare void @_ZN3std4sync4mpsc6Sender4send17h12345678abcdef90E(ptr, ptr)
declare ptr @_ZN3std4sync4mpsc8Receiver4recv17h12345678abcdef90E(ptr)

define void @rust_channel_usage() {
entry:
  %channel_result = call {ptr, ptr} @_ZN3std4sync4mpsc7channel17h12345678abcdef90E()
  %sender = extractvalue {ptr, ptr} %channel_result, 0
  %receiver = extractvalue {ptr, ptr} %channel_result, 1
  
  %data = alloca i32, align 4
  store i32 789, ptr %data, align 4
  call void @_ZN3std4sync4mpsc6Sender4send17h12345678abcdef90E(ptr %sender, ptr %data)
  
  %recv_result = call ptr @_ZN3std4sync4mpsc8Receiver4recv17h12345678abcdef90E(ptr %receiver)
  ret void
}

define i32 @main() {
entry:
  call void @rust_channel_usage()
  ret i32 0
} 