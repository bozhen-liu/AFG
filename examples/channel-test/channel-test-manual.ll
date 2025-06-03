; ModuleID = 'channel_test'
source_filename = "channel_test.rs"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nonlazybind uwtable
define void @_ZN4demo4main17h88923f3d44c29843E() unnamed_addr #0 {
start:
  ; Mock channel creation
  %channel_result = call {ptr, ptr} @_ZN4mpsc7channel17h1234567890abcdefE()
  
  ; Mock send operation
  %sender = extractvalue {ptr, ptr} %channel_result, 0
  %data = alloca i32, align 4
  store i32 42, ptr %data, align 4
  %send_result = call i32 @_ZN4mpsc6Sender4send17h1234567890abcdefE(ptr %sender, ptr %data)
  
  ; Mock receive operation  
  %receiver = extractvalue {ptr, ptr} %channel_result, 1
  %recv_result = call ptr @_ZN4mpsc8Receiver4recv17h1234567890abcdefE(ptr %receiver)
  
  ret void
}

; Mock channel creation function
declare {ptr, ptr} @_ZN4mpsc7channel17h1234567890abcdefE() unnamed_addr

; Mock send function
declare i32 @_ZN4mpsc6Sender4send17h1234567890abcdefE(ptr, ptr) unnamed_addr

; Mock receive function  
declare ptr @_ZN4mpsc8Receiver4recv17h1234567890abcdefE(ptr) unnamed_addr

; Main function wrapper (similar to Rust's structure)
define i32 @main(i32 %0, ptr %1) unnamed_addr #1 {
top:
  %2 = load volatile i8, ptr @__rustc_debug_gdb_scripts_section__, align 1
  %3 = sext i32 %0 to i64
  %4 = call i64 @_ZN3std2rt10lang_start17hda86b26a070ba0d9E(ptr @_ZN4demo4main17h88923f3d44c29843E, i64 %3, ptr %1, i8 0)
  %5 = trunc i64 %4 to i32
  ret i32 %5
}

; Mock lang_start function
declare i64 @_ZN3std2rt10lang_start17hda86b26a070ba0d9E(ptr, i64, ptr, i8) unnamed_addr

; Mock debug section
@__rustc_debug_gdb_scripts_section__ = external global i8

attributes #0 = { noinline nonlazybind uwtable }
attributes #1 = { nonlazybind uwtable } 