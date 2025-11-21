
; ModuleID = 'store_load_test.ll'
source_filename = "store_load_test.ll"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%QueryContext = type {{ ptr, i64 }, ptr }

@shared_map = global ptr null, align 8
@my_global_str = constant [14 x i8] c"hello, world!\00", align 1

define void @main() {
entry:
  ; Allocate and initialize a QueryContext struct
  %_1 = alloca %QueryContext, align 8

  ; Store global shared_map into the second field
  %0 = getelementptr inbounds %QueryContext, ptr %_1, i32 0, i32 1
  store ptr @shared_map, ptr %0, align 8

  ; Load the second field
  %1 = getelementptr inbounds %QueryContext, ptr %_1, i32 0, i32 1
  %map = load ptr, ptr %1, align 8

  ret void
}
