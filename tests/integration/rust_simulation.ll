; Simulated real Rust code with Arc, Mutex, and channels
@user_sessions = global ptr null

declare ptr @_ZN5alloc4sync12Arc$LT$T$GT$3new17h1234567890abcdefE(ptr)
declare ptr @_ZN3std4sync5mutex14Mutex$LT$T$GT$3new17h1234567890abcdefE(ptr)
declare {ptr, ptr} @_ZN3std4sync4mpsc7channel17h1234567890abcdefE()
declare i32 @_ZN3std4sync4mpsc6Sender4send17h1234567890abcdefE(ptr, ptr)
declare ptr @_ZN3std4sync4mpsc8Receiver4recv17h1234567890abcdefE(ptr)

define void @initialize_session_store() {
entry:
  %hashmap = alloca ptr, align 8
  %mutex = call ptr @_ZN3std4sync5mutex14Mutex$LT$T$GT$3new17h1234567890abcdefE(ptr %hashmap)
  %arc = call ptr @_ZN5alloc4sync12Arc$LT$T$GT$3new17h1234567890abcdefE(ptr %mutex)
  store ptr %arc, ptr @user_sessions, align 8
  ret void
}

define void @session_handler(ptr %request_channel) {
entry:
  ; Receive request from channel
  %request = call ptr @_ZN3std4sync4mpsc8Receiver4recv17h1234567890abcdefE(ptr %request_channel)
  
  ; Access shared session store
  %sessions = load ptr, ptr @user_sessions, align 8
  
  ; Process request (simplified)
  %response = alloca i32, align 4
  store i32 200, ptr %response, align 4
  ret void
}

define void @request_processor() {
entry:
  ; Create channel for request handling
  %channel_result = call {ptr, ptr} @_ZN3std4sync4mpsc7channel17h1234567890abcdefE()
  %sender = extractvalue {ptr, ptr} %channel_result, 0
  %receiver = extractvalue {ptr, ptr} %channel_result, 1
  
  ; Send simulated request
  %request = alloca [100 x i8], align 1
  %request_ptr = getelementptr [100 x i8], ptr %request, i32 0, i32 0
  %send_result = call i32 @_ZN3std4sync4mpsc6Sender4send17h1234567890abcdefE(ptr %sender, ptr %request_ptr)
  
  ; Handle request
  call void @session_handler(ptr %receiver)
  ret void
}

define i32 @main() {
entry:
  call void @initialize_session_store()
  call void @request_processor()
  ret i32 0
} 