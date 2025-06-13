; Complex integration test with multiple features
@global_data = global i32 0

declare { i8*, i8* } @_ZN3std4sync4mpsc7channel17h1234567890abcdefE()
declare void @_ZN3std4sync4mpsc6Sender4send17h1234567890abcdefE(i8*, i32)
declare i32 @_ZN3std4sync4mpsc8Receiver4recv17h1234567890abcdefE(i8*)
declare void @_ZN3std6thread5spawn17h1234567890abcdefE()

define void @processor(i32* %data) {
entry:
  %val = load i32, i32* %data
  %inc = add i32 %val, 1
  store i32 %inc, i32* %data
  ret void
}

define void @thread_worker() {
entry:
  %local_data = alloca i32, align 4
  store i32 100, i32* %local_data
  call void @_ZN3std6thread5spawn17h1234567890abcdefE()
  call void @processor(i32* %local_data)
  ret void
}

define void @channel_worker() {
entry:
  %channel = call { i8*, i8* } @_ZN3std4sync4mpsc7channel17h1234567890abcdefE()
  %sender = extractvalue { i8*, i8* } %channel, 0
  %receiver = extractvalue { i8*, i8* } %channel, 1
  
  call void @_ZN3std4sync4mpsc6Sender4send17h1234567890abcdefE(i8* %sender, i32 999)
  %result = call i32 @_ZN3std4sync4mpsc8Receiver4recv17h1234567890abcdefE(i8* %receiver)
  ret void
}

define i32 @main() {
entry:
  call void @thread_worker()
  call void @channel_worker()
  ret i32 0
} 