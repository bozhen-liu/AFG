; Edge cases and unusual patterns
@global_ptr = global ptr null

declare void @external_function(ptr)

; Simple function that might throw (for invoke testing)
define i32 @might_throw(ptr %arg) {
entry:
  %val = load i32, ptr %arg, align 4
  ret i32 %val
}

define void @empty_function() {
entry:
  ret void
}

define void @function_with_unreachable() {
entry:
  %ptr = alloca i32, align 4
  store i32 42, ptr %ptr, align 4
  unreachable
}

define void @function_with_phi(i32 %condition) {
entry:
  %ptr1 = alloca i32, align 4
  %ptr2 = alloca i32, align 4
  store i32 1, ptr %ptr1, align 4
  store i32 2, ptr %ptr2, align 4
  
  %cmp = icmp eq i32 %condition, 0
  br i1 %cmp, label %then, label %else

then:
  br label %merge

else:
  br label %merge

merge:
  %phi_ptr = phi ptr [ %ptr1, %then ], [ %ptr2, %else ]
  store i32 42, ptr %phi_ptr, align 4
  ret void
}

define void @atomic_operations_test() {
entry:
  %atomic_ptr = alloca i32, align 4
  store i32 100, ptr %atomic_ptr, align 4
  
  ; Atomic read-modify-write operation
  %old_val = atomicrmw add ptr %atomic_ptr, i32 5 seq_cst
  
  ; Atomic compare-exchange operation  
  %cmp_result = cmpxchg ptr %atomic_ptr, i32 105, i32 200 seq_cst seq_cst
  
  ret void
}

define void @invoke_test() {
entry:
  %ptr = alloca i32, align 4
  store i32 42, ptr %ptr, align 4
  
  ; Invoke instruction (can throw exceptions)
  %result = invoke i32 @might_throw(ptr %ptr)
          to label %normal unwind label %exception

normal:
  ret void

exception:
  %lpad = landingpad { ptr, i32 }
          cleanup
  ret void
}

define void @bitcast_test() {
entry:
  %int_ptr = alloca i32, align 4
  store i32 42, ptr %int_ptr, align 4
  
  ; BitCast pointer type conversion
  %char_ptr = bitcast ptr %int_ptr to ptr
  store i8 65, ptr %char_ptr, align 1
  
  ret void
}

define i32 @main() {
entry:
  call void @function_with_unreachable()
  call void @function_with_phi(i32 1)
  call void @atomic_operations_test()
  call void @invoke_test()
  call void @bitcast_test()
  ret i32 0
} 