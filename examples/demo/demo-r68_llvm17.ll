; ModuleID = 'demo.91e00a17-cgu.0'
source_filename = "demo.91e00a17-cgu.0"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%"redis::types::RedisError" = type { %"redis::types::ErrorRepr" }
%"redis::types::ErrorRepr" = type { i8, [55 x i8] }
%"redis::types::Value" = type { i64, [3 x i64] }
%"core::result::Result<redis::types::Value, redis::types::RedisError>" = type { i8, [55 x i8] }
%"redis::cmd::Cmd" = type { { i64, i64 }, %"alloc::vec::Vec<u8>", %"alloc::vec::Vec<redis::cmd::Arg<usize>>" }
%"alloc::vec::Vec<u8>" = type { { i64, ptr }, i64 }
%"alloc::vec::Vec<redis::cmd::Arg<usize>>" = type { { i64, ptr }, i64 }
%"alloc::string::String" = type { %"alloc::vec::Vec<u8>" }
%"core::fmt::Arguments<'_>" = type { { ptr, i64 }, { ptr, i64 }, { ptr, i64 } }
%"core::result::Result<alloc::string::String, redis::types::RedisError>" = type { i8, [55 x i8] }
%"core::result::Result<(), redis::types::RedisError>" = type { i8, [55 x i8] }
%"core::result::Result<redis::connection::Connection, redis::types::RedisError>" = type { [18 x i32], i32, [3 x i32] }
%"redis::connection::Connection" = type { %"redis::parser::Parser", i64, %"redis::connection::ActualConnection", i8, [3 x i8] }
%"redis::parser::Parser" = type { %"combine::stream::decoder::Decoder<combine::parser::combinator::AnySendSyncPartialState, combine::stream::PointerOffset<[u8]>>" }
%"combine::stream::decoder::Decoder<combine::parser::combinator::AnySendSyncPartialState, combine::stream::PointerOffset<[u8]>>" = type { %"combine::stream::buf_reader::Buffer", { ptr, ptr }, i64, i8, [7 x i8] }
%"combine::stream::buf_reader::Buffer" = type { %"bytes::bytes_mut::BytesMut" }
%"bytes::bytes_mut::BytesMut" = type { i64, i64, ptr, ptr }
%"redis::connection::ActualConnection" = type { i32, [2 x i32] }
%"[closure@src/main.rs:14:19: 14:26]" = type { ptr, %"alloc::string::String", %"alloc::string::String" }
%"alloc::sync::ArcInner<redis::client::Client>" = type { %"core::sync::atomic::AtomicUsize", %"core::sync::atomic::AtomicUsize", %"redis::client::Client" }
%"core::sync::atomic::AtomicUsize" = type { i64 }
%"redis::client::Client" = type { %"redis::connection::ConnectionInfo" }
%"redis::connection::ConnectionInfo" = type { %"redis::connection::ConnectionAddr", %"redis::connection::RedisConnectionInfo" }
%"redis::connection::ConnectionAddr" = type { i8, [31 x i8] }
%"redis::connection::RedisConnectionInfo" = type { i64, %"core::option::Option<alloc::string::String>", %"core::option::Option<alloc::string::String>" }
%"core::option::Option<alloc::string::String>" = type { [1 x i64], ptr, [1 x i64] }
%"core::result::Result<redis::types::Value, redis::types::RedisError>::Ok" = type { [1 x i64], %"redis::types::Value" }
%"core::result::Result<alloc::string::String, redis::types::RedisError>::Ok" = type { [1 x i64], %"alloc::string::String" }
%"std::thread::JoinInner<'_, ()>" = type { i64, ptr, ptr }
%"alloc::sync::ArcInner<std::thread::Packet<'_, ()>>" = type { %"core::sync::atomic::AtomicUsize", %"core::sync::atomic::AtomicUsize", %"std::thread::Packet<'_, ()>" }
%"std::thread::Packet<'_, ()>" = type { %"core::marker::PhantomData<core::option::Option<&std::thread::scoped::ScopeData>>", ptr, %"core::cell::UnsafeCell<core::option::Option<core::result::Result<(), alloc::boxed::Box<dyn core::any::Any + core::marker::Send>>>>" }
%"core::marker::PhantomData<core::option::Option<&std::thread::scoped::ScopeData>>" = type {}
%"core::cell::UnsafeCell<core::option::Option<core::result::Result<(), alloc::boxed::Box<dyn core::any::Any + core::marker::Send>>>>" = type { %"core::option::Option<core::result::Result<(), alloc::boxed::Box<dyn core::any::Any + core::marker::Send>>>" }
%"core::option::Option<core::result::Result<(), alloc::boxed::Box<dyn core::any::Any + core::marker::Send>>>" = type { i64, [2 x i64] }
%"core::option::Option<core::ops::range::Range<usize>>" = type { i64, [2 x i64] }
%"[closure@std::thread::Builder::spawn_unchecked_<'_, '_, [closure@src/main.rs:14:19: 14:26], ()>::{closure#1}]" = type { ptr, %"std::thread::Builder::spawn_unchecked_::MaybeDangling<[closure@src/main.rs:14:19: 14:26]>", ptr, ptr }
%"std::thread::Builder::spawn_unchecked_::MaybeDangling<[closure@src/main.rs:14:19: 14:26]>" = type { %"core::mem::maybe_uninit::MaybeUninit<[closure@src/main.rs:14:19: 14:26]>" }
%"core::mem::maybe_uninit::MaybeUninit<[closure@src/main.rs:14:19: 14:26]>" = type { [7 x i64] }
%"core::option::Option<core::result::Result<(), alloc::boxed::Box<dyn core::any::Any + core::marker::Send>>>::Some" = type { [1 x i64], { ptr, ptr } }
%"redis::types::Value::Data" = type { [1 x i64], %"alloc::vec::Vec<u8>" }
%"redis::types::Value::Bulk" = type { [1 x i64], %"alloc::vec::Vec<redis::types::Value>" }
%"alloc::vec::Vec<redis::types::Value>" = type { { i64, ptr }, i64 }
%"redis::types::Value::Status" = type { [1 x i64], %"alloc::string::String" }
%"redis::connection::ConnectionAddr::Unix" = type { [1 x i64], %"std::path::PathBuf" }
%"std::path::PathBuf" = type { %"std::ffi::os_str::OsString" }
%"std::ffi::os_str::OsString" = type { %"std::sys::unix::os_str::Buf" }
%"std::sys::unix::os_str::Buf" = type { %"alloc::vec::Vec<u8>" }
%"redis::connection::ConnectionAddr::Tcp" = type { [1 x i16], i16, [2 x i16], %"alloc::string::String" }
%"redis::connection::ConnectionAddr::TcpTls" = type { [1 x i8], i8, i16, [2 x i16], %"alloc::string::String" }
%"redis::types::ErrorRepr::IoError" = type { [1 x i64], ptr }
%"redis::types::ErrorRepr::WithDescriptionAndDetail" = type { [1 x i8], i8, [6 x i8], %"alloc::string::String", { ptr, i64 } }
%"redis::types::ErrorRepr::ExtensionError" = type { [1 x i64], %"alloc::string::String", %"alloc::string::String" }
%"alloc::ffi::c_str::NulError" = type { i64, %"alloc::vec::Vec<u8>" }
%"std::sys::unix::stdio::Stderr" = type { {} }
%"alloc::sync::ArcInner<std::thread::scoped::ScopeData>" = type { %"core::sync::atomic::AtomicUsize", %"core::sync::atomic::AtomicUsize", %"std::thread::scoped::ScopeData" }
%"std::thread::scoped::ScopeData" = type { %"core::sync::atomic::AtomicUsize", ptr, %"core::sync::atomic::AtomicBool", [7 x i8] }
%"core::sync::atomic::AtomicBool" = type { i8 }
%"alloc::sync::ArcInner<std::sync::mutex::Mutex<alloc::vec::Vec<u8>>>" = type { %"core::sync::atomic::AtomicUsize", %"core::sync::atomic::AtomicUsize", %"std::sync::mutex::Mutex<alloc::vec::Vec<u8>>" }
%"std::sync::mutex::Mutex<alloc::vec::Vec<u8>>" = type { %"std::sys::unix::locks::futex_mutex::Mutex", %"std::sync::poison::Flag", [3 x i8], %"core::cell::UnsafeCell<alloc::vec::Vec<u8>>" }
%"std::sys::unix::locks::futex_mutex::Mutex" = type { %"core::sync::atomic::AtomicU32" }
%"core::sync::atomic::AtomicU32" = type { i32 }
%"std::sync::poison::Flag" = type { %"core::sync::atomic::AtomicBool" }
%"core::cell::UnsafeCell<alloc::vec::Vec<u8>>" = type { %"alloc::vec::Vec<u8>" }
%"alloc::sync::ArcInner<std::thread::Inner>" = type { %"core::sync::atomic::AtomicUsize", %"core::sync::atomic::AtomicUsize", %"std::thread::Inner" }
%"std::thread::Inner" = type { { ptr, i64 }, i64, %"std::sys_common::thread_parking::futex::Parker", [1 x i32] }
%"std::sys_common::thread_parking::futex::Parker" = type { %"core::sync::atomic::AtomicU32" }
%"core::result::Result<usize, std::io::error::Error>" = type { i64, [1 x i64] }
%"core::result::Result<usize, std::io::error::Error>::Err" = type { [1 x i64], ptr }
%"std::io::error::SimpleMessage" = type { { ptr, i64 }, i8, [7 x i8] }
%"core::result::Result<std::sys::unix::thread::Thread, std::io::error::Error>" = type { i64, [1 x i64] }
%"std::thread::Builder" = type { { i64, i64 }, %"core::option::Option<alloc::string::String>" }
%"core::result::Result<std::sys::unix::thread::Thread, std::io::error::Error>::Err" = type { [1 x i64], ptr }
%"core::result::Result<redis::connection::ConnectionInfo, redis::types::RedisError>" = type { i8, [87 x i8] }
%"std::thread::JoinHandle<()>" = type { %"std::thread::JoinInner<'_, ()>" }
%"core::result::Result<redis::connection::ConnectionInfo, redis::types::RedisError>::Err" = type { [1 x i64], %"redis::types::RedisError" }

@alloc265 = private unnamed_addr constant <{ [73 x i8] }> <{ [73 x i8] c"/rustc/2c8cc343237b8f7d5a3c3703e3a87f2eb2c54a74/library/std/src/io/mod.rs" }>, align 1
@alloc266 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc265, [16 x i8] c"I\00\00\00\00\00\00\00\0D\06\00\00!\00\00\00" }>, align 8
@alloc72 = private unnamed_addr constant <{ [28 x i8] }> <{ [28 x i8] c"failed to write whole buffer" }>, align 1
@alloc75 = private unnamed_addr constant <{ ptr, [9 x i8], [7 x i8] }> <{ ptr @alloc72, [9 x i8] c"\1C\00\00\00\00\00\00\00\17", [7 x i8] undef }>, align 8
@vtable.0 = private unnamed_addr constant <{ ptr, [16 x i8], ptr, ptr, ptr }> <{ ptr @"_ZN4core3ptr92drop_in_place$LT$std..io..Write..write_fmt..Adapter$LT$std..sys..unix..stdio..Stderr$GT$$GT$17h531d7fdd7778cbdeE", [16 x i8] c"\10\00\00\00\00\00\00\00\08\00\00\00\00\00\00\00", ptr @"_ZN80_$LT$std..io..Write..write_fmt..Adapter$LT$T$GT$$u20$as$u20$core..fmt..Write$GT$9write_str17h93a9f8277eec1af4E", ptr @_ZN4core3fmt5Write10write_char17h208b4aa1c8599cdeE, ptr @_ZN4core3fmt5Write9write_fmt17h62df01c67385dd35E }>, align 8
@alloc65 = private unnamed_addr constant <{ [15 x i8] }> <{ [15 x i8] c"formatter error" }>, align 1
@alloc68 = private unnamed_addr constant <{ ptr, [9 x i8], [7 x i8] }> <{ ptr @alloc65, [9 x i8] c"\0F\00\00\00\00\00\00\00(", [7 x i8] undef }>, align 8
@vtable.1 = private unnamed_addr constant <{ ptr, [16 x i8], ptr, ptr, ptr }> <{ ptr @"_ZN4core3ptr104drop_in_place$LT$$RF$mut$u20$std..io..Write..write_fmt..Adapter$LT$std..sys..unix..stdio..Stderr$GT$$GT$17hc5daa0389cb7ac03E", [16 x i8] c"\08\00\00\00\00\00\00\00\08\00\00\00\00\00\00\00", ptr @"_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17hb062ed2bce5707a7E", ptr @"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h657bb9ea592f471eE", ptr @"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h657bb9ea592f471eE" }>, align 8
@alloc284 = private unnamed_addr constant <{ [43 x i8] }> <{ [43 x i8] c"called `Option::unwrap()` on a `None` value" }>, align 1
@alloc294 = private unnamed_addr constant <{ [77 x i8] }> <{ [77 x i8] c"/rustc/2c8cc343237b8f7d5a3c3703e3a87f2eb2c54a74/library/std/src/thread/mod.rs" }>, align 1
@alloc283 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc294, [16 x i8] c"M\00\00\00\00\00\00\00\B2\05\00\00I\00\00\00" }>, align 8
@alloc286 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc294, [16 x i8] c"M\00\00\00\00\00\00\00\B2\05\00\00(\00\00\00" }>, align 8
@alloc287 = private unnamed_addr constant <{ [22 x i8] }> <{ [22 x i8] c"failed to spawn thread" }>, align 1
@alloc289 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc294, [16 x i8] c"M\00\00\00\00\00\00\00\CB\02\00\00\1D\00\00\00" }>, align 8
@vtable.2 = private unnamed_addr constant <{ ptr, [16 x i8], ptr }> <{ ptr @"_ZN4core3ptr158drop_in_place$LT$std..thread..Builder..spawn_unchecked_$LT$demo..spawn_user_query..$u7b$$u7b$closure$u7d$$u7d$$C$$LP$$RP$$GT$..$u7b$$u7b$closure$u7d$$u7d$$GT$17h6cdb75df18ce3addE", [16 x i8] c"P\00\00\00\00\00\00\00\08\00\00\00\00\00\00\00", ptr @"_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17ha38577f055a33e7bE" }>, align 8
@alloc293 = private unnamed_addr constant <{ [47 x i8] }> <{ [47 x i8] c"thread name may not contain interior null bytes" }>, align 1
@alloc295 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc294, [16 x i8] c"M\00\00\00\00\00\00\00\F9\01\00\00 \00\00\00" }>, align 8
@vtable.3 = private unnamed_addr constant <{ ptr, [16 x i8], ptr, ptr, ptr }> <{ ptr @"_ZN4core3ptr104drop_in_place$LT$$RF$mut$u20$std..io..Write..write_fmt..Adapter$LT$std..sys..unix..stdio..Stderr$GT$$GT$17hc5daa0389cb7ac03E", [16 x i8] c"\08\00\00\00\00\00\00\00\08\00\00\00\00\00\00\00", ptr @"_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hd05fddd57ba332b7E", ptr @"_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17h6f5197a8c006540dE", ptr @"_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_fmt17h61027013d987549fE" }>, align 8
@alloc112 = private unnamed_addr constant <{}> zeroinitializer, align 8
@vtable.5 = private unnamed_addr constant <{ ptr, [16 x i8], ptr }> <{ ptr @"_ZN4core3ptr42drop_in_place$LT$std..io..error..Error$GT$17h44b2f0e87eb79141E", [16 x i8] c"\08\00\00\00\00\00\00\00\08\00\00\00\00\00\00\00", ptr @"_ZN58_$LT$std..io..error..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h8b78aa37499eb01fE" }>, align 8
@vtable.6 = private unnamed_addr constant <{ ptr, [16 x i8], ptr }> <{ ptr @"_ZN4core3ptr48drop_in_place$LT$alloc..ffi..c_str..NulError$GT$17h236d8428e3ec4c93E", [16 x i8] c" \00\00\00\00\00\00\00\08\00\00\00\00\00\00\00", ptr @"_ZN64_$LT$alloc..ffi..c_str..NulError$u20$as$u20$core..fmt..Debug$GT$3fmt17h46aec0dfdbe4e538E" }>, align 8
@alloc344 = private unnamed_addr constant <{ [43 x i8] }> <{ [43 x i8] c"called `Result::unwrap()` on an `Err` value" }>, align 1
@vtable.7 = private unnamed_addr constant <{ ptr, [16 x i8], ptr }> <{ ptr @"_ZN4core3ptr91drop_in_place$LT$alloc..boxed..Box$LT$dyn$u20$core..any..Any$u2b$core..marker..Send$GT$$GT$17hc9ec03a45b18c819E", [16 x i8] c"\10\00\00\00\00\00\00\00\08\00\00\00\00\00\00\00", ptr @"_ZN67_$LT$alloc..boxed..Box$LT$T$C$A$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17hb5083c8805e6966dE" }>, align 8
@vtable.8 = private unnamed_addr constant <{ ptr, [16 x i8], ptr }> <{ ptr @"_ZN4core3ptr45drop_in_place$LT$redis..types..RedisError$GT$17he9e92a6d6be589cdE", [16 x i8] c"8\00\00\00\00\00\00\00\08\00\00\00\00\00\00\00", ptr @"_ZN61_$LT$redis..types..RedisError$u20$as$u20$core..fmt..Debug$GT$3fmt17hb973bd1f4a1d7f24E" }>, align 8
@alloc349 = private unnamed_addr constant <{ [3 x i8] }> <{ [3 x i8] c"GET" }>, align 1
@alloc351 = private unnamed_addr constant <{ [3 x i8] }> <{ [3 x i8] c"SET" }>, align 1
@alloc54 = private unnamed_addr constant <{ [21 x i8] }> <{ [21 x i8] c"fatal runtime error: " }>, align 1
@alloc115 = private unnamed_addr constant <{ [1 x i8] }> <{ [1 x i8] c"\0A" }>, align 1
@alloc55 = private unnamed_addr constant <{ ptr, [8 x i8], ptr, [8 x i8] }> <{ ptr @alloc54, [8 x i8] c"\15\00\00\00\00\00\00\00", ptr @alloc115, [8 x i8] c"\01\00\00\00\00\00\00\00" }>, align 8
@alloc58 = private unnamed_addr constant <{ [30 x i8] }> <{ [30 x i8] c"thread result panicked on drop" }>, align 1
@alloc59 = private unnamed_addr constant <{ ptr, [8 x i8] }> <{ ptr @alloc58, [8 x i8] c"\1E\00\00\00\00\00\00\00" }>, align 8
@alloc139 = private unnamed_addr constant <{ [56 x i8] }> <{ [56 x i8] c"XXX is your first event today. (simulated response for '" }>, align 1
@alloc141 = private unnamed_addr constant <{ [2 x i8] }> <{ [2 x i8] c"')" }>, align 1
@alloc140 = private unnamed_addr constant <{ ptr, [8 x i8], ptr, [8 x i8] }> <{ ptr @alloc139, [8 x i8] c"8\00\00\00\00\00\00\00", ptr @alloc141, [8 x i8] c"\02\00\00\00\00\00\00\00" }>, align 8
@alloc377 = private unnamed_addr constant <{ [11 x i8] }> <{ [11 x i8] c"src/main.rs" }>, align 1
@alloc362 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc377, [16 x i8] c"\0B\00\00\00\00\00\00\00\0F\00\00\00/\00\00\00" }>, align 8
@alloc109 = private unnamed_addr constant <{ [6 x i8] }> <{ [6 x i8] c"query:" }>, align 1
@alloc110 = private unnamed_addr constant <{ ptr, [8 x i8] }> <{ ptr @alloc109, [8 x i8] c"\06\00\00\00\00\00\00\00" }>, align 8
@alloc119 = private unnamed_addr constant <{ [17 x i8] }> <{ [17 x i8] c" got new answer: " }>, align 1
@alloc118 = private unnamed_addr constant <{ ptr, [8 x i8], ptr, [8 x i8], ptr, [8 x i8] }> <{ ptr @alloc112, [8 x i8] zeroinitializer, ptr @alloc119, [8 x i8] c"\11\00\00\00\00\00\00\00", ptr @alloc115, [8 x i8] c"\01\00\00\00\00\00\00\00" }>, align 8
@alloc364 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc377, [16 x i8] c"\0B\00\00\00\00\00\00\00\1B\00\00\00/\00\00\00" }>, align 8
@alloc114 = private unnamed_addr constant <{ [20 x i8] }> <{ [20 x i8] c" got cached answer: " }>, align 1
@alloc113 = private unnamed_addr constant <{ ptr, [8 x i8], ptr, [8 x i8], ptr, [8 x i8] }> <{ ptr @alloc112, [8 x i8] zeroinitializer, ptr @alloc114, [8 x i8] c"\14\00\00\00\00\00\00\00", ptr @alloc115, [8 x i8] c"\01\00\00\00\00\00\00\00" }>, align 8
@alloc365 = private unnamed_addr constant <{ [23 x i8] }> <{ [23 x i8] c"redis://127.0.0.1:6379/" }>, align 1
@alloc367 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc377, [16 x i8] c"\0B\00\00\00\00\00\00\00!\00\00\00D\00\00\00" }>, align 8
@alloc368 = private unnamed_addr constant <{ [23 x i8] }> <{ [23 x i8] c"redis://127.0.0.1:6380/" }>, align 1
@alloc370 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc377, [16 x i8] c"\0B\00\00\00\00\00\00\00\22\00\00\00D\00\00\00" }>, align 8
@alloc373 = private unnamed_addr constant <{ [29 x i8] }> <{ [29 x i8] c"What is my first event today?" }>, align 1
@alloc372 = private unnamed_addr constant <{ [5 x i8] }> <{ [5 x i8] c"UserA" }>, align 1
@alloc374 = private unnamed_addr constant <{ [5 x i8] }> <{ [5 x i8] c"UserB" }>, align 1
@alloc376 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc377, [16 x i8] c"\0B\00\00\00\00\00\00\00)\00\00\00\14\00\00\00" }>, align 8
@alloc378 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc377, [16 x i8] c"\0B\00\00\00\00\00\00\00+\00\00\00\14\00\00\00" }>, align 8

; std::sys_common::backtrace::__rust_begin_short_backtrace
; Function Attrs: noinline nonlazybind uwtable
define internal fastcc void @_ZN3std10sys_common9backtrace28__rust_begin_short_backtrace17h2a014bada774ce73E(ptr noalias nocapture noundef readonly dereferenceable(56) %f) unnamed_addr #0 personality ptr @rust_eh_personality {
start:
  %e.i90.i = alloca %"redis::types::RedisError", align 8
  %val.i.i46.i = alloca %"redis::types::Value", align 8
  %_3.i.i47.i = alloca %"core::result::Result<redis::types::Value, redis::types::RedisError>", align 8
  %_14.i.i.i = alloca %"redis::cmd::Cmd", align 8
  %_13.i.i48.i = alloca %"alloc::string::String", align 8
  %_9.i.i.i = alloca %"redis::cmd::Cmd", align 8
  %_7.i49.i = alloca %"alloc::string::String", align 8
  %_5.i.i = alloca %"redis::cmd::Cmd", align 8
  %_2.i.i.i.i = alloca %"core::fmt::Arguments<'_>", align 8
  %_9.i.i = alloca [1 x { ptr, ptr }], align 8
  %question.i.i = alloca { ptr, i64 }, align 8
  %e.i33.i = alloca %"redis::types::RedisError", align 8
  %_9.i.i.i.i.i = alloca %"core::result::Result<alloc::string::String, redis::types::RedisError>", align 8
  %val.i.i.i = alloca %"redis::types::Value", align 8
  %_3.i.i.i = alloca %"core::result::Result<redis::types::Value, redis::types::RedisError>", align 8
  %_13.i.i.i = alloca %"redis::cmd::Cmd", align 8
  %_6.i.i.i = alloca %"redis::cmd::Cmd", align 8
  %_4.i.i = alloca %"redis::cmd::Cmd", align 8
  %_2.i.i.i = alloca %"core::fmt::Arguments<'_>", align 8
  %e.i.i = alloca %"redis::types::RedisError", align 8
  %_66.sroa.0.i = alloca %"alloc::vec::Vec<u8>", align 8
  %_63.i = alloca %"core::result::Result<(), redis::types::RedisError>", align 8
  %_55.i = alloca [2 x { ptr, ptr }], align 8
  %_48.i = alloca %"core::fmt::Arguments<'_>", align 8
  %answer1.i = alloca %"alloc::string::String", align 8
  %_35.i = alloca [2 x { ptr, ptr }], align 8
  %_28.i = alloca %"core::fmt::Arguments<'_>", align 8
  %answer.i = alloca %"alloc::string::String", align 8
  %_21.sroa.8.sroa.0.i = alloca [7 x i8], align 1
  %_21.sroa.12.sroa.7.i = alloca [24 x i8], align 8
  %_16.i = alloca [1 x { ptr, ptr }], align 8
  %res.i = alloca %"alloc::string::String", align 8
  %key.i = alloca %"alloc::string::String", align 8
  %_3.i = alloca %"core::result::Result<redis::connection::Connection, redis::types::RedisError>", align 8
  %con.i = alloca %"redis::connection::Connection", align 8
  %_2 = alloca %"[closure@src/main.rs:14:19: 14:26]", align 8
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %_2)
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %_2, ptr noundef nonnull align 8 dereferenceable(56) %f, i64 56, i1 false)
  tail call void @llvm.experimental.noalias.scope.decl(metadata !3)
  call void @llvm.lifetime.start.p0(i64 88, ptr nonnull %con.i), !noalias !3
  call void @llvm.lifetime.start.p0(i64 88, ptr nonnull %_3.i), !noalias !3
  %self.i = load ptr, ptr %_2, align 8, !alias.scope !3, !nonnull !6, !noundef !6
  %_5.i = getelementptr inbounds %"alloc::sync::ArcInner<redis::client::Client>", ptr %self.i, i64 0, i32 2
; invoke redis::client::Client::get_connection
  invoke void @_ZN5redis6client6Client14get_connection17h0ec62c907cf206e1E(ptr noalias nocapture noundef nonnull sret(%"core::result::Result<redis::connection::Connection, redis::types::RedisError>") dereferenceable(88) %_3.i, ptr noalias noundef nonnull readonly align 8 dereferenceable(88) %_5.i)
          to label %bb1.i unwind label %cleanup.i, !noalias !3

bb22.i:                                           ; preds = %cleanup.i114.i, %bb21.i, %cleanup.i.i, %cleanup.i
  %.pn11.i = phi { ptr, i32 } [ %.pn10.i, %bb21.i ], [ %0, %cleanup.i ], [ %4, %cleanup.i.i ], [ %82, %cleanup.i114.i ]
; invoke core::ptr::drop_in_place<demo::spawn_user_query::{{closure}}>
  invoke fastcc void @"_ZN4core3ptr72drop_in_place$LT$demo..spawn_user_query..$u7b$$u7b$closure$u7d$$u7d$$GT$17h3fc0c80003884286E"(ptr noundef nonnull %_2) #21
          to label %bb23.i unwind label %abort.i

cleanup.i:                                        ; preds = %bb4.i115.i, %start
  %0 = landingpad { ptr, i32 }
          cleanup
  br label %bb22.i

bb1.i:                                            ; preds = %start
  tail call void @llvm.experimental.noalias.scope.decl(metadata !7)
  tail call void @llvm.experimental.noalias.scope.decl(metadata !10)
  %1 = getelementptr inbounds %"core::result::Result<redis::connection::Connection, redis::types::RedisError>", ptr %_3.i, i64 0, i32 1
  %2 = load i32, ptr %1, align 8, !range !12, !alias.scope !10, !noalias !13, !noundef !6
  %3 = icmp eq i32 %2, 2
  br i1 %3, label %bb1.i.i, label %bb1.i24.i

bb1.i.i:                                          ; preds = %bb1.i
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %e.i.i), !noalias !14
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %e.i.i, ptr noundef nonnull align 8 dereferenceable(56) %_3.i, i64 56, i1 false), !noalias !13
; invoke core::result::unwrap_failed
  invoke void @_ZN4core6result13unwrap_failed17hdc73d4affce1d414E(ptr noalias noundef nonnull readonly align 1 @alloc344, i64 noundef 43, ptr noundef nonnull align 1 %e.i.i, ptr noalias noundef nonnull readonly align 8 dereferenceable(24) @vtable.8, ptr noalias noundef nonnull readonly align 8 dereferenceable(24) @alloc362) #22
          to label %unreachable.i.i unwind label %cleanup.i.i, !noalias !15

cleanup.i.i:                                      ; preds = %bb1.i.i
  %4 = landingpad { ptr, i32 }
          cleanup
; invoke core::ptr::drop_in_place<redis::types::RedisError>
  invoke void @"_ZN4core3ptr45drop_in_place$LT$redis..types..RedisError$GT$17he9e92a6d6be589cdE"(ptr noundef nonnull %e.i.i) #21
          to label %bb22.i unwind label %abort.i.i, !noalias !15

unreachable.i.i:                                  ; preds = %bb1.i.i
  unreachable

abort.i.i:                                        ; preds = %cleanup.i.i
  %5 = landingpad { ptr, i32 }
          cleanup
; call core::panicking::panic_cannot_unwind
  call void @_ZN4core9panicking19panic_cannot_unwind17h42344709dec62f2eE() #23, !noalias !15
  unreachable

bb21.i:                                           ; preds = %bb20.i, %cleanup2.i
  %.pn10.i = phi { ptr, i32 } [ %6, %cleanup2.i ], [ %.pn9.i, %bb20.i ]
; invoke core::ptr::drop_in_place<redis::connection::Connection>
  invoke fastcc void @"_ZN4core3ptr50drop_in_place$LT$redis..connection..Connection$GT$17h98975dd43c2c8c48E"(ptr noundef nonnull %con.i) #21
          to label %bb22.i unwind label %abort.i

cleanup2.i:                                       ; preds = %bb1.i24.i
  %6 = landingpad { ptr, i32 }
          cleanup
  br label %bb21.i

bb1.i24.i:                                        ; preds = %bb1.i
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(88) %con.i, ptr noundef nonnull align 8 dereferenceable(88) %_3.i, i64 88, i1 false), !alias.scope !15, !noalias !3
  call void @llvm.lifetime.end.p0(i64 88, ptr nonnull %_3.i), !noalias !3
  call void @llvm.lifetime.start.p0(i64 24, ptr nonnull %key.i), !noalias !3
  call void @llvm.lifetime.start.p0(i64 24, ptr nonnull %res.i), !noalias !3
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %_16.i), !noalias !3
  %_19.i = getelementptr inbounds %"[closure@src/main.rs:14:19: 14:26]", ptr %_2, i64 0, i32 1
  store ptr %_19.i, ptr %_16.i, align 8, !noalias !3
  %7 = getelementptr inbounds { ptr, ptr }, ptr %_16.i, i64 0, i32 1
  store ptr @"_ZN60_$LT$alloc..string..String$u20$as$u20$core..fmt..Display$GT$3fmt17h5fbcba97ac02a262E", ptr %7, align 8, !noalias !3
  call void @llvm.lifetime.start.p0(i64 48, ptr nonnull %_2.i.i.i), !noalias !16
  store ptr null, ptr %_2.i.i.i, align 8, !noalias !24
  %args.sroa.4129.0._2.i.i.sroa_idx.i = getelementptr inbounds i8, ptr %_2.i.i.i, i64 16
  store ptr @alloc110, ptr %args.sroa.4129.0._2.i.i.sroa_idx.i, align 8, !noalias !24
  %args.sroa.6.0._2.i.i.sroa_idx.i = getelementptr inbounds i8, ptr %_2.i.i.i, i64 24
  store i64 1, ptr %args.sroa.6.0._2.i.i.sroa_idx.i, align 8, !noalias !24
  %args.sroa.8.0._2.i.i.sroa_idx.i = getelementptr inbounds i8, ptr %_2.i.i.i, i64 32
  store ptr %_16.i, ptr %args.sroa.8.0._2.i.i.sroa_idx.i, align 8, !noalias !24
  %args.sroa.9.0._2.i.i.sroa_idx.i = getelementptr inbounds i8, ptr %_2.i.i.i, i64 40
  store i64 1, ptr %args.sroa.9.0._2.i.i.sroa_idx.i, align 8, !noalias !24
; invoke alloc::fmt::format::format_inner
  invoke void @_ZN5alloc3fmt6format12format_inner17h499afee7b38b5a15E(ptr noalias nocapture noundef nonnull sret(%"alloc::string::String") dereferenceable(24) %res.i, ptr noalias nocapture noundef nonnull readonly dereferenceable(48) %_2.i.i.i)
          to label %bb36.i unwind label %cleanup2.i

bb36.i:                                           ; preds = %bb1.i24.i
  call void @llvm.lifetime.end.p0(i64 48, ptr nonnull %_2.i.i.i), !noalias !16
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %_16.i), !noalias !3
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %key.i, ptr noundef nonnull align 8 dereferenceable(24) %res.i, i64 24, i1 false), !noalias !3
  call void @llvm.lifetime.end.p0(i64 24, ptr nonnull %res.i), !noalias !3
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %_21.sroa.8.sroa.0.i)
  call void @llvm.lifetime.start.p0(i64 24, ptr nonnull %_21.sroa.12.sroa.7.i)
  %8 = getelementptr inbounds i8, ptr %key.i, i64 8
  %key.val.i = load ptr, ptr %8, align 8, !noalias !3
  %9 = getelementptr inbounds i8, ptr %key.i, i64 16
  %key.val20.i = load i64, ptr %9, align 8, !noalias !3
  call void @llvm.lifetime.start.p0(i64 64, ptr nonnull %_4.i.i), !noalias !25
  call void @llvm.lifetime.start.p0(i64 64, ptr nonnull %_6.i.i.i), !noalias !29
; invoke redis::cmd::cmd
  invoke void @_ZN5redis3cmd3cmd17h0f3121e002b2e6b0E(ptr noalias nocapture noundef nonnull sret(%"redis::cmd::Cmd") dereferenceable(64) %_6.i.i.i, ptr noalias noundef nonnull readonly align 1 @alloc349, i64 noundef 3)
          to label %.noexc31.i unwind label %cleanup3.i

.noexc31.i:                                       ; preds = %bb36.i
  %10 = icmp ne ptr %key.val.i, null
  call void @llvm.assume(i1 %10)
; invoke <redis::cmd::Cmd as redis::types::RedisWrite>::write_arg
  invoke void @"_ZN60_$LT$redis..cmd..Cmd$u20$as$u20$redis..types..RedisWrite$GT$9write_arg17h8270d42f2a1b25b1E"(ptr noalias noundef nonnull align 8 dereferenceable(64) %_6.i.i.i, ptr noalias noundef nonnull readonly align 1 %key.val.i, i64 noundef %key.val20.i)
          to label %bb6.i.i.i unwind label %cleanup1.i.i.i, !noalias !33

cleanup1.i.i.i:                                   ; preds = %bb6.i.i.i, %.noexc31.i
  %11 = landingpad { ptr, i32 }
          cleanup
; invoke core::ptr::drop_in_place<redis::cmd::Cmd>
  invoke fastcc void @"_ZN4core3ptr36drop_in_place$LT$redis..cmd..Cmd$GT$17h1f157ef24f377633E"(ptr noundef nonnull %_6.i.i.i) #21
          to label %bb20.i unwind label %abort.i.i.i, !noalias !33

bb6.i.i.i:                                        ; preds = %.noexc31.i
  call void @llvm.lifetime.start.p0(i64 64, ptr nonnull %_13.i.i.i), !noalias !29
; invoke redis::cmd::Cmd::new
  invoke void @_ZN5redis3cmd3Cmd3new17h02c81ac25f6253f5E(ptr noalias nocapture noundef nonnull sret(%"redis::cmd::Cmd") dereferenceable(64) %_13.i.i.i)
          to label %bb8.i.i.i unwind label %cleanup1.i.i.i, !noalias !33

bb8.i.i.i:                                        ; preds = %bb6.i.i.i
  call void @llvm.experimental.noalias.scope.decl(metadata !34)
  call void @llvm.experimental.noalias.scope.decl(metadata !37)
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %_4.i.i, ptr noundef nonnull align 8 dereferenceable(64) %_6.i.i.i, i64 64, i1 false), !alias.scope !39, !noalias !41
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %_6.i.i.i, ptr noundef nonnull align 8 dereferenceable(64) %_13.i.i.i, i64 64, i1 false), !alias.scope !42, !noalias !43
  call void @llvm.lifetime.end.p0(i64 64, ptr nonnull %_13.i.i.i), !noalias !29
  %12 = getelementptr inbounds %"redis::cmd::Cmd", ptr %_6.i.i.i, i64 0, i32 1
  %_1.val.i.i.i.i.i = load i64, ptr %12, align 8, !noalias !29, !noundef !6
  %_3.i.i.i.i.i.i.i.i = icmp eq i64 %_1.val.i.i.i.i.i, 0
  br i1 %_3.i.i.i.i.i.i.i.i, label %bb4.i.i.i.i, label %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i.i.i"

"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i.i.i": ; preds = %bb8.i.i.i
  %13 = getelementptr inbounds %"redis::cmd::Cmd", ptr %_6.i.i.i, i64 0, i32 1, i32 0, i32 1
  %_1.val1.i.i.i.i.i = load ptr, ptr %13, align 8, !noalias !29, !nonnull !6
  %_6.i.i.i.i.i.i.i.i.i = icmp sgt i64 %_1.val.i.i.i.i.i, -1
  %.sroa.2.0.i.i.i.i.i.i.i.i.i = zext i1 %_6.i.i.i.i.i.i.i.i.i to i64
  call void @llvm.assume(i1 %_6.i.i.i.i.i.i.i.i.i)
  call void @__rust_dealloc(ptr noundef nonnull %_1.val1.i.i.i.i.i, i64 noundef %_1.val.i.i.i.i.i, i64 noundef %.sroa.2.0.i.i.i.i.i.i.i.i.i) #24, !noalias !33
  br label %bb4.i.i.i.i

bb4.i.i.i.i:                                      ; preds = %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i.i.i", %bb8.i.i.i
  %14 = getelementptr inbounds %"redis::cmd::Cmd", ptr %_6.i.i.i, i64 0, i32 2
  %_1.val.i1.i.i.i.i = load i64, ptr %14, align 8, !noalias !29, !noundef !6
  %_3.i.i.i.i2.i.i.i.i = icmp eq i64 %_1.val.i1.i.i.i.i, 0
  br i1 %_3.i.i.i.i2.i.i.i.i, label %"_ZN5redis8commands33_$LT$impl$u20$redis..cmd..Cmd$GT$3get17h459b9983035c4a35E.exit.i.i", label %bb2.i.i.i.i.i.i.i

bb2.i.i.i.i.i.i.i:                                ; preds = %bb4.i.i.i.i
  %15 = getelementptr inbounds %"redis::cmd::Cmd", ptr %_6.i.i.i, i64 0, i32 2, i32 0, i32 1
  %_1.val1.i3.i.i.i.i = load ptr, ptr %15, align 8, !noalias !29, !nonnull !6
  %_6.i.i.i.i.i4.i.i.i.i = icmp ult i64 %_1.val.i1.i.i.i.i, 576460752303423488
  %array_size.i.i.i.i.i.i.i.i.i = shl nuw nsw i64 %_1.val.i1.i.i.i.i, 4
  call void @llvm.assume(i1 %_6.i.i.i.i.i4.i.i.i.i)
  call void @__rust_dealloc(ptr noundef nonnull %_1.val1.i3.i.i.i.i, i64 noundef %array_size.i.i.i.i.i.i.i.i.i, i64 noundef 8) #24, !noalias !33
  br label %"_ZN5redis8commands33_$LT$impl$u20$redis..cmd..Cmd$GT$3get17h459b9983035c4a35E.exit.i.i"

abort.i.i.i:                                      ; preds = %cleanup1.i.i.i
  %16 = landingpad { ptr, i32 }
          cleanup
; call core::panicking::panic_cannot_unwind
  call void @_ZN4core9panicking19panic_cannot_unwind17h42344709dec62f2eE() #23, !noalias !33
  unreachable

"_ZN5redis8commands33_$LT$impl$u20$redis..cmd..Cmd$GT$3get17h459b9983035c4a35E.exit.i.i": ; preds = %bb2.i.i.i.i.i.i.i, %bb4.i.i.i.i
  call void @llvm.lifetime.end.p0(i64 64, ptr nonnull %_6.i.i.i), !noalias !29
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %_3.i.i.i), !noalias !44
; invoke redis::connection::ConnectionLike::req_command
  invoke fastcc void @_ZN5redis10connection14ConnectionLike11req_command17hb44cc350392f82eeE(ptr noalias nocapture noundef nonnull sret(%"core::result::Result<redis::types::Value, redis::types::RedisError>") dereferenceable(56) %_3.i.i.i, ptr noundef nonnull align 1 %con.i, ptr noalias noundef nonnull readonly align 8 dereferenceable(64) %_4.i.i)
          to label %.noexc.i.i unwind label %cleanup.i27.i, !noalias !48

.noexc.i.i:                                       ; preds = %"_ZN5redis8commands33_$LT$impl$u20$redis..cmd..Cmd$GT$3get17h459b9983035c4a35E.exit.i.i"
  %17 = load i8, ptr %_3.i.i.i, align 8, !range !49, !noalias !44, !noundef !6
  %18 = icmp eq i8 %17, 4
  br i1 %18, label %bb4.i.i.i, label %bb2.i.i.i

bb4.i.i.i:                                        ; preds = %.noexc.i.i
  call void @llvm.lifetime.start.p0(i64 32, ptr nonnull %val.i.i.i), !noalias !44
  %19 = getelementptr inbounds %"core::result::Result<redis::types::Value, redis::types::RedisError>::Ok", ptr %_3.i.i.i, i64 0, i32 1
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %val.i.i.i, ptr noundef nonnull align 8 dereferenceable(32) %19, i64 32, i1 false), !noalias !44
  call void @llvm.experimental.noalias.scope.decl(metadata !50)
  call void @llvm.experimental.noalias.scope.decl(metadata !53)
  %v.val.i.i.i.i.i = load i64, ptr %val.i.i.i, align 8, !range !56, !alias.scope !57, !noalias !58, !noundef !6
  %_7.i.i.i.i.i.i = icmp eq i64 %v.val.i.i.i.i.i, 0
  br i1 %_7.i.i.i.i.i.i, label %bb5.i.i.i, label %bb3.i.i.i.i.i

bb3.i.i.i.i.i:                                    ; preds = %bb4.i.i.i
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %_9.i.i.i.i.i), !noalias !61
; invoke <alloc::string::String as redis::types::FromRedisValue>::from_redis_value
  invoke void @"_ZN70_$LT$alloc..string..String$u20$as$u20$redis..types..FromRedisValue$GT$16from_redis_value17h764fc4ec7c118126E"(ptr noalias nocapture noundef nonnull sret(%"core::result::Result<alloc::string::String, redis::types::RedisError>") dereferenceable(56) %_9.i.i.i.i.i, ptr noalias noundef nonnull readonly align 8 dereferenceable(32) %val.i.i.i)
          to label %.noexc.i.i.i unwind label %cleanup.i.i.i, !noalias !62

.noexc.i.i.i:                                     ; preds = %bb3.i.i.i.i.i
  call void @llvm.experimental.noalias.scope.decl(metadata !63)
  %20 = load i8, ptr %_9.i.i.i.i.i, align 8, !range !49, !alias.scope !66, !noalias !68, !noundef !6
  %21 = icmp eq i8 %20, 4
  br i1 %21, label %bb6.i.i.i.i.i, label %bb8.i.i.i.i.i

bb6.i.i.i.i.i:                                    ; preds = %.noexc.i.i.i
  %22 = getelementptr inbounds %"core::result::Result<alloc::string::String, redis::types::RedisError>::Ok", ptr %_9.i.i.i.i.i, i64 0, i32 1
  %23 = load i64, ptr %22, align 8, !noalias !3
  %_8.sroa.7.i.i.i.i.sroa.7.7..sroa_idx.i = getelementptr inbounds %"core::result::Result<alloc::string::String, redis::types::RedisError>::Ok", ptr %_9.i.i.i.i.i, i64 0, i32 1, i32 0, i32 0, i32 1
  %_8.sroa.7.i.i.i.i.sroa.7.7.copyload.i = load ptr, ptr %_8.sroa.7.i.i.i.i.sroa.7.7..sroa_idx.i, align 8, !alias.scope !69, !noalias !61
  %_8.sroa.7.i.i.i.i.sroa.9.7..sroa_idx.i = getelementptr inbounds %"core::result::Result<alloc::string::String, redis::types::RedisError>::Ok", ptr %_9.i.i.i.i.i, i64 0, i32 1, i32 0, i32 1
  %_8.sroa.7.i.i.i.i.sroa.9.7.copyload.i = load i64, ptr %_8.sroa.7.i.i.i.i.sroa.9.7..sroa_idx.i, align 8, !alias.scope !69, !noalias !61
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %_9.i.i.i.i.i), !noalias !61
  br label %bb5.i.i.i

bb8.i.i.i.i.i:                                    ; preds = %.noexc.i.i.i
  %_8.sroa.7.0._9.sroa_idx.i.i.i.i.i = getelementptr inbounds i8, ptr %_9.i.i.i.i.i, i64 1
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %_21.sroa.8.sroa.0.i, ptr noundef nonnull align 1 dereferenceable(7) %_8.sroa.7.0._9.sroa_idx.i.i.i.i.i, i64 7, i1 false), !noalias !70
  %_8.sroa.7.i.i.i.i.sroa.0.sroa.5.0._8.sroa.7.0._9.sroa_idx.i.i.i.i.sroa_idx.i = getelementptr inbounds i8, ptr %_9.i.i.i.i.i, i64 8
  %_8.sroa.7.i.i.i.i.sroa.0.sroa.5.0.copyload.i = load i64, ptr %_8.sroa.7.i.i.i.i.sroa.0.sroa.5.0._8.sroa.7.0._9.sroa_idx.i.i.i.i.sroa_idx.i, align 8, !alias.scope !69, !noalias !61
  %_8.sroa.7.i.i.i.i.sroa.7.0._8.sroa.7.0._9.sroa_idx.i.i.i.i.sroa_idx.i = getelementptr inbounds i8, ptr %_9.i.i.i.i.i, i64 16
  %_8.sroa.7.i.i.i.i.sroa.7.0.copyload.i = load ptr, ptr %_8.sroa.7.i.i.i.i.sroa.7.0._8.sroa.7.0._9.sroa_idx.i.i.i.i.sroa_idx.i, align 8, !alias.scope !69, !noalias !61
  %_8.sroa.7.i.i.i.i.sroa.9.0._8.sroa.7.0._9.sroa_idx.i.i.i.i.sroa_idx.i = getelementptr inbounds i8, ptr %_9.i.i.i.i.i, i64 24
  %_8.sroa.7.i.i.i.i.sroa.9.0.copyload.i = load i64, ptr %_8.sroa.7.i.i.i.i.sroa.9.0._8.sroa.7.0._9.sroa_idx.i.i.i.i.sroa_idx.i, align 8, !alias.scope !69, !noalias !61
  %_8.sroa.9.0._9.sroa_idx.i.i.i.i.i = getelementptr inbounds i8, ptr %_9.i.i.i.i.i, i64 32
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %_21.sroa.12.sroa.7.i, ptr noundef nonnull align 8 dereferenceable(24) %_8.sroa.9.0._9.sroa_idx.i.i.i.i.i, i64 24, i1 false), !noalias !70
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %_9.i.i.i.i.i), !noalias !61
  br label %bb5.i.i.i

bb2.i.i.i:                                        ; preds = %.noexc.i.i
  %_21.sroa.8.0._3.i.i.sroa_idx.i = getelementptr inbounds i8, ptr %_3.i.i.i, i64 1
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %_21.sroa.8.sroa.0.i, ptr noundef nonnull align 1 dereferenceable(7) %_21.sroa.8.0._3.i.i.sroa_idx.i, i64 7, i1 false), !noalias !71
  %_21.sroa.8.sroa.5.0._21.sroa.8.0._3.i.i.sroa_idx.sroa_idx.i = getelementptr inbounds i8, ptr %_3.i.i.i, i64 8
  %_21.sroa.8.sroa.5.0.copyload.i = load i64, ptr %_21.sroa.8.sroa.5.0._21.sroa.8.0._3.i.i.sroa_idx.sroa_idx.i, align 8, !noalias !71
  %_21.sroa.11.0._3.i.i.sroa_idx.i = getelementptr inbounds i8, ptr %_3.i.i.i, i64 16
  %_21.sroa.11.0.copyload.i = load ptr, ptr %_21.sroa.11.0._3.i.i.sroa_idx.i, align 8, !noalias !71
  %_21.sroa.12.0._3.i.i.sroa_idx.i = getelementptr inbounds i8, ptr %_3.i.i.i, i64 24
  %_21.sroa.12.sroa.0.0.copyload.i = load i64, ptr %_21.sroa.12.0._3.i.i.sroa_idx.i, align 8, !noalias !71
  %_21.sroa.12.sroa.7.0._21.sroa.12.0._3.i.i.sroa_idx.sroa_idx.i = getelementptr inbounds i8, ptr %_3.i.i.i, i64 32
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %_21.sroa.12.sroa.7.i, ptr noundef nonnull align 8 dereferenceable(24) %_21.sroa.12.sroa.7.0._21.sroa.12.0._3.i.i.sroa_idx.sroa_idx.i, i64 24, i1 false), !noalias !71
  br label %bb2.i.i

cleanup.i.i.i:                                    ; preds = %bb3.i.i.i.i.i
  %24 = landingpad { ptr, i32 }
          cleanup
; invoke core::ptr::drop_in_place<redis::types::Value>
  invoke fastcc void @"_ZN4core3ptr40drop_in_place$LT$redis..types..Value$GT$17hbec51beeae85c599E"(ptr noundef nonnull %val.i.i.i) #21
          to label %cleanup.body.i.i unwind label %abort.i2.i.i, !noalias !62

bb5.i.i.i:                                        ; preds = %bb8.i.i.i.i.i, %bb6.i.i.i.i.i, %bb4.i.i.i
  %_21.sroa.8.sroa.5.0.i = phi i64 [ undef, %bb4.i.i.i ], [ %23, %bb6.i.i.i.i.i ], [ %_8.sroa.7.i.i.i.i.sroa.0.sroa.5.0.copyload.i, %bb8.i.i.i.i.i ]
  %_21.sroa.0.0.i = phi i8 [ 4, %bb4.i.i.i ], [ 4, %bb6.i.i.i.i.i ], [ %20, %bb8.i.i.i.i.i ]
  %_21.sroa.11.0.i = phi ptr [ null, %bb4.i.i.i ], [ %_8.sroa.7.i.i.i.i.sroa.7.7.copyload.i, %bb6.i.i.i.i.i ], [ %_8.sroa.7.i.i.i.i.sroa.7.0.copyload.i, %bb8.i.i.i.i.i ]
  %_21.sroa.12.sroa.0.0.i = phi i64 [ undef, %bb4.i.i.i ], [ %_8.sroa.7.i.i.i.i.sroa.9.7.copyload.i, %bb6.i.i.i.i.i ], [ %_8.sroa.7.i.i.i.i.sroa.9.0.copyload.i, %bb8.i.i.i.i.i ]
; invoke core::ptr::drop_in_place<redis::types::Value>
  invoke fastcc void @"_ZN4core3ptr40drop_in_place$LT$redis..types..Value$GT$17hbec51beeae85c599E"(ptr noundef nonnull %val.i.i.i)
          to label %.noexc3.i.i unwind label %cleanup.i27.i, !noalias !48

.noexc3.i.i:                                      ; preds = %bb5.i.i.i
  call void @llvm.lifetime.end.p0(i64 32, ptr nonnull %val.i.i.i), !noalias !44
  br label %bb2.i.i

abort.i2.i.i:                                     ; preds = %cleanup.i.i.i
  %25 = landingpad { ptr, i32 }
          cleanup
; call core::panicking::panic_cannot_unwind
  call void @_ZN4core9panicking19panic_cannot_unwind17h42344709dec62f2eE() #23, !noalias !62
  unreachable

cleanup.i27.i:                                    ; preds = %bb5.i.i.i, %"_ZN5redis8commands33_$LT$impl$u20$redis..cmd..Cmd$GT$3get17h459b9983035c4a35E.exit.i.i"
  %26 = landingpad { ptr, i32 }
          cleanup
  br label %cleanup.body.i.i

cleanup.body.i.i:                                 ; preds = %cleanup.i27.i, %cleanup.i.i.i
  %eh.lpad-body.i.i = phi { ptr, i32 } [ %26, %cleanup.i27.i ], [ %24, %cleanup.i.i.i ]
; invoke core::ptr::drop_in_place<redis::cmd::Cmd>
  invoke fastcc void @"_ZN4core3ptr36drop_in_place$LT$redis..cmd..Cmd$GT$17h1f157ef24f377633E"(ptr noundef nonnull %_4.i.i) #21
          to label %bb20.i unwind label %abort.i30.i, !noalias !48

bb2.i.i:                                          ; preds = %.noexc3.i.i, %bb2.i.i.i
  %_21.sroa.8.sroa.5.1.i = phi i64 [ %_21.sroa.8.sroa.5.0.i, %.noexc3.i.i ], [ %_21.sroa.8.sroa.5.0.copyload.i, %bb2.i.i.i ]
  %_21.sroa.0.1.i = phi i8 [ %_21.sroa.0.0.i, %.noexc3.i.i ], [ %17, %bb2.i.i.i ]
  %_21.sroa.11.1.i = phi ptr [ %_21.sroa.11.0.i, %.noexc3.i.i ], [ %_21.sroa.11.0.copyload.i, %bb2.i.i.i ]
  %_21.sroa.12.sroa.0.1.i = phi i64 [ %_21.sroa.12.sroa.0.0.i, %.noexc3.i.i ], [ %_21.sroa.12.sroa.0.0.copyload.i, %bb2.i.i.i ]
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %_3.i.i.i), !noalias !44
  %27 = getelementptr inbounds %"redis::cmd::Cmd", ptr %_4.i.i, i64 0, i32 1
  %_1.val.i.i.i.i = load i64, ptr %27, align 8, !noalias !25, !noundef !6
  %_3.i.i.i.i.i.i.i = icmp eq i64 %_1.val.i.i.i.i, 0
  br i1 %_3.i.i.i.i.i.i.i, label %bb4.i4.i.i, label %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i.i"

"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i.i": ; preds = %bb2.i.i
  %28 = getelementptr inbounds %"redis::cmd::Cmd", ptr %_4.i.i, i64 0, i32 1, i32 0, i32 1
  %_1.val1.i.i.i.i = load ptr, ptr %28, align 8, !noalias !25, !nonnull !6
  %_6.i.i.i.i.i.i.i28.i = icmp sgt i64 %_1.val.i.i.i.i, -1
  %.sroa.2.0.i.i.i.i.i.i.i29.i = zext i1 %_6.i.i.i.i.i.i.i28.i to i64
  call void @llvm.assume(i1 %_6.i.i.i.i.i.i.i28.i)
  call void @__rust_dealloc(ptr noundef nonnull %_1.val1.i.i.i.i, i64 noundef %_1.val.i.i.i.i, i64 noundef %.sroa.2.0.i.i.i.i.i.i.i29.i) #24, !noalias !48
  br label %bb4.i4.i.i

bb4.i4.i.i:                                       ; preds = %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i.i", %bb2.i.i
  %29 = getelementptr inbounds %"redis::cmd::Cmd", ptr %_4.i.i, i64 0, i32 2
  %_1.val.i1.i.i.i = load i64, ptr %29, align 8, !noalias !25, !noundef !6
  %_3.i.i.i.i2.i.i.i = icmp eq i64 %_1.val.i1.i.i.i, 0
  br i1 %_3.i.i.i.i2.i.i.i, label %bb4.i, label %bb2.i.i.i.i.i.i

bb2.i.i.i.i.i.i:                                  ; preds = %bb4.i4.i.i
  %30 = getelementptr inbounds %"redis::cmd::Cmd", ptr %_4.i.i, i64 0, i32 2, i32 0, i32 1
  %_1.val1.i3.i.i.i = load ptr, ptr %30, align 8, !noalias !25, !nonnull !6
  %_6.i.i.i.i.i4.i.i.i = icmp ult i64 %_1.val.i1.i.i.i, 576460752303423488
  %array_size.i.i.i.i.i.i.i.i = shl nuw nsw i64 %_1.val.i1.i.i.i, 4
  call void @llvm.assume(i1 %_6.i.i.i.i.i4.i.i.i)
  call void @__rust_dealloc(ptr noundef nonnull %_1.val1.i3.i.i.i, i64 noundef %array_size.i.i.i.i.i.i.i.i, i64 noundef 8) #24, !noalias !48
  br label %bb4.i

abort.i30.i:                                      ; preds = %cleanup.body.i.i
  %31 = landingpad { ptr, i32 }
          cleanup
; call core::panicking::panic_cannot_unwind
  call void @_ZN4core9panicking19panic_cannot_unwind17h42344709dec62f2eE() #23, !noalias !48
  unreachable

bb20.i:                                           ; preds = %cleanup6.i, %bb28.i, %cleanup.i93.i, %cleanup.body.i74.i, %bb10.i.i.i, %bb11.i.i.i, %cleanup4.i, %cleanup3.i, %cleanup.body.i.i, %cleanup1.i.i.i
  %.pn9.i = phi { ptr, i32 } [ %32, %cleanup3.i ], [ %11, %cleanup1.i.i.i ], [ %eh.lpad-body.i.i, %cleanup.body.i.i ], [ %73, %cleanup6.i ], [ %34, %cleanup4.i ], [ %71, %bb28.i ], [ %eh.lpad-body.i.i.i, %bb11.i.i.i ], [ %.pn4.i.i.i, %bb10.i.i.i ], [ %eh.lpad-body.i73.i, %cleanup.body.i74.i ], [ %69, %cleanup.i93.i ]
; call core::ptr::drop_in_place<alloc::string::String>
  call fastcc void @"_ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17h5f3174a51a28c86eE"(ptr noundef nonnull %key.i) #21
  br label %bb21.i

cleanup3.i:                                       ; preds = %bb7.i.i, %bb36.i
  %32 = landingpad { ptr, i32 }
          cleanup
  br label %bb20.i

bb4.i:                                            ; preds = %bb2.i.i.i.i.i.i, %bb4.i4.i.i
  call void @llvm.lifetime.end.p0(i64 64, ptr nonnull %_4.i.i), !noalias !25
  %33 = icmp eq i8 %_21.sroa.0.1.i, 4
  br i1 %33, label %bb5.i, label %bb7.i.i

bb7.i.i:                                          ; preds = %bb4.i
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %e.i33.i), !noalias !72
  store i8 %_21.sroa.0.1.i, ptr %e.i33.i, align 8, !noalias !77
  %_21.sroa.8.0.e.i33.sroa_idx.i = getelementptr inbounds i8, ptr %e.i33.i, i64 1
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %_21.sroa.8.0.e.i33.sroa_idx.i, ptr noundef nonnull align 1 dereferenceable(7) %_21.sroa.8.sroa.0.i, i64 7, i1 false), !noalias !77
  %_21.sroa.8.sroa.5.0._21.sroa.8.0.e.i33.sroa_idx.sroa_idx.i = getelementptr inbounds i8, ptr %e.i33.i, i64 8
  store i64 %_21.sroa.8.sroa.5.1.i, ptr %_21.sroa.8.sroa.5.0._21.sroa.8.0.e.i33.sroa_idx.sroa_idx.i, align 8, !noalias !77
  %_21.sroa.11.0.e.i33.sroa_idx.i = getelementptr inbounds i8, ptr %e.i33.i, i64 16
  store ptr %_21.sroa.11.1.i, ptr %_21.sroa.11.0.e.i33.sroa_idx.i, align 8, !noalias !77
  %_21.sroa.12.0.e.i33.sroa_idx.i = getelementptr inbounds i8, ptr %e.i33.i, i64 24
  store i64 %_21.sroa.12.sroa.0.1.i, ptr %_21.sroa.12.0.e.i33.sroa_idx.i, align 8, !noalias !77
  %_21.sroa.12.sroa.7.0._21.sroa.12.0.e.i33.sroa_idx.sroa_idx.i = getelementptr inbounds i8, ptr %e.i33.i, i64 32
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %_21.sroa.12.sroa.7.0._21.sroa.12.0.e.i33.sroa_idx.sroa_idx.i, ptr noundef nonnull align 8 dereferenceable(24) %_21.sroa.12.sroa.7.i, i64 24, i1 false), !noalias !77
; invoke core::ptr::drop_in_place<redis::types::RedisError>
  invoke void @"_ZN4core3ptr45drop_in_place$LT$redis..types..RedisError$GT$17he9e92a6d6be589cdE"(ptr noundef nonnull %e.i33.i)
          to label %bb5.thread.i unwind label %cleanup3.i

bb5.thread.i:                                     ; preds = %bb7.i.i
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %e.i33.i), !noalias !72
  call void @llvm.lifetime.end.p0(i64 7, ptr nonnull %_21.sroa.8.sroa.0.i)
  call void @llvm.lifetime.end.p0(i64 24, ptr nonnull %_21.sroa.12.sroa.7.i)
  br label %bb41.i

bb5.i:                                            ; preds = %bb4.i
  call void @llvm.lifetime.end.p0(i64 7, ptr nonnull %_21.sroa.8.sroa.0.i)
  call void @llvm.lifetime.end.p0(i64 24, ptr nonnull %_21.sroa.12.sroa.7.i)
  %.not.i = icmp eq ptr %_21.sroa.11.1.i, null
  br i1 %.not.i, label %bb41.i, label %bb7.i

cleanup4.i:                                       ; preds = %bb41.i
  %34 = landingpad { ptr, i32 }
          cleanup
  br label %bb20.i

bb41.i:                                           ; preds = %bb5.i, %bb5.thread.i
  call void @llvm.lifetime.start.p0(i64 24, ptr nonnull %answer1.i), !noalias !3
  %35 = getelementptr inbounds %"[closure@src/main.rs:14:19: 14:26]", ptr %_2, i64 0, i32 1, i32 0, i32 0, i32 1
  %_19.val.i = load ptr, ptr %35, align 8, !alias.scope !3, !nonnull !6, !noundef !6
  %36 = getelementptr inbounds %"[closure@src/main.rs:14:19: 14:26]", ptr %_2, i64 0, i32 1, i32 0, i32 1
  %_19.val19.i = load i64, ptr %36, align 8, !alias.scope !3, !noundef !6
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %question.i.i), !noalias !3
  store ptr %_19.val.i, ptr %question.i.i, align 8, !noalias !78
  %37 = getelementptr inbounds { ptr, i64 }, ptr %question.i.i, i64 0, i32 1
  store i64 %_19.val19.i, ptr %37, align 8, !noalias !78
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %_9.i.i), !noalias !78
  store ptr %question.i.i, ptr %_9.i.i, align 8, !noalias !78
  %38 = getelementptr inbounds { ptr, ptr }, ptr %_9.i.i, i64 0, i32 1
  store ptr @"_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17he2740909977511a8E", ptr %38, align 8, !noalias !78
  call void @llvm.lifetime.start.p0(i64 48, ptr nonnull %_2.i.i.i.i), !noalias !82
  store ptr null, ptr %_2.i.i.i.i, align 8, !noalias !90
  %args.sroa.42.0._2.i.i.sroa_idx.i.i = getelementptr inbounds i8, ptr %_2.i.i.i.i, i64 16
  store ptr @alloc140, ptr %args.sroa.42.0._2.i.i.sroa_idx.i.i, align 8, !noalias !90
  %args.sroa.6.0._2.i.i.sroa_idx.i.i = getelementptr inbounds i8, ptr %_2.i.i.i.i, i64 24
  store i64 2, ptr %args.sroa.6.0._2.i.i.sroa_idx.i.i, align 8, !noalias !90
  %args.sroa.8.0._2.i.i.sroa_idx.i.i = getelementptr inbounds i8, ptr %_2.i.i.i.i, i64 32
  store ptr %_9.i.i, ptr %args.sroa.8.0._2.i.i.sroa_idx.i.i, align 8, !noalias !90
  %args.sroa.9.0._2.i.i.sroa_idx.i.i = getelementptr inbounds i8, ptr %_2.i.i.i.i, i64 40
  store i64 1, ptr %args.sroa.9.0._2.i.i.sroa_idx.i.i, align 8, !noalias !90
; invoke alloc::fmt::format::format_inner
  invoke void @_ZN5alloc3fmt6format12format_inner17h499afee7b38b5a15E(ptr noalias nocapture noundef nonnull sret(%"alloc::string::String") dereferenceable(24) %answer1.i, ptr noalias nocapture noundef nonnull readonly dereferenceable(48) %_2.i.i.i.i)
          to label %bb12.i unwind label %cleanup4.i

bb12.i:                                           ; preds = %bb41.i
  call void @llvm.lifetime.end.p0(i64 48, ptr nonnull %_2.i.i.i.i), !noalias !82
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %_9.i.i), !noalias !78
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %question.i.i), !noalias !3
  call void @llvm.lifetime.start.p0(i64 48, ptr nonnull %_48.i), !noalias !3
  call void @llvm.lifetime.start.p0(i64 32, ptr nonnull %_55.i), !noalias !3
  %_58.i = getelementptr inbounds %"[closure@src/main.rs:14:19: 14:26]", ptr %_2, i64 0, i32 2
  store ptr %_58.i, ptr %_55.i, align 8, !noalias !3
  %39 = getelementptr inbounds { ptr, ptr }, ptr %_55.i, i64 0, i32 1
  store ptr @"_ZN60_$LT$alloc..string..String$u20$as$u20$core..fmt..Display$GT$3fmt17h5fbcba97ac02a262E", ptr %39, align 8, !noalias !3
  %40 = getelementptr inbounds [2 x { ptr, ptr }], ptr %_55.i, i64 0, i64 1
  store ptr %answer1.i, ptr %40, align 8, !noalias !3
  %41 = getelementptr inbounds [2 x { ptr, ptr }], ptr %_55.i, i64 0, i64 1, i32 1
  store ptr @"_ZN60_$LT$alloc..string..String$u20$as$u20$core..fmt..Display$GT$3fmt17h5fbcba97ac02a262E", ptr %41, align 8, !noalias !3
  %42 = getelementptr inbounds %"core::fmt::Arguments<'_>", ptr %_48.i, i64 0, i32 1
  store ptr @alloc118, ptr %42, align 8, !alias.scope !91, !noalias !94
  %43 = getelementptr inbounds %"core::fmt::Arguments<'_>", ptr %_48.i, i64 0, i32 1, i32 1
  store i64 3, ptr %43, align 8, !alias.scope !91, !noalias !94
  store ptr null, ptr %_48.i, align 8, !alias.scope !91, !noalias !94
  %44 = getelementptr inbounds %"core::fmt::Arguments<'_>", ptr %_48.i, i64 0, i32 2
  store ptr %_55.i, ptr %44, align 8, !alias.scope !91, !noalias !94
  %45 = getelementptr inbounds %"core::fmt::Arguments<'_>", ptr %_48.i, i64 0, i32 2, i32 1
  store i64 2, ptr %45, align 8, !alias.scope !91, !noalias !94
; invoke std::io::stdio::_print
  invoke void @_ZN3std2io5stdio6_print17h96fa75218cf4f48dE(ptr noalias nocapture noundef nonnull readonly dereferenceable(48) %_48.i)
          to label %bb13.i unwind label %bb28.i

bb13.i:                                           ; preds = %bb12.i
  call void @llvm.lifetime.end.p0(i64 48, ptr nonnull %_48.i), !noalias !3
  call void @llvm.lifetime.end.p0(i64 32, ptr nonnull %_55.i), !noalias !3
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %_63.i), !noalias !3
  call void @llvm.lifetime.start.p0(i64 24, ptr nonnull %_66.sroa.0.i)
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %_66.sroa.0.i, ptr noundef nonnull align 8 dereferenceable(24) %answer1.i, i64 24, i1 false), !noalias !3
  call void @llvm.lifetime.start.p0(i64 64, ptr nonnull %_5.i.i), !noalias !97
  call void @llvm.lifetime.start.p0(i64 24, ptr nonnull %_7.i49.i), !noalias !97
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %_7.i49.i, ptr noundef nonnull align 8 dereferenceable(24) %answer1.i, i64 24, i1 false), !noalias !3
  call void @llvm.lifetime.start.p0(i64 64, ptr nonnull %_9.i.i.i), !noalias !102
; invoke redis::cmd::cmd
  invoke void @_ZN5redis3cmd3cmd17h0f3121e002b2e6b0E(ptr noalias nocapture noundef nonnull sret(%"redis::cmd::Cmd") dereferenceable(64) %_9.i.i.i, ptr noalias noundef nonnull readonly align 1 @alloc351, i64 noundef 3)
          to label %bb1.i.i.i unwind label %bb11.thread.i.i.i, !noalias !106

bb11.i.i.i:                                       ; preds = %cleanup1.body.i.i.i
  br i1 %_15.2.lpad-body.i.i.i, label %bb10.i.i.i, label %bb20.i

bb11.thread.i.i.i:                                ; preds = %bb13.i
  %46 = landingpad { ptr, i32 }
          cleanup
  br label %bb10.i.i.i

bb1.i.i.i:                                        ; preds = %bb13.i
; invoke <redis::cmd::Cmd as redis::types::RedisWrite>::write_arg
  invoke void @"_ZN60_$LT$redis..cmd..Cmd$u20$as$u20$redis..types..RedisWrite$GT$9write_arg17h8270d42f2a1b25b1E"(ptr noalias noundef nonnull align 8 dereferenceable(64) %_9.i.i.i, ptr noalias noundef nonnull readonly align 1 %key.val.i, i64 noundef %key.val20.i)
          to label %bb2.i.i51.i unwind label %cleanup1.i.i50.i, !noalias !106

cleanup1.i.i50.i:                                 ; preds = %bb3.i.i.i, %bb1.i.i.i
  %_15.2.i.i.i = phi i1 [ false, %bb3.i.i.i ], [ true, %bb1.i.i.i ]
  %47 = landingpad { ptr, i32 }
          cleanup
  br label %cleanup1.body.i.i.i

cleanup1.body.i.i.i:                              ; preds = %cleanup.i.i.i.i, %cleanup1.i.i50.i
  %_15.2.lpad-body.i.i.i = phi i1 [ %_15.2.i.i.i, %cleanup1.i.i50.i ], [ false, %cleanup.i.i.i.i ]
  %eh.lpad-body.i.i.i = phi { ptr, i32 } [ %47, %cleanup1.i.i50.i ], [ %50, %cleanup.i.i.i.i ]
; invoke core::ptr::drop_in_place<redis::cmd::Cmd>
  invoke fastcc void @"_ZN4core3ptr36drop_in_place$LT$redis..cmd..Cmd$GT$17h1f157ef24f377633E"(ptr noundef nonnull %_9.i.i.i) #21
          to label %bb11.i.i.i unwind label %abort.i.i66.i, !noalias !106

bb2.i.i51.i:                                      ; preds = %bb1.i.i.i
  call void @llvm.lifetime.start.p0(i64 24, ptr nonnull %_13.i.i48.i), !noalias !102
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %_13.i.i48.i, ptr noundef nonnull align 8 dereferenceable(24) %_66.sroa.0.i, i64 24, i1 false), !noalias !107
  call void @llvm.experimental.noalias.scope.decl(metadata !108)
  %48 = getelementptr inbounds i8, ptr %_13.i.i48.i, i64 8
  %arg.val.i.i.i.i = load ptr, ptr %48, align 8, !alias.scope !108, !noalias !111, !nonnull !6, !noundef !6
  %49 = getelementptr inbounds i8, ptr %_13.i.i48.i, i64 16
  %arg.val1.i.i.i.i = load i64, ptr %49, align 8, !alias.scope !108, !noalias !111, !noundef !6
; invoke <redis::cmd::Cmd as redis::types::RedisWrite>::write_arg
  invoke void @"_ZN60_$LT$redis..cmd..Cmd$u20$as$u20$redis..types..RedisWrite$GT$9write_arg17h8270d42f2a1b25b1E"(ptr noalias noundef nonnull align 8 dereferenceable(64) %_9.i.i.i, ptr noalias noundef nonnull readonly align 1 %arg.val.i.i.i.i, i64 noundef %arg.val1.i.i.i.i)
          to label %bb1.i.i.i.i unwind label %cleanup.i.i.i.i, !noalias !113

cleanup.i.i.i.i:                                  ; preds = %bb2.i.i51.i
  %50 = landingpad { ptr, i32 }
          cleanup
; call core::ptr::drop_in_place<alloc::string::String>
  call fastcc void @"_ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17h5f3174a51a28c86eE"(ptr noundef nonnull %_13.i.i48.i) #21, !noalias !106
  br label %cleanup1.body.i.i.i

bb1.i.i.i.i:                                      ; preds = %bb2.i.i51.i
  %_1.val.i.i.i.i.i.i = load i64, ptr %_13.i.i48.i, align 8, !alias.scope !108, !noalias !111, !noundef !6
  %_3.i.i.i.i.i.i.i.i.i = icmp eq i64 %_1.val.i.i.i.i.i.i, 0
  br i1 %_3.i.i.i.i.i.i.i.i.i, label %bb3.i.i.i, label %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i.i.i.i"

"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i.i.i.i": ; preds = %bb1.i.i.i.i
  %_6.i.i.i.i.i.i.i.i.i.i = icmp sgt i64 %_1.val.i.i.i.i.i.i, -1
  %.sroa.2.0.i.i.i.i.i.i.i.i.i.i = zext i1 %_6.i.i.i.i.i.i.i.i.i.i to i64
  call void @llvm.assume(i1 %_6.i.i.i.i.i.i.i.i.i.i)
  call void @__rust_dealloc(ptr noundef nonnull %arg.val.i.i.i.i, i64 noundef %_1.val.i.i.i.i.i.i, i64 noundef %.sroa.2.0.i.i.i.i.i.i.i.i.i.i) #24, !noalias !113
  br label %bb3.i.i.i

bb3.i.i.i:                                        ; preds = %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i.i.i.i", %bb1.i.i.i.i
  call void @llvm.lifetime.end.p0(i64 24, ptr nonnull %_13.i.i48.i), !noalias !102
  call void @llvm.lifetime.start.p0(i64 64, ptr nonnull %_14.i.i.i), !noalias !102
; invoke redis::cmd::Cmd::new
  invoke void @_ZN5redis3cmd3Cmd3new17h02c81ac25f6253f5E(ptr noalias nocapture noundef nonnull sret(%"redis::cmd::Cmd") dereferenceable(64) %_14.i.i.i)
          to label %bb5.i.i54.i unwind label %cleanup1.i.i50.i, !noalias !106

bb5.i.i54.i:                                      ; preds = %bb3.i.i.i
  call void @llvm.experimental.noalias.scope.decl(metadata !114)
  call void @llvm.experimental.noalias.scope.decl(metadata !117)
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %_5.i.i, ptr noundef nonnull align 8 dereferenceable(64) %_9.i.i.i, i64 64, i1 false), !alias.scope !119, !noalias !121
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %_9.i.i.i, ptr noundef nonnull align 8 dereferenceable(64) %_14.i.i.i, i64 64, i1 false), !alias.scope !122, !noalias !123
  call void @llvm.lifetime.end.p0(i64 64, ptr nonnull %_14.i.i.i), !noalias !102
  %51 = getelementptr inbounds %"redis::cmd::Cmd", ptr %_9.i.i.i, i64 0, i32 1
  %_1.val.i.i.i.i52.i = load i64, ptr %51, align 8, !noalias !102, !noundef !6
  %_3.i.i.i.i.i.i.i53.i = icmp eq i64 %_1.val.i.i.i.i52.i, 0
  br i1 %_3.i.i.i.i.i.i.i53.i, label %bb4.i.i.i61.i, label %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i.i58.i"

"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i.i58.i": ; preds = %bb5.i.i54.i
  %52 = getelementptr inbounds %"redis::cmd::Cmd", ptr %_9.i.i.i, i64 0, i32 1, i32 0, i32 1
  %_1.val1.i.i.i.i55.i = load ptr, ptr %52, align 8, !noalias !102, !nonnull !6
  %_6.i.i.i.i.i.i.i.i56.i = icmp sgt i64 %_1.val.i.i.i.i52.i, -1
  %.sroa.2.0.i.i.i.i.i.i.i.i57.i = zext i1 %_6.i.i.i.i.i.i.i.i56.i to i64
  call void @llvm.assume(i1 %_6.i.i.i.i.i.i.i.i56.i)
  call void @__rust_dealloc(ptr noundef nonnull %_1.val1.i.i.i.i55.i, i64 noundef %_1.val.i.i.i.i52.i, i64 noundef %.sroa.2.0.i.i.i.i.i.i.i.i57.i) #24, !noalias !106
  br label %bb4.i.i.i61.i

bb4.i.i.i61.i:                                    ; preds = %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i.i58.i", %bb5.i.i54.i
  %53 = getelementptr inbounds %"redis::cmd::Cmd", ptr %_9.i.i.i, i64 0, i32 2
  %_1.val.i1.i.i.i59.i = load i64, ptr %53, align 8, !noalias !102, !noundef !6
  %_3.i.i.i.i2.i.i.i60.i = icmp eq i64 %_1.val.i1.i.i.i59.i, 0
  br i1 %_3.i.i.i.i2.i.i.i60.i, label %"_ZN5redis8commands33_$LT$impl$u20$redis..cmd..Cmd$GT$3set17h284181bf7b1d94e5E.exit.i.i", label %bb2.i.i.i.i.i.i65.i

bb2.i.i.i.i.i.i65.i:                              ; preds = %bb4.i.i.i61.i
  %54 = getelementptr inbounds %"redis::cmd::Cmd", ptr %_9.i.i.i, i64 0, i32 2, i32 0, i32 1
  %_1.val1.i3.i.i.i62.i = load ptr, ptr %54, align 8, !noalias !102, !nonnull !6
  %_6.i.i.i.i.i4.i.i.i63.i = icmp ult i64 %_1.val.i1.i.i.i59.i, 576460752303423488
  %array_size.i.i.i.i.i.i.i.i64.i = shl nuw nsw i64 %_1.val.i1.i.i.i59.i, 4
  call void @llvm.assume(i1 %_6.i.i.i.i.i4.i.i.i63.i)
  call void @__rust_dealloc(ptr noundef nonnull %_1.val1.i3.i.i.i62.i, i64 noundef %array_size.i.i.i.i.i.i.i.i64.i, i64 noundef 8) #24, !noalias !106
  br label %"_ZN5redis8commands33_$LT$impl$u20$redis..cmd..Cmd$GT$3set17h284181bf7b1d94e5E.exit.i.i"

abort.i.i66.i:                                    ; preds = %cleanup1.body.i.i.i
  %55 = landingpad { ptr, i32 }
          cleanup
; call core::panicking::panic_cannot_unwind
  call void @_ZN4core9panicking19panic_cannot_unwind17h42344709dec62f2eE() #23, !noalias !106
  unreachable

bb10.i.i.i:                                       ; preds = %bb11.thread.i.i.i, %bb11.i.i.i
  %.pn4.i.i.i = phi { ptr, i32 } [ %46, %bb11.thread.i.i.i ], [ %eh.lpad-body.i.i.i, %bb11.i.i.i ]
; call core::ptr::drop_in_place<alloc::string::String>
  call fastcc void @"_ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17h5f3174a51a28c86eE"(ptr noundef nonnull %_7.i49.i) #21, !noalias !124
  br label %bb20.i

"_ZN5redis8commands33_$LT$impl$u20$redis..cmd..Cmd$GT$3set17h284181bf7b1d94e5E.exit.i.i": ; preds = %bb2.i.i.i.i.i.i65.i, %bb4.i.i.i61.i
  call void @llvm.lifetime.end.p0(i64 64, ptr nonnull %_9.i.i.i), !noalias !102
  call void @llvm.lifetime.end.p0(i64 24, ptr nonnull %_7.i49.i), !noalias !97
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %_3.i.i47.i), !noalias !125
; invoke redis::connection::ConnectionLike::req_command
  invoke fastcc void @_ZN5redis10connection14ConnectionLike11req_command17hb44cc350392f82eeE(ptr noalias nocapture noundef nonnull sret(%"core::result::Result<redis::types::Value, redis::types::RedisError>") dereferenceable(56) %_3.i.i47.i, ptr noundef nonnull align 1 %con.i, ptr noalias noundef nonnull readonly align 8 dereferenceable(64) %_5.i.i)
          to label %.noexc.i69.i unwind label %cleanup.i72.i, !noalias !129

.noexc.i69.i:                                     ; preds = %"_ZN5redis8commands33_$LT$impl$u20$redis..cmd..Cmd$GT$3set17h284181bf7b1d94e5E.exit.i.i"
  %56 = load i8, ptr %_3.i.i47.i, align 8, !range !49, !noalias !125, !noundef !6
  %57 = icmp eq i8 %56, 4
  br i1 %57, label %bb4.i.i70.i, label %bb2.i2.i.i

bb4.i.i70.i:                                      ; preds = %.noexc.i69.i
  call void @llvm.lifetime.start.p0(i64 32, ptr nonnull %val.i.i46.i), !noalias !125
  %58 = getelementptr inbounds %"core::result::Result<redis::types::Value, redis::types::RedisError>::Ok", ptr %_3.i.i47.i, i64 0, i32 1
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %val.i.i46.i, ptr noundef nonnull align 8 dereferenceable(32) %58, i64 32, i1 false), !noalias !125
; invoke <() as redis::types::FromRedisValue>::from_redis_value
  invoke void @"_ZN57_$LT$$LP$$RP$$u20$as$u20$redis..types..FromRedisValue$GT$16from_redis_value17h7cc1db2fba739b90E"(ptr noalias nocapture noundef nonnull sret(%"core::result::Result<(), redis::types::RedisError>") dereferenceable(56) %_63.i, ptr noalias noundef nonnull readonly align 8 dereferenceable(32) %val.i.i46.i)
          to label %bb5.i3.i.i unwind label %cleanup.i.i71.i, !noalias !130

bb2.i2.i.i:                                       ; preds = %.noexc.i69.i
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %_63.i, ptr noundef nonnull align 8 dereferenceable(56) %_3.i.i47.i, i64 56, i1 false), !noalias !131
  br label %bb2.i77.i

cleanup.i.i71.i:                                  ; preds = %bb4.i.i70.i
  %59 = landingpad { ptr, i32 }
          cleanup
; invoke core::ptr::drop_in_place<redis::types::Value>
  invoke fastcc void @"_ZN4core3ptr40drop_in_place$LT$redis..types..Value$GT$17hbec51beeae85c599E"(ptr noundef nonnull %val.i.i46.i) #21
          to label %cleanup.body.i74.i unwind label %abort.i4.i.i, !noalias !132

bb5.i3.i.i:                                       ; preds = %bb4.i.i70.i
; invoke core::ptr::drop_in_place<redis::types::Value>
  invoke fastcc void @"_ZN4core3ptr40drop_in_place$LT$redis..types..Value$GT$17hbec51beeae85c599E"(ptr noundef nonnull %val.i.i46.i)
          to label %.noexc6.i.i unwind label %cleanup.i72.i, !noalias !129

.noexc6.i.i:                                      ; preds = %bb5.i3.i.i
  call void @llvm.lifetime.end.p0(i64 32, ptr nonnull %val.i.i46.i), !noalias !125
  br label %bb2.i77.i

abort.i4.i.i:                                     ; preds = %cleanup.i.i71.i
  %60 = landingpad { ptr, i32 }
          cleanup
; call core::panicking::panic_cannot_unwind
  call void @_ZN4core9panicking19panic_cannot_unwind17h42344709dec62f2eE() #23, !noalias !132
  unreachable

cleanup.i72.i:                                    ; preds = %bb5.i3.i.i, %"_ZN5redis8commands33_$LT$impl$u20$redis..cmd..Cmd$GT$3set17h284181bf7b1d94e5E.exit.i.i"
  %61 = landingpad { ptr, i32 }
          cleanup
  br label %cleanup.body.i74.i

cleanup.body.i74.i:                               ; preds = %cleanup.i72.i, %cleanup.i.i71.i
  %eh.lpad-body.i73.i = phi { ptr, i32 } [ %61, %cleanup.i72.i ], [ %59, %cleanup.i.i71.i ]
; invoke core::ptr::drop_in_place<redis::cmd::Cmd>
  invoke fastcc void @"_ZN4core3ptr36drop_in_place$LT$redis..cmd..Cmd$GT$17h1f157ef24f377633E"(ptr noundef nonnull %_5.i.i) #21
          to label %bb20.i unwind label %abort.i88.i, !noalias !129

bb2.i77.i:                                        ; preds = %.noexc6.i.i, %bb2.i2.i.i
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %_3.i.i47.i), !noalias !125
  %62 = getelementptr inbounds %"redis::cmd::Cmd", ptr %_5.i.i, i64 0, i32 1
  %_1.val.i.i.i75.i = load i64, ptr %62, align 8, !noalias !97, !noundef !6
  %_3.i.i.i.i.i.i76.i = icmp eq i64 %_1.val.i.i.i75.i, 0
  br i1 %_3.i.i.i.i.i.i76.i, label %bb4.i7.i.i, label %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i81.i"

"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i81.i": ; preds = %bb2.i77.i
  %63 = getelementptr inbounds %"redis::cmd::Cmd", ptr %_5.i.i, i64 0, i32 1, i32 0, i32 1
  %_1.val1.i.i.i78.i = load ptr, ptr %63, align 8, !noalias !97, !nonnull !6
  %_6.i.i.i.i.i.i.i79.i = icmp sgt i64 %_1.val.i.i.i75.i, -1
  %.sroa.2.0.i.i.i.i.i.i.i80.i = zext i1 %_6.i.i.i.i.i.i.i79.i to i64
  call void @llvm.assume(i1 %_6.i.i.i.i.i.i.i79.i)
  call void @__rust_dealloc(ptr noundef nonnull %_1.val1.i.i.i78.i, i64 noundef %_1.val.i.i.i75.i, i64 noundef %.sroa.2.0.i.i.i.i.i.i.i80.i) #24, !noalias !129
  br label %bb4.i7.i.i

bb4.i7.i.i:                                       ; preds = %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i81.i", %bb2.i77.i
  %64 = getelementptr inbounds %"redis::cmd::Cmd", ptr %_5.i.i, i64 0, i32 2
  %_1.val.i1.i.i82.i = load i64, ptr %64, align 8, !noalias !97, !noundef !6
  %_3.i.i.i.i2.i.i83.i = icmp eq i64 %_1.val.i1.i.i82.i, 0
  br i1 %_3.i.i.i.i2.i.i83.i, label %bb14.i, label %bb2.i.i.i.i.i87.i

bb2.i.i.i.i.i87.i:                                ; preds = %bb4.i7.i.i
  %65 = getelementptr inbounds %"redis::cmd::Cmd", ptr %_5.i.i, i64 0, i32 2, i32 0, i32 1
  %_1.val1.i3.i.i84.i = load ptr, ptr %65, align 8, !noalias !97, !nonnull !6
  %_6.i.i.i.i.i4.i.i85.i = icmp ult i64 %_1.val.i1.i.i82.i, 576460752303423488
  %array_size.i.i.i.i.i.i.i86.i = shl nuw nsw i64 %_1.val.i1.i.i82.i, 4
  call void @llvm.assume(i1 %_6.i.i.i.i.i4.i.i85.i)
  call void @__rust_dealloc(ptr noundef nonnull %_1.val1.i3.i.i84.i, i64 noundef %array_size.i.i.i.i.i.i.i86.i, i64 noundef 8) #24, !noalias !129
  br label %bb14.i

abort.i88.i:                                      ; preds = %cleanup.body.i74.i
  %66 = landingpad { ptr, i32 }
          cleanup
; call core::panicking::panic_cannot_unwind
  call void @_ZN4core9panicking19panic_cannot_unwind17h42344709dec62f2eE() #23, !noalias !129
  unreachable

bb14.i:                                           ; preds = %bb2.i.i.i.i.i87.i, %bb4.i7.i.i
  call void @llvm.lifetime.end.p0(i64 64, ptr nonnull %_5.i.i), !noalias !97
  call void @llvm.lifetime.end.p0(i64 24, ptr nonnull %_66.sroa.0.i)
  call void @llvm.experimental.noalias.scope.decl(metadata !133)
  %67 = load i8, ptr %_63.i, align 8, !range !49, !alias.scope !133, !noalias !3, !noundef !6
  %68 = icmp eq i8 %67, 4
  br i1 %68, label %bb27.i, label %bb1.i92.i

bb1.i92.i:                                        ; preds = %bb14.i
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %e.i90.i), !noalias !136
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %e.i90.i, ptr noundef nonnull align 8 dereferenceable(56) %_63.i, i64 56, i1 false), !noalias !3
; invoke core::result::unwrap_failed
  invoke void @_ZN4core6result13unwrap_failed17hdc73d4affce1d414E(ptr noalias noundef nonnull readonly align 1 @alloc344, i64 noundef 43, ptr noundef nonnull align 1 %e.i90.i, ptr noalias noundef nonnull readonly align 8 dereferenceable(24) @vtable.8, ptr noalias noundef nonnull readonly align 8 dereferenceable(24) @alloc364) #22
          to label %unreachable.i94.i unwind label %cleanup.i93.i, !noalias !133

cleanup.i93.i:                                    ; preds = %bb1.i92.i
  %69 = landingpad { ptr, i32 }
          cleanup
; invoke core::ptr::drop_in_place<redis::types::RedisError>
  invoke void @"_ZN4core3ptr45drop_in_place$LT$redis..types..RedisError$GT$17he9e92a6d6be589cdE"(ptr noundef nonnull %e.i90.i) #21
          to label %bb20.i unwind label %abort.i95.i, !noalias !133

unreachable.i94.i:                                ; preds = %bb1.i92.i
  unreachable

abort.i95.i:                                      ; preds = %cleanup.i93.i
  %70 = landingpad { ptr, i32 }
          cleanup
; call core::panicking::panic_cannot_unwind
  call void @_ZN4core9panicking19panic_cannot_unwind17h42344709dec62f2eE() #23, !noalias !133
  unreachable

bb28.i:                                           ; preds = %bb12.i
  %71 = landingpad { ptr, i32 }
          cleanup
; call core::ptr::drop_in_place<alloc::string::String>
  call fastcc void @"_ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17h5f3174a51a28c86eE"(ptr noundef nonnull %answer1.i) #21
  br label %bb20.i

abort.i:                                          ; preds = %bb21.i, %bb22.i
  %72 = landingpad { ptr, i32 }
          cleanup
; call core::panicking::panic_cannot_unwind
  call void @_ZN4core9panicking19panic_cannot_unwind17h42344709dec62f2eE() #23
  unreachable

bb27.i:                                           ; preds = %bb14.i
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %_63.i), !noalias !3
  call void @llvm.lifetime.end.p0(i64 24, ptr nonnull %answer1.i), !noalias !3
  br label %bb24.i

cleanup6.i:                                       ; preds = %bb7.i
  %73 = landingpad { ptr, i32 }
          cleanup
; call core::ptr::drop_in_place<alloc::string::String>
  call fastcc void @"_ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17h5f3174a51a28c86eE"(ptr noundef nonnull %answer.i) #21
  br label %bb20.i

bb7.i:                                            ; preds = %bb5.i
  call void @llvm.lifetime.start.p0(i64 24, ptr nonnull %answer.i), !noalias !3
  store i64 %_21.sroa.8.sroa.5.1.i, ptr %answer.i, align 8, !noalias !3
  %cached_answer.i.sroa.4.0.answer.i.sroa_idx = getelementptr inbounds i8, ptr %answer.i, i64 8
  store ptr %_21.sroa.11.1.i, ptr %cached_answer.i.sroa.4.0.answer.i.sroa_idx, align 8, !noalias !3
  %cached_answer.i.sroa.6.0.answer.i.sroa_idx = getelementptr inbounds i8, ptr %answer.i, i64 16
  store i64 %_21.sroa.12.sroa.0.1.i, ptr %cached_answer.i.sroa.6.0.answer.i.sroa_idx, align 8, !noalias !3
  call void @llvm.lifetime.start.p0(i64 48, ptr nonnull %_28.i), !noalias !3
  call void @llvm.lifetime.start.p0(i64 32, ptr nonnull %_35.i), !noalias !3
  %_38.i = getelementptr inbounds %"[closure@src/main.rs:14:19: 14:26]", ptr %_2, i64 0, i32 2
  store ptr %_38.i, ptr %_35.i, align 8, !noalias !3
  %74 = getelementptr inbounds { ptr, ptr }, ptr %_35.i, i64 0, i32 1
  store ptr @"_ZN60_$LT$alloc..string..String$u20$as$u20$core..fmt..Display$GT$3fmt17h5fbcba97ac02a262E", ptr %74, align 8, !noalias !3
  %75 = getelementptr inbounds [2 x { ptr, ptr }], ptr %_35.i, i64 0, i64 1
  store ptr %answer.i, ptr %75, align 8, !noalias !3
  %76 = getelementptr inbounds [2 x { ptr, ptr }], ptr %_35.i, i64 0, i64 1, i32 1
  store ptr @"_ZN60_$LT$alloc..string..String$u20$as$u20$core..fmt..Display$GT$3fmt17h5fbcba97ac02a262E", ptr %76, align 8, !noalias !3
  %77 = getelementptr inbounds %"core::fmt::Arguments<'_>", ptr %_28.i, i64 0, i32 1
  store ptr @alloc113, ptr %77, align 8, !alias.scope !137, !noalias !140
  %78 = getelementptr inbounds %"core::fmt::Arguments<'_>", ptr %_28.i, i64 0, i32 1, i32 1
  store i64 3, ptr %78, align 8, !alias.scope !137, !noalias !140
  store ptr null, ptr %_28.i, align 8, !alias.scope !137, !noalias !140
  %79 = getelementptr inbounds %"core::fmt::Arguments<'_>", ptr %_28.i, i64 0, i32 2
  store ptr %_35.i, ptr %79, align 8, !alias.scope !137, !noalias !140
  %80 = getelementptr inbounds %"core::fmt::Arguments<'_>", ptr %_28.i, i64 0, i32 2, i32 1
  store i64 2, ptr %80, align 8, !alias.scope !137, !noalias !140
; invoke std::io::stdio::_print
  invoke void @_ZN3std2io5stdio6_print17h96fa75218cf4f48dE(ptr noalias nocapture noundef nonnull readonly dereferenceable(48) %_28.i)
          to label %bb8.i unwind label %cleanup6.i

bb8.i:                                            ; preds = %bb7.i
  call void @llvm.lifetime.end.p0(i64 48, ptr nonnull %_28.i), !noalias !3
  call void @llvm.lifetime.end.p0(i64 32, ptr nonnull %_35.i), !noalias !3
  %_1.val.i.i.i = load i64, ptr %answer.i, align 8, !noalias !3, !noundef !6
  %_3.i.i.i.i.i.i = icmp eq i64 %_1.val.i.i.i, 0
  br i1 %_3.i.i.i.i.i.i, label %bb27.thread.i, label %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i"

"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i": ; preds = %bb8.i
  %_1.val1.i.i.i = load ptr, ptr %cached_answer.i.sroa.4.0.answer.i.sroa_idx, align 8, !noalias !3, !nonnull !6
  %_6.i.i.i.i.i.i.i = icmp sgt i64 %_1.val.i.i.i, -1
  %.sroa.2.0.i.i.i.i.i.i.i = zext i1 %_6.i.i.i.i.i.i.i to i64
  call void @llvm.assume(i1 %_6.i.i.i.i.i.i.i)
  call void @__rust_dealloc(ptr noundef nonnull %_1.val1.i.i.i, i64 noundef %_1.val.i.i.i, i64 noundef %.sroa.2.0.i.i.i.i.i.i.i) #24
  br label %bb27.thread.i

bb27.thread.i:                                    ; preds = %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i", %bb8.i
  call void @llvm.lifetime.end.p0(i64 24, ptr nonnull %answer.i), !noalias !3
  br label %bb24.i

bb24.i:                                           ; preds = %bb27.thread.i, %bb27.i
  %_1.val.i.i100.i = load i64, ptr %key.i, align 8, !noalias !3, !noundef !6
  %_3.i.i.i.i.i101.i = icmp eq i64 %_1.val.i.i100.i, 0
  br i1 %_3.i.i.i.i.i101.i, label %bb16.i, label %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i105.i"

"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i105.i": ; preds = %bb24.i
  %_6.i.i.i.i.i.i103.i = icmp sgt i64 %_1.val.i.i100.i, -1
  %.sroa.2.0.i.i.i.i.i.i104.i = zext i1 %_6.i.i.i.i.i.i103.i to i64
  call void @llvm.assume(i1 %_6.i.i.i.i.i.i103.i)
  call void @__rust_dealloc(ptr noundef nonnull %key.val.i, i64 noundef %_1.val.i.i100.i, i64 noundef %.sroa.2.0.i.i.i.i.i.i104.i) #24
  br label %bb16.i

bb16.i:                                           ; preds = %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i105.i", %bb24.i
  call void @llvm.lifetime.end.p0(i64 24, ptr nonnull %key.i), !noalias !3
  %81 = getelementptr inbounds %"redis::connection::Connection", ptr %con.i, i64 0, i32 2, i32 1
  %.val.i.i.i = load i32, ptr %81, align 4, !noalias !3
  %_2.i.i.i.i.i.i.i.i1.i.i = invoke noundef i32 @close(i32 noundef %.val.i.i.i)
          to label %bb4.i115.i unwind label %cleanup.i114.i

cleanup.i114.i:                                   ; preds = %bb16.i
  %82 = landingpad { ptr, i32 }
          cleanup
; invoke core::ptr::drop_in_place<redis::parser::Parser>
  invoke fastcc void @"_ZN4core3ptr42drop_in_place$LT$redis..parser..Parser$GT$17h484e3aee468a4e3cE"(ptr noundef nonnull %con.i) #21
          to label %bb22.i unwind label %abort.i116.i

bb4.i115.i:                                       ; preds = %bb16.i
; invoke core::ptr::drop_in_place<redis::parser::Parser>
  invoke fastcc void @"_ZN4core3ptr42drop_in_place$LT$redis..parser..Parser$GT$17h484e3aee468a4e3cE"(ptr noundef nonnull %con.i)
          to label %bb17.i unwind label %cleanup.i

abort.i116.i:                                     ; preds = %cleanup.i114.i
  %83 = landingpad { ptr, i32 }
          cleanup
; call core::panicking::panic_cannot_unwind
  call void @_ZN4core9panicking19panic_cannot_unwind17h42344709dec62f2eE() #23
  unreachable

bb17.i:                                           ; preds = %bb4.i115.i
  call void @llvm.lifetime.end.p0(i64 88, ptr nonnull %con.i), !noalias !3
  call void @llvm.experimental.noalias.scope.decl(metadata !143)
  %self1.i.i.i.i = load ptr, ptr %_2, align 8, !alias.scope !146, !nonnull !6, !noundef !6
  %84 = atomicrmw sub ptr %self1.i.i.i.i, i64 1 release, align 8, !noalias !143
  %85 = icmp eq i64 %84, 1
  br i1 %85, label %bb2.i.i.i.i, label %bb6.i123.i

bb2.i.i.i.i:                                      ; preds = %bb17.i
  fence acquire
  %self.val.i.i.i.i = load ptr, ptr %_2, align 8, !alias.scope !146, !nonnull !6
; call alloc::sync::Arc<T>::drop_slow
  call fastcc void @"_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17h5bc0dcdc32f3bc06E"(ptr nonnull %self.val.i.i.i.i), !noalias !143
  br label %bb6.i123.i

bb6.i123.i:                                       ; preds = %bb2.i.i.i.i, %bb17.i
  %_1.val.i.i.i121.i = load i64, ptr %_19.i, align 8, !alias.scope !3, !noundef !6
  %_3.i.i.i.i.i.i122.i = icmp eq i64 %_1.val.i.i.i121.i, 0
  br i1 %_3.i.i.i.i.i.i122.i, label %bb5.i128.i, label %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i127.i"

"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i127.i": ; preds = %bb6.i123.i
  %86 = getelementptr inbounds %"[closure@src/main.rs:14:19: 14:26]", ptr %_2, i64 0, i32 1, i32 0, i32 0, i32 1
  %_1.val1.i.i.i124.i = load ptr, ptr %86, align 8, !alias.scope !3, !nonnull !6
  %_6.i.i.i.i.i.i.i125.i = icmp sgt i64 %_1.val.i.i.i121.i, -1
  %.sroa.2.0.i.i.i.i.i.i.i126.i = zext i1 %_6.i.i.i.i.i.i.i125.i to i64
  call void @llvm.assume(i1 %_6.i.i.i.i.i.i.i125.i)
  call void @__rust_dealloc(ptr noundef nonnull %_1.val1.i.i.i124.i, i64 noundef %_1.val.i.i.i121.i, i64 noundef %.sroa.2.0.i.i.i.i.i.i.i126.i) #24
  br label %bb5.i128.i

bb5.i128.i:                                       ; preds = %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i127.i", %bb6.i123.i
  %87 = getelementptr inbounds %"[closure@src/main.rs:14:19: 14:26]", ptr %_2, i64 0, i32 2
  %_1.val.i.i3.i.i = load i64, ptr %87, align 8, !alias.scope !3, !noundef !6
  %_3.i.i.i.i.i4.i.i = icmp eq i64 %_1.val.i.i3.i.i, 0
  br i1 %_3.i.i.i.i.i4.i.i, label %"_ZN4demo16spawn_user_query28_$u7b$$u7b$closure$u7d$$u7d$17haf502634fafd28e6E.exit", label %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i8.i.i"

"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i8.i.i": ; preds = %bb5.i128.i
  %88 = getelementptr inbounds %"[closure@src/main.rs:14:19: 14:26]", ptr %_2, i64 0, i32 2, i32 0, i32 0, i32 1
  %_1.val1.i.i5.i.i = load ptr, ptr %88, align 8, !alias.scope !3, !nonnull !6
  %_6.i.i.i.i.i.i6.i.i = icmp sgt i64 %_1.val.i.i3.i.i, -1
  %.sroa.2.0.i.i.i.i.i.i7.i.i = zext i1 %_6.i.i.i.i.i.i6.i.i to i64
  call void @llvm.assume(i1 %_6.i.i.i.i.i.i6.i.i)
  call void @__rust_dealloc(ptr noundef nonnull %_1.val1.i.i5.i.i, i64 noundef %_1.val.i.i3.i.i, i64 noundef %.sroa.2.0.i.i.i.i.i.i7.i.i) #24
  br label %"_ZN4demo16spawn_user_query28_$u7b$$u7b$closure$u7d$$u7d$17haf502634fafd28e6E.exit"

bb23.i:                                           ; preds = %bb22.i
  resume { ptr, i32 } %.pn11.i

"_ZN4demo16spawn_user_query28_$u7b$$u7b$closure$u7d$$u7d$17haf502634fafd28e6E.exit": ; preds = %bb5.i128.i, %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i8.i.i"
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %_2)
  call void asm sideeffect "", "~{memory}"() #24, !srcloc !147
  ret void
}

; std::sys_common::backtrace::__rust_begin_short_backtrace
; Function Attrs: noinline nonlazybind uwtable
define internal fastcc void @_ZN3std10sys_common9backtrace28__rust_begin_short_backtrace17h7613cc2ef156ad16E(ptr nocapture noundef nonnull readonly %f) unnamed_addr #0 personality ptr @rust_eh_personality {
start:
  tail call void %f()
  tail call void asm sideeffect "", "~{memory}"() #24, !srcloc !147
  ret void
}

; std::io::Write::write_fmt
; Function Attrs: nonlazybind uwtable
define internal fastcc noundef ptr @_ZN3std2io5Write9write_fmt17hc65b2ef788d392c1E(ptr noalias noundef nonnull align 1 %self, ptr noalias nocapture noundef readonly dereferenceable(48) %fmt) unnamed_addr #1 personality ptr @rust_eh_personality {
start:
  %_10 = alloca %"core::fmt::Arguments<'_>", align 8
  %output = alloca { ptr, ptr }, align 8
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %output)
  %0 = getelementptr inbounds { ptr, ptr }, ptr %output, i64 0, i32 1
  store ptr %self, ptr %0, align 8
  store ptr null, ptr %output, align 8
  call void @llvm.lifetime.start.p0(i64 48, ptr nonnull %_10)
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(48) %_10, ptr noundef nonnull align 8 dereferenceable(48) %fmt, i64 48, i1 false)
; invoke core::fmt::write
  %1 = invoke noundef zeroext i1 @_ZN4core3fmt5write17h93e2f5923c7eca08E(ptr noundef nonnull align 1 %output, ptr noalias noundef nonnull readonly align 8 dereferenceable(24) @vtable.0, ptr noalias nocapture noundef nonnull readonly dereferenceable(48) %_10)
          to label %bb1 unwind label %cleanup

cleanup:                                          ; preds = %start
  %2 = landingpad { ptr, i32 }
          cleanup
; invoke core::ptr::drop_in_place<std::io::Write::write_fmt::Adapter<std::sys::unix::stdio::Stderr>>
  invoke void @"_ZN4core3ptr92drop_in_place$LT$std..io..Write..write_fmt..Adapter$LT$std..sys..unix..stdio..Stderr$GT$$GT$17h531d7fdd7778cbdeE"(ptr noundef nonnull %output) #21
          to label %common.resume unwind label %abort

bb1:                                              ; preds = %start
  call void @llvm.lifetime.end.p0(i64 48, ptr nonnull %_10)
  %3 = load ptr, ptr %output, align 8
  br i1 %1, label %bb12, label %bb11

abort:                                            ; preds = %cleanup
  %4 = landingpad { ptr, i32 }
          cleanup
; call core::panicking::panic_cannot_unwind
  call void @_ZN4core9panicking19panic_cannot_unwind17h42344709dec62f2eE() #23
  unreachable

common.resume:                                    ; preds = %cleanup, %cleanup.i.i.i.i.i.i.i.i
  %common.resume.op = phi { ptr, i32 } [ %11, %cleanup.i.i.i.i.i.i.i.i ], [ %2, %cleanup ]
  resume { ptr, i32 } %common.resume.op

bb12:                                             ; preds = %bb1
  %5 = icmp eq ptr %3, null
  %spec.select = select i1 %5, ptr @alloc68, ptr %3
  br label %bb10

bb10:                                             ; preds = %bb12, %"_ZN4core3ptr68drop_in_place$LT$alloc..boxed..Box$LT$std..io..error..Custom$GT$$GT$17h1f84f0febdcf91a3E.exit.i.i.i.i.i", %bb11
  %.04 = phi ptr [ null, %bb11 ], [ null, %"_ZN4core3ptr68drop_in_place$LT$alloc..boxed..Box$LT$std..io..error..Custom$GT$$GT$17h1f84f0febdcf91a3E.exit.i.i.i.i.i" ], [ %spec.select, %bb12 ]
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %output)
  ret ptr %.04

bb11:                                             ; preds = %bb1
  %6 = icmp ne ptr %3, null
  %_7.cast.i.i.i.i.i = ptrtoint ptr %3 to i64
  %_6.i.i.i.i.i = and i64 %_7.cast.i.i.i.i.i, 3
  %switch.i.i.i.i = icmp eq i64 %_6.i.i.i.i.i, 1
  %or.cond.i = and i1 %6, %switch.i.i.i.i
  br i1 %or.cond.i, label %bb2.i1.i.i.i.i, label %bb10

bb2.i1.i.i.i.i:                                   ; preds = %bb11
  %7 = getelementptr i8, ptr %3, i64 -1
  %8 = icmp ne ptr %7, null
  call void @llvm.assume(i1 %8)
  %_4.0.i.i.i.i.i.i.i.i = load ptr, ptr %7, align 8, !noundef !6
  %9 = getelementptr i8, ptr %3, i64 7
  %_4.1.i.i.i.i.i.i.i.i = load ptr, ptr %9, align 8, !nonnull !6, !align !148, !noundef !6
  %10 = load ptr, ptr %_4.1.i.i.i.i.i.i.i.i, align 8, !invariant.load !6, !nonnull !6
  invoke void %10(ptr noundef %_4.0.i.i.i.i.i.i.i.i)
          to label %bb3.i.i.i.i.i.i.i.i unwind label %cleanup.i.i.i.i.i.i.i.i

cleanup.i.i.i.i.i.i.i.i:                          ; preds = %bb2.i1.i.i.i.i
  %11 = landingpad { ptr, i32 }
          cleanup
  %12 = load ptr, ptr %7, align 8, !nonnull !6, !noundef !6
  %13 = load ptr, ptr %9, align 8, !nonnull !6, !align !148, !noundef !6
  %14 = getelementptr i8, ptr %13, i64 8
  %.val2.i.i.i.i.i.i.i.i = load i64, ptr %14, align 8, !range !149
  %15 = getelementptr i8, ptr %13, i64 16
  %.val3.i.i.i.i.i.i.i.i = load i64, ptr %15, align 8, !range !150
; call alloc::alloc::box_free
  call fastcc void @_ZN5alloc5alloc8box_free17h11e3a3be7aa785f4E(ptr noundef nonnull %12, i64 %.val2.i.i.i.i.i.i.i.i, i64 %.val3.i.i.i.i.i.i.i.i) #21
; call alloc::alloc::box_free
  call fastcc void @_ZN5alloc5alloc8box_free17h78ba79ece75676b2E(ptr noundef nonnull %7) #21
  br label %common.resume

bb3.i.i.i.i.i.i.i.i:                              ; preds = %bb2.i1.i.i.i.i
  %16 = load ptr, ptr %9, align 8, !nonnull !6, !align !148, !noundef !6
  %17 = getelementptr i8, ptr %16, i64 8
  %.val.i.i.i.i.i.i.i.i = load i64, ptr %17, align 8, !range !149
  %18 = icmp eq i64 %.val.i.i.i.i.i.i.i.i, 0
  br i1 %18, label %"_ZN4core3ptr68drop_in_place$LT$alloc..boxed..Box$LT$std..io..error..Custom$GT$$GT$17h1f84f0febdcf91a3E.exit.i.i.i.i.i", label %bb1.i.i.i.i.i.i.i.i.i.i

bb1.i.i.i.i.i.i.i.i.i.i:                          ; preds = %bb3.i.i.i.i.i.i.i.i
  %19 = getelementptr i8, ptr %16, i64 16
  %.val1.i.i.i.i.i.i.i.i = load i64, ptr %19, align 8, !range !150
  %20 = load ptr, ptr %7, align 8, !nonnull !6, !noundef !6
  %_18.i.i.i.i.i.i.i.i.i.i = icmp ult i64 %.val1.i.i.i.i.i.i.i.i, -9223372036854775807
  call void @llvm.assume(i1 %_18.i.i.i.i.i.i.i.i.i.i)
  call void @__rust_dealloc(ptr noundef nonnull %20, i64 noundef %.val.i.i.i.i.i.i.i.i, i64 noundef %.val1.i.i.i.i.i.i.i.i) #24
  br label %"_ZN4core3ptr68drop_in_place$LT$alloc..boxed..Box$LT$std..io..error..Custom$GT$$GT$17h1f84f0febdcf91a3E.exit.i.i.i.i.i"

"_ZN4core3ptr68drop_in_place$LT$alloc..boxed..Box$LT$std..io..error..Custom$GT$$GT$17h1f84f0febdcf91a3E.exit.i.i.i.i.i": ; preds = %bb1.i.i.i.i.i.i.i.i.i.i, %bb3.i.i.i.i.i.i.i.i
  call void @__rust_dealloc(ptr noundef nonnull %7, i64 noundef 24, i64 noundef 8) #24
  br label %bb10
}

; std::rt::lang_start
; Function Attrs: nonlazybind uwtable
define hidden noundef i64 @_ZN3std2rt10lang_start17h43188a59ef38aa5cE(ptr noundef nonnull %main, i64 noundef %argc, ptr noundef %argv, i8 noundef %sigpipe) unnamed_addr #1 {
start:
  %_9 = alloca ptr, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %_9)
  store ptr %main, ptr %_9, align 8
; call std::rt::lang_start_internal
  %0 = call noundef i64 @_ZN3std2rt19lang_start_internal17hca9d5c7277f5b67cE(ptr noundef nonnull align 1 %_9, ptr noalias noundef nonnull readonly align 8 dereferenceable(24) @vtable.1, i64 noundef %argc, ptr noundef %argv, i8 noundef %sigpipe)
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %_9)
  ret i64 %0
}

; std::rt::lang_start::{{closure}}
; Function Attrs: inlinehint nonlazybind uwtable
define internal noundef i32 @"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h657bb9ea592f471eE"(ptr noalias nocapture noundef readonly align 8 dereferenceable(8) %_1) unnamed_addr #2 {
start:
  %_4 = load ptr, ptr %_1, align 8, !nonnull !6, !noundef !6
; call std::sys_common::backtrace::__rust_begin_short_backtrace
  tail call fastcc void @_ZN3std10sys_common9backtrace28__rust_begin_short_backtrace17h7613cc2ef156ad16E(ptr noundef nonnull %_4)
  ret i32 0
}

; std::thread::JoinHandle<T>::join
; Function Attrs: nonlazybind uwtable
define internal fastcc { ptr, ptr } @"_ZN3std6thread19JoinHandle$LT$T$GT$4join17h83d2a16c943a4e2bE"(ptr noalias nocapture noundef readonly dereferenceable(24) %self) unnamed_addr #1 personality ptr @rust_eh_personality {
start:
  %_2 = alloca %"std::thread::JoinInner<'_, ()>", align 8
  call void @llvm.lifetime.start.p0(i64 24, ptr nonnull %_2)
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %_2, ptr noundef nonnull align 8 dereferenceable(24) %self, i64 24, i1 false)
  tail call void @llvm.experimental.noalias.scope.decl(metadata !151)
  %_3.i = load i64, ptr %_2, align 8, !alias.scope !151, !noundef !6
; invoke std::sys::unix::thread::Thread::join
  invoke void @_ZN3std3sys4unix6thread6Thread4join17h4f6592b9a2ad4cc5E(i64 noundef %_3.i)
          to label %bb1.i unwind label %cleanup.i, !noalias !151

cleanup.i:                                        ; preds = %bb9.invoke.i, %start
  %0 = landingpad { ptr, i32 }
          cleanup
  %1 = getelementptr inbounds %"std::thread::JoinInner<'_, ()>", ptr %_2, i64 0, i32 1
; call core::ptr::drop_in_place<std::thread::Thread>
  call fastcc void @"_ZN4core3ptr40drop_in_place$LT$std..thread..Thread$GT$17h315a208f60640622E"(ptr noundef nonnull %1) #21
  %2 = getelementptr inbounds %"std::thread::JoinInner<'_, ()>", ptr %_2, i64 0, i32 2
; invoke core::ptr::drop_in_place<alloc::sync::Arc<std::thread::Packet<()>>>
  invoke fastcc void @"_ZN4core3ptr80drop_in_place$LT$alloc..sync..Arc$LT$std..thread..Packet$LT$$LP$$RP$$GT$$GT$$GT$17hdac63bca8591c1a9E"(ptr noundef nonnull %2) #21
          to label %bb3.i unwind label %abort.i

bb1.i:                                            ; preds = %start
  %_11.i = getelementptr inbounds %"std::thread::JoinInner<'_, ()>", ptr %_2, i64 0, i32 2
  tail call void @llvm.experimental.noalias.scope.decl(metadata !154)
  tail call void @llvm.experimental.noalias.scope.decl(metadata !157)
  %self1.i.i.i = load ptr, ptr %_11.i, align 8, !alias.scope !160, !nonnull !6, !noundef !6
  %self2.i.i.i = getelementptr inbounds %"alloc::sync::ArcInner<std::thread::Packet<'_, ()>>", ptr %self1.i.i.i, i64 0, i32 1
  %3 = cmpxchg ptr %self2.i.i.i, i64 1, i64 -1 acquire monotonic, align 8, !noalias !160
  %4 = extractvalue { i64, i1 } %3, 1
  br i1 %4, label %"_ZN5alloc4sync12Arc$LT$T$GT$9is_unique17hc77ea7ed85afcc04E.exit.i.i", label %bb9.invoke.i

"_ZN5alloc4sync12Arc$LT$T$GT$9is_unique17hc77ea7ed85afcc04E.exit.i.i": ; preds = %bb1.i
  %self3.i.i.i = load ptr, ptr %_11.i, align 8, !alias.scope !160, !nonnull !6
  %5 = load atomic i64, ptr %self3.i.i.i acquire, align 8, !noalias !160
  %.fr.i.i = freeze i64 %5
  %unique.i.i.i = icmp eq i64 %.fr.i.i, 1
  %self5.i.i.i = getelementptr inbounds %"alloc::sync::ArcInner<std::thread::Packet<'_, ()>>", ptr %self3.i.i.i, i64 0, i32 1
  store atomic i64 1, ptr %self5.i.i.i release, align 8, !noalias !160
  br i1 %unique.i.i.i, label %bb12.i, label %bb9.invoke.i

bb9.invoke.i:                                     ; preds = %bb12.i, %"_ZN5alloc4sync12Arc$LT$T$GT$9is_unique17hc77ea7ed85afcc04E.exit.i.i", %bb1.i
  %6 = phi ptr [ @alloc286, %bb1.i ], [ @alloc286, %"_ZN5alloc4sync12Arc$LT$T$GT$9is_unique17hc77ea7ed85afcc04E.exit.i.i" ], [ @alloc283, %bb12.i ]
; invoke core::panicking::panic
  invoke void @_ZN4core9panicking5panic17h90931f06a97cc5e0E(ptr noalias noundef nonnull readonly align 1 @alloc284, i64 noundef 43, ptr noalias noundef nonnull readonly align 8 dereferenceable(24) %6) #22
          to label %bb9.cont.i unwind label %cleanup.i, !noalias !151

bb9.cont.i:                                       ; preds = %bb9.invoke.i
  unreachable

bb12.i:                                           ; preds = %"_ZN5alloc4sync12Arc$LT$T$GT$9is_unique17hc77ea7ed85afcc04E.exit.i.i"
  %self.i.i = load ptr, ptr %_11.i, align 8, !alias.scope !161
  %self3.i = getelementptr inbounds %"alloc::sync::ArcInner<std::thread::Packet<'_, ()>>", ptr %self.i.i, i64 0, i32 2, i32 2
  tail call void @llvm.experimental.noalias.scope.decl(metadata !162)
  tail call void @llvm.experimental.noalias.scope.decl(metadata !165)
  %self1.sroa.0.0.copyload.i = load i64, ptr %self3.i, align 8, !alias.scope !167, !noalias !169
  %self1.sroa.4.0.self3.sroa_idx.i = getelementptr inbounds %"alloc::sync::ArcInner<std::thread::Packet<'_, ()>>", ptr %self.i.i, i64 0, i32 2, i32 2, i32 0, i32 1
  %self1.sroa.4.0.copyload.i = load ptr, ptr %self1.sroa.4.0.self3.sroa_idx.i, align 8, !alias.scope !167, !noalias !169
  %self1.sroa.5.0.self3.sroa_idx.i = getelementptr inbounds %"alloc::sync::ArcInner<std::thread::Packet<'_, ()>>", ptr %self.i.i, i64 0, i32 2, i32 2, i32 0, i32 1, i64 1
  %self1.sroa.5.0.copyload.i = load ptr, ptr %self1.sroa.5.0.self3.sroa_idx.i, align 8, !alias.scope !167, !noalias !169
  store i64 0, ptr %self3.i, align 8, !alias.scope !170, !noalias !171
  %trunc.not.i = icmp eq i64 %self1.sroa.0.0.copyload.i, 0
  br i1 %trunc.not.i, label %bb9.invoke.i, label %bb15.i

bb15.i:                                           ; preds = %bb12.i
  %7 = getelementptr inbounds %"std::thread::JoinInner<'_, ()>", ptr %_2, i64 0, i32 1
  tail call void @llvm.experimental.noalias.scope.decl(metadata !172)
  %self1.i.i.i.i.i = load ptr, ptr %7, align 8, !alias.scope !175, !nonnull !6, !noundef !6
  %8 = atomicrmw sub ptr %self1.i.i.i.i.i, i64 1 release, align 8, !noalias !175
  %9 = icmp eq i64 %8, 1
  br i1 %9, label %bb2.i.i.i.i.i, label %bb6.i

bb2.i.i.i.i.i:                                    ; preds = %bb15.i
  fence acquire
  %self.val.i.i.i.i.i = load ptr, ptr %7, align 8, !alias.scope !175, !nonnull !6
; call alloc::sync::Arc<T>::drop_slow
  tail call fastcc void @"_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17he68302373675f7f4E"(ptr nonnull %self.val.i.i.i.i.i), !noalias !175
  br label %bb6.i

bb6.i:                                            ; preds = %bb2.i.i.i.i.i, %bb15.i
  tail call void @llvm.experimental.noalias.scope.decl(metadata !176)
  %self1.i.i6.i = load ptr, ptr %_11.i, align 8, !alias.scope !179, !nonnull !6, !noundef !6
  %10 = atomicrmw sub ptr %self1.i.i6.i, i64 1 release, align 8, !noalias !179
  %11 = icmp eq i64 %10, 1
  br i1 %11, label %bb2.i.i.i, label %"_ZN3std6thread18JoinInner$LT$T$GT$4join17h16e58e602d341610E.exit"

bb2.i.i.i:                                        ; preds = %bb6.i
  fence acquire
  %self.val.i.i.i = load ptr, ptr %_11.i, align 8, !alias.scope !179, !nonnull !6
; call alloc::sync::Arc<T>::drop_slow
  tail call fastcc void @"_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17hbaf97c6b34ae9334E"(ptr nonnull %self.val.i.i.i), !noalias !179
  br label %"_ZN3std6thread18JoinInner$LT$T$GT$4join17h16e58e602d341610E.exit"

abort.i:                                          ; preds = %cleanup.i
  %12 = landingpad { ptr, i32 }
          cleanup
; call core::panicking::panic_cannot_unwind
  tail call void @_ZN4core9panicking19panic_cannot_unwind17h42344709dec62f2eE() #23, !noalias !151
  unreachable

bb3.i:                                            ; preds = %cleanup.i
  resume { ptr, i32 } %0

"_ZN3std6thread18JoinInner$LT$T$GT$4join17h16e58e602d341610E.exit": ; preds = %bb6.i, %bb2.i.i.i
  %13 = insertvalue { ptr, ptr } undef, ptr %self1.sroa.4.0.copyload.i, 0
  %14 = insertvalue { ptr, ptr } %13, ptr %self1.sroa.5.0.copyload.i, 1
  call void @llvm.lifetime.end.p0(i64 24, ptr nonnull %_2)
  ret { ptr, ptr } %14
}

; <&T as core::fmt::Display>::fmt
; Function Attrs: nonlazybind uwtable
define internal noundef zeroext i1 @"_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17he2740909977511a8E"(ptr noalias nocapture noundef readonly align 8 dereferenceable(16) %self, ptr noalias noundef align 8 dereferenceable(64) %f) unnamed_addr #1 {
start:
  %_6.0 = load ptr, ptr %self, align 8, !nonnull !6, !align !180, !noundef !6
  %0 = getelementptr inbounds { ptr, i64 }, ptr %self, i64 0, i32 1
  %_6.1 = load i64, ptr %0, align 8, !noundef !6
; call <str as core::fmt::Display>::fmt
  %1 = tail call noundef zeroext i1 @"_ZN42_$LT$str$u20$as$u20$core..fmt..Display$GT$3fmt17h592dabb109171ad2E"(ptr noalias noundef nonnull readonly align 1 %_6.0, i64 noundef %_6.1, ptr noalias noundef nonnull align 8 dereferenceable(64) %f)
  ret i1 %1
}

; core::fmt::Write::write_char
; Function Attrs: nonlazybind uwtable
define internal noundef zeroext i1 @_ZN4core3fmt5Write10write_char17h208b4aa1c8599cdeE(ptr noalias nocapture noundef align 8 dereferenceable(16) %self, i32 noundef %c) unnamed_addr #1 {
start:
  %_10 = alloca [4 x i8], align 4
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %_10)
  store i32 0, ptr %_10, align 4
  %_2.i.i = icmp ult i32 %c, 128
  br i1 %_2.i.i, label %bb7.i, label %bb2.i.i

bb2.i.i:                                          ; preds = %start
  %_4.i.i = icmp ult i32 %c, 2048
  br i1 %_4.i.i, label %bb8.i, label %bb4.i.i

bb4.i.i:                                          ; preds = %bb2.i.i
  %_6.i.i = icmp ult i32 %c, 65536
  %b2.i = getelementptr inbounds [0 x i8], ptr %_10, i64 0, i64 1
  %c3.i = getelementptr inbounds [0 x i8], ptr %_10, i64 0, i64 2
  br i1 %_6.i.i, label %bb9.i, label %bb10.i

bb10.i:                                           ; preds = %bb4.i.i
  %d.i = getelementptr inbounds [0 x i8], ptr %_10, i64 0, i64 3
  %_55.i = lshr i32 %c, 18
  %0 = trunc i32 %_55.i to i8
  %_53.i = and i8 %0, 7
  %1 = or i8 %_53.i, -16
  store i8 %1, ptr %_10, align 4, !alias.scope !181
  %_59.i = lshr i32 %c, 12
  %2 = trunc i32 %_59.i to i8
  %_57.i = and i8 %2, 63
  %3 = or i8 %_57.i, -128
  store i8 %3, ptr %b2.i, align 1, !alias.scope !181
  %_63.i = lshr i32 %c, 6
  %4 = trunc i32 %_63.i to i8
  %_61.i = and i8 %4, 63
  %5 = or i8 %_61.i, -128
  store i8 %5, ptr %c3.i, align 2, !alias.scope !181
  %6 = trunc i32 %c to i8
  %_65.i = and i8 %6, 63
  %7 = or i8 %_65.i, -128
  store i8 %7, ptr %d.i, align 1, !alias.scope !181
  br label %_ZN4core4char7methods15encode_utf8_raw17h25b1f82ed72141b2E.exit

bb9.i:                                            ; preds = %bb4.i.i
  %_40.i = lshr i32 %c, 12
  %8 = trunc i32 %_40.i to i8
  %9 = or i8 %8, -32
  store i8 %9, ptr %_10, align 4, !alias.scope !181
  %_44.i = lshr i32 %c, 6
  %10 = trunc i32 %_44.i to i8
  %_42.i = and i8 %10, 63
  %11 = or i8 %_42.i, -128
  store i8 %11, ptr %b2.i, align 1, !alias.scope !181
  %12 = trunc i32 %c to i8
  %_46.i = and i8 %12, 63
  %13 = or i8 %_46.i, -128
  store i8 %13, ptr %c3.i, align 2, !alias.scope !181
  br label %_ZN4core4char7methods15encode_utf8_raw17h25b1f82ed72141b2E.exit

bb8.i:                                            ; preds = %bb2.i.i
  %b5.i = getelementptr inbounds [0 x i8], ptr %_10, i64 0, i64 1
  %_30.i = lshr i32 %c, 6
  %14 = trunc i32 %_30.i to i8
  %15 = or i8 %14, -64
  store i8 %15, ptr %_10, align 4, !alias.scope !181
  %16 = trunc i32 %c to i8
  %_32.i = and i8 %16, 63
  %17 = or i8 %_32.i, -128
  store i8 %17, ptr %b5.i, align 1, !alias.scope !181
  br label %_ZN4core4char7methods15encode_utf8_raw17h25b1f82ed72141b2E.exit

bb7.i:                                            ; preds = %start
  %18 = trunc i32 %c to i8
  store i8 %18, ptr %_10, align 4, !alias.scope !181
  br label %_ZN4core4char7methods15encode_utf8_raw17h25b1f82ed72141b2E.exit

_ZN4core4char7methods15encode_utf8_raw17h25b1f82ed72141b2E.exit: ; preds = %bb10.i, %bb9.i, %bb8.i, %bb7.i
  %.0.i3.i = phi i64 [ 1, %bb7.i ], [ 2, %bb8.i ], [ 3, %bb9.i ], [ 4, %bb10.i ]
; call <std::io::Write::write_fmt::Adapter<T> as core::fmt::Write>::write_str
  %19 = call noundef zeroext i1 @"_ZN80_$LT$std..io..Write..write_fmt..Adapter$LT$T$GT$$u20$as$u20$core..fmt..Write$GT$9write_str17h93a9f8277eec1af4E"(ptr noalias noundef nonnull align 8 dereferenceable(16) %self, ptr noalias noundef nonnull readonly align 1 %_10, i64 noundef %.0.i3.i)
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %_10)
  ret i1 %19
}

; core::fmt::Write::write_fmt
; Function Attrs: nonlazybind uwtable
define internal noundef zeroext i1 @_ZN4core3fmt5Write9write_fmt17h62df01c67385dd35E(ptr noalias noundef align 8 dereferenceable(16) %0, ptr noalias nocapture noundef readonly dereferenceable(48) %args) unnamed_addr #1 {
start:
  %_6 = alloca %"core::fmt::Arguments<'_>", align 8
  %self = alloca ptr, align 8
  store ptr %0, ptr %self, align 8
  call void @llvm.lifetime.start.p0(i64 48, ptr nonnull %_6)
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(48) %_6, ptr noundef nonnull align 8 dereferenceable(48) %args, i64 48, i1 false)
; call core::fmt::write
  %1 = call noundef zeroext i1 @_ZN4core3fmt5write17h93e2f5923c7eca08E(ptr noundef nonnull align 1 %self, ptr noalias noundef nonnull readonly align 8 dereferenceable(24) @vtable.3, ptr noalias nocapture noundef nonnull readonly dereferenceable(48) %_6)
  call void @llvm.lifetime.end.p0(i64 48, ptr nonnull %_6)
  ret i1 %1
}

; core::ops::function::FnOnce::call_once{{vtable.shim}}
; Function Attrs: inlinehint nonlazybind uwtable
define internal void @"_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17ha38577f055a33e7bE"(ptr noundef %_1) unnamed_addr #2 personality ptr @rust_eh_personality {
start:
  %_2.i.i.i.i.i.i = alloca %"[closure@src/main.rs:14:19: 14:26]", align 16
  %_13.i = alloca %"core::option::Option<core::ops::range::Range<usize>>", align 8
  %f.i = alloca %"[closure@src/main.rs:14:19: 14:26]", align 16
  tail call void @llvm.experimental.noalias.scope.decl(metadata !184)
  %_3.i = getelementptr inbounds %"[closure@std::thread::Builder::spawn_unchecked_<'_, '_, [closure@src/main.rs:14:19: 14:26], ()>::{closure#1}]", ptr %_1, i64 0, i32 2
; invoke std::thread::Thread::cname
  %0 = invoke { ptr, i64 } @_ZN3std6thread6Thread5cname17hda75f9288f08d76eE(ptr noalias noundef nonnull readonly align 8 dereferenceable(8) %_3.i)
          to label %bb1.i unwind label %bb22.i

bb24.i:                                           ; preds = %bb15.i
  br i1 %.not.i, label %bb18.i, label %bb19.i

bb1.i:                                            ; preds = %start
  %.fca.0.extract.i = extractvalue { ptr, i64 } %0, 0
  %.not11.i = icmp eq ptr %.fca.0.extract.i, null
  br i1 %.not11.i, label %bb4.i, label %bb2.i

bb2.i:                                            ; preds = %bb1.i
  %.fca.1.extract.i = extractvalue { ptr, i64 } %0, 1
; invoke std::sys::unix::thread::Thread::set_name
  invoke void @_ZN3std3sys4unix6thread6Thread8set_name17hb09a5e4dd2a2bb8bE(ptr noalias noundef nonnull readonly align 1 %.fca.0.extract.i, i64 noundef %.fca.1.extract.i)
          to label %bb4.i unwind label %bb22.i

bb4.i:                                            ; preds = %bb2.i, %bb1.i
  %_9.i = load ptr, ptr %_1, align 8, !alias.scope !184, !noundef !6
; invoke std::io::stdio::set_output_capture
  %1 = invoke noundef ptr @_ZN3std2io5stdio18set_output_capture17h650a707a873ed88aE(ptr noundef %_9.i)
          to label %bb5.i unwind label %bb23.i

bb5.i:                                            ; preds = %bb4.i
  %2 = icmp eq ptr %1, null
  br i1 %2, label %bb7.i, label %bb2.i.i

bb2.i.i:                                          ; preds = %bb5.i
  %3 = atomicrmw sub ptr %1, i64 1 release, align 8, !noalias !187
  %4 = icmp eq i64 %3, 1
  br i1 %4, label %bb2.i.i.i.i, label %bb7.i

bb2.i.i.i.i:                                      ; preds = %bb2.i.i
  fence acquire
; call alloc::sync::Arc<T>::drop_slow
  tail call fastcc void @"_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17h9988cc5f56f4cc91E"(ptr nonnull %1), !noalias !187
  br label %bb7.i

bb7.i:                                            ; preds = %bb2.i.i.i.i, %bb2.i.i, %bb5.i
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %f.i), !noalias !184
  %5 = getelementptr inbounds %"[closure@std::thread::Builder::spawn_unchecked_<'_, '_, [closure@src/main.rs:14:19: 14:26], ()>::{closure#1}]", ptr %_1, i64 0, i32 1
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 16 dereferenceable(56) %f.i, ptr noundef nonnull align 8 dereferenceable(56) %5, i64 56, i1 false)
  call void @llvm.lifetime.start.p0(i64 24, ptr nonnull %_13.i), !noalias !184
; invoke std::sys::unix::thread::guard::current
  invoke void @_ZN3std3sys4unix6thread5guard7current17h1572b420dcf422b7E(ptr noalias nocapture noundef nonnull sret(%"core::option::Option<core::ops::range::Range<usize>>") dereferenceable(24) %_13.i)
          to label %bb8.i unwind label %bb15.i

bb8.i:                                            ; preds = %bb7.i
  %_14.i = load ptr, ptr %_3.i, align 8, !alias.scope !184, !nonnull !6, !noundef !6
; invoke std::sys_common::thread_info::set
  invoke void @_ZN3std10sys_common11thread_info3set17hb7f1222b70b29532E(ptr noalias nocapture noundef nonnull readonly dereferenceable(24) %_13.i, ptr noundef nonnull %_14.i)
          to label %bb9.i unwind label %bb15.i

bb9.i:                                            ; preds = %bb8.i
  call void @llvm.lifetime.end.p0(i64 24, ptr nonnull %_13.i), !noalias !184
  %_17.sroa.0.sroa.5.0.f.sroa_idx.i = getelementptr inbounds i8, ptr %f.i, i64 16
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %_2.i.i.i.i.i.i), !noalias !190
  %6 = load <2 x ptr>, ptr %f.i, align 16, !noalias !184
  store <2 x ptr> %6, ptr %_2.i.i.i.i.i.i, align 16, !noalias !199
  %data.sroa.8.0._2.i.i.i.sroa_idx.i.i.i = getelementptr inbounds i8, ptr %_2.i.i.i.i.i.i, i64 16
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 16 dereferenceable(40) %data.sroa.8.0._2.i.i.i.sroa_idx.i.i.i, ptr noundef nonnull align 16 dereferenceable(40) %_17.sroa.0.sroa.5.0.f.sroa_idx.i, i64 40, i1 false), !noalias !184
; invoke std::sys_common::backtrace::__rust_begin_short_backtrace
  invoke fastcc void @_ZN3std10sys_common9backtrace28__rust_begin_short_backtrace17h2a014bada774ce73E(ptr noalias nocapture noundef nonnull dereferenceable(56) %_2.i.i.i.i.i.i)
          to label %13 unwind label %7, !noalias !200

7:                                                ; preds = %bb9.i
  %8 = landingpad { ptr, i32 }
          cleanup
          catch ptr null
  %9 = extractvalue { ptr, i32 } %8, 0
; invoke std::panicking::try::cleanup
  %10 = invoke { ptr, ptr } @_ZN3std9panicking3try7cleanup17h41c2fc1c7a2c52faE(ptr noundef %9)
          to label %.noexc.i unwind label %bb17.i

.noexc.i:                                         ; preds = %7
  %obj.0.i.i.i.i = extractvalue { ptr, ptr } %10, 0
  %obj.1.i.i.i.i = extractvalue { ptr, ptr } %10, 1
  %11 = icmp ne ptr %obj.0.i.i.i.i, null
  tail call void @llvm.assume(i1 %11)
  %12 = icmp ne ptr %obj.1.i.i.i.i, null
  tail call void @llvm.assume(i1 %12)
  br label %bb10.i

13:                                               ; preds = %bb9.i
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %_2.i.i.i.i.i.i), !noalias !190
  br label %bb10.i

bb10.i:                                           ; preds = %13, %.noexc.i
  %14 = phi ptr [ undef, %13 ], [ %obj.1.i.i.i.i, %.noexc.i ]
  %15 = phi ptr [ null, %13 ], [ %obj.0.i.i.i.i, %.noexc.i ]
  %self.i = getelementptr inbounds %"[closure@std::thread::Builder::spawn_unchecked_<'_, '_, [closure@src/main.rs:14:19: 14:26], ()>::{closure#1}]", ptr %_1, i64 0, i32 3
  %self2.i = load ptr, ptr %self.i, align 8, !alias.scope !184, !nonnull !6, !noundef !6
  %self3.i = getelementptr inbounds %"alloc::sync::ArcInner<std::thread::Packet<'_, ()>>", ptr %self2.i, i64 0, i32 2, i32 2
  %_2.i.i = load i64, ptr %self3.i, align 8, !range !201, !noundef !6
  %16 = icmp eq i64 %_2.i.i, 0
  br i1 %16, label %bb13.i, label %bb2.i14.i

bb2.i14.i:                                        ; preds = %bb10.i
  %17 = getelementptr inbounds %"alloc::sync::ArcInner<std::thread::Packet<'_, ()>>", ptr %self2.i, i64 0, i32 2, i32 2, i32 0, i32 1
  %18 = load ptr, ptr %17, align 8, !noundef !6
  %19 = icmp eq ptr %18, null
  br i1 %19, label %bb13.i, label %bb2.i.i.i

bb2.i.i.i:                                        ; preds = %bb2.i14.i
  %20 = getelementptr inbounds %"alloc::sync::ArcInner<std::thread::Packet<'_, ()>>", ptr %self2.i, i64 0, i32 2, i32 2, i32 0, i32 1, i64 1
  %_4.1.i.i.i.i = load ptr, ptr %20, align 8, !nonnull !6, !align !148, !noundef !6
  %21 = load ptr, ptr %_4.1.i.i.i.i, align 8, !invariant.load !6, !nonnull !6
  invoke void %21(ptr noundef nonnull %18)
          to label %bb3.i.i.i.i unwind label %cleanup.i.i.i.i

cleanup.i.i.i.i:                                  ; preds = %bb2.i.i.i
  %22 = landingpad { ptr, i32 }
          cleanup
  %23 = load ptr, ptr %17, align 8, !nonnull !6, !noundef !6
  %24 = load ptr, ptr %20, align 8, !nonnull !6, !align !148, !noundef !6
  %25 = getelementptr i8, ptr %24, i64 8
  %.val2.i.i.i.i = load i64, ptr %25, align 8, !range !149
  %26 = getelementptr i8, ptr %24, i64 16
  %.val3.i.i.i.i = load i64, ptr %26, align 8, !range !150
; call alloc::alloc::box_free
  tail call fastcc void @_ZN5alloc5alloc8box_free17h11e3a3be7aa785f4E(ptr noundef nonnull %23, i64 %.val2.i.i.i.i, i64 %.val3.i.i.i.i) #21
  store i64 1, ptr %self3.i, align 8
  store ptr %15, ptr %17, align 8
  store ptr %14, ptr %20, align 8
  br label %bb18.i

bb3.i.i.i.i:                                      ; preds = %bb2.i.i.i
  %27 = load ptr, ptr %20, align 8, !nonnull !6, !align !148, !noundef !6
  %28 = getelementptr i8, ptr %27, i64 8
  %.val.i.i.i.i = load i64, ptr %28, align 8, !range !149
  %29 = icmp eq i64 %.val.i.i.i.i, 0
  br i1 %29, label %bb13.i, label %bb1.i.i.i.i.i.i

bb1.i.i.i.i.i.i:                                  ; preds = %bb3.i.i.i.i
  %30 = getelementptr i8, ptr %27, i64 16
  %.val1.i.i.i.i = load i64, ptr %30, align 8, !range !150
  %31 = load ptr, ptr %17, align 8, !nonnull !6, !noundef !6
  %_18.i.i.i.i.i.i = icmp ult i64 %.val1.i.i.i.i, -9223372036854775807
  tail call void @llvm.assume(i1 %_18.i.i.i.i.i.i)
  tail call void @__rust_dealloc(ptr noundef nonnull %31, i64 noundef %.val.i.i.i.i, i64 noundef %.val1.i.i.i.i) #24
  br label %bb13.i

bb13.i:                                           ; preds = %bb1.i.i.i.i.i.i, %bb3.i.i.i.i, %bb2.i14.i, %bb10.i
  store i64 1, ptr %self3.i, align 8
  %_18.sroa.5.0.self3.sroa_idx6.i = getelementptr inbounds %"alloc::sync::ArcInner<std::thread::Packet<'_, ()>>", ptr %self2.i, i64 0, i32 2, i32 2, i32 0, i32 1
  store ptr %15, ptr %_18.sroa.5.0.self3.sroa_idx6.i, align 8
  %_18.sroa.6.0.self3.sroa_idx8.i = getelementptr inbounds %"alloc::sync::ArcInner<std::thread::Packet<'_, ()>>", ptr %self2.i, i64 0, i32 2, i32 2, i32 0, i32 1, i64 1
  store ptr %14, ptr %_18.sroa.6.0.self3.sroa_idx8.i, align 8
  %32 = load ptr, ptr %self.i, align 8, !alias.scope !184, !nonnull !6, !noundef !6
  %33 = atomicrmw sub ptr %32, i64 1 release, align 8, !noalias !202
  %34 = icmp eq i64 %33, 1
  br i1 %34, label %bb2.i.i15.i, label %"_ZN3std6thread7Builder16spawn_unchecked_28_$u7b$$u7b$closure$u7d$$u7d$17h94a26f3067fe8a1dE.exit"

bb2.i.i15.i:                                      ; preds = %bb13.i
  fence acquire
; call alloc::sync::Arc<T>::drop_slow
  tail call fastcc void @"_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17hbaf97c6b34ae9334E"(ptr nonnull %32)
  br label %"_ZN3std6thread7Builder16spawn_unchecked_28_$u7b$$u7b$closure$u7d$$u7d$17h94a26f3067fe8a1dE.exit"

abort.i:                                          ; preds = %bb18.i, %bb15.i
  %35 = landingpad { ptr, i32 }
          cleanup
; call core::panicking::panic_cannot_unwind
  tail call void @_ZN4core9panicking19panic_cannot_unwind17h42344709dec62f2eE() #23
  unreachable

bb15.i:                                           ; preds = %bb8.i, %bb7.i
  %.not.i = phi i1 [ true, %bb8.i ], [ false, %bb7.i ]
  %lpad.thr_comm.i = landingpad { ptr, i32 }
          cleanup
; invoke core::ptr::drop_in_place<demo::spawn_user_query::{{closure}}>
  invoke fastcc void @"_ZN4core3ptr72drop_in_place$LT$demo..spawn_user_query..$u7b$$u7b$closure$u7d$$u7d$$GT$17h3fc0c80003884286E"(ptr noundef nonnull %f.i) #21
          to label %bb24.i unwind label %abort.i

bb23.i:                                           ; preds = %bb4.i
  %lpad.thr_comm.split-lp75.i = landingpad { ptr, i32 }
          cleanup
; call core::ptr::drop_in_place<std::thread::Thread>
  tail call fastcc void @"_ZN4core3ptr40drop_in_place$LT$std..thread..Thread$GT$17h315a208f60640622E"(ptr noundef nonnull %_3.i) #21
  br label %bb20.i

bb19.i:                                           ; preds = %bb24.i
; call core::ptr::drop_in_place<std::thread::Thread>
  tail call fastcc void @"_ZN4core3ptr40drop_in_place$LT$std..thread..Thread$GT$17h315a208f60640622E"(ptr noundef nonnull %_3.i) #21
  br label %bb18.i

bb22.i:                                           ; preds = %bb2.i, %start
  %lpad.thr_comm74.i = landingpad { ptr, i32 }
          cleanup
; call core::ptr::drop_in_place<std::thread::Thread>
  tail call fastcc void @"_ZN4core3ptr40drop_in_place$LT$std..thread..Thread$GT$17h315a208f60640622E"(ptr noundef nonnull %_3.i) #21
; call core::ptr::drop_in_place<core::option::Option<alloc::sync::Arc<std::sync::mutex::Mutex<alloc::vec::Vec<u8>>>>>
  tail call fastcc void @"_ZN4core3ptr129drop_in_place$LT$core..option..Option$LT$alloc..sync..Arc$LT$std..sync..mutex..Mutex$LT$alloc..vec..Vec$LT$u8$GT$$GT$$GT$$GT$$GT$17h248c6a7ad92731ebE"(ptr noundef nonnull %_1) #21
  br label %bb20.i

bb17.i:                                           ; preds = %7
  %lpad.thr_comm.split-lp.i = landingpad { ptr, i32 }
          cleanup
  br label %bb18.i

bb20.i:                                           ; preds = %bb22.i, %bb23.i
  %.pn.pn2972.ph.i = phi { ptr, i32 } [ %lpad.thr_comm.split-lp75.i, %bb23.i ], [ %lpad.thr_comm74.i, %bb22.i ]
  %36 = getelementptr inbounds %"[closure@std::thread::Builder::spawn_unchecked_<'_, '_, [closure@src/main.rs:14:19: 14:26], ()>::{closure#1}]", ptr %_1, i64 0, i32 1
; call core::ptr::drop_in_place<std::thread::Builder::spawn_unchecked_::MaybeDangling<demo::spawn_user_query::{{closure}}>>
  tail call fastcc void @"_ZN4core3ptr133drop_in_place$LT$std..thread..Builder..spawn_unchecked_..MaybeDangling$LT$demo..spawn_user_query..$u7b$$u7b$closure$u7d$$u7d$$GT$$GT$17h10021b299e043f37E"(ptr noundef nonnull %36) #21
  br label %bb18.i

bb11.i:                                           ; preds = %bb18.i
  resume { ptr, i32 } %.pn.pn30475467.i

bb18.i:                                           ; preds = %bb20.i, %bb17.i, %bb19.i, %cleanup.i.i.i.i, %bb24.i
  %.pn.pn30475467.i = phi { ptr, i32 } [ %22, %cleanup.i.i.i.i ], [ %lpad.thr_comm.split-lp.i, %bb17.i ], [ %lpad.thr_comm.i, %bb24.i ], [ %lpad.thr_comm.i, %bb19.i ], [ %.pn.pn2972.ph.i, %bb20.i ]
  %37 = getelementptr inbounds %"[closure@std::thread::Builder::spawn_unchecked_<'_, '_, [closure@src/main.rs:14:19: 14:26], ()>::{closure#1}]", ptr %_1, i64 0, i32 3
; invoke core::ptr::drop_in_place<alloc::sync::Arc<std::thread::Packet<()>>>
  invoke fastcc void @"_ZN4core3ptr80drop_in_place$LT$alloc..sync..Arc$LT$std..thread..Packet$LT$$LP$$RP$$GT$$GT$$GT$17hdac63bca8591c1a9E"(ptr noundef nonnull %37) #21
          to label %bb11.i unwind label %abort.i

"_ZN3std6thread7Builder16spawn_unchecked_28_$u7b$$u7b$closure$u7d$$u7d$17h94a26f3067fe8a1dE.exit": ; preds = %bb13.i, %bb2.i.i15.i
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %f.i), !noalias !184
  ret void
}

; core::ops::function::FnOnce::call_once{{vtable.shim}}
; Function Attrs: inlinehint nonlazybind uwtable
define internal noundef i32 @"_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17hb062ed2bce5707a7E"(ptr nocapture noundef readonly %_1) unnamed_addr #2 personality ptr @rust_eh_personality {
start:
  %0 = load ptr, ptr %_1, align 8, !nonnull !6, !noundef !6
; call std::sys_common::backtrace::__rust_begin_short_backtrace
  tail call fastcc void @_ZN3std10sys_common9backtrace28__rust_begin_short_backtrace17h7613cc2ef156ad16E(ptr noundef nonnull %0), !noalias !205
  ret i32 0
}

; core::ptr::drop_in_place<core::option::Option<alloc::sync::Arc<std::thread::scoped::ScopeData>>>
; Function Attrs: nounwind nonlazybind uwtable
define internal fastcc void @"_ZN4core3ptr103drop_in_place$LT$core..option..Option$LT$alloc..sync..Arc$LT$std..thread..scoped..ScopeData$GT$$GT$$GT$17h7cc4bee20b845956E"(ptr nocapture noundef readonly %_1) unnamed_addr #3 {
start:
  %0 = load ptr, ptr %_1, align 8, !noundef !6
  %1 = icmp eq ptr %0, null
  br i1 %1, label %bb1, label %bb2

bb1:                                              ; preds = %bb2.i.i, %bb2, %start
  ret void

bb2:                                              ; preds = %start
  tail call void @llvm.experimental.noalias.scope.decl(metadata !208)
  %2 = atomicrmw sub ptr %0, i64 1 release, align 8, !noalias !208
  %3 = icmp eq i64 %2, 1
  br i1 %3, label %bb2.i.i, label %bb1

bb2.i.i:                                          ; preds = %bb2
  fence acquire
  %self.val.i.i = load ptr, ptr %_1, align 8, !alias.scope !208, !nonnull !6
; call alloc::sync::Arc<T>::drop_slow
  tail call fastcc void @"_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17hf7031fc3d45c20a4E"(ptr nonnull %self.val.i.i), !noalias !208
  br label %bb1
}

; core::ptr::drop_in_place<&mut std::io::Write::write_fmt::Adapter<std::sys::unix::stdio::Stderr>>
; Function Attrs: inlinehint mustprogress nofree norecurse nosync nounwind nonlazybind readnone willreturn uwtable
define internal void @"_ZN4core3ptr104drop_in_place$LT$$RF$mut$u20$std..io..Write..write_fmt..Adapter$LT$std..sys..unix..stdio..Stderr$GT$$GT$17hc5daa0389cb7ac03E"(ptr nocapture readnone %_1) unnamed_addr #4 {
start:
  ret void
}

; core::ptr::drop_in_place<core::option::Option<alloc::sync::Arc<std::sync::mutex::Mutex<alloc::vec::Vec<u8>>>>>
; Function Attrs: nounwind nonlazybind uwtable
define internal fastcc void @"_ZN4core3ptr129drop_in_place$LT$core..option..Option$LT$alloc..sync..Arc$LT$std..sync..mutex..Mutex$LT$alloc..vec..Vec$LT$u8$GT$$GT$$GT$$GT$$GT$17h248c6a7ad92731ebE"(ptr nocapture noundef readonly %_1) unnamed_addr #3 {
start:
  %0 = load ptr, ptr %_1, align 8, !noundef !6
  %1 = icmp eq ptr %0, null
  br i1 %1, label %bb1, label %bb2

bb1:                                              ; preds = %bb2.i.i, %bb2, %start
  ret void

bb2:                                              ; preds = %start
  tail call void @llvm.experimental.noalias.scope.decl(metadata !211)
  %2 = atomicrmw sub ptr %0, i64 1 release, align 8, !noalias !211
  %3 = icmp eq i64 %2, 1
  br i1 %3, label %bb2.i.i, label %bb1

bb2.i.i:                                          ; preds = %bb2
  fence acquire
  %self.val.i.i = load ptr, ptr %_1, align 8, !alias.scope !211, !nonnull !6
; call alloc::sync::Arc<T>::drop_slow
  tail call fastcc void @"_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17h9988cc5f56f4cc91E"(ptr nonnull %self.val.i.i), !noalias !211
  br label %bb1
}

; core::ptr::drop_in_place<core::result::Result<(),alloc::boxed::Box<dyn core::any::Any+core::marker::Send>>>
; Function Attrs: nonlazybind uwtable
define internal fastcc void @"_ZN4core3ptr130drop_in_place$LT$core..result..Result$LT$$LP$$RP$$C$alloc..boxed..Box$LT$dyn$u20$core..any..Any$u2b$core..marker..Send$GT$$GT$$GT$17h66dfc8a7f5392b27E"(ptr nocapture noundef readonly %_1) unnamed_addr #1 personality ptr @rust_eh_personality {
start:
  %0 = load ptr, ptr %_1, align 8, !noundef !6
  %1 = icmp eq ptr %0, null
  br i1 %1, label %bb1, label %bb2

bb1:                                              ; preds = %bb1.i.i.i, %bb3.i, %start
  ret void

bb2:                                              ; preds = %start
  %2 = getelementptr inbounds { ptr, ptr }, ptr %_1, i64 0, i32 1
  %_4.1.i = load ptr, ptr %2, align 8, !nonnull !6, !align !148, !noundef !6
  %3 = load ptr, ptr %_4.1.i, align 8, !invariant.load !6, !nonnull !6
  invoke void %3(ptr noundef nonnull %0)
          to label %bb3.i unwind label %cleanup.i

cleanup.i:                                        ; preds = %bb2
  %4 = landingpad { ptr, i32 }
          cleanup
  %5 = load ptr, ptr %_1, align 8, !nonnull !6, !noundef !6
  %6 = load ptr, ptr %2, align 8, !nonnull !6, !align !148, !noundef !6
  %7 = getelementptr i8, ptr %6, i64 8
  %.val2.i = load i64, ptr %7, align 8, !range !149
  %8 = getelementptr i8, ptr %6, i64 16
  %.val3.i = load i64, ptr %8, align 8, !range !150
; call alloc::alloc::box_free
  tail call fastcc void @_ZN5alloc5alloc8box_free17h11e3a3be7aa785f4E(ptr noundef nonnull %5, i64 %.val2.i, i64 %.val3.i) #21
  resume { ptr, i32 } %4

bb3.i:                                            ; preds = %bb2
  %9 = load ptr, ptr %2, align 8, !nonnull !6, !align !148, !noundef !6
  %10 = getelementptr i8, ptr %9, i64 8
  %.val.i = load i64, ptr %10, align 8, !range !149
  %11 = icmp eq i64 %.val.i, 0
  br i1 %11, label %bb1, label %bb1.i.i.i

bb1.i.i.i:                                        ; preds = %bb3.i
  %12 = getelementptr i8, ptr %9, i64 16
  %.val1.i = load i64, ptr %12, align 8, !range !150
  %13 = load ptr, ptr %_1, align 8, !nonnull !6, !noundef !6
  %_18.i.i.i = icmp ult i64 %.val1.i, -9223372036854775807
  tail call void @llvm.assume(i1 %_18.i.i.i)
  tail call void @__rust_dealloc(ptr noundef nonnull %13, i64 noundef %.val.i, i64 noundef %.val1.i) #24
  br label %bb1
}

; core::ptr::drop_in_place<std::thread::Builder::spawn_unchecked_::MaybeDangling<demo::spawn_user_query::{{closure}}>>
; Function Attrs: nounwind nonlazybind uwtable
define internal fastcc void @"_ZN4core3ptr133drop_in_place$LT$std..thread..Builder..spawn_unchecked_..MaybeDangling$LT$demo..spawn_user_query..$u7b$$u7b$closure$u7d$$u7d$$GT$$GT$17h10021b299e043f37E"(ptr nocapture noundef readonly %_1) unnamed_addr #3 personality ptr @rust_eh_personality {
start:
  tail call void @llvm.experimental.noalias.scope.decl(metadata !214)
  tail call void @llvm.experimental.noalias.scope.decl(metadata !217)
  tail call void @llvm.experimental.noalias.scope.decl(metadata !220)
  %self1.i.i.i.i.i = load ptr, ptr %_1, align 8, !alias.scope !223, !nonnull !6, !noundef !6
  %0 = atomicrmw sub ptr %self1.i.i.i.i.i, i64 1 release, align 8, !noalias !223
  %1 = icmp eq i64 %0, 1
  br i1 %1, label %bb2.i.i.i.i.i, label %bb6.i.i.i

bb2.i.i.i.i.i:                                    ; preds = %start
  fence acquire
  %self.val.i.i.i.i.i = load ptr, ptr %_1, align 8, !alias.scope !223, !nonnull !6
; call alloc::sync::Arc<T>::drop_slow
  tail call fastcc void @"_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17h5bc0dcdc32f3bc06E"(ptr nonnull %self.val.i.i.i.i.i), !noalias !223
  br label %bb6.i.i.i

bb6.i.i.i:                                        ; preds = %bb2.i.i.i.i.i, %start
  %2 = getelementptr inbounds %"[closure@src/main.rs:14:19: 14:26]", ptr %_1, i64 0, i32 1
  %_1.val.i.i.i.i.i = load i64, ptr %2, align 8, !alias.scope !224, !noundef !6
  %_3.i.i.i.i.i.i.i.i = icmp eq i64 %_1.val.i.i.i.i.i, 0
  br i1 %_3.i.i.i.i.i.i.i.i, label %bb5.i.i.i, label %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i.i.i"

"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i.i.i": ; preds = %bb6.i.i.i
  %3 = getelementptr %"[closure@src/main.rs:14:19: 14:26]", ptr %_1, i64 0, i32 1, i32 0, i32 0, i32 1
  %_1.val1.i.i.i.i.i = load ptr, ptr %3, align 8, !alias.scope !224, !nonnull !6
  %_6.i.i.i.i.i.i.i.i.i = icmp sgt i64 %_1.val.i.i.i.i.i, -1
  %.sroa.2.0.i.i.i.i.i.i.i.i.i = zext i1 %_6.i.i.i.i.i.i.i.i.i to i64
  tail call void @llvm.assume(i1 %_6.i.i.i.i.i.i.i.i.i)
  tail call void @__rust_dealloc(ptr noundef nonnull %_1.val1.i.i.i.i.i, i64 noundef %_1.val.i.i.i.i.i, i64 noundef %.sroa.2.0.i.i.i.i.i.i.i.i.i) #24, !noalias !224
  br label %bb5.i.i.i

bb5.i.i.i:                                        ; preds = %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i.i.i", %bb6.i.i.i
  %4 = getelementptr inbounds %"[closure@src/main.rs:14:19: 14:26]", ptr %_1, i64 0, i32 2
  %_1.val.i.i3.i.i.i = load i64, ptr %4, align 8, !alias.scope !224, !noundef !6
  %_3.i.i.i.i.i4.i.i.i = icmp eq i64 %_1.val.i.i3.i.i.i, 0
  br i1 %_3.i.i.i.i.i4.i.i.i, label %"_ZN104_$LT$std..thread..Builder..spawn_unchecked_..MaybeDangling$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h8ff69f164c7953e4E.exit", label %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i8.i.i.i"

"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i8.i.i.i": ; preds = %bb5.i.i.i
  %5 = getelementptr %"[closure@src/main.rs:14:19: 14:26]", ptr %_1, i64 0, i32 2, i32 0, i32 0, i32 1
  %_1.val1.i.i5.i.i.i = load ptr, ptr %5, align 8, !alias.scope !224, !nonnull !6
  %_6.i.i.i.i.i.i6.i.i.i = icmp sgt i64 %_1.val.i.i3.i.i.i, -1
  %.sroa.2.0.i.i.i.i.i.i7.i.i.i = zext i1 %_6.i.i.i.i.i.i6.i.i.i to i64
  tail call void @llvm.assume(i1 %_6.i.i.i.i.i.i6.i.i.i)
  tail call void @__rust_dealloc(ptr noundef nonnull %_1.val1.i.i5.i.i.i, i64 noundef %_1.val.i.i3.i.i.i, i64 noundef %.sroa.2.0.i.i.i.i.i.i7.i.i.i) #24, !noalias !224
  br label %"_ZN104_$LT$std..thread..Builder..spawn_unchecked_..MaybeDangling$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h8ff69f164c7953e4E.exit"

"_ZN104_$LT$std..thread..Builder..spawn_unchecked_..MaybeDangling$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h8ff69f164c7953e4E.exit": ; preds = %bb5.i.i.i, %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i8.i.i.i"
  ret void
}

; core::ptr::drop_in_place<std::thread::Builder::spawn_unchecked_<demo::spawn_user_query::{{closure}},()>::{{closure}}>
; Function Attrs: nonlazybind uwtable
define internal void @"_ZN4core3ptr158drop_in_place$LT$std..thread..Builder..spawn_unchecked_$LT$demo..spawn_user_query..$u7b$$u7b$closure$u7d$$u7d$$C$$LP$$RP$$GT$..$u7b$$u7b$closure$u7d$$u7d$$GT$17h6cdb75df18ce3addE"(ptr nocapture noundef readonly %_1) unnamed_addr #1 personality ptr @rust_eh_personality {
start:
  %0 = getelementptr inbounds %"[closure@std::thread::Builder::spawn_unchecked_<'_, '_, [closure@src/main.rs:14:19: 14:26], ()>::{closure#1}]", ptr %_1, i64 0, i32 2
  tail call void @llvm.experimental.noalias.scope.decl(metadata !225)
  %self1.i.i.i.i = load ptr, ptr %0, align 8, !alias.scope !225, !nonnull !6, !noundef !6
  %1 = atomicrmw sub ptr %self1.i.i.i.i, i64 1 release, align 8, !noalias !225
  %2 = icmp eq i64 %1, 1
  br i1 %2, label %bb2.i.i.i.i, label %bb8

bb2.i.i.i.i:                                      ; preds = %start
  fence acquire
  %self.val.i.i.i.i = load ptr, ptr %0, align 8, !alias.scope !225, !nonnull !6
; call alloc::sync::Arc<T>::drop_slow
  tail call fastcc void @"_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17he68302373675f7f4E"(ptr nonnull %self.val.i.i.i.i), !noalias !225
  br label %bb8

bb8:                                              ; preds = %bb2.i.i.i.i, %start
  %3 = load ptr, ptr %_1, align 8, !noundef !6
  %4 = icmp eq ptr %3, null
  br i1 %4, label %bb7, label %bb2.i

bb2.i:                                            ; preds = %bb8
  tail call void @llvm.experimental.noalias.scope.decl(metadata !228)
  %5 = atomicrmw sub ptr %3, i64 1 release, align 8, !noalias !228
  %6 = icmp eq i64 %5, 1
  br i1 %6, label %bb2.i.i.i, label %bb7

bb2.i.i.i:                                        ; preds = %bb2.i
  fence acquire
  %self.val.i.i.i = load ptr, ptr %_1, align 8, !alias.scope !228, !nonnull !6
; call alloc::sync::Arc<T>::drop_slow
  tail call fastcc void @"_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17h9988cc5f56f4cc91E"(ptr nonnull %self.val.i.i.i), !noalias !228
  br label %bb7

bb7:                                              ; preds = %bb2.i.i.i, %bb2.i, %bb8
  %7 = getelementptr inbounds %"[closure@std::thread::Builder::spawn_unchecked_<'_, '_, [closure@src/main.rs:14:19: 14:26], ()>::{closure#1}]", ptr %_1, i64 0, i32 1
  tail call void @llvm.experimental.noalias.scope.decl(metadata !231)
  tail call void @llvm.experimental.noalias.scope.decl(metadata !234)
  tail call void @llvm.experimental.noalias.scope.decl(metadata !237)
  %self1.i.i.i.i.i.i = load ptr, ptr %7, align 8, !alias.scope !240, !nonnull !6, !noundef !6
  %8 = atomicrmw sub ptr %self1.i.i.i.i.i.i, i64 1 release, align 8, !noalias !240
  %9 = icmp eq i64 %8, 1
  br i1 %9, label %bb2.i.i.i.i.i.i, label %bb6.i.i.i.i

bb2.i.i.i.i.i.i:                                  ; preds = %bb7
  fence acquire
  %self.val.i.i.i.i.i.i = load ptr, ptr %7, align 8, !alias.scope !240, !nonnull !6
; call alloc::sync::Arc<T>::drop_slow
  tail call fastcc void @"_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17h5bc0dcdc32f3bc06E"(ptr nonnull %self.val.i.i.i.i.i.i), !noalias !240
  br label %bb6.i.i.i.i

bb6.i.i.i.i:                                      ; preds = %bb2.i.i.i.i.i.i, %bb7
  %10 = getelementptr inbounds %"[closure@std::thread::Builder::spawn_unchecked_<'_, '_, [closure@src/main.rs:14:19: 14:26], ()>::{closure#1}]", ptr %_1, i64 0, i32 1, i32 0, i32 0, i64 1
  %_1.val.i.i.i.i.i.i = load i64, ptr %10, align 8, !alias.scope !241, !noundef !6
  %_3.i.i.i.i.i.i.i.i.i = icmp eq i64 %_1.val.i.i.i.i.i.i, 0
  br i1 %_3.i.i.i.i.i.i.i.i.i, label %bb5.i.i.i.i, label %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i.i.i.i"

"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i.i.i.i": ; preds = %bb6.i.i.i.i
  %11 = getelementptr %"[closure@std::thread::Builder::spawn_unchecked_<'_, '_, [closure@src/main.rs:14:19: 14:26], ()>::{closure#1}]", ptr %_1, i64 0, i32 1, i32 0, i32 0, i64 2
  %_1.val1.i.i.i.i.i.i = load ptr, ptr %11, align 8, !alias.scope !241, !nonnull !6
  %_6.i.i.i.i.i.i.i.i.i.i = icmp sgt i64 %_1.val.i.i.i.i.i.i, -1
  %.sroa.2.0.i.i.i.i.i.i.i.i.i.i = zext i1 %_6.i.i.i.i.i.i.i.i.i.i to i64
  tail call void @llvm.assume(i1 %_6.i.i.i.i.i.i.i.i.i.i)
  tail call void @__rust_dealloc(ptr noundef nonnull %_1.val1.i.i.i.i.i.i, i64 noundef %_1.val.i.i.i.i.i.i, i64 noundef %.sroa.2.0.i.i.i.i.i.i.i.i.i.i) #24, !noalias !241
  br label %bb5.i.i.i.i

bb5.i.i.i.i:                                      ; preds = %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i.i.i.i", %bb6.i.i.i.i
  %12 = getelementptr inbounds %"[closure@std::thread::Builder::spawn_unchecked_<'_, '_, [closure@src/main.rs:14:19: 14:26], ()>::{closure#1}]", ptr %_1, i64 0, i32 1, i32 0, i32 0, i64 4
  %_1.val.i.i3.i.i.i.i = load i64, ptr %12, align 8, !alias.scope !241, !noundef !6
  %_3.i.i.i.i.i4.i.i.i.i = icmp eq i64 %_1.val.i.i3.i.i.i.i, 0
  br i1 %_3.i.i.i.i.i4.i.i.i.i, label %bb6, label %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i8.i.i.i.i"

"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i8.i.i.i.i": ; preds = %bb5.i.i.i.i
  %13 = getelementptr %"[closure@std::thread::Builder::spawn_unchecked_<'_, '_, [closure@src/main.rs:14:19: 14:26], ()>::{closure#1}]", ptr %_1, i64 0, i32 1, i32 0, i32 0, i64 5
  %_1.val1.i.i5.i.i.i.i = load ptr, ptr %13, align 8, !alias.scope !241, !nonnull !6
  %_6.i.i.i.i.i.i6.i.i.i.i = icmp sgt i64 %_1.val.i.i3.i.i.i.i, -1
  %.sroa.2.0.i.i.i.i.i.i7.i.i.i.i = zext i1 %_6.i.i.i.i.i.i6.i.i.i.i to i64
  tail call void @llvm.assume(i1 %_6.i.i.i.i.i.i6.i.i.i.i)
  tail call void @__rust_dealloc(ptr noundef nonnull %_1.val1.i.i5.i.i.i.i, i64 noundef %_1.val.i.i3.i.i.i.i, i64 noundef %.sroa.2.0.i.i.i.i.i.i7.i.i.i.i) #24, !noalias !241
  br label %bb6

bb6:                                              ; preds = %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i8.i.i.i.i", %bb5.i.i.i.i
  %14 = getelementptr inbounds %"[closure@std::thread::Builder::spawn_unchecked_<'_, '_, [closure@src/main.rs:14:19: 14:26], ()>::{closure#1}]", ptr %_1, i64 0, i32 3
  tail call void @llvm.experimental.noalias.scope.decl(metadata !242)
  %self1.i.i = load ptr, ptr %14, align 8, !alias.scope !242, !nonnull !6, !noundef !6
  %15 = atomicrmw sub ptr %self1.i.i, i64 1 release, align 8, !noalias !242
  %16 = icmp eq i64 %15, 1
  br i1 %16, label %bb2.i.i, label %"_ZN4core3ptr80drop_in_place$LT$alloc..sync..Arc$LT$std..thread..Packet$LT$$LP$$RP$$GT$$GT$$GT$17hdac63bca8591c1a9E.exit"

bb2.i.i:                                          ; preds = %bb6
  fence acquire
  %self.val.i.i = load ptr, ptr %14, align 8, !alias.scope !242, !nonnull !6
; call alloc::sync::Arc<T>::drop_slow
  tail call fastcc void @"_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17hbaf97c6b34ae9334E"(ptr nonnull %self.val.i.i), !noalias !242
  br label %"_ZN4core3ptr80drop_in_place$LT$alloc..sync..Arc$LT$std..thread..Packet$LT$$LP$$RP$$GT$$GT$$GT$17hdac63bca8591c1a9E.exit"

"_ZN4core3ptr80drop_in_place$LT$alloc..sync..Arc$LT$std..thread..Packet$LT$$LP$$RP$$GT$$GT$$GT$17hdac63bca8591c1a9E.exit": ; preds = %bb6, %bb2.i.i
  ret void
}

; core::ptr::drop_in_place<core::cell::UnsafeCell<core::option::Option<core::result::Result<(),alloc::boxed::Box<dyn core::any::Any+core::marker::Send>>>>>
; Function Attrs: nonlazybind uwtable
define internal fastcc void @"_ZN4core3ptr188drop_in_place$LT$core..cell..UnsafeCell$LT$core..option..Option$LT$core..result..Result$LT$$LP$$RP$$C$alloc..boxed..Box$LT$dyn$u20$core..any..Any$u2b$core..marker..Send$GT$$GT$$GT$$GT$$GT$17h7a9f490cebdc6f00E"(ptr nocapture noundef readonly %_1) unnamed_addr #1 personality ptr @rust_eh_personality {
start:
  %_2.i = load i64, ptr %_1, align 8, !range !201, !noundef !6
  %0 = icmp eq i64 %_2.i, 0
  br i1 %0, label %"_ZN4core3ptr158drop_in_place$LT$core..option..Option$LT$core..result..Result$LT$$LP$$RP$$C$alloc..boxed..Box$LT$dyn$u20$core..any..Any$u2b$core..marker..Send$GT$$GT$$GT$$GT$17hf9ef694540fcafadE.exit", label %bb2.i

bb2.i:                                            ; preds = %start
  %1 = getelementptr inbounds %"core::option::Option<core::result::Result<(), alloc::boxed::Box<dyn core::any::Any + core::marker::Send>>>::Some", ptr %_1, i64 0, i32 1
  %2 = load ptr, ptr %1, align 8, !noundef !6
  %3 = icmp eq ptr %2, null
  br i1 %3, label %"_ZN4core3ptr158drop_in_place$LT$core..option..Option$LT$core..result..Result$LT$$LP$$RP$$C$alloc..boxed..Box$LT$dyn$u20$core..any..Any$u2b$core..marker..Send$GT$$GT$$GT$$GT$17hf9ef694540fcafadE.exit", label %bb2.i.i

bb2.i.i:                                          ; preds = %bb2.i
  %4 = getelementptr inbounds %"core::option::Option<core::result::Result<(), alloc::boxed::Box<dyn core::any::Any + core::marker::Send>>>::Some", ptr %_1, i64 0, i32 1, i32 1
  %_4.1.i.i.i = load ptr, ptr %4, align 8, !nonnull !6, !align !148, !noundef !6
  %5 = load ptr, ptr %_4.1.i.i.i, align 8, !invariant.load !6, !nonnull !6
  invoke void %5(ptr noundef nonnull %2)
          to label %bb3.i.i.i unwind label %cleanup.i.i.i

cleanup.i.i.i:                                    ; preds = %bb2.i.i
  %6 = landingpad { ptr, i32 }
          cleanup
  %7 = load ptr, ptr %1, align 8, !nonnull !6, !noundef !6
  %8 = load ptr, ptr %4, align 8, !nonnull !6, !align !148, !noundef !6
  %9 = getelementptr i8, ptr %8, i64 8
  %.val2.i.i.i = load i64, ptr %9, align 8, !range !149
  %10 = getelementptr i8, ptr %8, i64 16
  %.val3.i.i.i = load i64, ptr %10, align 8, !range !150
; call alloc::alloc::box_free
  tail call fastcc void @_ZN5alloc5alloc8box_free17h11e3a3be7aa785f4E(ptr noundef nonnull %7, i64 %.val2.i.i.i, i64 %.val3.i.i.i) #21
  resume { ptr, i32 } %6

bb3.i.i.i:                                        ; preds = %bb2.i.i
  %11 = load ptr, ptr %4, align 8, !nonnull !6, !align !148, !noundef !6
  %12 = getelementptr i8, ptr %11, i64 8
  %.val.i.i.i = load i64, ptr %12, align 8, !range !149
  %13 = icmp eq i64 %.val.i.i.i, 0
  br i1 %13, label %"_ZN4core3ptr158drop_in_place$LT$core..option..Option$LT$core..result..Result$LT$$LP$$RP$$C$alloc..boxed..Box$LT$dyn$u20$core..any..Any$u2b$core..marker..Send$GT$$GT$$GT$$GT$17hf9ef694540fcafadE.exit", label %bb1.i.i.i.i.i

bb1.i.i.i.i.i:                                    ; preds = %bb3.i.i.i
  %14 = getelementptr i8, ptr %11, i64 16
  %.val1.i.i.i = load i64, ptr %14, align 8, !range !150
  %15 = load ptr, ptr %1, align 8, !nonnull !6, !noundef !6
  %_18.i.i.i.i.i = icmp ult i64 %.val1.i.i.i, -9223372036854775807
  tail call void @llvm.assume(i1 %_18.i.i.i.i.i)
  tail call void @__rust_dealloc(ptr noundef nonnull %15, i64 noundef %.val.i.i.i, i64 noundef %.val1.i.i.i) #24
  br label %"_ZN4core3ptr158drop_in_place$LT$core..option..Option$LT$core..result..Result$LT$$LP$$RP$$C$alloc..boxed..Box$LT$dyn$u20$core..any..Any$u2b$core..marker..Send$GT$$GT$$GT$$GT$17hf9ef694540fcafadE.exit"

"_ZN4core3ptr158drop_in_place$LT$core..option..Option$LT$core..result..Result$LT$$LP$$RP$$C$alloc..boxed..Box$LT$dyn$u20$core..any..Any$u2b$core..marker..Send$GT$$GT$$GT$$GT$17hf9ef694540fcafadE.exit": ; preds = %start, %bb2.i, %bb3.i.i.i, %bb1.i.i.i.i.i
  ret void
}

; core::ptr::drop_in_place<redis::cmd::Cmd>
; Function Attrs: nonlazybind uwtable
define internal fastcc void @"_ZN4core3ptr36drop_in_place$LT$redis..cmd..Cmd$GT$17h1f157ef24f377633E"(ptr nocapture noundef readonly %_1) unnamed_addr #1 personality ptr @rust_eh_personality {
start:
  %0 = getelementptr inbounds %"redis::cmd::Cmd", ptr %_1, i64 0, i32 1
  %_1.val.i = load i64, ptr %0, align 8, !noundef !6
  %_3.i.i.i.i = icmp eq i64 %_1.val.i, 0
  br i1 %_3.i.i.i.i, label %bb4, label %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i"

"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i": ; preds = %start
  %1 = getelementptr %"redis::cmd::Cmd", ptr %_1, i64 0, i32 1, i32 0, i32 1
  %_1.val1.i = load ptr, ptr %1, align 8, !nonnull !6
  %_6.i.i.i.i.i = icmp sgt i64 %_1.val.i, -1
  %.sroa.2.0.i.i.i.i.i = zext i1 %_6.i.i.i.i.i to i64
  tail call void @llvm.assume(i1 %_6.i.i.i.i.i)
  tail call void @__rust_dealloc(ptr noundef nonnull %_1.val1.i, i64 noundef %_1.val.i, i64 noundef %.sroa.2.0.i.i.i.i.i) #24
  br label %bb4

bb4:                                              ; preds = %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i", %start
  %2 = getelementptr inbounds %"redis::cmd::Cmd", ptr %_1, i64 0, i32 2
  %_1.val.i1 = load i64, ptr %2, align 8, !noundef !6
  %_3.i.i.i.i2 = icmp eq i64 %_1.val.i1, 0
  br i1 %_3.i.i.i.i2, label %"_ZN4core3ptr72drop_in_place$LT$alloc..vec..Vec$LT$redis..cmd..Arg$LT$usize$GT$$GT$$GT$17hb7cb1a7076b640baE.exit", label %bb2.i.i.i

bb2.i.i.i:                                        ; preds = %bb4
  %3 = getelementptr %"redis::cmd::Cmd", ptr %_1, i64 0, i32 2, i32 0, i32 1
  %_1.val1.i3 = load ptr, ptr %3, align 8, !nonnull !6
  %_6.i.i.i.i.i4 = icmp ult i64 %_1.val.i1, 576460752303423488
  %array_size.i.i.i.i.i = shl nuw nsw i64 %_1.val.i1, 4
  tail call void @llvm.assume(i1 %_6.i.i.i.i.i4)
  tail call void @__rust_dealloc(ptr noundef nonnull %_1.val1.i3, i64 noundef %array_size.i.i.i.i.i, i64 noundef 8) #24
  br label %"_ZN4core3ptr72drop_in_place$LT$alloc..vec..Vec$LT$redis..cmd..Arg$LT$usize$GT$$GT$$GT$17hb7cb1a7076b640baE.exit"

"_ZN4core3ptr72drop_in_place$LT$alloc..vec..Vec$LT$redis..cmd..Arg$LT$usize$GT$$GT$$GT$17hb7cb1a7076b640baE.exit": ; preds = %bb4, %bb2.i.i.i
  ret void
}

; core::ptr::drop_in_place<redis::types::Value>
; Function Attrs: nonlazybind uwtable
define internal fastcc void @"_ZN4core3ptr40drop_in_place$LT$redis..types..Value$GT$17hbec51beeae85c599E"(ptr nocapture noundef readonly %_1) unnamed_addr #1 personality ptr @rust_eh_personality {
start:
  %_2 = load i64, ptr %_1, align 8, !range !56, !noundef !6
  switch i64 %_2, label %bb1 [
    i64 4, label %bb4
    i64 3, label %bb3
    i64 2, label %bb2
  ]

bb1:                                              ; preds = %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i", %bb4, %bb2.i.i, %"_ZN4core3ptr63drop_in_place$LT$alloc..vec..Vec$LT$redis..types..Value$GT$$GT$17hfdf8aa4f07221884E.exit", %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i", %bb2, %start
  ret void

bb2:                                              ; preds = %start
  %0 = getelementptr inbounds %"redis::types::Value::Data", ptr %_1, i64 0, i32 1
  %_1.val.i = load i64, ptr %0, align 8, !noundef !6
  %_3.i.i.i.i = icmp eq i64 %_1.val.i, 0
  br i1 %_3.i.i.i.i, label %bb1, label %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i"

"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i": ; preds = %bb2
  %1 = getelementptr %"redis::types::Value::Data", ptr %_1, i64 0, i32 1, i32 0, i32 1
  %_1.val1.i = load ptr, ptr %1, align 8, !nonnull !6
  %_6.i.i.i.i.i = icmp sgt i64 %_1.val.i, -1
  %.sroa.2.0.i.i.i.i.i = zext i1 %_6.i.i.i.i.i to i64
  tail call void @llvm.assume(i1 %_6.i.i.i.i.i)
  tail call void @__rust_dealloc(ptr noundef nonnull %_1.val1.i, i64 noundef %_1.val.i, i64 noundef %.sroa.2.0.i.i.i.i.i) #24
  br label %bb1

bb3:                                              ; preds = %start
  %2 = getelementptr inbounds %"redis::types::Value::Bulk", ptr %_1, i64 0, i32 1
  tail call void @llvm.experimental.noalias.scope.decl(metadata !245)
  %3 = getelementptr %"redis::types::Value::Bulk", ptr %_1, i64 0, i32 1, i32 0, i32 1
  %self1.i = load ptr, ptr %3, align 8, !alias.scope !245, !nonnull !6, !noundef !6
  %4 = getelementptr inbounds %"redis::types::Value::Bulk", ptr %_1, i64 0, i32 1, i32 1
  %len.i = load i64, ptr %4, align 8, !alias.scope !245, !noundef !6
  %_10.i.i = getelementptr inbounds %"redis::types::Value", ptr %self1.i, i64 %len.i
  br label %bb11.i.i

bb11.i.i:                                         ; preds = %bb10.i.i, %bb3
  %_9.0.i.i = phi ptr [ %self1.i, %bb3 ], [ %5, %bb10.i.i ]
  %_14.i.i = icmp eq ptr %_9.0.i.i, %_10.i.i
  br i1 %_14.i.i, label %"_ZN4core3ptr63drop_in_place$LT$alloc..vec..Vec$LT$redis..types..Value$GT$$GT$17hfdf8aa4f07221884E.exit", label %bb10.i.i

bb10.i.i:                                         ; preds = %bb11.i.i
  %5 = getelementptr inbounds %"redis::types::Value", ptr %_9.0.i.i, i64 1
; invoke core::ptr::drop_in_place<redis::types::Value>
  invoke fastcc void @"_ZN4core3ptr40drop_in_place$LT$redis..types..Value$GT$17hbec51beeae85c599E"(ptr noundef nonnull %_9.0.i.i)
          to label %bb11.i.i unwind label %cleanup.i.i, !noalias !245

bb9.i.i:                                          ; preds = %bb8.i.i, %cleanup.i.i
  %_9.1.i.i = phi ptr [ %5, %cleanup.i.i ], [ %7, %bb8.i.i ]
  %_12.i.i = icmp eq ptr %_9.1.i.i, %_10.i.i
  br i1 %_12.i.i, label %cleanup.i.body, label %bb8.i.i

cleanup.i.i:                                      ; preds = %bb10.i.i
  %6 = landingpad { ptr, i32 }
          cleanup
  br label %bb9.i.i

bb8.i.i:                                          ; preds = %bb9.i.i
  %7 = getelementptr inbounds %"redis::types::Value", ptr %_9.1.i.i, i64 1
; invoke core::ptr::drop_in_place<redis::types::Value>
  invoke fastcc void @"_ZN4core3ptr40drop_in_place$LT$redis..types..Value$GT$17hbec51beeae85c599E"(ptr noundef nonnull %_9.1.i.i) #21
          to label %bb9.i.i unwind label %abort.i.i, !noalias !245

abort.i.i:                                        ; preds = %bb8.i.i
  %8 = landingpad { ptr, i32 }
          cleanup
; call core::panicking::panic_cannot_unwind
  tail call void @_ZN4core9panicking19panic_cannot_unwind17h42344709dec62f2eE() #23, !noalias !245
  unreachable

cleanup.i.body:                                   ; preds = %bb9.i.i
  %_1.val2.i = load i64, ptr %2, align 8, !noundef !6
  %_1.val3.i = load ptr, ptr %3, align 8
; call core::ptr::drop_in_place<alloc::raw_vec::RawVec<redis::types::Value>>
  tail call fastcc void @"_ZN4core3ptr70drop_in_place$LT$alloc..raw_vec..RawVec$LT$redis..types..Value$GT$$GT$17ha274f04261b92c1fE"(i64 %_1.val2.i, ptr %_1.val3.i) #21
  resume { ptr, i32 } %6

"_ZN4core3ptr63drop_in_place$LT$alloc..vec..Vec$LT$redis..types..Value$GT$$GT$17hfdf8aa4f07221884E.exit": ; preds = %bb11.i.i
  %_1.val.i1 = load i64, ptr %2, align 8, !noundef !6
  %_3.i.i.i = icmp eq i64 %_1.val.i1, 0
  br i1 %_3.i.i.i, label %bb1, label %bb2.i.i

bb2.i.i:                                          ; preds = %"_ZN4core3ptr63drop_in_place$LT$alloc..vec..Vec$LT$redis..types..Value$GT$$GT$17hfdf8aa4f07221884E.exit"
  %_1.val1.i2 = load ptr, ptr %3, align 8, !nonnull !6
  %_6.i.i.i.i = icmp ult i64 %_1.val.i1, 288230376151711744
  %array_size.i.i.i.i = shl nuw nsw i64 %_1.val.i1, 5
  tail call void @llvm.assume(i1 %_6.i.i.i.i)
  tail call void @__rust_dealloc(ptr noundef nonnull %_1.val1.i2, i64 noundef %array_size.i.i.i.i, i64 noundef 8) #24
  br label %bb1

bb4:                                              ; preds = %start
  %9 = getelementptr inbounds %"redis::types::Value::Status", ptr %_1, i64 0, i32 1
  %_1.val.i.i = load i64, ptr %9, align 8, !noundef !6
  %_3.i.i.i.i.i = icmp eq i64 %_1.val.i.i, 0
  br i1 %_3.i.i.i.i.i, label %bb1, label %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i"

"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i": ; preds = %bb4
  %10 = getelementptr %"redis::types::Value::Status", ptr %_1, i64 0, i32 1, i32 0, i32 0, i32 1
  %_1.val1.i.i = load ptr, ptr %10, align 8, !nonnull !6
  %_6.i.i.i.i.i.i = icmp sgt i64 %_1.val.i.i, -1
  %.sroa.2.0.i.i.i.i.i.i = zext i1 %_6.i.i.i.i.i.i to i64
  tail call void @llvm.assume(i1 %_6.i.i.i.i.i.i)
  tail call void @__rust_dealloc(ptr noundef nonnull %_1.val1.i.i, i64 noundef %_1.val.i.i, i64 noundef %.sroa.2.0.i.i.i.i.i.i) #24
  br label %bb1
}

; core::ptr::drop_in_place<std::thread::Thread>
; Function Attrs: nounwind nonlazybind uwtable
define internal fastcc void @"_ZN4core3ptr40drop_in_place$LT$std..thread..Thread$GT$17h315a208f60640622E"(ptr nocapture noundef readonly %_1) unnamed_addr #3 {
start:
  tail call void @llvm.experimental.noalias.scope.decl(metadata !248)
  %self1.i.i.i = load ptr, ptr %_1, align 8, !alias.scope !248, !nonnull !6, !noundef !6
  %0 = atomicrmw sub ptr %self1.i.i.i, i64 1 release, align 8, !noalias !248
  %1 = icmp eq i64 %0, 1
  br i1 %1, label %bb2.i.i.i, label %"_ZN4core3ptr85drop_in_place$LT$core..pin..Pin$LT$alloc..sync..Arc$LT$std..thread..Inner$GT$$GT$$GT$17h5f99cbbfa6d53c1fE.exit"

bb2.i.i.i:                                        ; preds = %start
  fence acquire
  %self.val.i.i.i = load ptr, ptr %_1, align 8, !alias.scope !248, !nonnull !6
; call alloc::sync::Arc<T>::drop_slow
  tail call fastcc void @"_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17he68302373675f7f4E"(ptr nonnull %self.val.i.i.i), !noalias !248
  br label %"_ZN4core3ptr85drop_in_place$LT$core..pin..Pin$LT$alloc..sync..Arc$LT$std..thread..Inner$GT$$GT$$GT$17h5f99cbbfa6d53c1fE.exit"

"_ZN4core3ptr85drop_in_place$LT$core..pin..Pin$LT$alloc..sync..Arc$LT$std..thread..Inner$GT$$GT$$GT$17h5f99cbbfa6d53c1fE.exit": ; preds = %start, %bb2.i.i.i
  ret void
}

; core::ptr::drop_in_place<alloc::string::String>
; Function Attrs: nounwind nonlazybind uwtable
define internal fastcc void @"_ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17h5f3174a51a28c86eE"(ptr nocapture noundef readonly %_1) unnamed_addr #3 personality ptr @rust_eh_personality {
start:
  %_1.val.i = load i64, ptr %_1, align 8, !noundef !6
  %_3.i.i.i.i = icmp eq i64 %_1.val.i, 0
  br i1 %_3.i.i.i.i, label %"_ZN4core3ptr46drop_in_place$LT$alloc..vec..Vec$LT$u8$GT$$GT$17h3b6c9b466e6e94d4E.exit", label %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i"

"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i": ; preds = %start
  %0 = getelementptr i8, ptr %_1, i64 8
  %_1.val1.i = load ptr, ptr %0, align 8, !nonnull !6
  %_6.i.i.i.i.i = icmp sgt i64 %_1.val.i, -1
  %.sroa.2.0.i.i.i.i.i = zext i1 %_6.i.i.i.i.i to i64
  tail call void @llvm.assume(i1 %_6.i.i.i.i.i)
  tail call void @__rust_dealloc(ptr noundef nonnull %_1.val1.i, i64 noundef %_1.val.i, i64 noundef %.sroa.2.0.i.i.i.i.i) #24
  br label %"_ZN4core3ptr46drop_in_place$LT$alloc..vec..Vec$LT$u8$GT$$GT$17h3b6c9b466e6e94d4E.exit"

"_ZN4core3ptr46drop_in_place$LT$alloc..vec..Vec$LT$u8$GT$$GT$17h3b6c9b466e6e94d4E.exit": ; preds = %start, %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i"
  ret void
}

; core::ptr::drop_in_place<redis::client::Client>
; Function Attrs: nounwind nonlazybind uwtable
define internal fastcc void @"_ZN4core3ptr42drop_in_place$LT$redis..client..Client$GT$17h04bd24b5de385cecE"(ptr nocapture noundef readonly %_1) unnamed_addr #3 personality ptr @rust_eh_personality {
start:
  %0 = load i8, ptr %_1, align 8, !range !251, !noundef !6
  %_2.i.i = zext i8 %0 to i64
  switch i64 %_2.i.i, label %bb4.i.i [
    i64 0, label %bb2.i.i
    i64 1, label %bb3.i.i
  ]

bb4.i.i:                                          ; preds = %start
  %1 = getelementptr inbounds %"redis::connection::ConnectionAddr::Unix", ptr %_1, i64 0, i32 1
  %_1.val.i.i.i.i.i.i = load i64, ptr %1, align 8, !noundef !6
  %_3.i.i.i.i.i.i.i.i.i = icmp eq i64 %_1.val.i.i.i.i.i.i, 0
  br i1 %_3.i.i.i.i.i.i.i.i.i, label %bb4.i, label %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i.i.i.i"

"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i.i.i.i": ; preds = %bb4.i.i
  %2 = getelementptr %"redis::connection::ConnectionAddr::Unix", ptr %_1, i64 0, i32 1, i32 0, i32 0, i32 0, i32 0, i32 1
  %_1.val1.i.i.i.i.i.i = load ptr, ptr %2, align 8, !nonnull !6
  %_6.i.i.i.i.i.i.i.i.i.i = icmp sgt i64 %_1.val.i.i.i.i.i.i, -1
  %.sroa.2.0.i.i.i.i.i.i.i.i.i.i = zext i1 %_6.i.i.i.i.i.i.i.i.i.i to i64
  tail call void @llvm.assume(i1 %_6.i.i.i.i.i.i.i.i.i.i)
  tail call void @__rust_dealloc(ptr noundef nonnull %_1.val1.i.i.i.i.i.i, i64 noundef %_1.val.i.i.i.i.i.i, i64 noundef %.sroa.2.0.i.i.i.i.i.i.i.i.i.i) #24
  br label %bb4.i

bb2.i.i:                                          ; preds = %start
  %3 = getelementptr inbounds %"redis::connection::ConnectionAddr::Tcp", ptr %_1, i64 0, i32 3
  %_1.val.i.i.i.i = load i64, ptr %3, align 8, !noundef !6
  %_3.i.i.i.i.i.i.i = icmp eq i64 %_1.val.i.i.i.i, 0
  br i1 %_3.i.i.i.i.i.i.i, label %bb4.i, label %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i.i"

"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i.i": ; preds = %bb2.i.i
  %4 = getelementptr %"redis::connection::ConnectionAddr::Tcp", ptr %_1, i64 0, i32 3, i32 0, i32 0, i32 1
  %_1.val1.i.i.i.i = load ptr, ptr %4, align 8, !nonnull !6
  %_6.i.i.i.i.i.i.i.i = icmp sgt i64 %_1.val.i.i.i.i, -1
  %.sroa.2.0.i.i.i.i.i.i.i.i = zext i1 %_6.i.i.i.i.i.i.i.i to i64
  tail call void @llvm.assume(i1 %_6.i.i.i.i.i.i.i.i)
  tail call void @__rust_dealloc(ptr noundef nonnull %_1.val1.i.i.i.i, i64 noundef %_1.val.i.i.i.i, i64 noundef %.sroa.2.0.i.i.i.i.i.i.i.i) #24
  br label %bb4.i

bb3.i.i:                                          ; preds = %start
  %5 = getelementptr inbounds %"redis::connection::ConnectionAddr::TcpTls", ptr %_1, i64 0, i32 4
  %_1.val.i.i1.i.i = load i64, ptr %5, align 8, !noundef !6
  %_3.i.i.i.i.i2.i.i = icmp eq i64 %_1.val.i.i1.i.i, 0
  br i1 %_3.i.i.i.i.i2.i.i, label %bb4.i, label %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i6.i.i"

"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i6.i.i": ; preds = %bb3.i.i
  %6 = getelementptr %"redis::connection::ConnectionAddr::TcpTls", ptr %_1, i64 0, i32 4, i32 0, i32 0, i32 1
  %_1.val1.i.i3.i.i = load ptr, ptr %6, align 8, !nonnull !6
  %_6.i.i.i.i.i.i4.i.i = icmp sgt i64 %_1.val.i.i1.i.i, -1
  %.sroa.2.0.i.i.i.i.i.i5.i.i = zext i1 %_6.i.i.i.i.i.i4.i.i to i64
  tail call void @llvm.assume(i1 %_6.i.i.i.i.i.i4.i.i)
  tail call void @__rust_dealloc(ptr noundef nonnull %_1.val1.i.i3.i.i, i64 noundef %_1.val.i.i1.i.i, i64 noundef %.sroa.2.0.i.i.i.i.i.i5.i.i) #24
  br label %bb4.i

bb4.i:                                            ; preds = %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i6.i.i", %bb3.i.i, %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i.i", %bb2.i.i, %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i.i.i.i", %bb4.i.i
  %7 = getelementptr %"redis::connection::ConnectionInfo", ptr %_1, i64 0, i32 1, i32 1, i32 1
  %8 = load ptr, ptr %7, align 8, !noundef !6
  %9 = icmp eq ptr %8, null
  br i1 %9, label %bb4.i1.i, label %bb2.i.i.i

bb2.i.i.i:                                        ; preds = %bb4.i
  %10 = getelementptr inbounds %"redis::connection::ConnectionInfo", ptr %_1, i64 0, i32 1, i32 1
  %_1.val.i.i.i.i.i = load i64, ptr %10, align 8, !noundef !6
  %_3.i.i.i.i.i.i.i.i = icmp eq i64 %_1.val.i.i.i.i.i, 0
  br i1 %_3.i.i.i.i.i.i.i.i, label %bb4.i1.i, label %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i.i.i"

"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i.i.i": ; preds = %bb2.i.i.i
  %_6.i.i.i.i.i.i.i.i.i = icmp sgt i64 %_1.val.i.i.i.i.i, -1
  %.sroa.2.0.i.i.i.i.i.i.i.i.i = zext i1 %_6.i.i.i.i.i.i.i.i.i to i64
  tail call void @llvm.assume(i1 %_6.i.i.i.i.i.i.i.i.i)
  tail call void @__rust_dealloc(ptr noundef nonnull %8, i64 noundef %_1.val.i.i.i.i.i, i64 noundef %.sroa.2.0.i.i.i.i.i.i.i.i.i) #24
  br label %bb4.i1.i

bb4.i1.i:                                         ; preds = %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i.i.i", %bb2.i.i.i, %bb4.i
  %11 = getelementptr %"redis::connection::ConnectionInfo", ptr %_1, i64 0, i32 1, i32 2, i32 1
  %12 = load ptr, ptr %11, align 8, !noundef !6
  %13 = icmp eq ptr %12, null
  br i1 %13, label %"_ZN4core3ptr54drop_in_place$LT$redis..connection..ConnectionInfo$GT$17h33b3093e90677eadE.exit", label %bb2.i3.i.i

bb2.i3.i.i:                                       ; preds = %bb4.i1.i
  %14 = getelementptr inbounds %"redis::connection::ConnectionInfo", ptr %_1, i64 0, i32 1, i32 2
  %_1.val.i.i.i1.i.i = load i64, ptr %14, align 8, !noundef !6
  %_3.i.i.i.i.i.i2.i.i = icmp eq i64 %_1.val.i.i.i1.i.i, 0
  br i1 %_3.i.i.i.i.i.i2.i.i, label %"_ZN4core3ptr54drop_in_place$LT$redis..connection..ConnectionInfo$GT$17h33b3093e90677eadE.exit", label %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i6.i.i"

"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i6.i.i": ; preds = %bb2.i3.i.i
  %_6.i.i.i.i.i.i.i4.i.i = icmp sgt i64 %_1.val.i.i.i1.i.i, -1
  %.sroa.2.0.i.i.i.i.i.i.i5.i.i = zext i1 %_6.i.i.i.i.i.i.i4.i.i to i64
  tail call void @llvm.assume(i1 %_6.i.i.i.i.i.i.i4.i.i)
  tail call void @__rust_dealloc(ptr noundef nonnull %12, i64 noundef %_1.val.i.i.i1.i.i, i64 noundef %.sroa.2.0.i.i.i.i.i.i.i5.i.i) #24
  br label %"_ZN4core3ptr54drop_in_place$LT$redis..connection..ConnectionInfo$GT$17h33b3093e90677eadE.exit"

"_ZN4core3ptr54drop_in_place$LT$redis..connection..ConnectionInfo$GT$17h33b3093e90677eadE.exit": ; preds = %bb4.i1.i, %bb2.i3.i.i, %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i6.i.i"
  ret void
}

; core::ptr::drop_in_place<redis::parser::Parser>
; Function Attrs: nonlazybind uwtable
define internal fastcc void @"_ZN4core3ptr42drop_in_place$LT$redis..parser..Parser$GT$17h484e3aee468a4e3cE"(ptr noundef %_1) unnamed_addr #1 personality ptr @rust_eh_personality {
start:
  %0 = getelementptr inbounds %"combine::stream::decoder::Decoder<combine::parser::combinator::AnySendSyncPartialState, combine::stream::PointerOffset<[u8]>>", ptr %_1, i64 0, i32 1
  %1 = load ptr, ptr %0, align 8, !noundef !6
  %2 = icmp eq ptr %1, null
  br i1 %2, label %"_ZN4core3ptr167drop_in_place$LT$combine..stream..decoder..Decoder$LT$combine..parser..combinator..AnySendSyncPartialState$C$combine..stream..PointerOffset$LT$$u5b$u8$u5d$$GT$$GT$$GT$17hb7caeaf2ac3dbd52E.exit", label %bb2.i.i.i

bb2.i.i.i:                                        ; preds = %start
  %3 = getelementptr inbounds %"combine::stream::decoder::Decoder<combine::parser::combinator::AnySendSyncPartialState, combine::stream::PointerOffset<[u8]>>", ptr %_1, i64 0, i32 1, i32 1
  %_4.1.i.i.i.i = load ptr, ptr %3, align 8, !nonnull !6, !align !148, !noundef !6
  %4 = load ptr, ptr %_4.1.i.i.i.i, align 8, !invariant.load !6, !nonnull !6
  invoke void %4(ptr noundef nonnull %1)
          to label %bb3.i.i.i.i unwind label %cleanup.i.i.i.i

cleanup.i.i.i.i:                                  ; preds = %bb2.i.i.i
  %5 = landingpad { ptr, i32 }
          cleanup
  %6 = load ptr, ptr %0, align 8, !nonnull !6, !noundef !6
  %7 = load ptr, ptr %3, align 8, !nonnull !6, !align !148, !noundef !6
  %8 = getelementptr i8, ptr %7, i64 8
  %.val2.i.i.i.i = load i64, ptr %8, align 8, !range !149
  %9 = getelementptr i8, ptr %7, i64 16
  %.val3.i.i.i.i = load i64, ptr %9, align 8, !range !150
; call alloc::alloc::box_free
  tail call fastcc void @_ZN5alloc5alloc8box_free17h11e3a3be7aa785f4E(ptr noundef nonnull %6, i64 %.val2.i.i.i.i, i64 %.val3.i.i.i.i) #21
; invoke core::ptr::drop_in_place<combine::stream::buf_reader::Buffer>
  invoke fastcc void @"_ZN4core3ptr56drop_in_place$LT$combine..stream..buf_reader..Buffer$GT$17h8e1b4cfda56169baE"(ptr noundef %_1) #21
          to label %bb1.i unwind label %abort.i

bb3.i.i.i.i:                                      ; preds = %bb2.i.i.i
  %10 = load ptr, ptr %3, align 8, !nonnull !6, !align !148, !noundef !6
  %11 = getelementptr i8, ptr %10, i64 8
  %.val.i.i.i.i = load i64, ptr %11, align 8, !range !149
  %12 = icmp eq i64 %.val.i.i.i.i, 0
  br i1 %12, label %"_ZN4core3ptr167drop_in_place$LT$combine..stream..decoder..Decoder$LT$combine..parser..combinator..AnySendSyncPartialState$C$combine..stream..PointerOffset$LT$$u5b$u8$u5d$$GT$$GT$$GT$17hb7caeaf2ac3dbd52E.exit", label %bb1.i.i.i.i.i.i

bb1.i.i.i.i.i.i:                                  ; preds = %bb3.i.i.i.i
  %13 = getelementptr i8, ptr %10, i64 16
  %.val1.i.i.i.i = load i64, ptr %13, align 8, !range !150
  %14 = load ptr, ptr %0, align 8, !nonnull !6, !noundef !6
  %_18.i.i.i.i.i.i = icmp ult i64 %.val1.i.i.i.i, -9223372036854775807
  tail call void @llvm.assume(i1 %_18.i.i.i.i.i.i)
  tail call void @__rust_dealloc(ptr noundef nonnull %14, i64 noundef %.val.i.i.i.i, i64 noundef %.val1.i.i.i.i) #24
  br label %"_ZN4core3ptr167drop_in_place$LT$combine..stream..decoder..Decoder$LT$combine..parser..combinator..AnySendSyncPartialState$C$combine..stream..PointerOffset$LT$$u5b$u8$u5d$$GT$$GT$$GT$17hb7caeaf2ac3dbd52E.exit"

abort.i:                                          ; preds = %cleanup.i.i.i.i
  %15 = landingpad { ptr, i32 }
          cleanup
; call core::panicking::panic_cannot_unwind
  tail call void @_ZN4core9panicking19panic_cannot_unwind17h42344709dec62f2eE() #23
  unreachable

bb1.i:                                            ; preds = %cleanup.i.i.i.i
  resume { ptr, i32 } %5

"_ZN4core3ptr167drop_in_place$LT$combine..stream..decoder..Decoder$LT$combine..parser..combinator..AnySendSyncPartialState$C$combine..stream..PointerOffset$LT$$u5b$u8$u5d$$GT$$GT$$GT$17hb7caeaf2ac3dbd52E.exit": ; preds = %start, %bb3.i.i.i.i, %bb1.i.i.i.i.i.i
; call <bytes::bytes_mut::BytesMut as core::ops::drop::Drop>::drop
  tail call void @"_ZN68_$LT$bytes..bytes_mut..BytesMut$u20$as$u20$core..ops..drop..Drop$GT$4drop17h3ddab1da761f9101E"(ptr noalias noundef nonnull align 8 dereferenceable(32) %_1)
  ret void
}

; core::ptr::drop_in_place<std::io::error::Error>
; Function Attrs: nonlazybind uwtable
define internal void @"_ZN4core3ptr42drop_in_place$LT$std..io..error..Error$GT$17h44b2f0e87eb79141E"(ptr nocapture noundef readonly %_1) unnamed_addr #1 personality ptr @rust_eh_personality {
start:
  %_1.val = load ptr, ptr %_1, align 8, !nonnull !6, !noundef !6
  %_7.cast.i.i.i = ptrtoint ptr %_1.val to i64
  %_6.i.i.i = and i64 %_7.cast.i.i.i, 3
  %switch.i.i = icmp eq i64 %_6.i.i.i, 1
  br i1 %switch.i.i, label %bb2.i1.i.i, label %"_ZN4core3ptr57drop_in_place$LT$std..io..error..repr_bitpacked..Repr$GT$17h49eddd3e5245e215E.exit"

bb2.i1.i.i:                                       ; preds = %start
  %0 = getelementptr i8, ptr %_1.val, i64 -1
  %1 = icmp ne ptr %0, null
  tail call void @llvm.assume(i1 %1)
  %_4.0.i.i.i.i.i.i = load ptr, ptr %0, align 8, !noundef !6
  %2 = getelementptr i8, ptr %_1.val, i64 7
  %_4.1.i.i.i.i.i.i = load ptr, ptr %2, align 8, !nonnull !6, !align !148, !noundef !6
  %3 = load ptr, ptr %_4.1.i.i.i.i.i.i, align 8, !invariant.load !6, !nonnull !6
  invoke void %3(ptr noundef %_4.0.i.i.i.i.i.i)
          to label %bb3.i.i.i.i.i.i unwind label %cleanup.i.i.i.i.i.i

cleanup.i.i.i.i.i.i:                              ; preds = %bb2.i1.i.i
  %4 = landingpad { ptr, i32 }
          cleanup
  %5 = load ptr, ptr %0, align 8, !nonnull !6, !noundef !6
  %6 = load ptr, ptr %2, align 8, !nonnull !6, !align !148, !noundef !6
  %7 = getelementptr i8, ptr %6, i64 8
  %.val2.i.i.i.i.i.i = load i64, ptr %7, align 8, !range !149
  %8 = getelementptr i8, ptr %6, i64 16
  %.val3.i.i.i.i.i.i = load i64, ptr %8, align 8, !range !150
; call alloc::alloc::box_free
  tail call fastcc void @_ZN5alloc5alloc8box_free17h11e3a3be7aa785f4E(ptr noundef nonnull %5, i64 %.val2.i.i.i.i.i.i, i64 %.val3.i.i.i.i.i.i) #21
; call alloc::alloc::box_free
  tail call fastcc void @_ZN5alloc5alloc8box_free17h78ba79ece75676b2E(ptr noundef nonnull %0) #21
  resume { ptr, i32 } %4

bb3.i.i.i.i.i.i:                                  ; preds = %bb2.i1.i.i
  %9 = load ptr, ptr %2, align 8, !nonnull !6, !align !148, !noundef !6
  %10 = getelementptr i8, ptr %9, i64 8
  %.val.i.i.i.i.i.i = load i64, ptr %10, align 8, !range !149
  %11 = icmp eq i64 %.val.i.i.i.i.i.i, 0
  br i1 %11, label %"_ZN4core3ptr68drop_in_place$LT$alloc..boxed..Box$LT$std..io..error..Custom$GT$$GT$17h1f84f0febdcf91a3E.exit.i.i.i", label %bb1.i.i.i.i.i.i.i.i

bb1.i.i.i.i.i.i.i.i:                              ; preds = %bb3.i.i.i.i.i.i
  %12 = getelementptr i8, ptr %9, i64 16
  %.val1.i.i.i.i.i.i = load i64, ptr %12, align 8, !range !150
  %13 = load ptr, ptr %0, align 8, !nonnull !6, !noundef !6
  %_18.i.i.i.i.i.i.i.i = icmp ult i64 %.val1.i.i.i.i.i.i, -9223372036854775807
  tail call void @llvm.assume(i1 %_18.i.i.i.i.i.i.i.i)
  tail call void @__rust_dealloc(ptr noundef nonnull %13, i64 noundef %.val.i.i.i.i.i.i, i64 noundef %.val1.i.i.i.i.i.i) #24
  br label %"_ZN4core3ptr68drop_in_place$LT$alloc..boxed..Box$LT$std..io..error..Custom$GT$$GT$17h1f84f0febdcf91a3E.exit.i.i.i"

"_ZN4core3ptr68drop_in_place$LT$alloc..boxed..Box$LT$std..io..error..Custom$GT$$GT$17h1f84f0febdcf91a3E.exit.i.i.i": ; preds = %bb1.i.i.i.i.i.i.i.i, %bb3.i.i.i.i.i.i
  tail call void @__rust_dealloc(ptr noundef nonnull %0, i64 noundef 24, i64 noundef 8) #24
  br label %"_ZN4core3ptr57drop_in_place$LT$std..io..error..repr_bitpacked..Repr$GT$17h49eddd3e5245e215E.exit"

"_ZN4core3ptr57drop_in_place$LT$std..io..error..repr_bitpacked..Repr$GT$17h49eddd3e5245e215E.exit": ; preds = %start, %"_ZN4core3ptr68drop_in_place$LT$alloc..boxed..Box$LT$std..io..error..Custom$GT$$GT$17h1f84f0febdcf91a3E.exit.i.i.i"
  ret void
}

; core::ptr::drop_in_place<redis::types::RedisError>
; Function Attrs: nonlazybind uwtable
define internal void @"_ZN4core3ptr45drop_in_place$LT$redis..types..RedisError$GT$17he9e92a6d6be589cdE"(ptr nocapture noundef readonly %_1) unnamed_addr #1 personality ptr @rust_eh_personality {
start:
  %0 = load i8, ptr %_1, align 8, !range !252, !noundef !6
  %_2.i = zext i8 %0 to i64
  switch i64 %_2.i, label %bb7.i [
    i64 0, label %"_ZN4core3ptr44drop_in_place$LT$redis..types..ErrorRepr$GT$17h20bf84ed15824774E.exit"
    i64 1, label %bb3.i
    i64 2, label %bb6.i
  ]

bb7.i:                                            ; preds = %start
  %1 = getelementptr inbounds %"redis::types::ErrorRepr::IoError", ptr %_1, i64 0, i32 1
  %_1.val.i.i = load ptr, ptr %1, align 8, !nonnull !6, !noundef !6
  %_7.cast.i.i.i.i.i = ptrtoint ptr %_1.val.i.i to i64
  %_6.i.i.i.i.i = and i64 %_7.cast.i.i.i.i.i, 3
  %switch.i.i.i.i = icmp eq i64 %_6.i.i.i.i.i, 1
  br i1 %switch.i.i.i.i, label %bb2.i1.i.i.i.i, label %"_ZN4core3ptr44drop_in_place$LT$redis..types..ErrorRepr$GT$17h20bf84ed15824774E.exit"

bb2.i1.i.i.i.i:                                   ; preds = %bb7.i
  %2 = getelementptr i8, ptr %_1.val.i.i, i64 -1
  %3 = icmp ne ptr %2, null
  tail call void @llvm.assume(i1 %3)
  %_4.0.i.i.i.i.i.i.i.i = load ptr, ptr %2, align 8, !noundef !6
  %4 = getelementptr i8, ptr %_1.val.i.i, i64 7
  %_4.1.i.i.i.i.i.i.i.i = load ptr, ptr %4, align 8, !nonnull !6, !align !148, !noundef !6
  %5 = load ptr, ptr %_4.1.i.i.i.i.i.i.i.i, align 8, !invariant.load !6, !nonnull !6
  invoke void %5(ptr noundef %_4.0.i.i.i.i.i.i.i.i)
          to label %bb3.i.i.i.i.i.i.i.i unwind label %cleanup.i.i.i.i.i.i.i.i

cleanup.i.i.i.i.i.i.i.i:                          ; preds = %bb2.i1.i.i.i.i
  %6 = landingpad { ptr, i32 }
          cleanup
  %7 = load ptr, ptr %2, align 8, !nonnull !6, !noundef !6
  %8 = load ptr, ptr %4, align 8, !nonnull !6, !align !148, !noundef !6
  %9 = getelementptr i8, ptr %8, i64 8
  %.val2.i.i.i.i.i.i.i.i = load i64, ptr %9, align 8, !range !149
  %10 = getelementptr i8, ptr %8, i64 16
  %.val3.i.i.i.i.i.i.i.i = load i64, ptr %10, align 8, !range !150
; call alloc::alloc::box_free
  tail call fastcc void @_ZN5alloc5alloc8box_free17h11e3a3be7aa785f4E(ptr noundef nonnull %7, i64 %.val2.i.i.i.i.i.i.i.i, i64 %.val3.i.i.i.i.i.i.i.i) #21
; call alloc::alloc::box_free
  tail call fastcc void @_ZN5alloc5alloc8box_free17h78ba79ece75676b2E(ptr noundef nonnull %2) #21
  resume { ptr, i32 } %6

bb3.i.i.i.i.i.i.i.i:                              ; preds = %bb2.i1.i.i.i.i
  %11 = load ptr, ptr %4, align 8, !nonnull !6, !align !148, !noundef !6
  %12 = getelementptr i8, ptr %11, i64 8
  %.val.i.i.i.i.i.i.i.i = load i64, ptr %12, align 8, !range !149
  %13 = icmp eq i64 %.val.i.i.i.i.i.i.i.i, 0
  br i1 %13, label %"_ZN4core3ptr68drop_in_place$LT$alloc..boxed..Box$LT$std..io..error..Custom$GT$$GT$17h1f84f0febdcf91a3E.exit.i.i.i.i.i", label %bb1.i.i.i.i.i.i.i.i.i.i

bb1.i.i.i.i.i.i.i.i.i.i:                          ; preds = %bb3.i.i.i.i.i.i.i.i
  %14 = getelementptr i8, ptr %11, i64 16
  %.val1.i.i.i.i.i.i.i.i = load i64, ptr %14, align 8, !range !150
  %15 = load ptr, ptr %2, align 8, !nonnull !6, !noundef !6
  %_18.i.i.i.i.i.i.i.i.i.i = icmp ult i64 %.val1.i.i.i.i.i.i.i.i, -9223372036854775807
  tail call void @llvm.assume(i1 %_18.i.i.i.i.i.i.i.i.i.i)
  tail call void @__rust_dealloc(ptr noundef nonnull %15, i64 noundef %.val.i.i.i.i.i.i.i.i, i64 noundef %.val1.i.i.i.i.i.i.i.i) #24
  br label %"_ZN4core3ptr68drop_in_place$LT$alloc..boxed..Box$LT$std..io..error..Custom$GT$$GT$17h1f84f0febdcf91a3E.exit.i.i.i.i.i"

"_ZN4core3ptr68drop_in_place$LT$alloc..boxed..Box$LT$std..io..error..Custom$GT$$GT$17h1f84f0febdcf91a3E.exit.i.i.i.i.i": ; preds = %bb1.i.i.i.i.i.i.i.i.i.i, %bb3.i.i.i.i.i.i.i.i
  tail call void @__rust_dealloc(ptr noundef nonnull %2, i64 noundef 24, i64 noundef 8) #24
  br label %"_ZN4core3ptr44drop_in_place$LT$redis..types..ErrorRepr$GT$17h20bf84ed15824774E.exit"

bb3.i:                                            ; preds = %start
  %16 = getelementptr inbounds %"redis::types::ErrorRepr::WithDescriptionAndDetail", ptr %_1, i64 0, i32 3
  %_1.val.i.i.i = load i64, ptr %16, align 8, !noundef !6
  %_3.i.i.i.i.i.i = icmp eq i64 %_1.val.i.i.i, 0
  br i1 %_3.i.i.i.i.i.i, label %"_ZN4core3ptr44drop_in_place$LT$redis..types..ErrorRepr$GT$17h20bf84ed15824774E.exit", label %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i"

"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i": ; preds = %bb3.i
  %17 = getelementptr %"redis::types::ErrorRepr::WithDescriptionAndDetail", ptr %_1, i64 0, i32 3, i32 0, i32 0, i32 1
  %_1.val1.i.i.i = load ptr, ptr %17, align 8, !nonnull !6
  %_6.i.i.i.i.i.i.i = icmp sgt i64 %_1.val.i.i.i, -1
  %.sroa.2.0.i.i.i.i.i.i.i = zext i1 %_6.i.i.i.i.i.i.i to i64
  tail call void @llvm.assume(i1 %_6.i.i.i.i.i.i.i)
  tail call void @__rust_dealloc(ptr noundef nonnull %_1.val1.i.i.i, i64 noundef %_1.val.i.i.i, i64 noundef %.sroa.2.0.i.i.i.i.i.i.i) #24
  br label %"_ZN4core3ptr44drop_in_place$LT$redis..types..ErrorRepr$GT$17h20bf84ed15824774E.exit"

bb6.i:                                            ; preds = %start
  %18 = getelementptr inbounds %"redis::types::ErrorRepr::ExtensionError", ptr %_1, i64 0, i32 1
  %_1.val.i.i1.i = load i64, ptr %18, align 8, !noundef !6
  %_3.i.i.i.i.i2.i = icmp eq i64 %_1.val.i.i1.i, 0
  br i1 %_3.i.i.i.i.i2.i, label %bb5.i, label %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i6.i"

"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i6.i": ; preds = %bb6.i
  %19 = getelementptr %"redis::types::ErrorRepr::ExtensionError", ptr %_1, i64 0, i32 1, i32 0, i32 0, i32 1
  %_1.val1.i.i3.i = load ptr, ptr %19, align 8, !nonnull !6
  %_6.i.i.i.i.i.i4.i = icmp sgt i64 %_1.val.i.i1.i, -1
  %.sroa.2.0.i.i.i.i.i.i5.i = zext i1 %_6.i.i.i.i.i.i4.i to i64
  tail call void @llvm.assume(i1 %_6.i.i.i.i.i.i4.i)
  tail call void @__rust_dealloc(ptr noundef nonnull %_1.val1.i.i3.i, i64 noundef %_1.val.i.i1.i, i64 noundef %.sroa.2.0.i.i.i.i.i.i5.i) #24
  br label %bb5.i

bb5.i:                                            ; preds = %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i6.i", %bb6.i
  %20 = getelementptr inbounds %"redis::types::ErrorRepr::ExtensionError", ptr %_1, i64 0, i32 2
  %_1.val.i.i8.i = load i64, ptr %20, align 8, !noundef !6
  %_3.i.i.i.i.i9.i = icmp eq i64 %_1.val.i.i8.i, 0
  br i1 %_3.i.i.i.i.i9.i, label %"_ZN4core3ptr44drop_in_place$LT$redis..types..ErrorRepr$GT$17h20bf84ed15824774E.exit", label %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i13.i"

"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i13.i": ; preds = %bb5.i
  %21 = getelementptr %"redis::types::ErrorRepr::ExtensionError", ptr %_1, i64 0, i32 2, i32 0, i32 0, i32 1
  %_1.val1.i.i10.i = load ptr, ptr %21, align 8, !nonnull !6
  %_6.i.i.i.i.i.i11.i = icmp sgt i64 %_1.val.i.i8.i, -1
  %.sroa.2.0.i.i.i.i.i.i12.i = zext i1 %_6.i.i.i.i.i.i11.i to i64
  tail call void @llvm.assume(i1 %_6.i.i.i.i.i.i11.i)
  tail call void @__rust_dealloc(ptr noundef nonnull %_1.val1.i.i10.i, i64 noundef %_1.val.i.i8.i, i64 noundef %.sroa.2.0.i.i.i.i.i.i12.i) #24
  br label %"_ZN4core3ptr44drop_in_place$LT$redis..types..ErrorRepr$GT$17h20bf84ed15824774E.exit"

"_ZN4core3ptr44drop_in_place$LT$redis..types..ErrorRepr$GT$17h20bf84ed15824774E.exit": ; preds = %start, %bb7.i, %"_ZN4core3ptr68drop_in_place$LT$alloc..boxed..Box$LT$std..io..error..Custom$GT$$GT$17h1f84f0febdcf91a3E.exit.i.i.i.i.i", %bb3.i, %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i", %bb5.i, %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i13.i"
  ret void
}

; core::ptr::drop_in_place<alloc::vec::Vec<u8>>
; Function Attrs: nonlazybind uwtable
define internal fastcc void @"_ZN4core3ptr46drop_in_place$LT$alloc..vec..Vec$LT$u8$GT$$GT$17h3b6c9b466e6e94d4E"(ptr nocapture noundef readonly %_1) unnamed_addr #1 personality ptr @rust_eh_personality {
bb4:
  %_1.val = load i64, ptr %_1, align 8, !noundef !6
  %_3.i.i.i = icmp eq i64 %_1.val, 0
  br i1 %_3.i.i.i, label %"_ZN4core3ptr53drop_in_place$LT$alloc..raw_vec..RawVec$LT$u8$GT$$GT$17hff835c4ffba58ebdE.exit", label %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i"

"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i": ; preds = %bb4
  %0 = getelementptr i8, ptr %_1, i64 8
  %_1.val1 = load ptr, ptr %0, align 8, !nonnull !6
  %_6.i.i.i.i = icmp sgt i64 %_1.val, -1
  %.sroa.2.0.i.i.i.i = zext i1 %_6.i.i.i.i to i64
  tail call void @llvm.assume(i1 %_6.i.i.i.i)
  tail call void @__rust_dealloc(ptr noundef nonnull %_1.val1, i64 noundef %_1.val, i64 noundef %.sroa.2.0.i.i.i.i) #24
  br label %"_ZN4core3ptr53drop_in_place$LT$alloc..raw_vec..RawVec$LT$u8$GT$$GT$17hff835c4ffba58ebdE.exit"

"_ZN4core3ptr53drop_in_place$LT$alloc..raw_vec..RawVec$LT$u8$GT$$GT$17hff835c4ffba58ebdE.exit": ; preds = %bb4, %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i"
  ret void
}

; core::ptr::drop_in_place<alloc::ffi::c_str::NulError>
; Function Attrs: nounwind nonlazybind uwtable
define internal void @"_ZN4core3ptr48drop_in_place$LT$alloc..ffi..c_str..NulError$GT$17h236d8428e3ec4c93E"(ptr nocapture noundef readonly %_1) unnamed_addr #3 personality ptr @rust_eh_personality {
start:
  %0 = getelementptr inbounds %"alloc::ffi::c_str::NulError", ptr %_1, i64 0, i32 1
  %_1.val.i = load i64, ptr %0, align 8, !noundef !6
  %_3.i.i.i.i = icmp eq i64 %_1.val.i, 0
  br i1 %_3.i.i.i.i, label %"_ZN4core3ptr46drop_in_place$LT$alloc..vec..Vec$LT$u8$GT$$GT$17h3b6c9b466e6e94d4E.exit", label %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i"

"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i": ; preds = %start
  %1 = getelementptr %"alloc::ffi::c_str::NulError", ptr %_1, i64 0, i32 1, i32 0, i32 1
  %_1.val1.i = load ptr, ptr %1, align 8, !nonnull !6
  %_6.i.i.i.i.i = icmp sgt i64 %_1.val.i, -1
  %.sroa.2.0.i.i.i.i.i = zext i1 %_6.i.i.i.i.i to i64
  tail call void @llvm.assume(i1 %_6.i.i.i.i.i)
  tail call void @__rust_dealloc(ptr noundef nonnull %_1.val1.i, i64 noundef %_1.val.i, i64 noundef %.sroa.2.0.i.i.i.i.i) #24
  br label %"_ZN4core3ptr46drop_in_place$LT$alloc..vec..Vec$LT$u8$GT$$GT$17h3b6c9b466e6e94d4E.exit"

"_ZN4core3ptr46drop_in_place$LT$alloc..vec..Vec$LT$u8$GT$$GT$17h3b6c9b466e6e94d4E.exit": ; preds = %start, %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i"
  ret void
}

; core::ptr::drop_in_place<redis::connection::Connection>
; Function Attrs: nonlazybind uwtable
define internal fastcc void @"_ZN4core3ptr50drop_in_place$LT$redis..connection..Connection$GT$17h98975dd43c2c8c48E"(ptr noundef %_1) unnamed_addr #1 personality ptr @rust_eh_personality {
start:
  %0 = getelementptr inbounds %"redis::connection::Connection", ptr %_1, i64 0, i32 2, i32 1
  %.val.i = load i32, ptr %0, align 4
  %_2.i.i.i.i.i.i.i.i1 = invoke noundef i32 @close(i32 noundef %.val.i)
          to label %bb4 unwind label %cleanup

cleanup:                                          ; preds = %start
  %1 = landingpad { ptr, i32 }
          cleanup
; invoke core::ptr::drop_in_place<redis::parser::Parser>
  invoke fastcc void @"_ZN4core3ptr42drop_in_place$LT$redis..parser..Parser$GT$17h484e3aee468a4e3cE"(ptr noundef nonnull %_1) #21
          to label %bb1 unwind label %abort

bb4:                                              ; preds = %start
; call core::ptr::drop_in_place<redis::parser::Parser>
  tail call fastcc void @"_ZN4core3ptr42drop_in_place$LT$redis..parser..Parser$GT$17h484e3aee468a4e3cE"(ptr noundef nonnull %_1)
  ret void

abort:                                            ; preds = %cleanup
  %2 = landingpad { ptr, i32 }
          cleanup
; call core::panicking::panic_cannot_unwind
  tail call void @_ZN4core9panicking19panic_cannot_unwind17h42344709dec62f2eE() #23
  unreachable

bb1:                                              ; preds = %cleanup
  resume { ptr, i32 } %1
}

; core::ptr::drop_in_place<combine::stream::buf_reader::Buffer>
; Function Attrs: nonlazybind uwtable
define internal fastcc void @"_ZN4core3ptr56drop_in_place$LT$combine..stream..buf_reader..Buffer$GT$17h8e1b4cfda56169baE"(ptr noundef nonnull %_1) unnamed_addr #1 {
start:
; call <bytes::bytes_mut::BytesMut as core::ops::drop::Drop>::drop
  tail call void @"_ZN68_$LT$bytes..bytes_mut..BytesMut$u20$as$u20$core..ops..drop..Drop$GT$4drop17h3ddab1da761f9101E"(ptr noalias noundef nonnull align 8 dereferenceable(32) %_1)
  ret void
}

; core::ptr::drop_in_place<std::thread::Packet<()>>
; Function Attrs: nonlazybind uwtable
define internal fastcc void @"_ZN4core3ptr56drop_in_place$LT$std..thread..Packet$LT$$LP$$RP$$GT$$GT$17h95267ed0ad673807E"(ptr nocapture noundef %_1) unnamed_addr #1 personality ptr @rust_eh_personality {
start:
  %out.i = alloca %"std::sys::unix::stdio::Stderr", align 1
  %_29.i = alloca %"core::fmt::Arguments<'_>", align 8
  %_25.i = alloca [1 x { ptr, ptr }], align 8
  %_18.i = alloca %"core::fmt::Arguments<'_>", align 8
  %_7.i = alloca { ptr, ptr }, align 8
  tail call void @llvm.experimental.noalias.scope.decl(metadata !253)
  call void @llvm.lifetime.start.p0(i64 0, ptr nonnull %out.i)
  %self1.i = getelementptr inbounds %"std::thread::Packet<'_, ()>", ptr %_1, i64 0, i32 2
  %_6.i = load i64, ptr %self1.i, align 8, !range !201, !alias.scope !253, !noundef !6
  %0 = icmp eq i64 %_6.i, 1
  %1 = getelementptr inbounds %"std::thread::Packet<'_, ()>", ptr %_1, i64 0, i32 2, i32 0, i32 1
  %2 = load ptr, ptr %1, align 8, !alias.scope !253
  %.not4.i = icmp ne ptr %2, null
  %or.cond.i = select i1 %0, i1 %.not4.i, i1 false
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %_7.i), !noalias !253
  tail call void @llvm.experimental.noalias.scope.decl(metadata !256)
  tail call void @llvm.experimental.noalias.scope.decl(metadata !259)
  tail call void @llvm.experimental.noalias.scope.decl(metadata !262)
  tail call void @llvm.experimental.noalias.scope.decl(metadata !265)
  %3 = icmp eq i64 %_6.i, 0
  %4 = icmp eq ptr %2, null
  %or.cond10.i = select i1 %3, i1 true, i1 %4
  br i1 %or.cond10.i, label %"_ZN4core3ptr130drop_in_place$LT$core..result..Result$LT$$LP$$RP$$C$alloc..boxed..Box$LT$dyn$u20$core..any..Any$u2b$core..marker..Send$GT$$GT$$GT$17h66dfc8a7f5392b27E.exit.i", label %bb2.i.i.i.i.i.i.i.i.i

bb2.i.i.i.i.i.i.i.i.i:                            ; preds = %start
  %5 = getelementptr inbounds %"std::thread::Packet<'_, ()>", ptr %_1, i64 0, i32 2, i32 0, i32 1, i64 1
  %_4.1.i.i.i.i.i.i.i.i.i.i = load ptr, ptr %5, align 8, !alias.scope !268, !nonnull !6, !align !148, !noundef !6
  %6 = load ptr, ptr %_4.1.i.i.i.i.i.i.i.i.i.i, align 8, !invariant.load !6, !noalias !268, !nonnull !6
  invoke void %6(ptr noundef nonnull %2)
          to label %bb3.i.i.i.i.i.i.i.i.i.i unwind label %bb6.i, !noalias !268

bb3.i.i.i.i.i.i.i.i.i.i:                          ; preds = %bb2.i.i.i.i.i.i.i.i.i
  %7 = getelementptr i8, ptr %_4.1.i.i.i.i.i.i.i.i.i.i, i64 8
  %.val.i.i.i.i.i.i.i.i.i.i = load i64, ptr %7, align 8, !range !149, !noalias !268
  %8 = icmp eq i64 %.val.i.i.i.i.i.i.i.i.i.i, 0
  br i1 %8, label %"_ZN4core3ptr130drop_in_place$LT$core..result..Result$LT$$LP$$RP$$C$alloc..boxed..Box$LT$dyn$u20$core..any..Any$u2b$core..marker..Send$GT$$GT$$GT$17h66dfc8a7f5392b27E.exit.i", label %bb1.i.i.i.i.i.i.i.i.i.i.i.i

bb1.i.i.i.i.i.i.i.i.i.i.i.i:                      ; preds = %bb3.i.i.i.i.i.i.i.i.i.i
  %9 = getelementptr i8, ptr %_4.1.i.i.i.i.i.i.i.i.i.i, i64 16
  %.val1.i.i.i.i.i.i.i.i.i.i = load i64, ptr %9, align 8, !range !150, !noalias !268
  %_18.i.i.i.i.i.i.i.i.i.i.i.i = icmp ult i64 %.val1.i.i.i.i.i.i.i.i.i.i, -9223372036854775807
  tail call void @llvm.assume(i1 %_18.i.i.i.i.i.i.i.i.i.i.i.i)
  tail call void @__rust_dealloc(ptr noundef nonnull %2, i64 noundef %.val.i.i.i.i.i.i.i.i.i.i, i64 noundef %.val1.i.i.i.i.i.i.i.i.i.i) #24, !noalias !268
  br label %"_ZN4core3ptr130drop_in_place$LT$core..result..Result$LT$$LP$$RP$$C$alloc..boxed..Box$LT$dyn$u20$core..any..Any$u2b$core..marker..Send$GT$$GT$$GT$17h66dfc8a7f5392b27E.exit.i"

bb6.i:                                            ; preds = %bb2.i.i.i.i.i.i.i.i.i
  %10 = landingpad { ptr, i32 }
          cleanup
          catch ptr null
  %11 = getelementptr i8, ptr %_4.1.i.i.i.i.i.i.i.i.i.i, i64 8
  %.val2.i.i.i.i.i.i.i.i.i.i = load i64, ptr %11, align 8, !range !149, !noalias !268
  %12 = getelementptr i8, ptr %_4.1.i.i.i.i.i.i.i.i.i.i, i64 16
  %.val3.i.i.i.i.i.i.i.i.i.i = load i64, ptr %12, align 8, !range !150, !noalias !268
; call alloc::alloc::box_free
  tail call fastcc void @_ZN5alloc5alloc8box_free17h11e3a3be7aa785f4E(ptr noundef nonnull %2, i64 %.val2.i.i.i.i.i.i.i.i.i.i, i64 %.val3.i.i.i.i.i.i.i.i.i.i) #21, !noalias !268
  store i64 0, ptr %self1.i, align 8, !alias.scope !268
  %13 = extractvalue { ptr, i32 } %10, 0
; invoke std::panicking::try::cleanup
  %14 = invoke { ptr, ptr } @_ZN3std9panicking3try7cleanup17h41c2fc1c7a2c52faE(ptr noundef %13)
          to label %.noexc unwind label %cleanup

.noexc:                                           ; preds = %bb6.i
  %obj.0.i.i.i.i = extractvalue { ptr, ptr } %14, 0
  %obj.1.i.i.i.i = extractvalue { ptr, ptr } %14, 1
  %15 = icmp ne ptr %obj.0.i.i.i.i, null
  tail call void @llvm.assume(i1 %15)
  %16 = icmp ne ptr %obj.1.i.i.i.i, null
  tail call void @llvm.assume(i1 %16)
  store ptr %obj.0.i.i.i.i, ptr %_7.i, align 8, !noalias !253
  %.fca.1.gep.i = getelementptr inbounds { ptr, ptr }, ptr %_7.i, i64 0, i32 1
  store ptr %obj.1.i.i.i.i, ptr %.fca.1.gep.i, align 8, !noalias !253
; invoke std::sys::unix::stdio::panic_output
  %17 = invoke noundef zeroext i1 @_ZN3std3sys4unix5stdio12panic_output17h10b27a13c39e27f7E()
          to label %bb7.i unwind label %cleanup.i, !noalias !253

"_ZN4core3ptr130drop_in_place$LT$core..result..Result$LT$$LP$$RP$$C$alloc..boxed..Box$LT$dyn$u20$core..any..Any$u2b$core..marker..Send$GT$$GT$$GT$17h66dfc8a7f5392b27E.exit.i": ; preds = %bb1.i.i.i.i.i.i.i.i.i.i.i.i, %bb3.i.i.i.i.i.i.i.i.i.i, %start
  store i64 0, ptr %self1.i, align 8, !alias.scope !268
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %_7.i), !noalias !253
  %18 = load ptr, ptr %_1, align 8
  %.not3.i = icmp eq ptr %18, null
  br i1 %.not3.i, label %bb6.thread, label %bb16.i

bb6.thread:                                       ; preds = %"_ZN4core3ptr130drop_in_place$LT$core..result..Result$LT$$LP$$RP$$C$alloc..boxed..Box$LT$dyn$u20$core..any..Any$u2b$core..marker..Send$GT$$GT$$GT$17h66dfc8a7f5392b27E.exit.i"
  call void @llvm.lifetime.end.p0(i64 0, ptr nonnull %out.i)
  br label %bb5

bb16.i:                                           ; preds = %"_ZN4core3ptr130drop_in_place$LT$core..result..Result$LT$$LP$$RP$$C$alloc..boxed..Box$LT$dyn$u20$core..any..Any$u2b$core..marker..Send$GT$$GT$$GT$17h66dfc8a7f5392b27E.exit.i"
  %_42.i = getelementptr inbounds %"alloc::sync::ArcInner<std::thread::scoped::ScopeData>", ptr %18, i64 0, i32 2
; invoke std::thread::scoped::ScopeData::decrement_num_running_threads
  invoke void @_ZN3std6thread6scoped9ScopeData29decrement_num_running_threads17hd0b29bf4c04585f2E(ptr noundef nonnull align 8 %_42.i, i1 noundef zeroext %or.cond.i)
          to label %bb6 unwind label %cleanup

cleanup.i:                                        ; preds = %bb11.i, %bb10.i, %bb13.i, %.noexc
  %19 = landingpad { ptr, i32 }
          cleanup
; invoke core::ptr::drop_in_place<core::result::Result<(),alloc::boxed::Box<dyn core::any::Any+core::marker::Send>>>
  invoke fastcc void @"_ZN4core3ptr130drop_in_place$LT$core..result..Result$LT$$LP$$RP$$C$alloc..boxed..Box$LT$dyn$u20$core..any..Any$u2b$core..marker..Send$GT$$GT$$GT$17h66dfc8a7f5392b27E"(ptr noundef nonnull %_7.i) #21
          to label %cleanup.body unwind label %abort.i, !noalias !253

bb7.i:                                            ; preds = %.noexc
  br i1 %17, label %bb10.i, label %bb13.i

bb13.i:                                           ; preds = %bb12.i, %bb7.i
; invoke std::sys::unix::abort_internal
  invoke void @_ZN3std3sys4unix14abort_internal17h7f37f07e4ed20c97E() #22
          to label %unreachable.i unwind label %cleanup.i, !noalias !253

bb10.i:                                           ; preds = %bb7.i
  call void @llvm.lifetime.start.p0(i64 48, ptr nonnull %_18.i), !noalias !253
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %_25.i), !noalias !253
  call void @llvm.lifetime.start.p0(i64 48, ptr nonnull %_29.i), !noalias !253
  %20 = getelementptr inbounds %"core::fmt::Arguments<'_>", ptr %_29.i, i64 0, i32 1
  store ptr @alloc59, ptr %20, align 8, !alias.scope !269, !noalias !272
  %21 = getelementptr inbounds %"core::fmt::Arguments<'_>", ptr %_29.i, i64 0, i32 1, i32 1
  store i64 1, ptr %21, align 8, !alias.scope !269, !noalias !272
  store ptr null, ptr %_29.i, align 8, !alias.scope !269, !noalias !272
  %22 = getelementptr inbounds %"core::fmt::Arguments<'_>", ptr %_29.i, i64 0, i32 2
  store ptr @alloc112, ptr %22, align 8, !alias.scope !269, !noalias !272
  %23 = getelementptr inbounds %"core::fmt::Arguments<'_>", ptr %_29.i, i64 0, i32 2, i32 1
  store i64 0, ptr %23, align 8, !alias.scope !269, !noalias !272
  store ptr %_29.i, ptr %_25.i, align 8, !noalias !253
  %24 = getelementptr inbounds { ptr, ptr }, ptr %_25.i, i64 0, i32 1
  store ptr @"_ZN59_$LT$core..fmt..Arguments$u20$as$u20$core..fmt..Display$GT$3fmt17he38941b7d204d60dE", ptr %24, align 8, !noalias !253
  %25 = getelementptr inbounds %"core::fmt::Arguments<'_>", ptr %_18.i, i64 0, i32 1
  store ptr @alloc55, ptr %25, align 8, !alias.scope !275, !noalias !278
  %26 = getelementptr inbounds %"core::fmt::Arguments<'_>", ptr %_18.i, i64 0, i32 1, i32 1
  store i64 2, ptr %26, align 8, !alias.scope !275, !noalias !278
  store ptr null, ptr %_18.i, align 8, !alias.scope !275, !noalias !278
  %27 = getelementptr inbounds %"core::fmt::Arguments<'_>", ptr %_18.i, i64 0, i32 2
  store ptr %_25.i, ptr %27, align 8, !alias.scope !275, !noalias !278
  %28 = getelementptr inbounds %"core::fmt::Arguments<'_>", ptr %_18.i, i64 0, i32 2, i32 1
  store i64 1, ptr %28, align 8, !alias.scope !275, !noalias !278
; invoke std::io::Write::write_fmt
  %29 = invoke fastcc noundef ptr @_ZN3std2io5Write9write_fmt17hc65b2ef788d392c1E(ptr noalias noundef nonnull align 1 %out.i, ptr noalias nocapture noundef nonnull readonly dereferenceable(48) %_18.i)
          to label %bb11.i unwind label %cleanup.i, !noalias !253

bb11.i:                                           ; preds = %bb10.i
  call void @llvm.lifetime.end.p0(i64 48, ptr nonnull %_18.i), !noalias !253
; invoke core::ptr::drop_in_place<core::result::Result<(),std::io::error::Error>>
  invoke fastcc void @"_ZN4core3ptr81drop_in_place$LT$core..result..Result$LT$$LP$$RP$$C$std..io..error..Error$GT$$GT$17h502ade48c0f79bfbE"(ptr %29)
          to label %bb12.i unwind label %cleanup.i, !noalias !253

bb12.i:                                           ; preds = %bb11.i
  call void @llvm.lifetime.end.p0(i64 48, ptr nonnull %_29.i), !noalias !253
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %_25.i), !noalias !253
  br label %bb13.i

unreachable.i:                                    ; preds = %bb13.i
  unreachable

abort.i:                                          ; preds = %cleanup.i
  %30 = landingpad { ptr, i32 }
          cleanup
; call core::panicking::panic_cannot_unwind
  call void @_ZN4core9panicking19panic_cannot_unwind17h42344709dec62f2eE() #23, !noalias !253
  unreachable

cleanup:                                          ; preds = %bb16.i, %bb6.i
  %31 = landingpad { ptr, i32 }
          cleanup
  br label %cleanup.body

cleanup.body:                                     ; preds = %cleanup.i, %cleanup
  %eh.lpad-body = phi { ptr, i32 } [ %31, %cleanup ], [ %19, %cleanup.i ]
; call core::ptr::drop_in_place<core::option::Option<alloc::sync::Arc<std::thread::scoped::ScopeData>>>
  call fastcc void @"_ZN4core3ptr103drop_in_place$LT$core..option..Option$LT$alloc..sync..Arc$LT$std..thread..scoped..ScopeData$GT$$GT$$GT$17h7cc4bee20b845956E"(ptr noundef nonnull %_1) #21
; invoke core::ptr::drop_in_place<core::cell::UnsafeCell<core::option::Option<core::result::Result<(),alloc::boxed::Box<dyn core::any::Any+core::marker::Send>>>>>
  invoke fastcc void @"_ZN4core3ptr188drop_in_place$LT$core..cell..UnsafeCell$LT$core..option..Option$LT$core..result..Result$LT$$LP$$RP$$C$alloc..boxed..Box$LT$dyn$u20$core..any..Any$u2b$core..marker..Send$GT$$GT$$GT$$GT$$GT$17h7a9f490cebdc6f00E"(ptr noundef nonnull %self1.i) #21
          to label %common.resume unwind label %abort

bb6:                                              ; preds = %bb16.i
  %.pr = load ptr, ptr %_1, align 8
  call void @llvm.lifetime.end.p0(i64 0, ptr nonnull %out.i)
  %32 = icmp eq ptr %.pr, null
  br i1 %32, label %bb5, label %bb2.i

bb2.i:                                            ; preds = %bb6
  tail call void @llvm.experimental.noalias.scope.decl(metadata !281)
  %33 = atomicrmw sub ptr %.pr, i64 1 release, align 8, !noalias !281
  %34 = icmp eq i64 %33, 1
  br i1 %34, label %bb2.i.i.i, label %bb5

bb2.i.i.i:                                        ; preds = %bb2.i
  fence acquire
  %self.val.i.i.i = load ptr, ptr %_1, align 8, !alias.scope !281, !nonnull !6
; call alloc::sync::Arc<T>::drop_slow
  tail call fastcc void @"_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17hf7031fc3d45c20a4E"(ptr nonnull %self.val.i.i.i), !noalias !281
  br label %bb5

abort:                                            ; preds = %cleanup.body
  %35 = landingpad { ptr, i32 }
          cleanup
; call core::panicking::panic_cannot_unwind
  call void @_ZN4core9panicking19panic_cannot_unwind17h42344709dec62f2eE() #23
  unreachable

bb5:                                              ; preds = %bb2.i.i.i, %bb2.i, %bb6, %bb6.thread
  %_2.i.i = load i64, ptr %self1.i, align 8, !range !201, !noundef !6
  %36 = icmp eq i64 %_2.i.i, 0
  br i1 %36, label %"_ZN4core3ptr188drop_in_place$LT$core..cell..UnsafeCell$LT$core..option..Option$LT$core..result..Result$LT$$LP$$RP$$C$alloc..boxed..Box$LT$dyn$u20$core..any..Any$u2b$core..marker..Send$GT$$GT$$GT$$GT$$GT$17h7a9f490cebdc6f00E.exit", label %bb2.i.i

bb2.i.i:                                          ; preds = %bb5
  %37 = load ptr, ptr %1, align 8, !noundef !6
  %38 = icmp eq ptr %37, null
  br i1 %38, label %"_ZN4core3ptr188drop_in_place$LT$core..cell..UnsafeCell$LT$core..option..Option$LT$core..result..Result$LT$$LP$$RP$$C$alloc..boxed..Box$LT$dyn$u20$core..any..Any$u2b$core..marker..Send$GT$$GT$$GT$$GT$$GT$17h7a9f490cebdc6f00E.exit", label %bb2.i.i.i4

bb2.i.i.i4:                                       ; preds = %bb2.i.i
  %39 = getelementptr inbounds %"std::thread::Packet<'_, ()>", ptr %_1, i64 0, i32 2, i32 0, i32 1, i64 1
  %_4.1.i.i.i.i = load ptr, ptr %39, align 8, !nonnull !6, !align !148, !noundef !6
  %40 = load ptr, ptr %_4.1.i.i.i.i, align 8, !invariant.load !6, !nonnull !6
  invoke void %40(ptr noundef nonnull %37)
          to label %bb3.i.i.i.i unwind label %cleanup.i.i.i.i

common.resume:                                    ; preds = %cleanup.body, %cleanup.i.i.i.i
  %common.resume.op = phi { ptr, i32 } [ %41, %cleanup.i.i.i.i ], [ %eh.lpad-body, %cleanup.body ]
  resume { ptr, i32 } %common.resume.op

cleanup.i.i.i.i:                                  ; preds = %bb2.i.i.i4
  %41 = landingpad { ptr, i32 }
          cleanup
  %42 = load ptr, ptr %1, align 8, !nonnull !6, !noundef !6
  %43 = load ptr, ptr %39, align 8, !nonnull !6, !align !148, !noundef !6
  %44 = getelementptr i8, ptr %43, i64 8
  %.val2.i.i.i.i = load i64, ptr %44, align 8, !range !149
  %45 = getelementptr i8, ptr %43, i64 16
  %.val3.i.i.i.i = load i64, ptr %45, align 8, !range !150
; call alloc::alloc::box_free
  tail call fastcc void @_ZN5alloc5alloc8box_free17h11e3a3be7aa785f4E(ptr noundef nonnull %42, i64 %.val2.i.i.i.i, i64 %.val3.i.i.i.i) #21
  br label %common.resume

bb3.i.i.i.i:                                      ; preds = %bb2.i.i.i4
  %46 = load ptr, ptr %39, align 8, !nonnull !6, !align !148, !noundef !6
  %47 = getelementptr i8, ptr %46, i64 8
  %.val.i.i.i.i = load i64, ptr %47, align 8, !range !149
  %48 = icmp eq i64 %.val.i.i.i.i, 0
  br i1 %48, label %"_ZN4core3ptr188drop_in_place$LT$core..cell..UnsafeCell$LT$core..option..Option$LT$core..result..Result$LT$$LP$$RP$$C$alloc..boxed..Box$LT$dyn$u20$core..any..Any$u2b$core..marker..Send$GT$$GT$$GT$$GT$$GT$17h7a9f490cebdc6f00E.exit", label %bb1.i.i.i.i.i.i

bb1.i.i.i.i.i.i:                                  ; preds = %bb3.i.i.i.i
  %49 = getelementptr i8, ptr %46, i64 16
  %.val1.i.i.i.i = load i64, ptr %49, align 8, !range !150
  %50 = load ptr, ptr %1, align 8, !nonnull !6, !noundef !6
  %_18.i.i.i.i.i.i = icmp ult i64 %.val1.i.i.i.i, -9223372036854775807
  tail call void @llvm.assume(i1 %_18.i.i.i.i.i.i)
  tail call void @__rust_dealloc(ptr noundef nonnull %50, i64 noundef %.val.i.i.i.i, i64 noundef %.val1.i.i.i.i) #24
  br label %"_ZN4core3ptr188drop_in_place$LT$core..cell..UnsafeCell$LT$core..option..Option$LT$core..result..Result$LT$$LP$$RP$$C$alloc..boxed..Box$LT$dyn$u20$core..any..Any$u2b$core..marker..Send$GT$$GT$$GT$$GT$$GT$17h7a9f490cebdc6f00E.exit"

"_ZN4core3ptr188drop_in_place$LT$core..cell..UnsafeCell$LT$core..option..Option$LT$core..result..Result$LT$$LP$$RP$$C$alloc..boxed..Box$LT$dyn$u20$core..any..Any$u2b$core..marker..Send$GT$$GT$$GT$$GT$$GT$17h7a9f490cebdc6f00E.exit": ; preds = %bb5, %bb2.i.i, %bb3.i.i.i.i, %bb1.i.i.i.i.i.i
  ret void
}

; core::ptr::drop_in_place<std::thread::JoinHandle<()>>
; Function Attrs: nonlazybind uwtable
define internal fastcc void @"_ZN4core3ptr60drop_in_place$LT$std..thread..JoinHandle$LT$$LP$$RP$$GT$$GT$17h6edbba2370971c99E"(ptr noundef nonnull %_1) unnamed_addr #1 personality ptr @rust_eh_personality {
start:
; invoke <std::sys::unix::thread::Thread as core::ops::drop::Drop>::drop
  invoke void @"_ZN72_$LT$std..sys..unix..thread..Thread$u20$as$u20$core..ops..drop..Drop$GT$4drop17h88402d24365b1d48E"(ptr noalias noundef nonnull align 8 dereferenceable(8) %_1)
          to label %bb6.i unwind label %cleanup.i

cleanup.i:                                        ; preds = %start
  %0 = landingpad { ptr, i32 }
          cleanup
  %1 = getelementptr inbounds %"std::thread::JoinInner<'_, ()>", ptr %_1, i64 0, i32 1
; call core::ptr::drop_in_place<std::thread::Thread>
  tail call fastcc void @"_ZN4core3ptr40drop_in_place$LT$std..thread..Thread$GT$17h315a208f60640622E"(ptr noundef nonnull %1) #21
  %2 = getelementptr inbounds %"std::thread::JoinInner<'_, ()>", ptr %_1, i64 0, i32 2
; invoke core::ptr::drop_in_place<alloc::sync::Arc<std::thread::Packet<()>>>
  invoke fastcc void @"_ZN4core3ptr80drop_in_place$LT$alloc..sync..Arc$LT$std..thread..Packet$LT$$LP$$RP$$GT$$GT$$GT$17hdac63bca8591c1a9E"(ptr noundef nonnull %2) #21
          to label %bb1.i unwind label %abort.i

bb6.i:                                            ; preds = %start
  %3 = getelementptr inbounds %"std::thread::JoinInner<'_, ()>", ptr %_1, i64 0, i32 1
  tail call void @llvm.experimental.noalias.scope.decl(metadata !284)
  %self1.i.i.i.i.i = load ptr, ptr %3, align 8, !alias.scope !284, !nonnull !6, !noundef !6
  %4 = atomicrmw sub ptr %self1.i.i.i.i.i, i64 1 release, align 8, !noalias !284
  %5 = icmp eq i64 %4, 1
  br i1 %5, label %bb2.i.i.i.i.i, label %bb5.i

bb2.i.i.i.i.i:                                    ; preds = %bb6.i
  fence acquire
  %self.val.i.i.i.i.i = load ptr, ptr %3, align 8, !alias.scope !284, !nonnull !6
; call alloc::sync::Arc<T>::drop_slow
  tail call fastcc void @"_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17he68302373675f7f4E"(ptr nonnull %self.val.i.i.i.i.i), !noalias !284
  br label %bb5.i

abort.i:                                          ; preds = %cleanup.i
  %6 = landingpad { ptr, i32 }
          cleanup
; call core::panicking::panic_cannot_unwind
  tail call void @_ZN4core9panicking19panic_cannot_unwind17h42344709dec62f2eE() #23
  unreachable

bb5.i:                                            ; preds = %bb2.i.i.i.i.i, %bb6.i
  %7 = getelementptr inbounds %"std::thread::JoinInner<'_, ()>", ptr %_1, i64 0, i32 2
  tail call void @llvm.experimental.noalias.scope.decl(metadata !287)
  %self1.i.i.i = load ptr, ptr %7, align 8, !alias.scope !287, !nonnull !6, !noundef !6
  %8 = atomicrmw sub ptr %self1.i.i.i, i64 1 release, align 8, !noalias !287
  %9 = icmp eq i64 %8, 1
  br i1 %9, label %bb2.i.i.i, label %"_ZN4core3ptr59drop_in_place$LT$std..thread..JoinInner$LT$$LP$$RP$$GT$$GT$17h1f69a472001248fcE.exit"

bb2.i.i.i:                                        ; preds = %bb5.i
  fence acquire
  %self.val.i.i.i = load ptr, ptr %7, align 8, !alias.scope !287, !nonnull !6
; call alloc::sync::Arc<T>::drop_slow
  tail call fastcc void @"_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17hbaf97c6b34ae9334E"(ptr nonnull %self.val.i.i.i), !noalias !287
  br label %"_ZN4core3ptr59drop_in_place$LT$std..thread..JoinInner$LT$$LP$$RP$$GT$$GT$17h1f69a472001248fcE.exit"

bb1.i:                                            ; preds = %cleanup.i
  resume { ptr, i32 } %0

"_ZN4core3ptr59drop_in_place$LT$std..thread..JoinInner$LT$$LP$$RP$$GT$$GT$17h1f69a472001248fcE.exit": ; preds = %bb5.i, %bb2.i.i.i
  ret void
}

; core::ptr::drop_in_place<alloc::sync::Arc<redis::client::Client>>
; Function Attrs: nounwind nonlazybind uwtable
define internal fastcc void @"_ZN4core3ptr66drop_in_place$LT$alloc..sync..Arc$LT$redis..client..Client$GT$$GT$17h7f41de5249136022E"(ptr nocapture noundef readonly %_1) unnamed_addr #3 {
start:
  tail call void @llvm.experimental.noalias.scope.decl(metadata !290)
  %self1.i = load ptr, ptr %_1, align 8, !alias.scope !290, !nonnull !6, !noundef !6
  %0 = atomicrmw sub ptr %self1.i, i64 1 release, align 8, !noalias !290
  %1 = icmp eq i64 %0, 1
  br i1 %1, label %bb2.i, label %"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h8df286fb36c045abE.exit"

bb2.i:                                            ; preds = %start
  fence acquire
  %self.val.i = load ptr, ptr %_1, align 8, !alias.scope !290, !nonnull !6
; call alloc::sync::Arc<T>::drop_slow
  tail call fastcc void @"_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17h5bc0dcdc32f3bc06E"(ptr nonnull %self.val.i), !noalias !290
  br label %"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h8df286fb36c045abE.exit"

"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h8df286fb36c045abE.exit": ; preds = %start, %bb2.i
  ret void
}

; core::ptr::drop_in_place<alloc::raw_vec::RawVec<redis::types::Value>>
; Function Attrs: nounwind nonlazybind uwtable
define internal fastcc void @"_ZN4core3ptr70drop_in_place$LT$alloc..raw_vec..RawVec$LT$redis..types..Value$GT$$GT$17ha274f04261b92c1fE"(i64 %_1.0.val, ptr %_1.8.val) unnamed_addr #3 personality ptr @rust_eh_personality {
start:
  %_3.i.i = icmp eq i64 %_1.0.val, 0
  br i1 %_3.i.i, label %"_ZN77_$LT$alloc..raw_vec..RawVec$LT$T$C$A$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hfc784f5dcf42c88dE.exit", label %bb2.i

bb2.i:                                            ; preds = %start
  %_6.i.i.i = icmp ult i64 %_1.0.val, 288230376151711744
  %array_size.i.i.i = shl nuw nsw i64 %_1.0.val, 5
  tail call void @llvm.assume(i1 %_6.i.i.i)
  %0 = icmp ne ptr %_1.8.val, null
  tail call void @llvm.assume(i1 %0)
  tail call void @__rust_dealloc(ptr noundef nonnull %_1.8.val, i64 noundef %array_size.i.i.i, i64 noundef 8) #24
  br label %"_ZN77_$LT$alloc..raw_vec..RawVec$LT$T$C$A$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hfc784f5dcf42c88dE.exit"

"_ZN77_$LT$alloc..raw_vec..RawVec$LT$T$C$A$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hfc784f5dcf42c88dE.exit": ; preds = %start, %bb2.i
  ret void
}

; core::ptr::drop_in_place<core::option::Option<alloc::string::String>>
; Function Attrs: nounwind nonlazybind uwtable
define internal fastcc void @"_ZN4core3ptr70drop_in_place$LT$core..option..Option$LT$alloc..string..String$GT$$GT$17h93941aee084f5427E"(ptr nocapture noundef readonly %_1) unnamed_addr #3 personality ptr @rust_eh_personality {
start:
  %0 = getelementptr %"core::option::Option<alloc::string::String>", ptr %_1, i64 0, i32 1
  %1 = load ptr, ptr %0, align 8, !noundef !6
  %2 = icmp eq ptr %1, null
  br i1 %2, label %bb1, label %bb2

bb1:                                              ; preds = %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i", %bb2, %start
  ret void

bb2:                                              ; preds = %start
  %_1.val.i.i = load i64, ptr %_1, align 8, !noundef !6
  %_3.i.i.i.i.i = icmp eq i64 %_1.val.i.i, 0
  br i1 %_3.i.i.i.i.i, label %bb1, label %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i"

"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i": ; preds = %bb2
  %_6.i.i.i.i.i.i = icmp sgt i64 %_1.val.i.i, -1
  %.sroa.2.0.i.i.i.i.i.i = zext i1 %_6.i.i.i.i.i.i to i64
  tail call void @llvm.assume(i1 %_6.i.i.i.i.i.i)
  tail call void @__rust_dealloc(ptr noundef nonnull %1, i64 noundef %_1.val.i.i, i64 noundef %.sroa.2.0.i.i.i.i.i.i) #24
  br label %bb1
}

; core::ptr::drop_in_place<alloc::sync::ArcInner<redis::client::Client>>
; Function Attrs: nounwind nonlazybind uwtable
define internal fastcc void @"_ZN4core3ptr71drop_in_place$LT$alloc..sync..ArcInner$LT$redis..client..Client$GT$$GT$17h0c5bb33b6ac74b57E"(ptr nocapture noundef readonly %_1) unnamed_addr #3 {
start:
  %0 = getelementptr inbounds %"alloc::sync::ArcInner<redis::client::Client>", ptr %_1, i64 0, i32 2
; call core::ptr::drop_in_place<redis::client::Client>
  tail call fastcc void @"_ZN4core3ptr42drop_in_place$LT$redis..client..Client$GT$17h04bd24b5de385cecE"(ptr noundef nonnull %0)
  ret void
}

; core::ptr::drop_in_place<demo::spawn_user_query::{{closure}}>
; Function Attrs: nonlazybind uwtable
define internal fastcc void @"_ZN4core3ptr72drop_in_place$LT$demo..spawn_user_query..$u7b$$u7b$closure$u7d$$u7d$$GT$17h3fc0c80003884286E"(ptr nocapture noundef readonly %_1) unnamed_addr #1 personality ptr @rust_eh_personality {
start:
  tail call void @llvm.experimental.noalias.scope.decl(metadata !293)
  %self1.i.i = load ptr, ptr %_1, align 8, !alias.scope !293, !nonnull !6, !noundef !6
  %0 = atomicrmw sub ptr %self1.i.i, i64 1 release, align 8, !noalias !293
  %1 = icmp eq i64 %0, 1
  br i1 %1, label %bb2.i.i, label %bb6

bb2.i.i:                                          ; preds = %start
  fence acquire
  %self.val.i.i = load ptr, ptr %_1, align 8, !alias.scope !293, !nonnull !6
; call alloc::sync::Arc<T>::drop_slow
  tail call fastcc void @"_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17h5bc0dcdc32f3bc06E"(ptr nonnull %self.val.i.i), !noalias !293
  br label %bb6

bb6:                                              ; preds = %bb2.i.i, %start
  %2 = getelementptr inbounds %"[closure@src/main.rs:14:19: 14:26]", ptr %_1, i64 0, i32 1
  %_1.val.i.i = load i64, ptr %2, align 8, !noundef !6
  %_3.i.i.i.i.i = icmp eq i64 %_1.val.i.i, 0
  br i1 %_3.i.i.i.i.i, label %bb5, label %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i"

"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i": ; preds = %bb6
  %3 = getelementptr %"[closure@src/main.rs:14:19: 14:26]", ptr %_1, i64 0, i32 1, i32 0, i32 0, i32 1
  %_1.val1.i.i = load ptr, ptr %3, align 8, !nonnull !6
  %_6.i.i.i.i.i.i = icmp sgt i64 %_1.val.i.i, -1
  %.sroa.2.0.i.i.i.i.i.i = zext i1 %_6.i.i.i.i.i.i to i64
  tail call void @llvm.assume(i1 %_6.i.i.i.i.i.i)
  tail call void @__rust_dealloc(ptr noundef nonnull %_1.val1.i.i, i64 noundef %_1.val.i.i, i64 noundef %.sroa.2.0.i.i.i.i.i.i) #24
  br label %bb5

bb5:                                              ; preds = %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i", %bb6
  %4 = getelementptr inbounds %"[closure@src/main.rs:14:19: 14:26]", ptr %_1, i64 0, i32 2
  %_1.val.i.i3 = load i64, ptr %4, align 8, !noundef !6
  %_3.i.i.i.i.i4 = icmp eq i64 %_1.val.i.i3, 0
  br i1 %_3.i.i.i.i.i4, label %"_ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17h5f3174a51a28c86eE.exit9", label %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i8"

"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i8": ; preds = %bb5
  %5 = getelementptr %"[closure@src/main.rs:14:19: 14:26]", ptr %_1, i64 0, i32 2, i32 0, i32 0, i32 1
  %_1.val1.i.i5 = load ptr, ptr %5, align 8, !nonnull !6
  %_6.i.i.i.i.i.i6 = icmp sgt i64 %_1.val.i.i3, -1
  %.sroa.2.0.i.i.i.i.i.i7 = zext i1 %_6.i.i.i.i.i.i6 to i64
  tail call void @llvm.assume(i1 %_6.i.i.i.i.i.i6)
  tail call void @__rust_dealloc(ptr noundef nonnull %_1.val1.i.i5, i64 noundef %_1.val.i.i3, i64 noundef %.sroa.2.0.i.i.i.i.i.i7) #24
  br label %"_ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17h5f3174a51a28c86eE.exit9"

"_ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17h5f3174a51a28c86eE.exit9": ; preds = %bb5, %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i8"
  ret void
}

; core::ptr::drop_in_place<alloc::sync::Arc<std::thread::Packet<()>>>
; Function Attrs: nonlazybind uwtable
define internal fastcc void @"_ZN4core3ptr80drop_in_place$LT$alloc..sync..Arc$LT$std..thread..Packet$LT$$LP$$RP$$GT$$GT$$GT$17hdac63bca8591c1a9E"(ptr nocapture noundef readonly %_1) unnamed_addr #1 {
start:
  tail call void @llvm.experimental.noalias.scope.decl(metadata !296)
  %self1.i = load ptr, ptr %_1, align 8, !alias.scope !296, !nonnull !6, !noundef !6
  %0 = atomicrmw sub ptr %self1.i, i64 1 release, align 8, !noalias !296
  %1 = icmp eq i64 %0, 1
  br i1 %1, label %bb2.i, label %"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hfef7099c19bb28eaE.exit"

bb2.i:                                            ; preds = %start
  fence acquire
  %self.val.i = load ptr, ptr %_1, align 8, !alias.scope !296, !nonnull !6
; call alloc::sync::Arc<T>::drop_slow
  tail call fastcc void @"_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17hbaf97c6b34ae9334E"(ptr nonnull %self.val.i), !noalias !296
  br label %"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hfef7099c19bb28eaE.exit"

"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hfef7099c19bb28eaE.exit": ; preds = %start, %bb2.i
  ret void
}

; core::ptr::drop_in_place<core::result::Result<(),std::io::error::Error>>
; Function Attrs: nonlazybind uwtable
define internal fastcc void @"_ZN4core3ptr81drop_in_place$LT$core..result..Result$LT$$LP$$RP$$C$std..io..error..Error$GT$$GT$17h502ade48c0f79bfbE"(ptr %_1.0.val) unnamed_addr #1 personality ptr @rust_eh_personality {
start:
  %0 = icmp ne ptr %_1.0.val, null
  %_7.cast.i.i.i.i = ptrtoint ptr %_1.0.val to i64
  %_6.i.i.i.i = and i64 %_7.cast.i.i.i.i, 3
  %switch.i.i.i = icmp eq i64 %_6.i.i.i.i, 1
  %or.cond = select i1 %0, i1 %switch.i.i.i, i1 false
  br i1 %or.cond, label %bb2.i1.i.i.i, label %bb1

bb1:                                              ; preds = %"_ZN4core3ptr68drop_in_place$LT$alloc..boxed..Box$LT$std..io..error..Custom$GT$$GT$17h1f84f0febdcf91a3E.exit.i.i.i.i", %start
  ret void

bb2.i1.i.i.i:                                     ; preds = %start
  %1 = getelementptr i8, ptr %_1.0.val, i64 -1
  %2 = icmp ne ptr %1, null
  tail call void @llvm.assume(i1 %2)
  %_4.0.i.i.i.i.i.i.i = load ptr, ptr %1, align 8, !noundef !6
  %3 = getelementptr i8, ptr %_1.0.val, i64 7
  %_4.1.i.i.i.i.i.i.i = load ptr, ptr %3, align 8, !nonnull !6, !align !148, !noundef !6
  %4 = load ptr, ptr %_4.1.i.i.i.i.i.i.i, align 8, !invariant.load !6, !nonnull !6
  invoke void %4(ptr noundef %_4.0.i.i.i.i.i.i.i)
          to label %bb3.i.i.i.i.i.i.i unwind label %cleanup.i.i.i.i.i.i.i

cleanup.i.i.i.i.i.i.i:                            ; preds = %bb2.i1.i.i.i
  %5 = landingpad { ptr, i32 }
          cleanup
  %6 = load ptr, ptr %1, align 8, !nonnull !6, !noundef !6
  %7 = load ptr, ptr %3, align 8, !nonnull !6, !align !148, !noundef !6
  %8 = getelementptr i8, ptr %7, i64 8
  %.val2.i.i.i.i.i.i.i = load i64, ptr %8, align 8, !range !149
  %9 = getelementptr i8, ptr %7, i64 16
  %.val3.i.i.i.i.i.i.i = load i64, ptr %9, align 8, !range !150
; call alloc::alloc::box_free
  tail call fastcc void @_ZN5alloc5alloc8box_free17h11e3a3be7aa785f4E(ptr noundef nonnull %6, i64 %.val2.i.i.i.i.i.i.i, i64 %.val3.i.i.i.i.i.i.i) #21
; call alloc::alloc::box_free
  tail call fastcc void @_ZN5alloc5alloc8box_free17h78ba79ece75676b2E(ptr noundef nonnull %1) #21
  resume { ptr, i32 } %5

bb3.i.i.i.i.i.i.i:                                ; preds = %bb2.i1.i.i.i
  %10 = load ptr, ptr %3, align 8, !nonnull !6, !align !148, !noundef !6
  %11 = getelementptr i8, ptr %10, i64 8
  %.val.i.i.i.i.i.i.i = load i64, ptr %11, align 8, !range !149
  %12 = icmp eq i64 %.val.i.i.i.i.i.i.i, 0
  br i1 %12, label %"_ZN4core3ptr68drop_in_place$LT$alloc..boxed..Box$LT$std..io..error..Custom$GT$$GT$17h1f84f0febdcf91a3E.exit.i.i.i.i", label %bb1.i.i.i.i.i.i.i.i.i

bb1.i.i.i.i.i.i.i.i.i:                            ; preds = %bb3.i.i.i.i.i.i.i
  %13 = getelementptr i8, ptr %10, i64 16
  %.val1.i.i.i.i.i.i.i = load i64, ptr %13, align 8, !range !150
  %14 = load ptr, ptr %1, align 8, !nonnull !6, !noundef !6
  %_18.i.i.i.i.i.i.i.i.i = icmp ult i64 %.val1.i.i.i.i.i.i.i, -9223372036854775807
  tail call void @llvm.assume(i1 %_18.i.i.i.i.i.i.i.i.i)
  tail call void @__rust_dealloc(ptr noundef nonnull %14, i64 noundef %.val.i.i.i.i.i.i.i, i64 noundef %.val1.i.i.i.i.i.i.i) #24
  br label %"_ZN4core3ptr68drop_in_place$LT$alloc..boxed..Box$LT$std..io..error..Custom$GT$$GT$17h1f84f0febdcf91a3E.exit.i.i.i.i"

"_ZN4core3ptr68drop_in_place$LT$alloc..boxed..Box$LT$std..io..error..Custom$GT$$GT$17h1f84f0febdcf91a3E.exit.i.i.i.i": ; preds = %bb1.i.i.i.i.i.i.i.i.i, %bb3.i.i.i.i.i.i.i
  tail call void @__rust_dealloc(ptr noundef nonnull %1, i64 noundef 24, i64 noundef 8) #24
  br label %bb1
}

; core::ptr::drop_in_place<alloc::sync::ArcInner<std::thread::Packet<()>>>
; Function Attrs: nonlazybind uwtable
define internal fastcc void @"_ZN4core3ptr85drop_in_place$LT$alloc..sync..ArcInner$LT$std..thread..Packet$LT$$LP$$RP$$GT$$GT$$GT$17h21358fc51fb9a30cE"(ptr nocapture noundef %_1) unnamed_addr #1 {
start:
  %0 = getelementptr inbounds %"alloc::sync::ArcInner<std::thread::Packet<'_, ()>>", ptr %_1, i64 0, i32 2
; call core::ptr::drop_in_place<std::thread::Packet<()>>
  tail call fastcc void @"_ZN4core3ptr56drop_in_place$LT$std..thread..Packet$LT$$LP$$RP$$GT$$GT$17h95267ed0ad673807E"(ptr noundef nonnull %0)
  ret void
}

; core::ptr::drop_in_place<alloc::boxed::Box<dyn core::any::Any+core::marker::Send>>
; Function Attrs: nonlazybind uwtable
define internal void @"_ZN4core3ptr91drop_in_place$LT$alloc..boxed..Box$LT$dyn$u20$core..any..Any$u2b$core..marker..Send$GT$$GT$17hc9ec03a45b18c819E"(ptr nocapture noundef readonly %_1) unnamed_addr #1 personality ptr @rust_eh_personality {
start:
  %_4.0 = load ptr, ptr %_1, align 8, !noundef !6
  %0 = getelementptr inbounds { ptr, ptr }, ptr %_1, i64 0, i32 1
  %_4.1 = load ptr, ptr %0, align 8, !nonnull !6, !align !148, !noundef !6
  %1 = load ptr, ptr %_4.1, align 8, !invariant.load !6, !nonnull !6
  invoke void %1(ptr noundef %_4.0)
          to label %bb3 unwind label %cleanup

cleanup:                                          ; preds = %start
  %2 = landingpad { ptr, i32 }
          cleanup
  %3 = load ptr, ptr %_1, align 8, !nonnull !6, !noundef !6
  %4 = load ptr, ptr %0, align 8, !nonnull !6, !align !148, !noundef !6
  %5 = getelementptr i8, ptr %4, i64 8
  %.val2 = load i64, ptr %5, align 8, !range !149
  %6 = getelementptr i8, ptr %4, i64 16
  %.val3 = load i64, ptr %6, align 8, !range !150
; call alloc::alloc::box_free
  tail call fastcc void @_ZN5alloc5alloc8box_free17h11e3a3be7aa785f4E(ptr noundef nonnull %3, i64 %.val2, i64 %.val3) #21
  resume { ptr, i32 } %2

bb3:                                              ; preds = %start
  %7 = load ptr, ptr %0, align 8, !nonnull !6, !align !148, !noundef !6
  %8 = getelementptr i8, ptr %7, i64 8
  %.val = load i64, ptr %8, align 8, !range !149
  %9 = icmp eq i64 %.val, 0
  br i1 %9, label %_ZN5alloc5alloc8box_free17heac3398ded37063fE.exit, label %bb1.i.i

bb1.i.i:                                          ; preds = %bb3
  %10 = getelementptr i8, ptr %7, i64 16
  %.val1 = load i64, ptr %10, align 8, !range !150
  %11 = load ptr, ptr %_1, align 8, !nonnull !6, !noundef !6
  %_18.i.i = icmp ult i64 %.val1, -9223372036854775807
  tail call void @llvm.assume(i1 %_18.i.i)
  tail call void @__rust_dealloc(ptr noundef nonnull %11, i64 noundef %.val, i64 noundef %.val1) #24
  br label %_ZN5alloc5alloc8box_free17heac3398ded37063fE.exit

_ZN5alloc5alloc8box_free17heac3398ded37063fE.exit: ; preds = %bb3, %bb1.i.i
  ret void
}

; core::ptr::drop_in_place<std::io::Write::write_fmt::Adapter<std::sys::unix::stdio::Stderr>>
; Function Attrs: nonlazybind uwtable
define internal void @"_ZN4core3ptr92drop_in_place$LT$std..io..Write..write_fmt..Adapter$LT$std..sys..unix..stdio..Stderr$GT$$GT$17h531d7fdd7778cbdeE"(ptr nocapture noundef readonly %_1) unnamed_addr #1 personality ptr @rust_eh_personality {
start:
  %_1.val = load ptr, ptr %_1, align 8, !noundef !6
  %0 = icmp ne ptr %_1.val, null
  %_7.cast.i.i.i.i.i = ptrtoint ptr %_1.val to i64
  %_6.i.i.i.i.i = and i64 %_7.cast.i.i.i.i.i, 3
  %switch.i.i.i.i = icmp eq i64 %_6.i.i.i.i.i, 1
  %or.cond.i = and i1 %0, %switch.i.i.i.i
  br i1 %or.cond.i, label %bb2.i1.i.i.i.i, label %"_ZN4core3ptr81drop_in_place$LT$core..result..Result$LT$$LP$$RP$$C$std..io..error..Error$GT$$GT$17h502ade48c0f79bfbE.exit"

bb2.i1.i.i.i.i:                                   ; preds = %start
  %1 = getelementptr i8, ptr %_1.val, i64 -1
  %2 = icmp ne ptr %1, null
  tail call void @llvm.assume(i1 %2)
  %_4.0.i.i.i.i.i.i.i.i = load ptr, ptr %1, align 8, !noundef !6
  %3 = getelementptr i8, ptr %_1.val, i64 7
  %_4.1.i.i.i.i.i.i.i.i = load ptr, ptr %3, align 8, !nonnull !6, !align !148, !noundef !6
  %4 = load ptr, ptr %_4.1.i.i.i.i.i.i.i.i, align 8, !invariant.load !6, !nonnull !6
  invoke void %4(ptr noundef %_4.0.i.i.i.i.i.i.i.i)
          to label %bb3.i.i.i.i.i.i.i.i unwind label %cleanup.i.i.i.i.i.i.i.i

cleanup.i.i.i.i.i.i.i.i:                          ; preds = %bb2.i1.i.i.i.i
  %5 = landingpad { ptr, i32 }
          cleanup
  %6 = load ptr, ptr %1, align 8, !nonnull !6, !noundef !6
  %7 = load ptr, ptr %3, align 8, !nonnull !6, !align !148, !noundef !6
  %8 = getelementptr i8, ptr %7, i64 8
  %.val2.i.i.i.i.i.i.i.i = load i64, ptr %8, align 8, !range !149
  %9 = getelementptr i8, ptr %7, i64 16
  %.val3.i.i.i.i.i.i.i.i = load i64, ptr %9, align 8, !range !150
; call alloc::alloc::box_free
  tail call fastcc void @_ZN5alloc5alloc8box_free17h11e3a3be7aa785f4E(ptr noundef nonnull %6, i64 %.val2.i.i.i.i.i.i.i.i, i64 %.val3.i.i.i.i.i.i.i.i) #21
; call alloc::alloc::box_free
  tail call fastcc void @_ZN5alloc5alloc8box_free17h78ba79ece75676b2E(ptr noundef nonnull %1) #21
  resume { ptr, i32 } %5

bb3.i.i.i.i.i.i.i.i:                              ; preds = %bb2.i1.i.i.i.i
  %10 = load ptr, ptr %3, align 8, !nonnull !6, !align !148, !noundef !6
  %11 = getelementptr i8, ptr %10, i64 8
  %.val.i.i.i.i.i.i.i.i = load i64, ptr %11, align 8, !range !149
  %12 = icmp eq i64 %.val.i.i.i.i.i.i.i.i, 0
  br i1 %12, label %"_ZN4core3ptr68drop_in_place$LT$alloc..boxed..Box$LT$std..io..error..Custom$GT$$GT$17h1f84f0febdcf91a3E.exit.i.i.i.i.i", label %bb1.i.i.i.i.i.i.i.i.i.i

bb1.i.i.i.i.i.i.i.i.i.i:                          ; preds = %bb3.i.i.i.i.i.i.i.i
  %13 = getelementptr i8, ptr %10, i64 16
  %.val1.i.i.i.i.i.i.i.i = load i64, ptr %13, align 8, !range !150
  %14 = load ptr, ptr %1, align 8, !nonnull !6, !noundef !6
  %_18.i.i.i.i.i.i.i.i.i.i = icmp ult i64 %.val1.i.i.i.i.i.i.i.i, -9223372036854775807
  tail call void @llvm.assume(i1 %_18.i.i.i.i.i.i.i.i.i.i)
  tail call void @__rust_dealloc(ptr noundef nonnull %14, i64 noundef %.val.i.i.i.i.i.i.i.i, i64 noundef %.val1.i.i.i.i.i.i.i.i) #24
  br label %"_ZN4core3ptr68drop_in_place$LT$alloc..boxed..Box$LT$std..io..error..Custom$GT$$GT$17h1f84f0febdcf91a3E.exit.i.i.i.i.i"

"_ZN4core3ptr68drop_in_place$LT$alloc..boxed..Box$LT$std..io..error..Custom$GT$$GT$17h1f84f0febdcf91a3E.exit.i.i.i.i.i": ; preds = %bb1.i.i.i.i.i.i.i.i.i.i, %bb3.i.i.i.i.i.i.i.i
  tail call void @__rust_dealloc(ptr noundef nonnull %1, i64 noundef 24, i64 noundef 8) #24
  br label %"_ZN4core3ptr81drop_in_place$LT$core..result..Result$LT$$LP$$RP$$C$std..io..error..Error$GT$$GT$17h502ade48c0f79bfbE.exit"

"_ZN4core3ptr81drop_in_place$LT$core..result..Result$LT$$LP$$RP$$C$std..io..error..Error$GT$$GT$17h502ade48c0f79bfbE.exit": ; preds = %start, %"_ZN4core3ptr68drop_in_place$LT$alloc..boxed..Box$LT$std..io..error..Custom$GT$$GT$17h1f84f0febdcf91a3E.exit.i.i.i.i.i"
  ret void
}

; <&mut W as core::fmt::Write>::write_char
; Function Attrs: nonlazybind uwtable
define internal noundef zeroext i1 @"_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17h6f5197a8c006540dE"(ptr noalias nocapture noundef readonly align 8 dereferenceable(8) %self, i32 noundef %c) unnamed_addr #1 {
start:
  %_10.i = alloca [4 x i8], align 4
  %_5 = load ptr, ptr %self, align 8, !nonnull !6, !align !148, !noundef !6
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %_10.i), !noalias !299
  store i32 0, ptr %_10.i, align 4, !noalias !299
  %_2.i.i.i = icmp ult i32 %c, 128
  br i1 %_2.i.i.i, label %bb7.i.i, label %bb2.i.i.i

bb2.i.i.i:                                        ; preds = %start
  %_4.i.i.i = icmp ult i32 %c, 2048
  br i1 %_4.i.i.i, label %bb8.i.i, label %bb4.i.i.i

bb4.i.i.i:                                        ; preds = %bb2.i.i.i
  %_6.i.i.i = icmp ult i32 %c, 65536
  %b2.i.i = getelementptr inbounds [0 x i8], ptr %_10.i, i64 0, i64 1
  %c3.i.i = getelementptr inbounds [0 x i8], ptr %_10.i, i64 0, i64 2
  br i1 %_6.i.i.i, label %bb9.i.i, label %bb10.i.i

bb10.i.i:                                         ; preds = %bb4.i.i.i
  %d.i.i = getelementptr inbounds [0 x i8], ptr %_10.i, i64 0, i64 3
  %_55.i.i = lshr i32 %c, 18
  %0 = trunc i32 %_55.i.i to i8
  %_53.i.i = and i8 %0, 7
  %1 = or i8 %_53.i.i, -16
  store i8 %1, ptr %_10.i, align 4, !alias.scope !302, !noalias !299
  %_59.i.i = lshr i32 %c, 12
  %2 = trunc i32 %_59.i.i to i8
  %_57.i.i = and i8 %2, 63
  %3 = or i8 %_57.i.i, -128
  store i8 %3, ptr %b2.i.i, align 1, !alias.scope !302, !noalias !299
  %_63.i.i = lshr i32 %c, 6
  %4 = trunc i32 %_63.i.i to i8
  %_61.i.i = and i8 %4, 63
  %5 = or i8 %_61.i.i, -128
  store i8 %5, ptr %c3.i.i, align 2, !alias.scope !302, !noalias !299
  %6 = trunc i32 %c to i8
  %_65.i.i = and i8 %6, 63
  %7 = or i8 %_65.i.i, -128
  store i8 %7, ptr %d.i.i, align 1, !alias.scope !302, !noalias !299
  br label %_ZN4core3fmt5Write10write_char17h208b4aa1c8599cdeE.exit

bb9.i.i:                                          ; preds = %bb4.i.i.i
  %_40.i.i = lshr i32 %c, 12
  %8 = trunc i32 %_40.i.i to i8
  %9 = or i8 %8, -32
  store i8 %9, ptr %_10.i, align 4, !alias.scope !302, !noalias !299
  %_44.i.i = lshr i32 %c, 6
  %10 = trunc i32 %_44.i.i to i8
  %_42.i.i = and i8 %10, 63
  %11 = or i8 %_42.i.i, -128
  store i8 %11, ptr %b2.i.i, align 1, !alias.scope !302, !noalias !299
  %12 = trunc i32 %c to i8
  %_46.i.i = and i8 %12, 63
  %13 = or i8 %_46.i.i, -128
  store i8 %13, ptr %c3.i.i, align 2, !alias.scope !302, !noalias !299
  br label %_ZN4core3fmt5Write10write_char17h208b4aa1c8599cdeE.exit

bb8.i.i:                                          ; preds = %bb2.i.i.i
  %b5.i.i = getelementptr inbounds [0 x i8], ptr %_10.i, i64 0, i64 1
  %_30.i.i = lshr i32 %c, 6
  %14 = trunc i32 %_30.i.i to i8
  %15 = or i8 %14, -64
  store i8 %15, ptr %_10.i, align 4, !alias.scope !302, !noalias !299
  %16 = trunc i32 %c to i8
  %_32.i.i = and i8 %16, 63
  %17 = or i8 %_32.i.i, -128
  store i8 %17, ptr %b5.i.i, align 1, !alias.scope !302, !noalias !299
  br label %_ZN4core3fmt5Write10write_char17h208b4aa1c8599cdeE.exit

bb7.i.i:                                          ; preds = %start
  %18 = trunc i32 %c to i8
  store i8 %18, ptr %_10.i, align 4, !alias.scope !302, !noalias !299
  br label %_ZN4core3fmt5Write10write_char17h208b4aa1c8599cdeE.exit

_ZN4core3fmt5Write10write_char17h208b4aa1c8599cdeE.exit: ; preds = %bb10.i.i, %bb9.i.i, %bb8.i.i, %bb7.i.i
  %.0.i3.i.i = phi i64 [ 1, %bb7.i.i ], [ 2, %bb8.i.i ], [ 3, %bb9.i.i ], [ 4, %bb10.i.i ]
; call <std::io::Write::write_fmt::Adapter<T> as core::fmt::Write>::write_str
  %19 = call noundef zeroext i1 @"_ZN80_$LT$std..io..Write..write_fmt..Adapter$LT$T$GT$$u20$as$u20$core..fmt..Write$GT$9write_str17h93a9f8277eec1af4E"(ptr noalias noundef nonnull align 8 dereferenceable(16) %_5, ptr noalias noundef nonnull readonly align 1 %_10.i, i64 noundef %.0.i3.i.i)
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %_10.i), !noalias !299
  ret i1 %19
}

; <&mut W as core::fmt::Write>::write_fmt
; Function Attrs: nonlazybind uwtable
define internal noundef zeroext i1 @"_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_fmt17h61027013d987549fE"(ptr noalias nocapture noundef readonly align 8 dereferenceable(8) %self, ptr noalias nocapture noundef readonly dereferenceable(48) %args) unnamed_addr #1 {
start:
  %_6.i = alloca %"core::fmt::Arguments<'_>", align 8
  %self.i = alloca ptr, align 8
  %_5 = load ptr, ptr %self, align 8, !nonnull !6, !align !148, !noundef !6
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %self.i)
  store ptr %_5, ptr %self.i, align 8, !noalias !305
  call void @llvm.lifetime.start.p0(i64 48, ptr nonnull %_6.i), !noalias !305
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(48) %_6.i, ptr noundef nonnull align 8 dereferenceable(48) %args, i64 48, i1 false)
; call core::fmt::write
  %0 = call noundef zeroext i1 @_ZN4core3fmt5write17h93e2f5923c7eca08E(ptr noundef nonnull align 1 %self.i, ptr noalias noundef nonnull readonly align 8 dereferenceable(24) @vtable.3, ptr noalias nocapture noundef nonnull readonly dereferenceable(48) %_6.i), !noalias !309
  call void @llvm.lifetime.end.p0(i64 48, ptr nonnull %_6.i), !noalias !305
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %self.i)
  ret i1 %0
}

; <&mut W as core::fmt::Write>::write_str
; Function Attrs: nonlazybind uwtable
define internal noundef zeroext i1 @"_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hd05fddd57ba332b7E"(ptr noalias nocapture noundef readonly align 8 dereferenceable(8) %self, ptr noalias noundef nonnull readonly align 1 %s.0, i64 noundef %s.1) unnamed_addr #1 {
start:
  %_5 = load ptr, ptr %self, align 8, !nonnull !6, !align !148, !noundef !6
; call <std::io::Write::write_fmt::Adapter<T> as core::fmt::Write>::write_str
  %0 = tail call noundef zeroext i1 @"_ZN80_$LT$std..io..Write..write_fmt..Adapter$LT$T$GT$$u20$as$u20$core..fmt..Write$GT$9write_str17h93a9f8277eec1af4E"(ptr noalias noundef nonnull align 8 dereferenceable(16) %_5, ptr noalias noundef nonnull readonly align 1 %s.0, i64 noundef %s.1)
  ret i1 %0
}

; alloc::sync::Arc<T>::drop_slow
; Function Attrs: noinline nounwind nonlazybind uwtable
define internal fastcc void @"_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17h5bc0dcdc32f3bc06E"(ptr %self.0.val) unnamed_addr #5 {
start:
  %0 = icmp ne ptr %self.0.val, null
  tail call void @llvm.assume(i1 %0)
  %_10 = getelementptr inbounds %"alloc::sync::ArcInner<redis::client::Client>", ptr %self.0.val, i64 0, i32 2
; call core::ptr::drop_in_place<redis::client::Client>
  tail call fastcc void @"_ZN4core3ptr42drop_in_place$LT$redis..client..Client$GT$17h04bd24b5de385cecE"(ptr noundef nonnull %_10)
  %1 = icmp eq ptr %self.0.val, inttoptr (i64 -1 to ptr)
  br i1 %1, label %"_ZN4core3ptr67drop_in_place$LT$alloc..sync..Weak$LT$redis..client..Client$GT$$GT$17h2d730ebce8c7abb8E.exit", label %bb2.i.i

bb2.i.i:                                          ; preds = %start
  %_11.i.i.i = getelementptr inbounds %"alloc::sync::ArcInner<redis::client::Client>", ptr %self.0.val, i64 0, i32 1
  %2 = atomicrmw sub ptr %_11.i.i.i, i64 1 release, align 8, !noalias !310
  %3 = icmp eq i64 %2, 1
  br i1 %3, label %bb4.i.i, label %"_ZN4core3ptr67drop_in_place$LT$alloc..sync..Weak$LT$redis..client..Client$GT$$GT$17h2d730ebce8c7abb8E.exit"

bb4.i.i:                                          ; preds = %bb2.i.i
  fence acquire
  tail call void @__rust_dealloc(ptr noundef nonnull %self.0.val, i64 noundef 104, i64 noundef 8) #24, !noalias !310
  br label %"_ZN4core3ptr67drop_in_place$LT$alloc..sync..Weak$LT$redis..client..Client$GT$$GT$17h2d730ebce8c7abb8E.exit"

"_ZN4core3ptr67drop_in_place$LT$alloc..sync..Weak$LT$redis..client..Client$GT$$GT$17h2d730ebce8c7abb8E.exit": ; preds = %start, %bb2.i.i, %bb4.i.i
  ret void
}

; alloc::sync::Arc<T>::drop_slow
; Function Attrs: noinline nounwind nonlazybind uwtable
define internal fastcc void @"_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17h9988cc5f56f4cc91E"(ptr %self.0.val) unnamed_addr #5 personality ptr @rust_eh_personality {
start:
  %0 = icmp ne ptr %self.0.val, null
  tail call void @llvm.assume(i1 %0)
  %1 = getelementptr inbounds %"alloc::sync::ArcInner<std::sync::mutex::Mutex<alloc::vec::Vec<u8>>>", ptr %self.0.val, i64 0, i32 2, i32 3
  %_1.val.i.i.i = load i64, ptr %1, align 8, !noundef !6
  %_3.i.i.i.i.i.i = icmp eq i64 %_1.val.i.i.i, 0
  br i1 %_3.i.i.i.i.i.i, label %"_ZN4core3ptr77drop_in_place$LT$std..sync..mutex..Mutex$LT$alloc..vec..Vec$LT$u8$GT$$GT$$GT$17h9e44b73261db1c22E.exit", label %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i"

"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i": ; preds = %start
  %2 = getelementptr %"alloc::sync::ArcInner<std::sync::mutex::Mutex<alloc::vec::Vec<u8>>>", ptr %self.0.val, i64 0, i32 2, i32 3, i32 0, i32 0, i32 1
  %_1.val1.i.i.i = load ptr, ptr %2, align 8, !nonnull !6
  %_6.i.i.i.i.i.i.i = icmp sgt i64 %_1.val.i.i.i, -1
  %.sroa.2.0.i.i.i.i.i.i.i = zext i1 %_6.i.i.i.i.i.i.i to i64
  tail call void @llvm.assume(i1 %_6.i.i.i.i.i.i.i)
  tail call void @__rust_dealloc(ptr noundef nonnull %_1.val1.i.i.i, i64 noundef %_1.val.i.i.i, i64 noundef %.sroa.2.0.i.i.i.i.i.i.i) #24
  br label %"_ZN4core3ptr77drop_in_place$LT$std..sync..mutex..Mutex$LT$alloc..vec..Vec$LT$u8$GT$$GT$$GT$17h9e44b73261db1c22E.exit"

"_ZN4core3ptr77drop_in_place$LT$std..sync..mutex..Mutex$LT$alloc..vec..Vec$LT$u8$GT$$GT$$GT$17h9e44b73261db1c22E.exit": ; preds = %start, %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i.i.i"
  %3 = icmp eq ptr %self.0.val, inttoptr (i64 -1 to ptr)
  br i1 %3, label %"_ZN4core3ptr102drop_in_place$LT$alloc..sync..Weak$LT$std..sync..mutex..Mutex$LT$alloc..vec..Vec$LT$u8$GT$$GT$$GT$$GT$17h60c694276d070b8bE.exit", label %bb2.i.i

bb2.i.i:                                          ; preds = %"_ZN4core3ptr77drop_in_place$LT$std..sync..mutex..Mutex$LT$alloc..vec..Vec$LT$u8$GT$$GT$$GT$17h9e44b73261db1c22E.exit"
  %_11.i.i.i = getelementptr inbounds %"alloc::sync::ArcInner<std::sync::mutex::Mutex<alloc::vec::Vec<u8>>>", ptr %self.0.val, i64 0, i32 1
  %4 = atomicrmw sub ptr %_11.i.i.i, i64 1 release, align 8, !noalias !313
  %5 = icmp eq i64 %4, 1
  br i1 %5, label %bb4.i.i, label %"_ZN4core3ptr102drop_in_place$LT$alloc..sync..Weak$LT$std..sync..mutex..Mutex$LT$alloc..vec..Vec$LT$u8$GT$$GT$$GT$$GT$17h60c694276d070b8bE.exit"

bb4.i.i:                                          ; preds = %bb2.i.i
  fence acquire
  tail call void @__rust_dealloc(ptr noundef nonnull %self.0.val, i64 noundef 48, i64 noundef 8) #24, !noalias !313
  br label %"_ZN4core3ptr102drop_in_place$LT$alloc..sync..Weak$LT$std..sync..mutex..Mutex$LT$alloc..vec..Vec$LT$u8$GT$$GT$$GT$$GT$17h60c694276d070b8bE.exit"

"_ZN4core3ptr102drop_in_place$LT$alloc..sync..Weak$LT$std..sync..mutex..Mutex$LT$alloc..vec..Vec$LT$u8$GT$$GT$$GT$$GT$17h60c694276d070b8bE.exit": ; preds = %"_ZN4core3ptr77drop_in_place$LT$std..sync..mutex..Mutex$LT$alloc..vec..Vec$LT$u8$GT$$GT$$GT$17h9e44b73261db1c22E.exit", %bb2.i.i, %bb4.i.i
  ret void
}

; alloc::sync::Arc<T>::drop_slow
; Function Attrs: noinline nonlazybind uwtable
define internal fastcc void @"_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17hbaf97c6b34ae9334E"(ptr %self.0.val) unnamed_addr #0 {
start:
  %0 = icmp ne ptr %self.0.val, null
  tail call void @llvm.assume(i1 %0)
  %_10 = getelementptr inbounds %"alloc::sync::ArcInner<std::thread::Packet<'_, ()>>", ptr %self.0.val, i64 0, i32 2
; call core::ptr::drop_in_place<std::thread::Packet<()>>
  tail call fastcc void @"_ZN4core3ptr56drop_in_place$LT$std..thread..Packet$LT$$LP$$RP$$GT$$GT$17h95267ed0ad673807E"(ptr noundef nonnull %_10)
  %1 = icmp eq ptr %self.0.val, inttoptr (i64 -1 to ptr)
  br i1 %1, label %"_ZN4core3ptr81drop_in_place$LT$alloc..sync..Weak$LT$std..thread..Packet$LT$$LP$$RP$$GT$$GT$$GT$17h333c0da1e5836dd1E.exit", label %bb2.i.i

bb2.i.i:                                          ; preds = %start
  %_11.i.i.i = getelementptr inbounds %"alloc::sync::ArcInner<std::thread::Packet<'_, ()>>", ptr %self.0.val, i64 0, i32 1
  %2 = atomicrmw sub ptr %_11.i.i.i, i64 1 release, align 8, !noalias !316
  %3 = icmp eq i64 %2, 1
  br i1 %3, label %bb4.i.i, label %"_ZN4core3ptr81drop_in_place$LT$alloc..sync..Weak$LT$std..thread..Packet$LT$$LP$$RP$$GT$$GT$$GT$17h333c0da1e5836dd1E.exit"

bb4.i.i:                                          ; preds = %bb2.i.i
  fence acquire
  tail call void @__rust_dealloc(ptr noundef nonnull %self.0.val, i64 noundef 48, i64 noundef 8) #24, !noalias !316
  br label %"_ZN4core3ptr81drop_in_place$LT$alloc..sync..Weak$LT$std..thread..Packet$LT$$LP$$RP$$GT$$GT$$GT$17h333c0da1e5836dd1E.exit"

"_ZN4core3ptr81drop_in_place$LT$alloc..sync..Weak$LT$std..thread..Packet$LT$$LP$$RP$$GT$$GT$$GT$17h333c0da1e5836dd1E.exit": ; preds = %start, %bb2.i.i, %bb4.i.i
  ret void
}

; alloc::sync::Arc<T>::drop_slow
; Function Attrs: noinline nounwind nonlazybind uwtable
define internal fastcc void @"_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17he68302373675f7f4E"(ptr %self.0.val) unnamed_addr #5 personality ptr @rust_eh_personality {
start:
  %0 = icmp ne ptr %self.0.val, null
  tail call void @llvm.assume(i1 %0)
  %_10 = getelementptr inbounds %"alloc::sync::ArcInner<std::thread::Inner>", ptr %self.0.val, i64 0, i32 2
  %1 = load ptr, ptr %_10, align 8, !noundef !6
  %2 = icmp eq ptr %1, null
  br i1 %2, label %"_ZN4core3ptr39drop_in_place$LT$std..thread..Inner$GT$17he6fb0d306cd8c71dE.exit", label %bb2.i.i

bb2.i.i:                                          ; preds = %start
  store i8 0, ptr %1, align 1
  %3 = getelementptr %"alloc::sync::ArcInner<std::thread::Inner>", ptr %self.0.val, i64 0, i32 2, i32 0, i32 1
  %_1.val2.i.i.i = load i64, ptr %3, align 8, !noundef !6
  %4 = icmp eq i64 %_1.val2.i.i.i, 0
  br i1 %4, label %"_ZN4core3ptr39drop_in_place$LT$std..thread..Inner$GT$17he6fb0d306cd8c71dE.exit", label %bb1.i.i.i.i.i.i

bb1.i.i.i.i.i.i:                                  ; preds = %bb2.i.i
  %_1.val1.i.i.i = load ptr, ptr %_10, align 8, !nonnull !6, !noundef !6
  tail call void @__rust_dealloc(ptr noundef nonnull %_1.val1.i.i.i, i64 noundef %_1.val2.i.i.i, i64 noundef 1) #24
  br label %"_ZN4core3ptr39drop_in_place$LT$std..thread..Inner$GT$17he6fb0d306cd8c71dE.exit"

"_ZN4core3ptr39drop_in_place$LT$std..thread..Inner$GT$17he6fb0d306cd8c71dE.exit": ; preds = %start, %bb2.i.i, %bb1.i.i.i.i.i.i
  %5 = icmp eq ptr %self.0.val, inttoptr (i64 -1 to ptr)
  br i1 %5, label %"_ZN4core3ptr64drop_in_place$LT$alloc..sync..Weak$LT$std..thread..Inner$GT$$GT$17h38bfcd371e007482E.exit", label %bb2.i.i2

bb2.i.i2:                                         ; preds = %"_ZN4core3ptr39drop_in_place$LT$std..thread..Inner$GT$17he6fb0d306cd8c71dE.exit"
  %_11.i.i.i = getelementptr inbounds %"alloc::sync::ArcInner<std::thread::Inner>", ptr %self.0.val, i64 0, i32 1
  %6 = atomicrmw sub ptr %_11.i.i.i, i64 1 release, align 8, !noalias !319
  %7 = icmp eq i64 %6, 1
  br i1 %7, label %bb4.i.i, label %"_ZN4core3ptr64drop_in_place$LT$alloc..sync..Weak$LT$std..thread..Inner$GT$$GT$17h38bfcd371e007482E.exit"

bb4.i.i:                                          ; preds = %bb2.i.i2
  fence acquire
  tail call void @__rust_dealloc(ptr noundef nonnull %self.0.val, i64 noundef 48, i64 noundef 8) #24, !noalias !319
  br label %"_ZN4core3ptr64drop_in_place$LT$alloc..sync..Weak$LT$std..thread..Inner$GT$$GT$17h38bfcd371e007482E.exit"

"_ZN4core3ptr64drop_in_place$LT$alloc..sync..Weak$LT$std..thread..Inner$GT$$GT$17h38bfcd371e007482E.exit": ; preds = %"_ZN4core3ptr39drop_in_place$LT$std..thread..Inner$GT$17he6fb0d306cd8c71dE.exit", %bb2.i.i2, %bb4.i.i
  ret void
}

; alloc::sync::Arc<T>::drop_slow
; Function Attrs: noinline nounwind nonlazybind uwtable
define internal fastcc void @"_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17hf7031fc3d45c20a4E"(ptr %self.0.val) unnamed_addr #5 {
start:
  %0 = icmp ne ptr %self.0.val, null
  tail call void @llvm.assume(i1 %0)
  %1 = getelementptr inbounds %"alloc::sync::ArcInner<std::thread::scoped::ScopeData>", ptr %self.0.val, i64 0, i32 2, i32 1
  tail call void @llvm.experimental.noalias.scope.decl(metadata !322)
  %self1.i.i.i.i.i = load ptr, ptr %1, align 8, !alias.scope !322, !nonnull !6, !noundef !6
  %2 = atomicrmw sub ptr %self1.i.i.i.i.i, i64 1 release, align 8, !noalias !322
  %3 = icmp eq i64 %2, 1
  br i1 %3, label %bb2.i.i.i.i.i, label %"_ZN4core3ptr51drop_in_place$LT$std..thread..scoped..ScopeData$GT$17hf1808737236cfc13E.exit"

bb2.i.i.i.i.i:                                    ; preds = %start
  fence acquire
  %self.val.i.i.i.i.i = load ptr, ptr %1, align 8, !alias.scope !322, !nonnull !6
; call alloc::sync::Arc<T>::drop_slow
  tail call fastcc void @"_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17he68302373675f7f4E"(ptr nonnull %self.val.i.i.i.i.i), !noalias !322
  br label %"_ZN4core3ptr51drop_in_place$LT$std..thread..scoped..ScopeData$GT$17hf1808737236cfc13E.exit"

"_ZN4core3ptr51drop_in_place$LT$std..thread..scoped..ScopeData$GT$17hf1808737236cfc13E.exit": ; preds = %start, %bb2.i.i.i.i.i
  %4 = icmp eq ptr %self.0.val, inttoptr (i64 -1 to ptr)
  br i1 %4, label %"_ZN4core3ptr76drop_in_place$LT$alloc..sync..Weak$LT$std..thread..scoped..ScopeData$GT$$GT$17h9253f67838bc51b2E.exit", label %bb2.i.i

bb2.i.i:                                          ; preds = %"_ZN4core3ptr51drop_in_place$LT$std..thread..scoped..ScopeData$GT$17hf1808737236cfc13E.exit"
  %_11.i.i.i = getelementptr inbounds %"alloc::sync::ArcInner<std::thread::scoped::ScopeData>", ptr %self.0.val, i64 0, i32 1
  %5 = atomicrmw sub ptr %_11.i.i.i, i64 1 release, align 8, !noalias !325
  %6 = icmp eq i64 %5, 1
  br i1 %6, label %bb4.i.i, label %"_ZN4core3ptr76drop_in_place$LT$alloc..sync..Weak$LT$std..thread..scoped..ScopeData$GT$$GT$17h9253f67838bc51b2E.exit"

bb4.i.i:                                          ; preds = %bb2.i.i
  fence acquire
  tail call void @__rust_dealloc(ptr noundef nonnull %self.0.val, i64 noundef 40, i64 noundef 8) #24, !noalias !325
  br label %"_ZN4core3ptr76drop_in_place$LT$alloc..sync..Weak$LT$std..thread..scoped..ScopeData$GT$$GT$17h9253f67838bc51b2E.exit"

"_ZN4core3ptr76drop_in_place$LT$alloc..sync..Weak$LT$std..thread..scoped..ScopeData$GT$$GT$17h9253f67838bc51b2E.exit": ; preds = %"_ZN4core3ptr51drop_in_place$LT$std..thread..scoped..ScopeData$GT$17hf1808737236cfc13E.exit", %bb2.i.i, %bb4.i.i
  ret void
}

; alloc::alloc::box_free
; Function Attrs: inlinehint nounwind nonlazybind uwtable
define internal fastcc void @_ZN5alloc5alloc8box_free17h11e3a3be7aa785f4E(ptr noundef nonnull %0, i64 %.8.val, i64 %.16.val) unnamed_addr #6 personality ptr @rust_eh_personality {
start:
  %1 = icmp eq i64 %.8.val, 0
  br i1 %1, label %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit", label %bb1.i

bb1.i:                                            ; preds = %start
  %_18.i = icmp ult i64 %.16.val, -9223372036854775807
  tail call void @llvm.assume(i1 %_18.i)
  tail call void @__rust_dealloc(ptr noundef nonnull %0, i64 noundef %.8.val, i64 noundef %.16.val) #24
  br label %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit"

"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit": ; preds = %start, %bb1.i
  ret void
}

; alloc::alloc::box_free
; Function Attrs: inlinehint nounwind nonlazybind uwtable
define internal fastcc void @_ZN5alloc5alloc8box_free17h78ba79ece75676b2E(ptr noundef nonnull %0) unnamed_addr #6 personality ptr @rust_eh_personality {
start:
  tail call void @__rust_dealloc(ptr noundef nonnull %0, i64 noundef 24, i64 noundef 8) #24
  ret void
}

; redis::connection::ConnectionLike::req_command
; Function Attrs: nonlazybind uwtable
define internal fastcc void @_ZN5redis10connection14ConnectionLike11req_command17hb44cc350392f82eeE(ptr noalias nocapture noundef sret(%"core::result::Result<redis::types::Value, redis::types::RedisError>") dereferenceable(56) %0, ptr noalias noundef align 8 dereferenceable(88) %self, ptr noalias noundef readonly align 8 dereferenceable(64) %cmd) unnamed_addr #1 personality ptr @rust_eh_personality {
start:
  %pcmd = alloca %"alloc::vec::Vec<u8>", align 8
  call void @llvm.lifetime.start.p0(i64 24, ptr nonnull %pcmd)
  store i64 0, ptr %pcmd, align 8, !alias.scope !328, !noalias !331
  %1 = getelementptr inbounds { i64, ptr }, ptr %pcmd, i64 0, i32 1
  store ptr inttoptr (i64 1 to ptr), ptr %1, align 8, !alias.scope !328, !noalias !331
  %2 = getelementptr inbounds %"alloc::vec::Vec<u8>", ptr %pcmd, i64 0, i32 1
  store i64 0, ptr %2, align 8, !alias.scope !328, !noalias !331
; invoke redis::cmd::Cmd::write_packed_command
  invoke void @_ZN5redis3cmd3Cmd20write_packed_command17h335349a4c3f61478E(ptr noalias noundef nonnull readonly align 8 dereferenceable(64) %cmd, ptr noalias noundef nonnull align 8 dereferenceable(24) %pcmd)
          to label %bb2 unwind label %cleanup.i

cleanup.i:                                        ; preds = %start
  %3 = landingpad { ptr, i32 }
          cleanup
; invoke core::ptr::drop_in_place<alloc::vec::Vec<u8>>
  invoke fastcc void @"_ZN4core3ptr46drop_in_place$LT$alloc..vec..Vec$LT$u8$GT$$GT$17h3b6c9b466e6e94d4E"(ptr noundef nonnull %pcmd) #21
          to label %common.resume unwind label %abort.i

abort.i:                                          ; preds = %cleanup.i
  %4 = landingpad { ptr, i32 }
          cleanup
; call core::panicking::panic_cannot_unwind
  call void @_ZN4core9panicking19panic_cannot_unwind17h42344709dec62f2eE() #23
  unreachable

common.resume:                                    ; preds = %cleanup, %cleanup.i
  %common.resume.op = phi { ptr, i32 } [ %3, %cleanup.i ], [ %5, %cleanup ]
  resume { ptr, i32 } %common.resume.op

cleanup:                                          ; preds = %bb2
  %5 = landingpad { ptr, i32 }
          cleanup
; invoke core::ptr::drop_in_place<alloc::vec::Vec<u8>>
  invoke fastcc void @"_ZN4core3ptr46drop_in_place$LT$alloc..vec..Vec$LT$u8$GT$$GT$17h3b6c9b466e6e94d4E"(ptr noundef nonnull %pcmd) #21
          to label %common.resume unwind label %abort

bb2:                                              ; preds = %start
  %pcmd.val = load ptr, ptr %1, align 8, !nonnull !6, !noundef !6
  %pcmd.val1 = load i64, ptr %2, align 8, !noundef !6
; invoke <redis::connection::Connection as redis::connection::ConnectionLike>::req_packed_command
  invoke void @"_ZN83_$LT$redis..connection..Connection$u20$as$u20$redis..connection..ConnectionLike$GT$18req_packed_command17ha574c0c9bed78e8fE"(ptr noalias nocapture noundef nonnull sret(%"core::result::Result<redis::types::Value, redis::types::RedisError>") dereferenceable(56) %0, ptr noalias noundef nonnull align 8 dereferenceable(88) %self, ptr noalias noundef nonnull readonly align 1 %pcmd.val, i64 noundef %pcmd.val1)
          to label %bb3 unwind label %cleanup

bb3:                                              ; preds = %bb2
  %_1.val.i = load i64, ptr %pcmd, align 8, !noundef !6
  %_3.i.i.i.i = icmp eq i64 %_1.val.i, 0
  br i1 %_3.i.i.i.i, label %"_ZN4core3ptr46drop_in_place$LT$alloc..vec..Vec$LT$u8$GT$$GT$17h3b6c9b466e6e94d4E.exit", label %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i"

"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i": ; preds = %bb3
  %_1.val1.i = load ptr, ptr %1, align 8, !nonnull !6
  %_6.i.i.i.i.i = icmp sgt i64 %_1.val.i, -1
  %.sroa.2.0.i.i.i.i.i = zext i1 %_6.i.i.i.i.i to i64
  call void @llvm.assume(i1 %_6.i.i.i.i.i)
  call void @__rust_dealloc(ptr noundef nonnull %_1.val1.i, i64 noundef %_1.val.i, i64 noundef %.sroa.2.0.i.i.i.i.i) #24
  br label %"_ZN4core3ptr46drop_in_place$LT$alloc..vec..Vec$LT$u8$GT$$GT$17h3b6c9b466e6e94d4E.exit"

"_ZN4core3ptr46drop_in_place$LT$alloc..vec..Vec$LT$u8$GT$$GT$17h3b6c9b466e6e94d4E.exit": ; preds = %bb3, %"_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hd3b6f63f10d4c319E.exit.i.i.i"
  call void @llvm.lifetime.end.p0(i64 24, ptr nonnull %pcmd)
  ret void

abort:                                            ; preds = %cleanup
  %6 = landingpad { ptr, i32 }
          cleanup
; call core::panicking::panic_cannot_unwind
  call void @_ZN4core9panicking19panic_cannot_unwind17h42344709dec62f2eE() #23
  unreachable
}

; <alloc::string::String as core::fmt::Display>::fmt
; Function Attrs: inlinehint nonlazybind uwtable
define internal noundef zeroext i1 @"_ZN60_$LT$alloc..string..String$u20$as$u20$core..fmt..Display$GT$3fmt17h5fbcba97ac02a262E"(ptr noalias nocapture noundef readonly align 8 dereferenceable(24) %self, ptr noalias noundef align 8 dereferenceable(64) %f) unnamed_addr #2 {
start:
  %0 = getelementptr i8, ptr %self, i64 8
  %self.val = load ptr, ptr %0, align 8, !nonnull !6, !noundef !6
  %1 = getelementptr i8, ptr %self, i64 16
  %self.val1 = load i64, ptr %1, align 8, !noundef !6
; call <str as core::fmt::Display>::fmt
  %2 = tail call noundef zeroext i1 @"_ZN42_$LT$str$u20$as$u20$core..fmt..Display$GT$3fmt17h592dabb109171ad2E"(ptr noalias noundef nonnull readonly align 1 %self.val, i64 noundef %self.val1, ptr noalias noundef nonnull align 8 dereferenceable(64) %f)
  ret i1 %2
}

; <alloc::boxed::Box<T,A> as core::fmt::Debug>::fmt
; Function Attrs: nonlazybind uwtable
define internal noundef zeroext i1 @"_ZN67_$LT$alloc..boxed..Box$LT$T$C$A$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17hb5083c8805e6966dE"(ptr noalias nocapture noundef readonly align 8 dereferenceable(16) %self, ptr noalias noundef align 8 dereferenceable(64) %f) unnamed_addr #1 {
start:
  %_6.0 = load ptr, ptr %self, align 8, !nonnull !6, !align !180, !noundef !6
  %0 = getelementptr inbounds { ptr, ptr }, ptr %self, i64 0, i32 1
  %_6.1 = load ptr, ptr %0, align 8, !nonnull !6, !align !148, !noundef !6
; call <dyn core::any::Any+core::marker::Send as core::fmt::Debug>::fmt
  %1 = tail call noundef zeroext i1 @"_ZN82_$LT$dyn$u20$core..any..Any$u2b$core..marker..Send$u20$as$u20$core..fmt..Debug$GT$3fmt17h1a4efa3817931fb5E"(ptr noundef nonnull align 1 %_6.0, ptr noalias noundef nonnull readonly align 8 dereferenceable(24) %_6.1, ptr noalias noundef nonnull align 8 dereferenceable(64) %f)
  ret i1 %1
}

; <std::io::Write::write_fmt::Adapter<T> as core::fmt::Write>::write_str
; Function Attrs: nonlazybind uwtable
define internal noundef zeroext i1 @"_ZN80_$LT$std..io..Write..write_fmt..Adapter$LT$T$GT$$u20$as$u20$core..fmt..Write$GT$9write_str17h93a9f8277eec1af4E"(ptr noalias nocapture noundef align 8 dereferenceable(16) %self, ptr noalias noundef nonnull readonly align 1 %s.0, i64 noundef %s.1) unnamed_addr #1 personality ptr @rust_eh_personality {
start:
  %_6.i = alloca %"core::result::Result<usize, std::io::error::Error>", align 8
  %0 = getelementptr inbounds { ptr, ptr }, ptr %self, i64 0, i32 1
  %_12 = load ptr, ptr %0, align 8, !nonnull !6, !align !180, !noundef !6
  %_4.not27.i = icmp eq i64 %s.1, 0
  br i1 %_4.not27.i, label %bb7, label %bb2.lr.ph.i

bb2.lr.ph.i:                                      ; preds = %start
  %1 = getelementptr inbounds %"core::result::Result<usize, std::io::error::Error>::Err", ptr %_6.i, i64 0, i32 1
  br label %bb2.i

bb2.i:                                            ; preds = %bb16.i, %bb2.lr.ph.i
  %buf.sroa.0.029.i = phi ptr [ %s.0, %bb2.lr.ph.i ], [ %buf.sroa.0.152.i, %bb16.i ]
  %buf.sroa.5.028.i = phi i64 [ %s.1, %bb2.lr.ph.i ], [ %buf.sroa.5.150.i, %bb16.i ]
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %_6.i), !noalias !333
; call <std::sys::unix::stdio::Stderr as std::io::Write>::write
  call void @"_ZN64_$LT$std..sys..unix..stdio..Stderr$u20$as$u20$std..io..Write$GT$5write17he10f3cdf2d243ffdE"(ptr noalias nocapture noundef nonnull sret(%"core::result::Result<usize, std::io::error::Error>") dereferenceable(16) %_6.i, ptr noalias noundef nonnull align 1 %_12, ptr noalias noundef nonnull readonly align 1 %buf.sroa.0.029.i, i64 noundef %buf.sroa.5.028.i)
  %_9.i = load i64, ptr %_6.i, align 8, !range !201, !noalias !333, !noundef !6
  %trunc.not.i = icmp eq i64 %_9.i, 0
  br i1 %trunc.not.i, label %bb4.i, label %bb8.i

bb4.i:                                            ; preds = %bb2.i
  %2 = load i64, ptr %1, align 8, !noalias !333, !noundef !6
  %3 = icmp eq i64 %2, 0
  br i1 %3, label %bb2, label %bb7.i

bb8.i:                                            ; preds = %bb2.i
  %.val.i = load ptr, ptr %1, align 8, !noalias !333, !nonnull !6, !noundef !6
  %_7.cast.i.i.i = ptrtoint ptr %.val.i to i64
  %_6.i.i.i = and i64 %_7.cast.i.i.i, 3
  switch i64 %_6.i.i.i, label %start.unreachabledefault.i.i.i [
    i64 2, label %bb3.i.i
    i64 3, label %bb3.i.i.i
    i64 0, label %bb9.i.thread26
    i64 1, label %bb9.i
  ]

start.unreachabledefault.i.i.i:                   ; preds = %bb8.i
  unreachable

bb3.i.i.i:                                        ; preds = %bb8.i
  %_14.i.i.mask.i = and i64 %_7.cast.i.i.i, -4294967296
  %switch14.i = icmp eq i64 %_14.i.i.mask.i, 150323855360
  br i1 %switch14.i, label %bb16.i, label %bb2

bb3.i.i:                                          ; preds = %bb8.i
  %4 = lshr i64 %_7.cast.i.i.i, 32
  %code.i.i.i = trunc i64 %4 to i32
; invoke std::sys::unix::decode_error_kind
  %5 = invoke noundef i8 @_ZN3std3sys4unix17decode_error_kind17h5adf76a4518830caE(i32 noundef %code.i.i.i)
          to label %bb9.i.thread unwind label %bb21.i

bb9.i:                                            ; preds = %bb8.i
  %6 = getelementptr i8, ptr %.val.i, i64 -1
  %7 = icmp ne ptr %6, null
  tail call void @llvm.assume(i1 %7)
  %8 = getelementptr i8, ptr %.val.i, i64 15
  %9 = load i8, ptr %8, align 8, !range !337
  %_22.i = icmp eq i8 %9, 35
  br i1 %_22.i, label %bb2.i1.i.i.i.i, label %bb2

bb9.i.thread26:                                   ; preds = %bb8.i
  %10 = getelementptr inbounds %"std::io::error::SimpleMessage", ptr %.val.i, i64 0, i32 1
  %11 = load i8, ptr %10, align 8, !range !337
  %_22.i28 = icmp eq i8 %11, 35
  br i1 %_22.i28, label %bb16.i, label %bb2

bb9.i.thread:                                     ; preds = %bb3.i.i
  %_22.i21 = icmp eq i8 %5, 35
  br i1 %_22.i21, label %bb16.i, label %bb2

bb19.i:                                           ; preds = %bb7.i
  %12 = getelementptr inbounds i8, ptr %buf.sroa.0.029.i, i64 %2
  %len.i.i.i = sub i64 %buf.sroa.5.028.i, %2
  br label %bb16.i

bb7.i:                                            ; preds = %bb4.i
  %_3.i.i = icmp ult i64 %buf.sroa.5.028.i, %2
  br i1 %_3.i.i, label %bb1.i7.i, label %bb19.i

bb1.i7.i:                                         ; preds = %bb7.i
; call core::slice::index::slice_start_index_len_fail
  tail call void @_ZN4core5slice5index26slice_start_index_len_fail17h504609f2a6b168d1E(i64 noundef %2, i64 noundef %buf.sroa.5.028.i, ptr noalias noundef nonnull readonly align 8 dereferenceable(24) @alloc266) #22
  unreachable

common.resume:                                    ; preds = %bb21.i, %cleanup.i.i.i.i.i.i.i.i, %cleanup.i.i.i.i.i.i.i.i12
  %common.resume.op = phi { ptr, i32 } [ %31, %cleanup.i.i.i.i.i.i.i.i12 ], [ %16, %cleanup.i.i.i.i.i.i.i.i ], [ %lpad.loopexit.i, %bb21.i ]
  resume { ptr, i32 } %common.resume.op

bb21.i:                                           ; preds = %bb3.i.i
  %lpad.loopexit.i = landingpad { ptr, i32 }
          cleanup
; invoke core::ptr::drop_in_place<std::io::error::Error>
  invoke void @"_ZN4core3ptr42drop_in_place$LT$std..io..error..Error$GT$17h44b2f0e87eb79141E"(ptr noundef nonnull %1) #21
          to label %common.resume unwind label %abort.i

abort.i:                                          ; preds = %bb21.i
  %13 = landingpad { ptr, i32 }
          cleanup
; call core::panicking::panic_cannot_unwind
  tail call void @_ZN4core9panicking19panic_cannot_unwind17h42344709dec62f2eE() #23
  unreachable

bb16.i:                                           ; preds = %bb9.i.thread26, %bb9.i.thread, %bb3.i.i.i, %"_ZN4core3ptr68drop_in_place$LT$alloc..boxed..Box$LT$std..io..error..Custom$GT$$GT$17h1f84f0febdcf91a3E.exit.i.i.i.i.i", %bb19.i
  %buf.sroa.0.152.i = phi ptr [ %buf.sroa.0.029.i, %"_ZN4core3ptr68drop_in_place$LT$alloc..boxed..Box$LT$std..io..error..Custom$GT$$GT$17h1f84f0febdcf91a3E.exit.i.i.i.i.i" ], [ %12, %bb19.i ], [ %buf.sroa.0.029.i, %bb3.i.i.i ], [ %buf.sroa.0.029.i, %bb9.i.thread ], [ %buf.sroa.0.029.i, %bb9.i.thread26 ]
  %buf.sroa.5.150.i = phi i64 [ %buf.sroa.5.028.i, %"_ZN4core3ptr68drop_in_place$LT$alloc..boxed..Box$LT$std..io..error..Custom$GT$$GT$17h1f84f0febdcf91a3E.exit.i.i.i.i.i" ], [ %len.i.i.i, %bb19.i ], [ %buf.sroa.5.028.i, %bb3.i.i.i ], [ %buf.sroa.5.028.i, %bb9.i.thread ], [ %buf.sroa.5.028.i, %bb9.i.thread26 ]
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %_6.i), !noalias !333
  %_4.not.i = icmp eq i64 %buf.sroa.5.150.i, 0
  br i1 %_4.not.i, label %bb7, label %bb2.i

bb2.i1.i.i.i.i:                                   ; preds = %bb9.i
  %_4.0.i.i.i.i.i.i.i.i = load ptr, ptr %6, align 8, !noundef !6
  %14 = getelementptr i8, ptr %.val.i, i64 7
  %_4.1.i.i.i.i.i.i.i.i = load ptr, ptr %14, align 8, !nonnull !6, !align !148, !noundef !6
  %15 = load ptr, ptr %_4.1.i.i.i.i.i.i.i.i, align 8, !invariant.load !6, !nonnull !6
  invoke void %15(ptr noundef %_4.0.i.i.i.i.i.i.i.i)
          to label %bb3.i.i.i.i.i.i.i.i unwind label %cleanup.i.i.i.i.i.i.i.i

cleanup.i.i.i.i.i.i.i.i:                          ; preds = %bb2.i1.i.i.i.i
  %16 = landingpad { ptr, i32 }
          cleanup
  %17 = load ptr, ptr %6, align 8, !nonnull !6, !noundef !6
  %18 = load ptr, ptr %14, align 8, !nonnull !6, !align !148, !noundef !6
  %19 = getelementptr i8, ptr %18, i64 8
  %.val2.i.i.i.i.i.i.i.i = load i64, ptr %19, align 8, !range !149
  %20 = getelementptr i8, ptr %18, i64 16
  %.val3.i.i.i.i.i.i.i.i = load i64, ptr %20, align 8, !range !150
; call alloc::alloc::box_free
  tail call fastcc void @_ZN5alloc5alloc8box_free17h11e3a3be7aa785f4E(ptr noundef nonnull %17, i64 %.val2.i.i.i.i.i.i.i.i, i64 %.val3.i.i.i.i.i.i.i.i) #21
; call alloc::alloc::box_free
  tail call fastcc void @_ZN5alloc5alloc8box_free17h78ba79ece75676b2E(ptr noundef nonnull %6) #21
  br label %common.resume

bb3.i.i.i.i.i.i.i.i:                              ; preds = %bb2.i1.i.i.i.i
  %21 = load ptr, ptr %14, align 8, !nonnull !6, !align !148, !noundef !6
  %22 = getelementptr i8, ptr %21, i64 8
  %.val.i.i.i.i.i.i.i.i = load i64, ptr %22, align 8, !range !149
  %23 = icmp eq i64 %.val.i.i.i.i.i.i.i.i, 0
  br i1 %23, label %"_ZN4core3ptr68drop_in_place$LT$alloc..boxed..Box$LT$std..io..error..Custom$GT$$GT$17h1f84f0febdcf91a3E.exit.i.i.i.i.i", label %bb1.i.i.i.i.i.i.i.i.i.i

bb1.i.i.i.i.i.i.i.i.i.i:                          ; preds = %bb3.i.i.i.i.i.i.i.i
  %24 = getelementptr i8, ptr %21, i64 16
  %.val1.i.i.i.i.i.i.i.i = load i64, ptr %24, align 8, !range !150
  %25 = load ptr, ptr %6, align 8, !nonnull !6, !noundef !6
  %_18.i.i.i.i.i.i.i.i.i.i = icmp ult i64 %.val1.i.i.i.i.i.i.i.i, -9223372036854775807
  tail call void @llvm.assume(i1 %_18.i.i.i.i.i.i.i.i.i.i)
  tail call void @__rust_dealloc(ptr noundef nonnull %25, i64 noundef %.val.i.i.i.i.i.i.i.i, i64 noundef %.val1.i.i.i.i.i.i.i.i) #24
  br label %"_ZN4core3ptr68drop_in_place$LT$alloc..boxed..Box$LT$std..io..error..Custom$GT$$GT$17h1f84f0febdcf91a3E.exit.i.i.i.i.i"

"_ZN4core3ptr68drop_in_place$LT$alloc..boxed..Box$LT$std..io..error..Custom$GT$$GT$17h1f84f0febdcf91a3E.exit.i.i.i.i.i": ; preds = %bb1.i.i.i.i.i.i.i.i.i.i, %bb3.i.i.i.i.i.i.i.i
  tail call void @__rust_dealloc(ptr noundef nonnull %6, i64 noundef 24, i64 noundef 8) #24
  br label %bb16.i

bb2:                                              ; preds = %bb9.i.thread26, %bb9.i.thread, %bb9.i, %bb3.i.i.i, %bb4.i
  %.0.i = phi ptr [ @alloc75, %bb4.i ], [ %.val.i, %bb9.i ], [ %.val.i, %bb3.i.i.i ], [ %.val.i, %bb9.i.thread ], [ %.val.i, %bb9.i.thread26 ]
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %_6.i), !noalias !333
  %self.val = load ptr, ptr %self, align 8, !noundef !6
  %26 = icmp ne ptr %self.val, null
  %_7.cast.i.i.i.i.i4 = ptrtoint ptr %self.val to i64
  %_6.i.i.i.i.i5 = and i64 %_7.cast.i.i.i.i.i4, 3
  %switch.i.i.i.i6 = icmp eq i64 %_6.i.i.i.i.i5, 1
  %or.cond.i = and i1 %26, %switch.i.i.i.i6
  br i1 %or.cond.i, label %bb2.i1.i.i.i.i9, label %bb6

bb2.i1.i.i.i.i9:                                  ; preds = %bb2
  %27 = getelementptr i8, ptr %self.val, i64 -1
  %28 = icmp ne ptr %27, null
  tail call void @llvm.assume(i1 %28)
  %_4.0.i.i.i.i.i.i.i.i7 = load ptr, ptr %27, align 8, !noundef !6
  %29 = getelementptr i8, ptr %self.val, i64 7
  %_4.1.i.i.i.i.i.i.i.i8 = load ptr, ptr %29, align 8, !nonnull !6, !align !148, !noundef !6
  %30 = load ptr, ptr %_4.1.i.i.i.i.i.i.i.i8, align 8, !invariant.load !6, !nonnull !6
  invoke void %30(ptr noundef %_4.0.i.i.i.i.i.i.i.i7)
          to label %bb3.i.i.i.i.i.i.i.i14 unwind label %cleanup.i.i.i.i.i.i.i.i12

cleanup.i.i.i.i.i.i.i.i12:                        ; preds = %bb2.i1.i.i.i.i9
  %31 = landingpad { ptr, i32 }
          cleanup
  %32 = load ptr, ptr %27, align 8, !nonnull !6, !noundef !6
  %33 = load ptr, ptr %29, align 8, !nonnull !6, !align !148, !noundef !6
  %34 = getelementptr i8, ptr %33, i64 8
  %.val2.i.i.i.i.i.i.i.i10 = load i64, ptr %34, align 8, !range !149
  %35 = getelementptr i8, ptr %33, i64 16
  %.val3.i.i.i.i.i.i.i.i11 = load i64, ptr %35, align 8, !range !150
; call alloc::alloc::box_free
  tail call fastcc void @_ZN5alloc5alloc8box_free17h11e3a3be7aa785f4E(ptr noundef nonnull %32, i64 %.val2.i.i.i.i.i.i.i.i10, i64 %.val3.i.i.i.i.i.i.i.i11) #21
; call alloc::alloc::box_free
  tail call fastcc void @_ZN5alloc5alloc8box_free17h78ba79ece75676b2E(ptr noundef nonnull %27) #21
  store ptr %.0.i, ptr %self, align 8
  br label %common.resume

bb3.i.i.i.i.i.i.i.i14:                            ; preds = %bb2.i1.i.i.i.i9
  %36 = load ptr, ptr %29, align 8, !nonnull !6, !align !148, !noundef !6
  %37 = getelementptr i8, ptr %36, i64 8
  %.val.i.i.i.i.i.i.i.i13 = load i64, ptr %37, align 8, !range !149
  %38 = icmp eq i64 %.val.i.i.i.i.i.i.i.i13, 0
  br i1 %38, label %"_ZN4core3ptr68drop_in_place$LT$alloc..boxed..Box$LT$std..io..error..Custom$GT$$GT$17h1f84f0febdcf91a3E.exit.i.i.i.i.i18", label %bb1.i.i.i.i.i.i.i.i.i.i17

bb1.i.i.i.i.i.i.i.i.i.i17:                        ; preds = %bb3.i.i.i.i.i.i.i.i14
  %39 = getelementptr i8, ptr %36, i64 16
  %.val1.i.i.i.i.i.i.i.i15 = load i64, ptr %39, align 8, !range !150
  %40 = load ptr, ptr %27, align 8, !nonnull !6, !noundef !6
  %_18.i.i.i.i.i.i.i.i.i.i16 = icmp ult i64 %.val1.i.i.i.i.i.i.i.i15, -9223372036854775807
  tail call void @llvm.assume(i1 %_18.i.i.i.i.i.i.i.i.i.i16)
  tail call void @__rust_dealloc(ptr noundef nonnull %40, i64 noundef %.val.i.i.i.i.i.i.i.i13, i64 noundef %.val1.i.i.i.i.i.i.i.i15) #24
  br label %"_ZN4core3ptr68drop_in_place$LT$alloc..boxed..Box$LT$std..io..error..Custom$GT$$GT$17h1f84f0febdcf91a3E.exit.i.i.i.i.i18"

"_ZN4core3ptr68drop_in_place$LT$alloc..boxed..Box$LT$std..io..error..Custom$GT$$GT$17h1f84f0febdcf91a3E.exit.i.i.i.i.i18": ; preds = %bb1.i.i.i.i.i.i.i.i.i.i17, %bb3.i.i.i.i.i.i.i.i14
  tail call void @__rust_dealloc(ptr noundef nonnull %27, i64 noundef 24, i64 noundef 8) #24
  br label %bb6

bb6:                                              ; preds = %"_ZN4core3ptr68drop_in_place$LT$alloc..boxed..Box$LT$std..io..error..Custom$GT$$GT$17h1f84f0febdcf91a3E.exit.i.i.i.i.i18", %bb2
  store ptr %.0.i, ptr %self, align 8
  br label %bb7

bb7:                                              ; preds = %bb16.i, %start, %bb6
  %41 = phi i1 [ true, %bb6 ], [ false, %start ], [ false, %bb16.i ]
  ret i1 %41
}

; demo::spawn_user_query
; Function Attrs: nonlazybind uwtable
define internal fastcc void @_ZN4demo16spawn_user_query17h5ac1926a8053c79aE(ptr noalias nocapture noundef writeonly dereferenceable(24) %0, ptr noundef nonnull %1, ptr noalias nocapture noundef nonnull readonly align 1 %user.0) unnamed_addr #1 personality ptr @rust_eh_personality {
start:
  %e.i.i = alloca ptr, align 8
  %x.i.i.i.i.i = alloca %"alloc::sync::ArcInner<std::thread::Packet<'_, ()>>", align 16
  %e.i.i.i.i.i.i.i = alloca %"alloc::ffi::c_str::NulError", align 8
  %_2.i.i.i.i.i.i.i.i.i = alloca %"alloc::string::String", align 8
  %_15.i.i.i.i.i.i.i.i = alloca %"alloc::vec::Vec<u8>", align 8
  %bytes.i.i.i.i.i.i.i.i = alloca %"alloc::vec::Vec<u8>", align 8
  %x.i.i.i.i = alloca %"[closure@std::thread::Builder::spawn_unchecked_<'_, '_, [closure@src/main.rs:14:19: 14:26], ()>::{closure#1}]", align 8
  %self3.i.i.i.i = alloca %"core::result::Result<std::sys::unix::thread::Thread, std::io::error::Error>", align 8
  %main.i.i.i.i = alloca %"[closure@std::thread::Builder::spawn_unchecked_<'_, '_, [closure@src/main.rs:14:19: 14:26], ()>::{closure#1}]", align 8
  %output_capture.i.i.i.i = alloca ptr, align 8
  %their_packet.i.i.i.i = alloca ptr, align 8
  %my_packet.i.i.i.i = alloca ptr, align 8
  %their_thread.i.i.i.i = alloca ptr, align 8
  %my_thread.i.i.i.i = alloca ptr, align 8
  %name.i.i.i.i = alloca %"core::option::Option<alloc::string::String>", align 8
  %scope_data.i.i.i.i = alloca ptr, align 8
  %_8.i.i.i = alloca %"[closure@src/main.rs:14:19: 14:26]", align 8
  %_3.i = alloca %"std::thread::Builder", align 8
  %_8 = alloca %"[closure@src/main.rs:14:19: 14:26]", align 8
  %question = alloca %"alloc::string::String", align 8
  %client = alloca ptr, align 8
  store ptr %1, ptr %client, align 8
  call void @llvm.lifetime.start.p0(i64 24, ptr nonnull %question)
  %2 = tail call noundef dereferenceable_or_null(29) ptr @__rust_alloc(i64 noundef 29, i64 noundef 1) #24, !noalias !338
  %3 = icmp eq ptr %2, null
  br i1 %3, label %bb19.i.i.i, label %bb7

bb19.i.i.i:                                       ; preds = %start
; invoke alloc::alloc::handle_alloc_error
  invoke void @_ZN5alloc5alloc18handle_alloc_error17h1f2182fad8da84c7E(i64 noundef 29, i64 noundef 1) #22
          to label %.noexc unwind label %bb6.thread

.noexc:                                           ; preds = %bb19.i.i.i
  unreachable

bb6.thread:                                       ; preds = %bb19.i.i.i
  %4 = landingpad { ptr, i32 }
          cleanup
  br label %bb5

bb7:                                              ; preds = %start
  tail call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(29) %2, ptr noundef nonnull align 1 dereferenceable(29) @alloc373, i64 29, i1 false)
  store i64 29, ptr %question, align 8
  %_18.sroa.4.0.question.sroa_idx = getelementptr inbounds i8, ptr %question, i64 8
  store ptr %2, ptr %_18.sroa.4.0.question.sroa_idx, align 8
  %_18.sroa.5.0.question.sroa_idx = getelementptr inbounds i8, ptr %question, i64 16
  store i64 29, ptr %_18.sroa.5.0.question.sroa_idx, align 8
  %5 = tail call noundef dereferenceable_or_null(5) ptr @__rust_alloc(i64 noundef 5, i64 noundef 1) #24, !noalias !345
  %6 = icmp eq ptr %5, null
  br i1 %6, label %bb19.i.i.i3, label %bb9

bb19.i.i.i3:                                      ; preds = %bb7
; invoke alloc::alloc::handle_alloc_error
  invoke void @_ZN5alloc5alloc18handle_alloc_error17h1f2182fad8da84c7E(i64 noundef 5, i64 noundef 1) #22
          to label %.noexc4 unwind label %bb3

.noexc4:                                          ; preds = %bb19.i.i.i3
  unreachable

bb9:                                              ; preds = %bb7
  tail call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(5) %5, ptr noundef nonnull align 1 dereferenceable(5) %user.0, i64 5, i1 false)
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %_8)
  store ptr %1, ptr %_8, align 8
  %7 = getelementptr inbounds %"[closure@src/main.rs:14:19: 14:26]", ptr %_8, i64 0, i32 1
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %7, ptr noundef nonnull align 8 dereferenceable(24) %question, i64 24, i1 false)
  %8 = getelementptr inbounds %"[closure@src/main.rs:14:19: 14:26]", ptr %_8, i64 0, i32 2
  store i64 5, ptr %8, align 8
  %user.sroa.0.sroa.4.0..sroa_idx = getelementptr inbounds %"[closure@src/main.rs:14:19: 14:26]", ptr %_8, i64 0, i32 2, i32 0, i32 0, i32 1
  store ptr %5, ptr %user.sroa.0.sroa.4.0..sroa_idx, align 8
  %user.sroa.0.sroa.5.0..sroa_idx = getelementptr inbounds %"[closure@src/main.rs:14:19: 14:26]", ptr %_8, i64 0, i32 2, i32 0, i32 1
  store i64 5, ptr %user.sroa.0.sroa.5.0..sroa_idx, align 8
  tail call void @llvm.experimental.noalias.scope.decl(metadata !352)
  call void @llvm.lifetime.start.p0(i64 40, ptr nonnull %_3.i), !noalias !355
; invoke std::thread::Builder::new
  invoke void @_ZN3std6thread7Builder3new17he856e7fb4f75260bE(ptr noalias nocapture noundef nonnull sret(%"std::thread::Builder") dereferenceable(40) %_3.i)
          to label %bb1.i unwind label %bb5.i, !noalias !355

bb1.i:                                            ; preds = %bb9
  tail call void @llvm.experimental.noalias.scope.decl(metadata !357)
  %_3.sroa.0.0.copyload.i.i = load i64, ptr %_3.i, align 8, !alias.scope !357, !noalias !360
  %_3.sroa.4.0.self.sroa_idx.i.i = getelementptr inbounds i8, ptr %_3.i, i64 8
  %_3.sroa.4.0.copyload.i.i = load i64, ptr %_3.sroa.4.0.self.sroa_idx.i.i, align 8, !alias.scope !357, !noalias !360
  %_3.sroa.5.0.self.sroa_idx.i.i = getelementptr inbounds i8, ptr %_3.i, i64 16
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %_8.i.i.i), !noalias !363
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %_8.i.i.i, ptr noundef nonnull align 8 dereferenceable(56) %_8, i64 56, i1 false), !noalias !352
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %scope_data.i.i.i.i), !noalias !363
  store ptr null, ptr %scope_data.i.i.i.i, align 8, !noalias !368
  call void @llvm.lifetime.start.p0(i64 24, ptr nonnull %name.i.i.i.i), !noalias !368
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %name.i.i.i.i, ptr noundef nonnull align 8 dereferenceable(24) %_3.sroa.5.0.self.sroa_idx.i.i, i64 24, i1 false), !noalias !360
  %trunc.not.i.i.i.i = icmp eq i64 %_3.sroa.0.0.copyload.i.i, 0
  br i1 %trunc.not.i.i.i.i, label %bb40.i.i.i.i, label %bb44.i.i.i.i

bb40.i.i.i.i:                                     ; preds = %bb1.i
; invoke std::sys_common::thread::min_stack
  %9 = invoke noundef i64 @_ZN3std10sys_common6thread9min_stack17h9b3e35e64e2b9f54E()
          to label %bb44.i.i.i.i unwind label %bb36.i.i.i.i, !noalias !368

bb44.i.i.i.i:                                     ; preds = %bb40.i.i.i.i, %bb1.i
  %stack_size.019.i.i.i.i = phi i64 [ %9, %bb40.i.i.i.i ], [ %_3.sroa.4.0.copyload.i.i, %bb1.i ]
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %my_thread.i.i.i.i), !noalias !368
  %_10.sroa.4.0.name.sroa_idx.i.i.i.i = getelementptr inbounds i8, ptr %name.i.i.i.i, i64 8
  %_10.sroa.4.0.copyload.i.i.i.i = load ptr, ptr %_10.sroa.4.0.name.sroa_idx.i.i.i.i, align 8, !noalias !368
  %10 = icmp eq ptr %_10.sroa.4.0.copyload.i.i.i.i, null
  br i1 %10, label %bb1.i.i.i.i, label %bb3.i.i.i.i.i

bb3.i.i.i.i.i:                                    ; preds = %bb44.i.i.i.i
  %_10.sroa.5.0.name.sroa_idx.i.i.i.i = getelementptr inbounds i8, ptr %name.i.i.i.i, i64 16
  %_10.sroa.5.0.copyload.i.i.i.i = load i64, ptr %_10.sroa.5.0.name.sroa_idx.i.i.i.i, align 8, !noalias !368
  %_10.sroa.0.0.copyload.i.i.i.i = load i64, ptr %name.i.i.i.i, align 8, !noalias !368
  call void @llvm.lifetime.start.p0(i64 24, ptr nonnull %bytes.i.i.i.i.i.i.i.i), !noalias !373
  call void @llvm.lifetime.start.p0(i64 24, ptr nonnull %_2.i.i.i.i.i.i.i.i.i), !noalias !384
  store i64 %_10.sroa.0.0.copyload.i.i.i.i, ptr %_2.i.i.i.i.i.i.i.i.i, align 8, !noalias !368
  %_10.sroa.4.0._2.i.i.i.i.i.sroa_idx.i.i.i.i = getelementptr inbounds i8, ptr %_2.i.i.i.i.i.i.i.i.i, i64 8
  store ptr %_10.sroa.4.0.copyload.i.i.i.i, ptr %_10.sroa.4.0._2.i.i.i.i.i.sroa_idx.i.i.i.i, align 8, !noalias !368
  %_10.sroa.5.0._2.i.i.i.i.i.sroa_idx.i.i.i.i = getelementptr inbounds i8, ptr %_2.i.i.i.i.i.i.i.i.i, i64 16
  store i64 %_10.sroa.5.0.copyload.i.i.i.i, ptr %_10.sroa.5.0._2.i.i.i.i.i.sroa_idx.i.i.i.i, align 8, !noalias !368
; invoke alloc::string::<impl core::convert::From<alloc::string::String> for alloc::vec::Vec<u8>>::from
  invoke void @"_ZN5alloc6string104_$LT$impl$u20$core..convert..From$LT$alloc..string..String$GT$$u20$for$u20$alloc..vec..Vec$LT$u8$GT$$GT$4from17hea10657225ca3aa5E"(ptr noalias nocapture noundef nonnull sret(%"alloc::vec::Vec<u8>") dereferenceable(24) %bytes.i.i.i.i.i.i.i.i, ptr noalias nocapture noundef nonnull readonly dereferenceable(24) %_2.i.i.i.i.i.i.i.i.i)
          to label %.noexc.i.i.i.i unwind label %bb37.thread42.i.i.i.i, !noalias !368

.noexc.i.i.i.i:                                   ; preds = %bb3.i.i.i.i.i
  call void @llvm.lifetime.end.p0(i64 24, ptr nonnull %_2.i.i.i.i.i.i.i.i.i), !noalias !384
  %11 = getelementptr inbounds i8, ptr %bytes.i.i.i.i.i.i.i.i, i64 8
  %bytes.val.i.i.i.i.i.i.i.i = load ptr, ptr %11, align 8, !noalias !373, !nonnull !6, !noundef !6
  %12 = getelementptr inbounds i8, ptr %bytes.i.i.i.i.i.i.i.i, i64 16
  %bytes.val1.i.i.i.i.i.i.i.i = load i64, ptr %12, align 8, !noalias !373, !noundef !6
  %_3.i.i.i.i.i.i.i.i.i = icmp ult i64 %bytes.val1.i.i.i.i.i.i.i.i, 16
  br i1 %_3.i.i.i.i.i.i.i.i.i, label %bb1.i.i.i.i.i.i.i.i.i, label %bb3.i.i.i.i.i.i.i.i.i

bb3.i.i.i.i.i.i.i.i.i:                            ; preds = %.noexc.i.i.i.i
; invoke core::slice::memchr::memchr_aligned
  %13 = invoke { i64, i64 } @_ZN4core5slice6memchr14memchr_aligned17h5d92e28ac54ef117E(i8 noundef 0, ptr noalias noundef nonnull readonly align 1 %bytes.val.i.i.i.i.i.i.i.i, i64 noundef %bytes.val1.i.i.i.i.i.i.i.i)
          to label %bb3.i.i.i.i.i.i.i.i unwind label %bb10.i.i.i.i.i.i.i.i, !noalias !373

bb1.i.i.i.i.i.i.i.i.i:                            ; preds = %.noexc.i.i.i.i
  %_41.not.i.i.i.i.i.i.i.i.i.i = icmp eq i64 %bytes.val1.i.i.i.i.i.i.i.i, 0
  br i1 %_41.not.i.i.i.i.i.i.i.i.i.i, label %_ZN4core5slice6memchr12memchr_naive17h2f9ffde40830c78eE.exit.i.i.i.i.i.i.i.i.i, label %bb3.i.i.i.i.i.i.i.i.i.i

bb3.i.i.i.i.i.i.i.i.i.i:                          ; preds = %bb1.i.i.i.i.i.i.i.i.i, %bb5.i.i.i.i.i.i.i.i.i.i
  %i.02.i.i.i.i.i.i.i.i.i.i = phi i64 [ %15, %bb5.i.i.i.i.i.i.i.i.i.i ], [ 0, %bb1.i.i.i.i.i.i.i.i.i ]
  %14 = getelementptr inbounds [0 x i8], ptr %bytes.val.i.i.i.i.i.i.i.i, i64 0, i64 %i.02.i.i.i.i.i.i.i.i.i.i
  %_9.i.i.i.i.i.i.i.i.i.i = load i8, ptr %14, align 1, !alias.scope !388, !noalias !373, !noundef !6
  %_8.i.i.i.i.i.i.i.i.i.i = icmp eq i8 %_9.i.i.i.i.i.i.i.i.i.i, 0
  br i1 %_8.i.i.i.i.i.i.i.i.i.i, label %_ZN4core5slice6memchr12memchr_naive17h2f9ffde40830c78eE.exit.i.i.i.i.i.i.i.i.i, label %bb5.i.i.i.i.i.i.i.i.i.i

bb5.i.i.i.i.i.i.i.i.i.i:                          ; preds = %bb3.i.i.i.i.i.i.i.i.i.i
  %15 = add nuw nsw i64 %i.02.i.i.i.i.i.i.i.i.i.i, 1
  %exitcond.not.i.i.i.i.i.i.i.i.i.i = icmp eq i64 %15, %bytes.val1.i.i.i.i.i.i.i.i
  br i1 %exitcond.not.i.i.i.i.i.i.i.i.i.i, label %_ZN4core5slice6memchr12memchr_naive17h2f9ffde40830c78eE.exit.i.i.i.i.i.i.i.i.i, label %bb3.i.i.i.i.i.i.i.i.i.i

_ZN4core5slice6memchr12memchr_naive17h2f9ffde40830c78eE.exit.i.i.i.i.i.i.i.i.i: ; preds = %bb5.i.i.i.i.i.i.i.i.i.i, %bb3.i.i.i.i.i.i.i.i.i.i, %bb1.i.i.i.i.i.i.i.i.i
  %i.0.lcssa.i.i.i.i.i.i.i.i.i.i = phi i64 [ 0, %bb1.i.i.i.i.i.i.i.i.i ], [ %i.02.i.i.i.i.i.i.i.i.i.i, %bb3.i.i.i.i.i.i.i.i.i.i ], [ %bytes.val1.i.i.i.i.i.i.i.i, %bb5.i.i.i.i.i.i.i.i.i.i ]
  %.sroa.0.0.i.i.i.i.i.i.i.i.i.i = phi i64 [ 0, %bb1.i.i.i.i.i.i.i.i.i ], [ 1, %bb3.i.i.i.i.i.i.i.i.i.i ], [ 0, %bb5.i.i.i.i.i.i.i.i.i.i ]
  %16 = insertvalue { i64, i64 } undef, i64 %.sroa.0.0.i.i.i.i.i.i.i.i.i.i, 0
  %17 = insertvalue { i64, i64 } %16, i64 %i.0.lcssa.i.i.i.i.i.i.i.i.i.i, 1
  br label %bb3.i.i.i.i.i.i.i.i

bb3.i.i.i.i.i.i.i.i:                              ; preds = %_ZN4core5slice6memchr12memchr_naive17h2f9ffde40830c78eE.exit.i.i.i.i.i.i.i.i.i, %bb3.i.i.i.i.i.i.i.i.i
  %.pn.i.i.i.i.i.i.i.i.i = phi { i64, i64 } [ %17, %_ZN4core5slice6memchr12memchr_naive17h2f9ffde40830c78eE.exit.i.i.i.i.i.i.i.i.i ], [ %13, %bb3.i.i.i.i.i.i.i.i.i ]
  %.fca.0.extract.i.i.i.i.i.i.i.i = extractvalue { i64, i64 } %.pn.i.i.i.i.i.i.i.i.i, 0
  %switch.i.i.i.i.i.i.i.i = icmp eq i64 %.fca.0.extract.i.i.i.i.i.i.i.i, 0
  br i1 %switch.i.i.i.i.i.i.i.i, label %"_ZN3std6thread7Builder16spawn_unchecked_28_$u7b$$u7b$closure$u7d$$u7d$17h8c6e246506240f52E.exit.i.i.i.i.i", label %bb1.i.i.i.i.i.i.i

bb10.i.i.i.i.i.i.i.i:                             ; preds = %bb3.i.i.i.i.i.i.i.i.i
  %18 = landingpad { ptr, i32 }
          cleanup
; invoke core::ptr::drop_in_place<alloc::vec::Vec<u8>>
  invoke fastcc void @"_ZN4core3ptr46drop_in_place$LT$alloc..vec..Vec$LT$u8$GT$$GT$17h3b6c9b466e6e94d4E"(ptr noundef nonnull %bytes.i.i.i.i.i.i.i.i) #21
          to label %bb26.thread.i.i.i.i unwind label %abort.i.i.i.i.i.i.i.i, !noalias !373

abort.i.i.i.i.i.i.i.i:                            ; preds = %bb10.i.i.i.i.i.i.i.i
  %19 = landingpad { ptr, i32 }
          cleanup
; call core::panicking::panic_cannot_unwind
  tail call void @_ZN4core9panicking19panic_cannot_unwind17h42344709dec62f2eE() #23, !noalias !373
  unreachable

bb1.i.i.i.i.i.i.i:                                ; preds = %bb3.i.i.i.i.i.i.i.i
  %.fca.1.extract.i.i.i.i.i.i.i.i = extractvalue { i64, i64 } %.pn.i.i.i.i.i.i.i.i.i, 1
  %_3.sroa.6.8.copyload.i.i.i.i.i.i = load i64, ptr %bytes.i.i.i.i.i.i.i.i, align 8, !noalias !393
  call void @llvm.lifetime.end.p0(i64 24, ptr nonnull %bytes.i.i.i.i.i.i.i.i), !noalias !373
  call void @llvm.lifetime.start.p0(i64 32, ptr nonnull %e.i.i.i.i.i.i.i), !noalias !394
  store i64 %.fca.1.extract.i.i.i.i.i.i.i.i, ptr %e.i.i.i.i.i.i.i, align 8, !noalias !397
  %_3.sroa.6.0.e.i.sroa_idx.i.i.i.i.i.i = getelementptr inbounds i8, ptr %e.i.i.i.i.i.i.i, i64 8
  store i64 %_3.sroa.6.8.copyload.i.i.i.i.i.i, ptr %_3.sroa.6.0.e.i.sroa_idx.i.i.i.i.i.i, align 8, !noalias !397
  %_3.sroa.9.0.e.i.sroa_idx.i.i.i.i.i.i = getelementptr inbounds i8, ptr %e.i.i.i.i.i.i.i, i64 16
  store ptr %bytes.val.i.i.i.i.i.i.i.i, ptr %_3.sroa.9.0.e.i.sroa_idx.i.i.i.i.i.i, align 8, !noalias !397
  %_3.sroa.11.0.e.i.sroa_idx.i.i.i.i.i.i = getelementptr inbounds i8, ptr %e.i.i.i.i.i.i.i, i64 24
  store i64 %bytes.val1.i.i.i.i.i.i.i.i, ptr %_3.sroa.11.0.e.i.sroa_idx.i.i.i.i.i.i, align 8, !noalias !397
; invoke core::result::unwrap_failed
  invoke void @_ZN4core6result13unwrap_failed17hdc73d4affce1d414E(ptr noalias noundef nonnull readonly align 1 @alloc293, i64 noundef 47, ptr noundef nonnull align 1 %e.i.i.i.i.i.i.i, ptr noalias noundef nonnull readonly align 8 dereferenceable(24) @vtable.6, ptr noalias noundef nonnull readonly align 8 dereferenceable(24) @alloc295) #22
          to label %unreachable.i.i.i.i.i.i.i unwind label %cleanup.i.i.i.i.i.i.i, !noalias !394

cleanup.i.i.i.i.i.i.i:                            ; preds = %bb1.i.i.i.i.i.i.i
  %20 = landingpad { ptr, i32 }
          cleanup
; call core::ptr::drop_in_place<alloc::ffi::c_str::NulError>
  call void @"_ZN4core3ptr48drop_in_place$LT$alloc..ffi..c_str..NulError$GT$17h236d8428e3ec4c93E"(ptr noundef nonnull %e.i.i.i.i.i.i.i) #21, !noalias !394
  br label %bb26.thread.i.i.i.i

unreachable.i.i.i.i.i.i.i:                        ; preds = %bb1.i.i.i.i.i.i.i
  unreachable

"_ZN3std6thread7Builder16spawn_unchecked_28_$u7b$$u7b$closure$u7d$$u7d$17h8c6e246506240f52E.exit.i.i.i.i.i": ; preds = %bb3.i.i.i.i.i.i.i.i
  call void @llvm.lifetime.start.p0(i64 24, ptr nonnull %_15.i.i.i.i.i.i.i.i), !noalias !373
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %_15.i.i.i.i.i.i.i.i, ptr noundef nonnull align 8 dereferenceable(24) %bytes.i.i.i.i.i.i.i.i, i64 24, i1 false), !noalias !373
; invoke alloc::ffi::c_str::CString::_from_vec_unchecked
  %21 = invoke { ptr, i64 } @_ZN5alloc3ffi5c_str7CString19_from_vec_unchecked17h53edb6e6aa33562fE(ptr noalias nocapture noundef nonnull dereferenceable(24) %_15.i.i.i.i.i.i.i.i)
          to label %.noexc19.i.i.i.i unwind label %bb37.thread42.i.i.i.i, !noalias !368

.noexc19.i.i.i.i:                                 ; preds = %"_ZN3std6thread7Builder16spawn_unchecked_28_$u7b$$u7b$closure$u7d$$u7d$17h8c6e246506240f52E.exit.i.i.i.i.i"
  call void @llvm.lifetime.end.p0(i64 24, ptr nonnull %_15.i.i.i.i.i.i.i.i), !noalias !373
  call void @llvm.lifetime.end.p0(i64 24, ptr nonnull %bytes.i.i.i.i.i.i.i.i), !noalias !373
  %_5.0.i.i.i.i.i = extractvalue { ptr, i64 } %21, 0
  %_5.1.i.i.i.i.i = extractvalue { ptr, i64 } %21, 1
  br label %bb1.i.i.i.i

bb37.thread42.i.i.i.i:                            ; preds = %bb1.i.i.i.i, %"_ZN3std6thread7Builder16spawn_unchecked_28_$u7b$$u7b$closure$u7d$$u7d$17h8c6e246506240f52E.exit.i.i.i.i.i", %bb3.i.i.i.i.i
  %lpad.thr_comm.i.i.i.i = landingpad { ptr, i32 }
          cleanup
  br label %bb26.thread.i.i.i.i

bb1.i.i.i.i:                                      ; preds = %.noexc19.i.i.i.i, %bb44.i.i.i.i
  %.sroa.3.0.i.i.i.i.i = phi i64 [ %_5.1.i.i.i.i.i, %.noexc19.i.i.i.i ], [ undef, %bb44.i.i.i.i ]
  %.sroa.0.0.i.i.i.i.i = phi ptr [ %_5.0.i.i.i.i.i, %.noexc19.i.i.i.i ], [ null, %bb44.i.i.i.i ]
; invoke std::thread::Thread::new
  %22 = invoke noundef nonnull ptr @_ZN3std6thread6Thread3new17h05dd7e316a337ab2E(ptr noalias noundef align 1 %.sroa.0.0.i.i.i.i.i, i64 %.sroa.3.0.i.i.i.i.i)
          to label %bb2.i.i.i.i unwind label %bb37.thread42.i.i.i.i

bb2.i.i.i.i:                                      ; preds = %bb1.i.i.i.i
  store ptr %22, ptr %my_thread.i.i.i.i, align 8, !noalias !368
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %their_thread.i.i.i.i), !noalias !368
  %23 = atomicrmw add ptr %22, i64 1 monotonic, align 8, !noalias !368
  %_7.i.i.i.i.i = icmp slt i64 %23, 0
  br i1 %_7.i.i.i.i.i, label %bb1.i.i.i.i.i, label %bb45.i.i.i.i

bb1.i.i.i.i.i:                                    ; preds = %bb2.i.i.i.i
  tail call void @llvm.trap(), !noalias !368
  unreachable

bb45.i.i.i.i:                                     ; preds = %bb2.i.i.i.i
  store ptr %22, ptr %their_thread.i.i.i.i, align 8, !noalias !368
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %my_packet.i.i.i.i), !noalias !368
  call void @llvm.lifetime.start.p0(i64 48, ptr nonnull %x.i.i.i.i.i), !noalias !398
  %24 = getelementptr inbounds %"alloc::sync::ArcInner<std::thread::Packet<'_, ()>>", ptr %x.i.i.i.i.i, i64 0, i32 2
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 16 dereferenceable(16) %24, i8 0, i64 16, i1 false), !noalias !368
  store <2 x i64> <i64 1, i64 1>, ptr %x.i.i.i.i.i, align 16, !noalias !398
  %25 = tail call noundef align 8 dereferenceable_or_null(48) ptr @__rust_alloc(i64 noundef 48, i64 noundef 8) #24, !noalias !398
  %26 = icmp eq ptr %25, null
  br i1 %26, label %bb1.i.i.i.i.i.i, label %bb3.i.i.i.i

bb1.i.i.i.i.i.i:                                  ; preds = %bb45.i.i.i.i
; invoke alloc::alloc::handle_alloc_error
  invoke void @_ZN5alloc5alloc18handle_alloc_error17h1f2182fad8da84c7E(i64 noundef 48, i64 noundef 8) #22
          to label %.noexc.i.i.i.i.i unwind label %cleanup.i.i.i.i.i, !noalias !398

.noexc.i.i.i.i.i:                                 ; preds = %bb1.i.i.i.i.i.i
  unreachable

cleanup.i.i.i.i.i:                                ; preds = %bb1.i.i.i.i.i.i
  %27 = landingpad { ptr, i32 }
          cleanup
; invoke core::ptr::drop_in_place<alloc::sync::ArcInner<std::thread::Packet<()>>>
  invoke fastcc void @"_ZN4core3ptr85drop_in_place$LT$alloc..sync..ArcInner$LT$std..thread..Packet$LT$$LP$$RP$$GT$$GT$$GT$17h21358fc51fb9a30cE"(ptr noundef nonnull %x.i.i.i.i.i) #21
          to label %bb34.i.i.i.i unwind label %abort.i.i.i.i.i, !noalias !398

abort.i.i.i.i.i:                                  ; preds = %cleanup.i.i.i.i.i
  %28 = landingpad { ptr, i32 }
          cleanup
; call core::panicking::panic_cannot_unwind
  tail call void @_ZN4core9panicking19panic_cannot_unwind17h42344709dec62f2eE() #23, !noalias !398
  unreachable

bb35.i.i.i.i:                                     ; preds = %bb23.i.i.i.i
  br i1 %.not2.i.i.i.i, label %bb26.i.i.i.i, label %bb34.i.i.i.i

bb3.i.i.i.i:                                      ; preds = %bb45.i.i.i.i
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(48) %25, ptr noundef nonnull align 16 dereferenceable(48) %x.i.i.i.i.i, i64 48, i1 false), !noalias !398
  call void @llvm.lifetime.end.p0(i64 48, ptr nonnull %x.i.i.i.i.i), !noalias !398
  store ptr %25, ptr %my_packet.i.i.i.i, align 8, !noalias !368
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %their_packet.i.i.i.i), !noalias !368
  %29 = atomicrmw add ptr %25, i64 1 monotonic, align 8, !noalias !368
  %_7.i22.i.i.i.i = icmp slt i64 %29, 0
  br i1 %_7.i22.i.i.i.i, label %bb1.i23.i.i.i.i, label %bb4.i.i.i.i

bb1.i23.i.i.i.i:                                  ; preds = %bb3.i.i.i.i
  tail call void @llvm.trap(), !noalias !368
  unreachable

bb23.i.i.i.i:                                     ; preds = %bb32.i.i.i.i, %bb28.i.i.i.i, %cleanup13.i.i.i.i, %bb29.i.i.i.i
  %.not2.i.i.i.i = phi i1 [ true, %bb28.i.i.i.i ], [ true, %bb29.i.i.i.i ], [ true, %cleanup13.i.i.i.i ], [ false, %bb32.i.i.i.i ]
  %_57.1.i.i.i.i = phi i8 [ 0, %bb28.i.i.i.i ], [ 0, %bb29.i.i.i.i ], [ 0, %cleanup13.i.i.i.i ], [ 1, %bb32.i.i.i.i ]
  %.pn.pn.pn.pn.i.i.i.i = phi { ptr, i32 } [ %51, %bb28.i.i.i.i ], [ %47, %bb29.i.i.i.i ], [ %48, %cleanup13.i.i.i.i ], [ %.pn.pn.pn57.i.i.i.i, %bb32.i.i.i.i ]
; invoke core::ptr::drop_in_place<alloc::sync::Arc<std::thread::Packet<()>>>
  invoke fastcc void @"_ZN4core3ptr80drop_in_place$LT$alloc..sync..Arc$LT$std..thread..Packet$LT$$LP$$RP$$GT$$GT$$GT$17hdac63bca8591c1a9E"(ptr noundef nonnull %my_packet.i.i.i.i) #21
          to label %bb35.i.i.i.i unwind label %abort.i.i.i.i, !noalias !368

bb4.i.i.i.i:                                      ; preds = %bb3.i.i.i.i
  store ptr %25, ptr %their_packet.i.i.i.i, align 8, !noalias !368
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %output_capture.i.i.i.i), !noalias !368
; invoke std::io::stdio::set_output_capture
  %30 = invoke noundef ptr @_ZN3std2io5stdio18set_output_capture17h650a707a873ed88aE(ptr noundef null)
          to label %bb5.i.i.i.i unwind label %bb33.thread.i.i.i.i, !noalias !368

bb33.thread.i.i.i.i:                              ; preds = %bb4.i.i.i.i
  %31 = landingpad { ptr, i32 }
          cleanup
  br label %bb32.i.i.i.i

bb5.i.i.i.i:                                      ; preds = %bb4.i.i.i.i
  store ptr %30, ptr %output_capture.i.i.i.i, align 8, !noalias !368
  %32 = icmp eq ptr %30, null
  br i1 %32, label %bb6.i.i.i.i, label %bb48.i.i.i.i

bb48.i.i.i.i:                                     ; preds = %bb5.i.i.i.i
  %33 = atomicrmw add ptr %30, i64 1 monotonic, align 8, !noalias !368
  %_7.i24.i.i.i.i = icmp slt i64 %33, 0
  br i1 %_7.i24.i.i.i.i, label %bb1.i25.i.i.i.i, label %bb6.i.i.i.i

bb1.i25.i.i.i.i:                                  ; preds = %bb48.i.i.i.i
  tail call void @llvm.trap(), !noalias !368
  unreachable

bb6.i.i.i.i:                                      ; preds = %bb48.i.i.i.i, %bb5.i.i.i.i
; invoke std::io::stdio::set_output_capture
  %34 = invoke noundef ptr @_ZN3std2io5stdio18set_output_capture17h650a707a873ed88aE(ptr noundef %30)
          to label %bb7.i.i.i.i unwind label %bb30.i.i.i.i, !noalias !368

bb7.i.i.i.i:                                      ; preds = %bb6.i.i.i.i
  %35 = icmp eq ptr %34, null
  br i1 %35, label %bb9.i.i.i.i, label %bb2.i.i.i.i.i

bb2.i.i.i.i.i:                                    ; preds = %bb7.i.i.i.i
  %36 = atomicrmw sub ptr %34, i64 1 release, align 8, !noalias !401
  %37 = icmp eq i64 %36, 1
  br i1 %37, label %bb2.i.i.i.i.i.i.i, label %bb9.i.i.i.i

bb2.i.i.i.i.i.i.i:                                ; preds = %bb2.i.i.i.i.i
  fence acquire
; call alloc::sync::Arc<T>::drop_slow
  tail call fastcc void @"_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17h9988cc5f56f4cc91E"(ptr nonnull %34), !noalias !401
  br label %bb9.i.i.i.i

bb9.i.i.i.i:                                      ; preds = %bb2.i.i.i.i.i.i.i, %bb2.i.i.i.i.i, %bb7.i.i.i.i
  call void @llvm.lifetime.start.p0(i64 80, ptr nonnull %main.i.i.i.i), !noalias !368
  %38 = getelementptr inbounds %"[closure@std::thread::Builder::spawn_unchecked_<'_, '_, [closure@src/main.rs:14:19: 14:26], ()>::{closure#1}]", ptr %main.i.i.i.i, i64 0, i32 2
  %39 = load ptr, ptr %their_thread.i.i.i.i, align 8, !noalias !368, !nonnull !6, !noundef !6
  store ptr %39, ptr %38, align 8, !noalias !368
  %40 = load ptr, ptr %output_capture.i.i.i.i, align 8, !noalias !368, !noundef !6
  store ptr %40, ptr %main.i.i.i.i, align 8, !noalias !368
  %41 = getelementptr inbounds %"[closure@std::thread::Builder::spawn_unchecked_<'_, '_, [closure@src/main.rs:14:19: 14:26], ()>::{closure#1}]", ptr %main.i.i.i.i, i64 0, i32 1
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %41, ptr noundef nonnull align 8 dereferenceable(56) %_8.i.i.i, i64 56, i1 false), !noalias !404
  %42 = getelementptr inbounds %"[closure@std::thread::Builder::spawn_unchecked_<'_, '_, [closure@src/main.rs:14:19: 14:26], ()>::{closure#1}]", ptr %main.i.i.i.i, i64 0, i32 3
  %43 = load ptr, ptr %their_packet.i.i.i.i, align 8, !noalias !368, !nonnull !6, !noundef !6
  store ptr %43, ptr %42, align 8, !noalias !368
  %self10.i.i.i.i = load ptr, ptr %my_packet.i.i.i.i, align 8, !noalias !368, !nonnull !6, !noundef !6
  %_30.i.i.i.i = getelementptr inbounds %"alloc::sync::ArcInner<std::thread::Packet<'_, ()>>", ptr %self10.i.i.i.i, i64 0, i32 2
  %44 = load ptr, ptr %_30.i.i.i.i, align 8, !noalias !368, !noundef !6
  %.not5.i.i.i.i = icmp eq ptr %44, null
  br i1 %.not5.i.i.i.i, label %bb12.i.i.i.i, label %bb10.i.i.i.i

bb10.i.i.i.i:                                     ; preds = %bb9.i.i.i.i
  %_36.i.i.i.i = getelementptr inbounds %"alloc::sync::ArcInner<std::thread::scoped::ScopeData>", ptr %44, i64 0, i32 2
; invoke std::thread::scoped::ScopeData::increment_num_running_threads
  invoke void @_ZN3std6thread6scoped9ScopeData29increment_num_running_threads17ha82c1a6bf73eb90eE(ptr noundef nonnull align 8 %_36.i.i.i.i)
          to label %bb12.i.i.i.i unwind label %bb28.i.i.i.i, !noalias !368

bb12.i.i.i.i:                                     ; preds = %bb10.i.i.i.i, %bb9.i.i.i.i
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %self3.i.i.i.i), !noalias !368
  call void @llvm.lifetime.start.p0(i64 80, ptr nonnull %x.i.i.i.i), !noalias !368
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(80) %x.i.i.i.i, ptr noundef nonnull align 8 dereferenceable(80) %main.i.i.i.i, i64 80, i1 false), !noalias !368
  %45 = tail call noundef align 8 dereferenceable_or_null(80) ptr @__rust_alloc(i64 noundef 80, i64 noundef 8) #24, !noalias !368
  %46 = icmp eq ptr %45, null
  br i1 %46, label %bb1.i28.i.i.i.i, label %bb50.i.i.i.i

bb1.i28.i.i.i.i:                                  ; preds = %bb12.i.i.i.i
; invoke alloc::alloc::handle_alloc_error
  invoke void @_ZN5alloc5alloc18handle_alloc_error17h1f2182fad8da84c7E(i64 noundef 80, i64 noundef 8) #22
          to label %.noexc29.i.i.i.i unwind label %cleanup13.i.i.i.i, !noalias !368

.noexc29.i.i.i.i:                                 ; preds = %bb1.i28.i.i.i.i
  unreachable

bb29.i.i.i.i:                                     ; preds = %bb50.i.i.i.i
  %47 = landingpad { ptr, i32 }
          cleanup
  br label %bb23.i.i.i.i

cleanup13.i.i.i.i:                                ; preds = %bb1.i28.i.i.i.i
  %48 = landingpad { ptr, i32 }
          cleanup
; invoke core::ptr::drop_in_place<std::thread::Builder::spawn_unchecked_<demo::spawn_user_query::{{closure}},()>::{{closure}}>
  invoke void @"_ZN4core3ptr158drop_in_place$LT$std..thread..Builder..spawn_unchecked_$LT$demo..spawn_user_query..$u7b$$u7b$closure$u7d$$u7d$$C$$LP$$RP$$GT$..$u7b$$u7b$closure$u7d$$u7d$$GT$17h6cdb75df18ce3addE"(ptr noundef nonnull %x.i.i.i.i) #21
          to label %bb23.i.i.i.i unwind label %abort.i.i.i.i, !noalias !368

bb50.i.i.i.i:                                     ; preds = %bb12.i.i.i.i
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(80) %45, ptr noundef nonnull align 8 dereferenceable(80) %main.i.i.i.i, i64 80, i1 false), !noalias !368
  call void @llvm.lifetime.end.p0(i64 80, ptr nonnull %x.i.i.i.i), !noalias !368
; invoke std::sys::unix::thread::Thread::new
  invoke void @_ZN3std3sys4unix6thread6Thread3new17h7e6cfd809124a6f8E(ptr noalias nocapture noundef nonnull sret(%"core::result::Result<std::sys::unix::thread::Thread, std::io::error::Error>") dereferenceable(16) %self3.i.i.i.i, i64 noundef %stack_size.019.i.i.i.i, ptr noalias noundef nonnull align 1 %45, ptr noalias noundef nonnull readonly align 8 dereferenceable(24) @vtable.2)
          to label %bb14.i.i.i.i unwind label %bb29.i.i.i.i, !noalias !368

abort.i.i.i.i:                                    ; preds = %bb39.i.i.i.i, %bb32.i.i.i.i, %bb28.i.i.i.i, %cleanup13.i.i.i.i, %bb23.i.i.i.i
  %49 = landingpad { ptr, i32 }
          cleanup
; call core::panicking::panic_cannot_unwind
  call void @_ZN4core9panicking19panic_cannot_unwind17h42344709dec62f2eE() #23, !noalias !368
  unreachable

bb14.i.i.i.i:                                     ; preds = %bb50.i.i.i.i
  %_93.i.i.i.i = load i64, ptr %self3.i.i.i.i, align 8, !range !201, !noalias !368, !noundef !6
  %trunc15.not.i.i.i.i = icmp eq i64 %_93.i.i.i.i, 0
  %50 = getelementptr inbounds %"core::result::Result<std::sys::unix::thread::Thread, std::io::error::Error>::Err", ptr %self3.i.i.i.i, i64 0, i32 1
  %e.i.i.i.i = load ptr, ptr %50, align 8, !noalias !368
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %self3.i.i.i.i), !noalias !368
  br i1 %trunc15.not.i.i.i.i, label %bb1, label %bb18.i.i.i.i

bb28.i.i.i.i:                                     ; preds = %bb10.i.i.i.i
  %51 = landingpad { ptr, i32 }
          cleanup
; invoke core::ptr::drop_in_place<std::thread::Builder::spawn_unchecked_<demo::spawn_user_query::{{closure}},()>::{{closure}}>
  invoke void @"_ZN4core3ptr158drop_in_place$LT$std..thread..Builder..spawn_unchecked_$LT$demo..spawn_user_query..$u7b$$u7b$closure$u7d$$u7d$$C$$LP$$RP$$GT$..$u7b$$u7b$closure$u7d$$u7d$$GT$17h6cdb75df18ce3addE"(ptr noundef nonnull %main.i.i.i.i) #21
          to label %bb23.i.i.i.i unwind label %abort.i.i.i.i, !noalias !368

bb30.i.i.i.i:                                     ; preds = %bb6.i.i.i.i
  %52 = landingpad { ptr, i32 }
          cleanup
; call core::ptr::drop_in_place<core::option::Option<alloc::sync::Arc<std::sync::mutex::Mutex<alloc::vec::Vec<u8>>>>>
  call fastcc void @"_ZN4core3ptr129drop_in_place$LT$core..option..Option$LT$alloc..sync..Arc$LT$std..sync..mutex..Mutex$LT$alloc..vec..Vec$LT$u8$GT$$GT$$GT$$GT$$GT$17h248c6a7ad92731ebE"(ptr noundef nonnull %output_capture.i.i.i.i) #21, !noalias !368
  br label %bb32.i.i.i.i

bb32.i.i.i.i:                                     ; preds = %bb30.i.i.i.i, %bb33.thread.i.i.i.i
  %.pn.pn.pn57.i.i.i.i = phi { ptr, i32 } [ %31, %bb33.thread.i.i.i.i ], [ %52, %bb30.i.i.i.i ]
; invoke core::ptr::drop_in_place<alloc::sync::Arc<std::thread::Packet<()>>>
  invoke fastcc void @"_ZN4core3ptr80drop_in_place$LT$alloc..sync..Arc$LT$std..thread..Packet$LT$$LP$$RP$$GT$$GT$$GT$17hdac63bca8591c1a9E"(ptr noundef nonnull %their_packet.i.i.i.i) #21
          to label %bb23.i.i.i.i unwind label %abort.i.i.i.i, !noalias !368

bb34.i.i.i.i:                                     ; preds = %bb35.i.i.i.i, %cleanup.i.i.i.i.i
  %.pn.pn.pn.pn.pn50.i.i.i.i = phi { ptr, i32 } [ %.pn.pn.pn.pn.i.i.i.i, %bb35.i.i.i.i ], [ %27, %cleanup.i.i.i.i.i ]
  %_60.249.i.i.i.i = phi i8 [ %_57.1.i.i.i.i, %bb35.i.i.i.i ], [ 1, %cleanup.i.i.i.i.i ]
; call core::ptr::drop_in_place<std::thread::Thread>
  call fastcc void @"_ZN4core3ptr40drop_in_place$LT$std..thread..Thread$GT$17h315a208f60640622E"(ptr noundef nonnull %their_thread.i.i.i.i) #21, !noalias !368
  br label %bb26.i.i.i.i

bb36.i.i.i.i:                                     ; preds = %bb40.i.i.i.i
  %lpad.thr_comm.split-lp.i.i.i.i = landingpad { ptr, i32 }
          cleanup
; call core::ptr::drop_in_place<core::option::Option<alloc::string::String>>
  call fastcc void @"_ZN4core3ptr70drop_in_place$LT$core..option..Option$LT$alloc..string..String$GT$$GT$17h93941aee084f5427E"(ptr noundef nonnull %name.i.i.i.i) #21, !noalias !368
  br label %bb26.thread.i.i.i.i

bb18.i.i.i.i:                                     ; preds = %bb14.i.i.i.i
  call void @llvm.lifetime.end.p0(i64 80, ptr nonnull %main.i.i.i.i), !noalias !368
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %output_capture.i.i.i.i), !noalias !368
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %their_packet.i.i.i.i), !noalias !368
  tail call void @llvm.experimental.noalias.scope.decl(metadata !405)
  %53 = atomicrmw sub ptr %self10.i.i.i.i, i64 1 release, align 8, !noalias !408
  %54 = icmp eq i64 %53, 1
  br i1 %54, label %bb2.i.i.i.i.i.i, label %bb19.i.i.i.i

bb2.i.i.i.i.i.i:                                  ; preds = %bb18.i.i.i.i
  fence acquire
  %self.val.i.i.i.i.i.i = load ptr, ptr %my_packet.i.i.i.i, align 8, !alias.scope !405, !noalias !368, !nonnull !6
; invoke alloc::sync::Arc<T>::drop_slow
  invoke fastcc void @"_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17hbaf97c6b34ae9334E"(ptr nonnull %self.val.i.i.i.i.i.i)
          to label %bb19.i.i.i.i unwind label %cleanup16.i.i.i.i, !noalias !368

cleanup16.i.i.i.i:                                ; preds = %bb2.i.i.i.i.i.i
  %55 = landingpad { ptr, i32 }
          cleanup
; call core::ptr::drop_in_place<std::thread::Thread>
  call fastcc void @"_ZN4core3ptr40drop_in_place$LT$std..thread..Thread$GT$17h315a208f60640622E"(ptr noundef nonnull %my_thread.i.i.i.i) #21, !noalias !368
  br label %bb2

bb19.i.i.i.i:                                     ; preds = %bb2.i.i.i.i.i.i, %bb18.i.i.i.i
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %my_packet.i.i.i.i), !noalias !368
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %their_thread.i.i.i.i), !noalias !368
  tail call void @llvm.experimental.noalias.scope.decl(metadata !409)
  %self1.i.i.i.i.i.i.i.i = load ptr, ptr %my_thread.i.i.i.i, align 8, !alias.scope !409, !noalias !368, !nonnull !6, !noundef !6
  %56 = atomicrmw sub ptr %self1.i.i.i.i.i.i.i.i, i64 1 release, align 8, !noalias !412
  %57 = icmp eq i64 %56, 1
  br i1 %57, label %bb2.i.i.i.i.i.i.i.i, label %bb1.i.i

bb2.i.i.i.i.i.i.i.i:                              ; preds = %bb19.i.i.i.i
  fence acquire
  %self.val.i.i.i.i.i.i.i.i = load ptr, ptr %my_thread.i.i.i.i, align 8, !alias.scope !409, !noalias !368, !nonnull !6
; call alloc::sync::Arc<T>::drop_slow
  tail call fastcc void @"_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17he68302373675f7f4E"(ptr nonnull %self.val.i.i.i.i.i.i.i.i), !noalias !412
  br label %bb1.i.i

bb26.i.i.i.i:                                     ; preds = %bb34.i.i.i.i, %bb35.i.i.i.i
  %_60.1.i.i.i.i = phi i8 [ %_60.249.i.i.i.i, %bb34.i.i.i.i ], [ %_57.1.i.i.i.i, %bb35.i.i.i.i ]
  %.pn.pn.pn.pn.pn.pn.i.i.i.i = phi { ptr, i32 } [ %.pn.pn.pn.pn.pn50.i.i.i.i, %bb34.i.i.i.i ], [ %.pn.pn.pn.pn.i.i.i.i, %bb35.i.i.i.i ]
; call core::ptr::drop_in_place<std::thread::Thread>
  call fastcc void @"_ZN4core3ptr40drop_in_place$LT$std..thread..Thread$GT$17h315a208f60640622E"(ptr noundef nonnull %my_thread.i.i.i.i) #21, !noalias !368
  %.not1.i.i.i.i = icmp eq i8 %_60.1.i.i.i.i, 0
  br i1 %.not1.i.i.i.i, label %bb2, label %bb39.i.i.i.i

bb26.thread.i.i.i.i:                              ; preds = %bb36.i.i.i.i, %bb37.thread42.i.i.i.i, %cleanup.i.i.i.i.i.i.i, %bb10.i.i.i.i.i.i.i.i
  %.pn673.i.i.i.i = phi { ptr, i32 } [ %lpad.thr_comm.i.i.i.i, %bb37.thread42.i.i.i.i ], [ %lpad.thr_comm.split-lp.i.i.i.i, %bb36.i.i.i.i ], [ %18, %bb10.i.i.i.i.i.i.i.i ], [ %20, %cleanup.i.i.i.i.i.i.i ]
; call core::ptr::drop_in_place<core::option::Option<alloc::sync::Arc<std::thread::scoped::ScopeData>>>
  call fastcc void @"_ZN4core3ptr103drop_in_place$LT$core..option..Option$LT$alloc..sync..Arc$LT$std..thread..scoped..ScopeData$GT$$GT$$GT$17h7cc4bee20b845956E"(ptr noundef nonnull %scope_data.i.i.i.i) #21, !noalias !368
  br label %bb39.i.i.i.i

bb39.i.i.i.i:                                     ; preds = %bb26.thread.i.i.i.i, %bb26.i.i.i.i
  %.pn67494.i.i.i.i = phi { ptr, i32 } [ %.pn673.i.i.i.i, %bb26.thread.i.i.i.i ], [ %.pn.pn.pn.pn.pn.pn.i.i.i.i, %bb26.i.i.i.i ]
; invoke core::ptr::drop_in_place<demo::spawn_user_query::{{closure}}>
  invoke fastcc void @"_ZN4core3ptr72drop_in_place$LT$demo..spawn_user_query..$u7b$$u7b$closure$u7d$$u7d$$GT$17h3fc0c80003884286E"(ptr noundef nonnull %_8.i.i.i) #21
          to label %bb2 unwind label %abort.i.i.i.i, !noalias !404

bb1.i.i:                                          ; preds = %bb2.i.i.i.i.i.i.i.i, %bb19.i.i.i.i
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %my_thread.i.i.i.i), !noalias !368
  call void @llvm.lifetime.end.p0(i64 24, ptr nonnull %name.i.i.i.i), !noalias !368
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %scope_data.i.i.i.i), !noalias !363
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %_8.i.i.i), !noalias !363
  call void @llvm.lifetime.end.p0(i64 40, ptr nonnull %_3.i), !noalias !355
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %e.i.i), !noalias !413
  %58 = icmp ne ptr %e.i.i.i.i, null
  tail call void @llvm.assume(i1 %58)
  store ptr %e.i.i.i.i, ptr %e.i.i, align 8, !noalias !413
; invoke core::result::unwrap_failed
  invoke void @_ZN4core6result13unwrap_failed17hdc73d4affce1d414E(ptr noalias noundef nonnull readonly align 1 @alloc287, i64 noundef 22, ptr noundef nonnull align 1 %e.i.i, ptr noalias noundef nonnull readonly align 8 dereferenceable(24) @vtable.5, ptr noalias noundef nonnull readonly align 8 dereferenceable(24) @alloc289) #22
          to label %unreachable.i.i unwind label %cleanup.i.i, !noalias !413

cleanup.i.i:                                      ; preds = %bb1.i.i
  %59 = landingpad { ptr, i32 }
          cleanup
; invoke core::ptr::drop_in_place<std::io::error::Error>
  invoke void @"_ZN4core3ptr42drop_in_place$LT$std..io..error..Error$GT$17h44b2f0e87eb79141E"(ptr noundef nonnull %e.i.i) #21
          to label %bb2 unwind label %abort.i.i, !noalias !413

unreachable.i.i:                                  ; preds = %bb1.i.i
  unreachable

abort.i.i:                                        ; preds = %cleanup.i.i
  %60 = landingpad { ptr, i32 }
          cleanup
; call core::panicking::panic_cannot_unwind
  call void @_ZN4core9panicking19panic_cannot_unwind17h42344709dec62f2eE() #23, !noalias !413
  unreachable

bb5.i:                                            ; preds = %bb9
  %61 = landingpad { ptr, i32 }
          cleanup
; invoke core::ptr::drop_in_place<demo::spawn_user_query::{{closure}}>
  invoke fastcc void @"_ZN4core3ptr72drop_in_place$LT$demo..spawn_user_query..$u7b$$u7b$closure$u7d$$u7d$$GT$17h3fc0c80003884286E"(ptr noundef nonnull %_8) #21
          to label %bb2 unwind label %abort.i, !noalias !352

abort.i:                                          ; preds = %bb5.i
  %62 = landingpad { ptr, i32 }
          cleanup
; call core::panicking::panic_cannot_unwind
  tail call void @_ZN4core9panicking19panic_cannot_unwind17h42344709dec62f2eE() #23, !noalias !355
  unreachable

bb1:                                              ; preds = %bb14.i.i.i.i
  %_52.i.i.i.i = load ptr, ptr %my_thread.i.i.i.i, align 8, !noalias !368, !nonnull !6, !noundef !6
  %63 = ptrtoint ptr %self10.i.i.i.i to i64
  call void @llvm.lifetime.end.p0(i64 80, ptr nonnull %main.i.i.i.i), !noalias !368
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %output_capture.i.i.i.i), !noalias !368
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %their_packet.i.i.i.i), !noalias !368
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %my_packet.i.i.i.i), !noalias !368
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %their_thread.i.i.i.i), !noalias !368
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %my_thread.i.i.i.i), !noalias !368
  call void @llvm.lifetime.end.p0(i64 24, ptr nonnull %name.i.i.i.i), !noalias !368
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %scope_data.i.i.i.i), !noalias !363
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %_8.i.i.i), !noalias !363
  call void @llvm.lifetime.end.p0(i64 40, ptr nonnull %_3.i), !noalias !355
  tail call void @llvm.experimental.noalias.scope.decl(metadata !417)
  tail call void @llvm.experimental.noalias.scope.decl(metadata !418)
  store ptr %e.i.i.i.i, ptr %0, align 8, !alias.scope !419, !noalias !420
  %_2.sroa.6.0..sroa_idx.i = getelementptr inbounds i8, ptr %0, i64 8
  store ptr %_52.i.i.i.i, ptr %_2.sroa.6.0..sroa_idx.i, align 8, !alias.scope !419, !noalias !420
  %_2.sroa.9.0..sroa_idx.i = getelementptr inbounds i8, ptr %0, i64 16
  store i64 %63, ptr %_2.sroa.9.0..sroa_idx.i, align 8, !alias.scope !419, !noalias !420
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %_8)
  call void @llvm.lifetime.end.p0(i64 24, ptr nonnull %question)
  ret void

bb3:                                              ; preds = %bb19.i.i.i3
  %64 = landingpad { ptr, i32 }
          cleanup
; call core::ptr::drop_in_place<alloc::string::String>
  call fastcc void @"_ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17h5f3174a51a28c86eE"(ptr noundef nonnull %question) #21
  br label %bb5

bb2:                                              ; preds = %bb5, %bb5.i, %cleanup.i.i, %bb39.i.i.i.i, %bb26.i.i.i.i, %cleanup16.i.i.i.i
  %.pn10 = phi { ptr, i32 } [ %.pn9, %bb5 ], [ %59, %cleanup.i.i ], [ %55, %cleanup16.i.i.i.i ], [ %.pn.pn.pn.pn.pn.pn.i.i.i.i, %bb26.i.i.i.i ], [ %.pn67494.i.i.i.i, %bb39.i.i.i.i ], [ %61, %bb5.i ]
  resume { ptr, i32 } %.pn10

bb5:                                              ; preds = %bb3, %bb6.thread
  %.pn9 = phi { ptr, i32 } [ %4, %bb6.thread ], [ %64, %bb3 ]
; call core::ptr::drop_in_place<alloc::sync::Arc<redis::client::Client>>
  call fastcc void @"_ZN4core3ptr66drop_in_place$LT$alloc..sync..Arc$LT$redis..client..Client$GT$$GT$17h7f41de5249136022E"(ptr noundef nonnull %client) #21
  br label %bb2
}

; demo::main
; Function Attrs: nonlazybind uwtable
define internal void @_ZN4demo4main17h3a2356faed25125dE() unnamed_addr #1 personality ptr @rust_eh_personality {
start:
  %e.i43 = alloca { ptr, ptr }, align 8
  %e.i35 = alloca { ptr, ptr }, align 8
  %x.i28 = alloca %"alloc::sync::ArcInner<redis::client::Client>", align 16
  %e.i20 = alloca %"redis::types::RedisError", align 8
  %_5.i10 = alloca %"core::result::Result<redis::connection::ConnectionInfo, redis::types::RedisError>", align 8
  %_4.sroa.7.i11 = alloca [63 x i8], align 1
  %x.i = alloca %"alloc::sync::ArcInner<redis::client::Client>", align 16
  %e.i = alloca %"redis::types::RedisError", align 8
  %_5.i = alloca %"core::result::Result<redis::connection::ConnectionInfo, redis::types::RedisError>", align 8
  %_4.sroa.7.i = alloca [63 x i8], align 1
  %_24 = alloca %"std::thread::JoinHandle<()>", align 8
  %_21 = alloca %"std::thread::JoinHandle<()>", align 8
  %handle2 = alloca %"std::thread::JoinHandle<()>", align 8
  %handle1 = alloca %"std::thread::JoinHandle<()>", align 8
  %_6.sroa.6 = alloca [63 x i8], align 1
  %_5.sroa.0.sroa.4 = alloca [63 x i8], align 1
  %_5.sroa.0.sroa.5 = alloca %"core::option::Option<alloc::string::String>", align 8
  %client2 = alloca ptr, align 8
  %_3.sroa.6 = alloca [63 x i8], align 1
  %_2.sroa.0.sroa.4 = alloca [63 x i8], align 1
  %_2.sroa.0.sroa.5 = alloca %"core::option::Option<alloc::string::String>", align 8
  %client1 = alloca ptr, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %client1)
  call void @llvm.lifetime.start.p0(i64 63, ptr nonnull %_2.sroa.0.sroa.4)
  call void @llvm.lifetime.start.p0(i64 24, ptr nonnull %_2.sroa.0.sroa.5)
  call void @llvm.lifetime.start.p0(i64 63, ptr nonnull %_3.sroa.6)
  call void @llvm.lifetime.start.p0(i64 63, ptr nonnull %_4.sroa.7.i)
  call void @llvm.lifetime.start.p0(i64 88, ptr nonnull %_5.i), !noalias !421
; call <&str as redis::connection::IntoConnectionInfo>::into_connection_info
  call void @"_ZN65_$LT$$RF$str$u20$as$u20$redis..connection..IntoConnectionInfo$GT$20into_connection_info17h51c81c4e478998bcE"(ptr noalias nocapture noundef nonnull sret(%"core::result::Result<redis::connection::ConnectionInfo, redis::types::RedisError>") dereferenceable(88) %_5.i, ptr noalias noundef nonnull readonly align 1 @alloc365, i64 noundef 23), !noalias !425
  tail call void @llvm.experimental.noalias.scope.decl(metadata !426)
  %0 = load i8, ptr %_5.i, align 8, !range !252, !alias.scope !429, !noalias !431, !noundef !6
  %1 = icmp eq i8 %0, 3
  br i1 %1, label %bb1.i, label %"_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17he89861419ab92940E.exit"

bb1.i:                                            ; preds = %start
  %2 = getelementptr inbounds %"core::result::Result<redis::connection::ConnectionInfo, redis::types::RedisError>::Err", ptr %_5.i, i64 0, i32 1
  %_4.sroa.7.8.sroa_idx2.i = getelementptr inbounds i8, ptr %_4.sroa.7.i, i64 7
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(56) %_4.sroa.7.8.sroa_idx2.i, ptr noundef nonnull align 8 dereferenceable(56) %2, i64 56, i1 false), !alias.scope !432, !noalias !421
  call void @llvm.lifetime.end.p0(i64 88, ptr nonnull %_5.i), !noalias !421
  %_3.sroa.6.8.sroa_idx = getelementptr inbounds i8, ptr %_3.sroa.6, i64 7
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(56) %_3.sroa.6.8.sroa_idx, ptr noundef nonnull align 1 dereferenceable(56) %_4.sroa.7.8.sroa_idx2.i, i64 56, i1 false), !noalias !433
  call void @llvm.lifetime.end.p0(i64 63, ptr nonnull %_4.sroa.7.i)
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %e.i), !noalias !434
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %e.i, ptr noundef nonnull align 1 dereferenceable(56) %_3.sroa.6.8.sroa_idx, i64 56, i1 false), !noalias !439
; invoke core::result::unwrap_failed
  invoke void @_ZN4core6result13unwrap_failed17hdc73d4affce1d414E(ptr noalias noundef nonnull readonly align 1 @alloc344, i64 noundef 43, ptr noundef nonnull align 1 %e.i, ptr noalias noundef nonnull readonly align 8 dereferenceable(24) @vtable.8, ptr noalias noundef nonnull readonly align 8 dereferenceable(24) @alloc367) #22
          to label %unreachable.i unwind label %cleanup.i, !noalias !440

cleanup.i:                                        ; preds = %bb1.i
  %3 = landingpad { ptr, i32 }
          cleanup
; invoke core::ptr::drop_in_place<redis::types::RedisError>
  invoke void @"_ZN4core3ptr45drop_in_place$LT$redis..types..RedisError$GT$17he9e92a6d6be589cdE"(ptr noundef nonnull %e.i) #21
          to label %common.resume unwind label %abort.i, !noalias !440

unreachable.i:                                    ; preds = %bb1.i
  unreachable

abort.i:                                          ; preds = %cleanup.i
  %4 = landingpad { ptr, i32 }
          cleanup
; call core::panicking::panic_cannot_unwind
  call void @_ZN4core9panicking19panic_cannot_unwind17h42344709dec62f2eE() #23, !noalias !440
  unreachable

common.resume:                                    ; preds = %bb16, %bb14, %cleanup.i46, %bb20, %bb18, %cleanup.i, %cleanup.i9
  %common.resume.op = phi { ptr, i32 } [ %8, %cleanup.i9 ], [ %3, %cleanup.i ], [ %eh.lpad-body, %bb20 ], [ %34, %bb18 ], [ %33, %bb16 ], [ %eh.lpad-body4270, %bb14 ], [ %30, %cleanup.i46 ]
  resume { ptr, i32 } %common.resume.op

"_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17he89861419ab92940E.exit": ; preds = %start
  %_4.sroa.7.0._5.sroa_idx.i = getelementptr inbounds i8, ptr %_5.i, i64 1
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(63) %_4.sroa.7.i, ptr noundef nonnull align 1 dereferenceable(63) %_4.sroa.7.0._5.sroa_idx.i, i64 63, i1 false), !alias.scope !432, !noalias !421
  %_4.sroa.9.0._5.sroa_idx.i = getelementptr inbounds i8, ptr %_5.i, i64 64
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %_2.sroa.0.sroa.5, ptr noundef nonnull align 8 dereferenceable(24) %_4.sroa.9.0._5.sroa_idx.i, i64 24, i1 false), !noalias !6
  call void @llvm.lifetime.end.p0(i64 88, ptr nonnull %_5.i), !noalias !421
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(63) %_3.sroa.6, ptr noundef nonnull align 1 dereferenceable(63) %_4.sroa.7.i, i64 63, i1 false), !noalias !433
  call void @llvm.lifetime.end.p0(i64 63, ptr nonnull %_4.sroa.7.i)
  tail call void @llvm.experimental.noalias.scope.decl(metadata !441)
  tail call void @llvm.experimental.noalias.scope.decl(metadata !442)
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(63) %_2.sroa.0.sroa.4, ptr noundef nonnull align 1 dereferenceable(63) %_3.sroa.6, i64 63, i1 false), !alias.scope !440, !noalias !443
  call void @llvm.lifetime.end.p0(i64 63, ptr nonnull %_3.sroa.6)
  call void @llvm.lifetime.start.p0(i64 104, ptr nonnull %x.i), !noalias !444
  %5 = getelementptr inbounds %"alloc::sync::ArcInner<redis::client::Client>", ptr %x.i, i64 0, i32 2
  store i8 %0, ptr %5, align 16
  %_2.sroa.0.sroa.4.0..sroa_idx = getelementptr inbounds %"alloc::sync::ArcInner<redis::client::Client>", ptr %x.i, i64 0, i32 2, i32 0, i32 0, i32 1
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(63) %_2.sroa.0.sroa.4.0..sroa_idx, ptr noundef nonnull align 1 dereferenceable(63) %_2.sroa.0.sroa.4, i64 63, i1 false)
  %_2.sroa.0.sroa.5.0..sroa_idx = getelementptr inbounds %"alloc::sync::ArcInner<redis::client::Client>", ptr %x.i, i64 0, i32 2, i32 0, i32 1, i32 2
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 16 dereferenceable(24) %_2.sroa.0.sroa.5.0..sroa_idx, ptr noundef nonnull align 8 dereferenceable(24) %_2.sroa.0.sroa.5, i64 24, i1 false)
  store <2 x i64> <i64 1, i64 1>, ptr %x.i, align 16, !noalias !444
  %6 = tail call noundef align 8 dereferenceable_or_null(104) ptr @__rust_alloc(i64 noundef 104, i64 noundef 8) #24, !noalias !444
  %7 = icmp eq ptr %6, null
  br i1 %7, label %bb1.i.i, label %"_ZN5alloc4sync12Arc$LT$T$GT$3new17hfb073776e0193294E.exit"

bb1.i.i:                                          ; preds = %"_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17he89861419ab92940E.exit"
; invoke alloc::alloc::handle_alloc_error
  invoke void @_ZN5alloc5alloc18handle_alloc_error17h1f2182fad8da84c7E(i64 noundef 104, i64 noundef 8) #22
          to label %.noexc.i unwind label %cleanup.i9, !noalias !444

.noexc.i:                                         ; preds = %bb1.i.i
  unreachable

cleanup.i9:                                       ; preds = %bb1.i.i
  %8 = landingpad { ptr, i32 }
          cleanup
; call core::ptr::drop_in_place<alloc::sync::ArcInner<redis::client::Client>>
  call fastcc void @"_ZN4core3ptr71drop_in_place$LT$alloc..sync..ArcInner$LT$redis..client..Client$GT$$GT$17h0c5bb33b6ac74b57E"(ptr noundef nonnull %x.i) #21, !noalias !444
  br label %common.resume

"_ZN5alloc4sync12Arc$LT$T$GT$3new17hfb073776e0193294E.exit": ; preds = %"_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17he89861419ab92940E.exit"
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(104) %6, ptr noundef nonnull align 16 dereferenceable(104) %x.i, i64 104, i1 false), !noalias !444
  call void @llvm.lifetime.end.p0(i64 104, ptr nonnull %x.i), !noalias !444
  store ptr %6, ptr %client1, align 8
  call void @llvm.lifetime.end.p0(i64 63, ptr nonnull %_2.sroa.0.sroa.4)
  call void @llvm.lifetime.end.p0(i64 24, ptr nonnull %_2.sroa.0.sroa.5)
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %client2)
  call void @llvm.lifetime.start.p0(i64 63, ptr nonnull %_5.sroa.0.sroa.4)
  call void @llvm.lifetime.start.p0(i64 24, ptr nonnull %_5.sroa.0.sroa.5)
  call void @llvm.lifetime.start.p0(i64 63, ptr nonnull %_6.sroa.6)
  call void @llvm.lifetime.start.p0(i64 63, ptr nonnull %_4.sroa.7.i11)
  call void @llvm.lifetime.start.p0(i64 88, ptr nonnull %_5.i10), !noalias !447
; invoke <&str as redis::connection::IntoConnectionInfo>::into_connection_info
  invoke void @"_ZN65_$LT$$RF$str$u20$as$u20$redis..connection..IntoConnectionInfo$GT$20into_connection_info17h51c81c4e478998bcE"(ptr noalias nocapture noundef nonnull sret(%"core::result::Result<redis::connection::ConnectionInfo, redis::types::RedisError>") dereferenceable(88) %_5.i10, ptr noalias noundef nonnull readonly align 1 @alloc368, i64 noundef 23)
          to label %.noexc unwind label %cleanup

.noexc:                                           ; preds = %"_ZN5alloc4sync12Arc$LT$T$GT$3new17hfb073776e0193294E.exit"
  tail call void @llvm.experimental.noalias.scope.decl(metadata !451)
  %9 = load i8, ptr %_5.i10, align 8, !range !252, !alias.scope !454, !noalias !456, !noundef !6
  %10 = icmp eq i8 %9, 3
  br i1 %10, label %bb1.i22, label %bb5

cleanup:                                          ; preds = %"_ZN5alloc4sync12Arc$LT$T$GT$3new17hfb073776e0193294E.exit"
  %11 = landingpad { ptr, i32 }
          cleanup
  br label %bb20

bb1.i22:                                          ; preds = %.noexc
  %12 = getelementptr inbounds %"core::result::Result<redis::connection::ConnectionInfo, redis::types::RedisError>::Err", ptr %_5.i10, i64 0, i32 1
  %_4.sroa.7.8.sroa_idx2.i17 = getelementptr inbounds i8, ptr %_4.sroa.7.i11, i64 7
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(56) %_4.sroa.7.8.sroa_idx2.i17, ptr noundef nonnull align 8 dereferenceable(56) %12, i64 56, i1 false), !alias.scope !457, !noalias !447
  call void @llvm.lifetime.end.p0(i64 88, ptr nonnull %_5.i10), !noalias !447
  %_6.sroa.6.8.sroa_idx = getelementptr inbounds i8, ptr %_6.sroa.6, i64 7
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(56) %_6.sroa.6.8.sroa_idx, ptr noundef nonnull align 1 dereferenceable(56) %_4.sroa.7.8.sroa_idx2.i17, i64 56, i1 false), !noalias !458
  call void @llvm.lifetime.end.p0(i64 63, ptr nonnull %_4.sroa.7.i11)
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %e.i20), !noalias !459
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %e.i20, ptr noundef nonnull align 1 dereferenceable(56) %_6.sroa.6.8.sroa_idx, i64 56, i1 false), !noalias !464
; invoke core::result::unwrap_failed
  invoke void @_ZN4core6result13unwrap_failed17hdc73d4affce1d414E(ptr noalias noundef nonnull readonly align 1 @alloc344, i64 noundef 43, ptr noundef nonnull align 1 %e.i20, ptr noalias noundef nonnull readonly align 8 dereferenceable(24) @vtable.8, ptr noalias noundef nonnull readonly align 8 dereferenceable(24) @alloc370) #22
          to label %unreachable.i24 unwind label %cleanup.i23, !noalias !465

cleanup.i23:                                      ; preds = %bb1.i22
  %13 = landingpad { ptr, i32 }
          cleanup
; invoke core::ptr::drop_in_place<redis::types::RedisError>
  invoke void @"_ZN4core3ptr45drop_in_place$LT$redis..types..RedisError$GT$17he9e92a6d6be589cdE"(ptr noundef nonnull %e.i20) #21
          to label %bb20 unwind label %abort.i25, !noalias !465

unreachable.i24:                                  ; preds = %bb1.i22
  unreachable

abort.i25:                                        ; preds = %cleanup.i23
  %14 = landingpad { ptr, i32 }
          cleanup
; call core::panicking::panic_cannot_unwind
  call void @_ZN4core9panicking19panic_cannot_unwind17h42344709dec62f2eE() #23, !noalias !465
  unreachable

bb5:                                              ; preds = %.noexc
  %_4.sroa.7.0._5.sroa_idx.i12 = getelementptr inbounds i8, ptr %_5.i10, i64 1
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(63) %_4.sroa.7.i11, ptr noundef nonnull align 1 dereferenceable(63) %_4.sroa.7.0._5.sroa_idx.i12, i64 63, i1 false), !alias.scope !457, !noalias !447
  %_4.sroa.9.0._5.sroa_idx.i13 = getelementptr inbounds i8, ptr %_5.i10, i64 64
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %_5.sroa.0.sroa.5, ptr noundef nonnull align 8 dereferenceable(24) %_4.sroa.9.0._5.sroa_idx.i13, i64 24, i1 false), !noalias !6
  call void @llvm.lifetime.end.p0(i64 88, ptr nonnull %_5.i10), !noalias !447
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(63) %_6.sroa.6, ptr noundef nonnull align 1 dereferenceable(63) %_4.sroa.7.i11, i64 63, i1 false), !noalias !458
  call void @llvm.lifetime.end.p0(i64 63, ptr nonnull %_4.sroa.7.i11)
  tail call void @llvm.experimental.noalias.scope.decl(metadata !466)
  tail call void @llvm.experimental.noalias.scope.decl(metadata !467)
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(63) %_5.sroa.0.sroa.4, ptr noundef nonnull align 1 dereferenceable(63) %_6.sroa.6, i64 63, i1 false), !alias.scope !465, !noalias !468
  call void @llvm.lifetime.end.p0(i64 63, ptr nonnull %_6.sroa.6)
  call void @llvm.lifetime.start.p0(i64 104, ptr nonnull %x.i28), !noalias !469
  %15 = getelementptr inbounds %"alloc::sync::ArcInner<redis::client::Client>", ptr %x.i28, i64 0, i32 2
  store i8 %9, ptr %15, align 16
  %_5.sroa.0.sroa.4.0..sroa_idx = getelementptr inbounds %"alloc::sync::ArcInner<redis::client::Client>", ptr %x.i28, i64 0, i32 2, i32 0, i32 0, i32 1
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(63) %_5.sroa.0.sroa.4.0..sroa_idx, ptr noundef nonnull align 1 dereferenceable(63) %_5.sroa.0.sroa.4, i64 63, i1 false)
  %_5.sroa.0.sroa.5.0..sroa_idx = getelementptr inbounds %"alloc::sync::ArcInner<redis::client::Client>", ptr %x.i28, i64 0, i32 2, i32 0, i32 1, i32 2
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 16 dereferenceable(24) %_5.sroa.0.sroa.5.0..sroa_idx, ptr noundef nonnull align 8 dereferenceable(24) %_5.sroa.0.sroa.5, i64 24, i1 false)
  store <2 x i64> <i64 1, i64 1>, ptr %x.i28, align 16, !noalias !469
  %16 = tail call noundef align 8 dereferenceable_or_null(104) ptr @__rust_alloc(i64 noundef 104, i64 noundef 8) #24, !noalias !469
  %17 = icmp eq ptr %16, null
  br i1 %17, label %bb1.i.i29, label %bb6

bb1.i.i29:                                        ; preds = %bb5
; invoke alloc::alloc::handle_alloc_error
  invoke void @_ZN5alloc5alloc18handle_alloc_error17h1f2182fad8da84c7E(i64 noundef 104, i64 noundef 8) #22
          to label %.noexc.i30 unwind label %cleanup.i31, !noalias !469

.noexc.i30:                                       ; preds = %bb1.i.i29
  unreachable

cleanup.i31:                                      ; preds = %bb1.i.i29
  %18 = landingpad { ptr, i32 }
          cleanup
; call core::ptr::drop_in_place<alloc::sync::ArcInner<redis::client::Client>>
  call fastcc void @"_ZN4core3ptr71drop_in_place$LT$alloc..sync..ArcInner$LT$redis..client..Client$GT$$GT$17h0c5bb33b6ac74b57E"(ptr noundef nonnull %x.i28) #21, !noalias !469
  br label %bb20

bb6:                                              ; preds = %bb5
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(104) %16, ptr noundef nonnull align 16 dereferenceable(104) %x.i28, i64 104, i1 false), !noalias !469
  call void @llvm.lifetime.end.p0(i64 104, ptr nonnull %x.i28), !noalias !469
  store ptr %16, ptr %client2, align 8
  call void @llvm.lifetime.end.p0(i64 63, ptr nonnull %_5.sroa.0.sroa.4)
  call void @llvm.lifetime.end.p0(i64 24, ptr nonnull %_5.sroa.0.sroa.5)
  call void @llvm.lifetime.start.p0(i64 24, ptr nonnull %handle1)
; invoke demo::spawn_user_query
  invoke fastcc void @_ZN4demo16spawn_user_query17h5ac1926a8053c79aE(ptr noalias nocapture noundef nonnull dereferenceable(24) %handle1, ptr noundef nonnull %6, ptr noalias noundef nonnull readonly align 1 @alloc372)
          to label %bb7 unwind label %bb18

bb7:                                              ; preds = %bb6
  call void @llvm.lifetime.start.p0(i64 24, ptr nonnull %handle2)
; invoke demo::spawn_user_query
  invoke fastcc void @_ZN4demo16spawn_user_query17h5ac1926a8053c79aE(ptr noalias nocapture noundef nonnull dereferenceable(24) %handle2, ptr noundef nonnull %16, ptr noalias noundef nonnull readonly align 1 @alloc374)
          to label %bb8 unwind label %bb16

bb8:                                              ; preds = %bb7
  call void @llvm.lifetime.start.p0(i64 24, ptr nonnull %_21)
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %_21, ptr noundef nonnull align 8 dereferenceable(24) %handle1, i64 24, i1 false)
; invoke std::thread::JoinHandle<T>::join
  %19 = invoke fastcc { ptr, ptr } @"_ZN3std6thread19JoinHandle$LT$T$GT$4join17h83d2a16c943a4e2bE"(ptr noalias nocapture noundef nonnull readonly dereferenceable(24) %_21)
          to label %bb9 unwind label %cleanup3.body.thread74

cleanup3.body.thread74:                           ; preds = %bb8
  %20 = landingpad { ptr, i32 }
          cleanup
  br label %bb14

bb9:                                              ; preds = %bb8
  %_20.0 = extractvalue { ptr, ptr } %19, 0
  call void @llvm.lifetime.end.p0(i64 24, ptr nonnull %_21)
  %21 = icmp eq ptr %_20.0, null
  br i1 %21, label %bb10, label %bb1.i37

bb1.i37:                                          ; preds = %bb9
  %_20.1 = extractvalue { ptr, ptr } %19, 1
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %e.i35), !noalias !472
  %22 = icmp ne ptr %_20.1, null
  tail call void @llvm.assume(i1 %22)
  store ptr %_20.0, ptr %e.i35, align 8, !noalias !472
  %23 = getelementptr inbounds { ptr, ptr }, ptr %e.i35, i64 0, i32 1
  store ptr %_20.1, ptr %23, align 8, !noalias !472
; invoke core::result::unwrap_failed
  invoke void @_ZN4core6result13unwrap_failed17hdc73d4affce1d414E(ptr noalias noundef nonnull readonly align 1 @alloc344, i64 noundef 43, ptr noundef nonnull align 1 %e.i35, ptr noalias noundef nonnull readonly align 8 dereferenceable(24) @vtable.7, ptr noalias noundef nonnull readonly align 8 dereferenceable(24) @alloc376) #22
          to label %unreachable.i39 unwind label %cleanup.i38

cleanup.i38:                                      ; preds = %bb1.i37
  %24 = landingpad { ptr, i32 }
          cleanup
; invoke core::ptr::drop_in_place<alloc::boxed::Box<dyn core::any::Any+core::marker::Send>>
  invoke void @"_ZN4core3ptr91drop_in_place$LT$alloc..boxed..Box$LT$dyn$u20$core..any..Any$u2b$core..marker..Send$GT$$GT$17hc9ec03a45b18c819E"(ptr noundef nonnull %e.i35) #21
          to label %bb14 unwind label %abort.i40

unreachable.i39:                                  ; preds = %bb1.i37
  unreachable

abort.i40:                                        ; preds = %cleanup.i38
  %25 = landingpad { ptr, i32 }
          cleanup
; call core::panicking::panic_cannot_unwind
  call void @_ZN4core9panicking19panic_cannot_unwind17h42344709dec62f2eE() #23
  unreachable

bb10:                                             ; preds = %bb9
  call void @llvm.lifetime.start.p0(i64 24, ptr nonnull %_24)
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %_24, ptr noundef nonnull align 8 dereferenceable(24) %handle2, i64 24, i1 false)
; call std::thread::JoinHandle<T>::join
  %26 = call fastcc { ptr, ptr } @"_ZN3std6thread19JoinHandle$LT$T$GT$4join17h83d2a16c943a4e2bE"(ptr noalias nocapture noundef nonnull readonly dereferenceable(24) %_24)
  %_23.0 = extractvalue { ptr, ptr } %26, 0
  call void @llvm.lifetime.end.p0(i64 24, ptr nonnull %_24)
  %27 = icmp eq ptr %_23.0, null
  br i1 %27, label %bb12, label %bb1.i45

bb1.i45:                                          ; preds = %bb10
  %_23.1 = extractvalue { ptr, ptr } %26, 1
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %e.i43), !noalias !476
  %28 = icmp ne ptr %_23.1, null
  tail call void @llvm.assume(i1 %28)
  store ptr %_23.0, ptr %e.i43, align 8, !noalias !476
  %29 = getelementptr inbounds { ptr, ptr }, ptr %e.i43, i64 0, i32 1
  store ptr %_23.1, ptr %29, align 8, !noalias !476
; invoke core::result::unwrap_failed
  invoke void @_ZN4core6result13unwrap_failed17hdc73d4affce1d414E(ptr noalias noundef nonnull readonly align 1 @alloc344, i64 noundef 43, ptr noundef nonnull align 1 %e.i43, ptr noalias noundef nonnull readonly align 8 dereferenceable(24) @vtable.7, ptr noalias noundef nonnull readonly align 8 dereferenceable(24) @alloc378) #22
          to label %unreachable.i47 unwind label %cleanup.i46

cleanup.i46:                                      ; preds = %bb1.i45
  %30 = landingpad { ptr, i32 }
          cleanup
; invoke core::ptr::drop_in_place<alloc::boxed::Box<dyn core::any::Any+core::marker::Send>>
  invoke void @"_ZN4core3ptr91drop_in_place$LT$alloc..boxed..Box$LT$dyn$u20$core..any..Any$u2b$core..marker..Send$GT$$GT$17hc9ec03a45b18c819E"(ptr noundef nonnull %e.i43) #21
          to label %common.resume unwind label %abort.i48

unreachable.i47:                                  ; preds = %bb1.i45
  unreachable

abort.i48:                                        ; preds = %cleanup.i46
  %31 = landingpad { ptr, i32 }
          cleanup
; call core::panicking::panic_cannot_unwind
  call void @_ZN4core9panicking19panic_cannot_unwind17h42344709dec62f2eE() #23
  unreachable

bb12:                                             ; preds = %bb10
  call void @llvm.lifetime.end.p0(i64 24, ptr nonnull %handle2)
  call void @llvm.lifetime.end.p0(i64 24, ptr nonnull %handle1)
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %client2)
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %client1)
  ret void

bb14:                                             ; preds = %cleanup.i38, %cleanup3.body.thread74
  %eh.lpad-body4270 = phi { ptr, i32 } [ %20, %cleanup3.body.thread74 ], [ %24, %cleanup.i38 ]
; invoke core::ptr::drop_in_place<std::thread::JoinHandle<()>>
  invoke fastcc void @"_ZN4core3ptr60drop_in_place$LT$std..thread..JoinHandle$LT$$LP$$RP$$GT$$GT$17h6edbba2370971c99E"(ptr noundef nonnull %handle2) #21
          to label %common.resume unwind label %abort

abort:                                            ; preds = %bb16, %bb14
  %32 = landingpad { ptr, i32 }
          cleanup
; call core::panicking::panic_cannot_unwind
  call void @_ZN4core9panicking19panic_cannot_unwind17h42344709dec62f2eE() #23
  unreachable

bb16:                                             ; preds = %bb7
  %33 = landingpad { ptr, i32 }
          cleanup
; invoke core::ptr::drop_in_place<std::thread::JoinHandle<()>>
  invoke fastcc void @"_ZN4core3ptr60drop_in_place$LT$std..thread..JoinHandle$LT$$LP$$RP$$GT$$GT$17h6edbba2370971c99E"(ptr noundef nonnull %handle1) #21
          to label %common.resume unwind label %abort

bb18:                                             ; preds = %bb6
  %34 = landingpad { ptr, i32 }
          cleanup
; call core::ptr::drop_in_place<alloc::sync::Arc<redis::client::Client>>
  call fastcc void @"_ZN4core3ptr66drop_in_place$LT$alloc..sync..Arc$LT$redis..client..Client$GT$$GT$17h7f41de5249136022E"(ptr noundef nonnull %client2) #21
  br label %common.resume

bb20:                                             ; preds = %cleanup.i23, %cleanup, %cleanup.i31
  %eh.lpad-body = phi { ptr, i32 } [ %11, %cleanup ], [ %18, %cleanup.i31 ], [ %13, %cleanup.i23 ]
; call core::ptr::drop_in_place<alloc::sync::Arc<redis::client::Client>>
  call fastcc void @"_ZN4core3ptr66drop_in_place$LT$alloc..sync..Arc$LT$redis..client..Client$GT$$GT$17h7f41de5249136022E"(ptr noundef nonnull %client1) #21
  br label %common.resume
}

; core::slice::index::slice_start_index_len_fail
; Function Attrs: cold noinline noreturn nonlazybind uwtable
declare void @_ZN4core5slice5index26slice_start_index_len_fail17h504609f2a6b168d1E(i64 noundef, i64 noundef, ptr noalias noundef readonly align 8 dereferenceable(24)) unnamed_addr #7

; Function Attrs: nonlazybind uwtable
declare noundef i32 @rust_eh_personality(i32 noundef, i32 noundef, i64 noundef, ptr noundef, ptr noundef) unnamed_addr #1

; Function Attrs: argmemonly mustprogress nocallback nofree nounwind willreturn
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #8

; <std::sys::unix::stdio::Stderr as std::io::Write>::write
; Function Attrs: nonlazybind uwtable
declare void @"_ZN64_$LT$std..sys..unix..stdio..Stderr$u20$as$u20$std..io..Write$GT$5write17he10f3cdf2d243ffdE"(ptr noalias nocapture noundef sret(%"core::result::Result<usize, std::io::error::Error>") dereferenceable(16), ptr noalias noundef nonnull align 1, ptr noalias noundef nonnull readonly align 1, i64 noundef) unnamed_addr #1

; core::panicking::panic_cannot_unwind
; Function Attrs: cold noinline noreturn nounwind nonlazybind uwtable
declare void @_ZN4core9panicking19panic_cannot_unwind17h42344709dec62f2eE() unnamed_addr #9

; core::fmt::write
; Function Attrs: nonlazybind uwtable
declare noundef zeroext i1 @_ZN4core3fmt5write17h93e2f5923c7eca08E(ptr noundef nonnull align 1, ptr noalias noundef readonly align 8 dereferenceable(24), ptr noalias nocapture noundef readonly dereferenceable(48)) unnamed_addr #1

; core::panicking::panic
; Function Attrs: cold noinline noreturn nonlazybind uwtable
declare void @_ZN4core9panicking5panic17h90931f06a97cc5e0E(ptr noalias noundef nonnull readonly align 1, i64 noundef, ptr noalias noundef readonly align 8 dereferenceable(24)) unnamed_addr #7

; std::sys::unix::decode_error_kind
; Function Attrs: nonlazybind uwtable
declare noundef i8 @_ZN3std3sys4unix17decode_error_kind17h5adf76a4518830caE(i32 noundef) unnamed_addr #1

; std::rt::lang_start_internal
; Function Attrs: nonlazybind uwtable
declare noundef i64 @_ZN3std2rt19lang_start_internal17hca9d5c7277f5b67cE(ptr noundef nonnull align 1, ptr noalias noundef readonly align 8 dereferenceable(24), i64 noundef, ptr noundef, i8 noundef) unnamed_addr #1

; std::sys::unix::thread::Thread::join
; Function Attrs: nonlazybind uwtable
declare void @_ZN3std3sys4unix6thread6Thread4join17h4f6592b9a2ad4cc5E(i64 noundef) unnamed_addr #1

; std::thread::Builder::new
; Function Attrs: nonlazybind uwtable
declare void @_ZN3std6thread7Builder3new17he856e7fb4f75260bE(ptr noalias nocapture noundef sret(%"std::thread::Builder") dereferenceable(40)) unnamed_addr #1

; std::thread::Thread::new
; Function Attrs: nonlazybind uwtable
declare noundef nonnull ptr @_ZN3std6thread6Thread3new17h05dd7e316a337ab2E(ptr noalias noundef align 1, i64) unnamed_addr #1

; std::io::stdio::set_output_capture
; Function Attrs: nonlazybind uwtable
declare noundef ptr @_ZN3std2io5stdio18set_output_capture17h650a707a873ed88aE(ptr noundef) unnamed_addr #1

; std::thread::scoped::ScopeData::increment_num_running_threads
; Function Attrs: nonlazybind uwtable
declare void @_ZN3std6thread6scoped9ScopeData29increment_num_running_threads17ha82c1a6bf73eb90eE(ptr noundef nonnull align 8) unnamed_addr #1

; std::sys::unix::thread::Thread::new
; Function Attrs: nonlazybind uwtable
declare void @_ZN3std3sys4unix6thread6Thread3new17h7e6cfd809124a6f8E(ptr noalias nocapture noundef sret(%"core::result::Result<std::sys::unix::thread::Thread, std::io::error::Error>") dereferenceable(16), i64 noundef, ptr noalias noundef nonnull align 1, ptr noalias noundef readonly align 8 dereferenceable(24)) unnamed_addr #1

; std::thread::Thread::cname
; Function Attrs: nonlazybind uwtable
declare { ptr, i64 } @_ZN3std6thread6Thread5cname17hda75f9288f08d76eE(ptr noalias noundef readonly align 8 dereferenceable(8)) unnamed_addr #1

; std::sys::unix::thread::Thread::set_name
; Function Attrs: nonlazybind uwtable
declare void @_ZN3std3sys4unix6thread6Thread8set_name17hb09a5e4dd2a2bb8bE(ptr noalias noundef nonnull readonly align 1, i64 noundef) unnamed_addr #1

; std::sys::unix::thread::guard::current
; Function Attrs: nonlazybind uwtable
declare void @_ZN3std3sys4unix6thread5guard7current17h1572b420dcf422b7E(ptr noalias nocapture noundef sret(%"core::option::Option<core::ops::range::Range<usize>>") dereferenceable(24)) unnamed_addr #1

; std::sys_common::thread_info::set
; Function Attrs: nonlazybind uwtable
declare void @_ZN3std10sys_common11thread_info3set17hb7f1222b70b29532E(ptr noalias nocapture noundef readonly dereferenceable(24), ptr noundef nonnull) unnamed_addr #1

; std::panicking::try::cleanup
; Function Attrs: cold nonlazybind uwtable
declare { ptr, ptr } @_ZN3std9panicking3try7cleanup17h41c2fc1c7a2c52faE(ptr noundef) unnamed_addr #10

; <str as core::fmt::Display>::fmt
; Function Attrs: nonlazybind uwtable
declare noundef zeroext i1 @"_ZN42_$LT$str$u20$as$u20$core..fmt..Display$GT$3fmt17h592dabb109171ad2E"(ptr noalias noundef nonnull readonly align 1, i64 noundef, ptr noalias noundef align 8 dereferenceable(64)) unnamed_addr #1

; Function Attrs: argmemonly mustprogress nocallback nofree nounwind willreturn writeonly
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #11

; std::sys_common::thread::min_stack
; Function Attrs: nonlazybind uwtable
declare noundef i64 @_ZN3std10sys_common6thread9min_stack17h9b3e35e64e2b9f54E() unnamed_addr #1

; <bytes::bytes_mut::BytesMut as core::ops::drop::Drop>::drop
; Function Attrs: nonlazybind uwtable
declare void @"_ZN68_$LT$bytes..bytes_mut..BytesMut$u20$as$u20$core..ops..drop..Drop$GT$4drop17h3ddab1da761f9101E"(ptr noalias noundef align 8 dereferenceable(32)) unnamed_addr #1

; <std::sys::unix::thread::Thread as core::ops::drop::Drop>::drop
; Function Attrs: nonlazybind uwtable
declare void @"_ZN72_$LT$std..sys..unix..thread..Thread$u20$as$u20$core..ops..drop..Drop$GT$4drop17h88402d24365b1d48E"(ptr noalias noundef align 8 dereferenceable(8)) unnamed_addr #1

; Function Attrs: inaccessiblememonly mustprogress nocallback nofree nosync nounwind willreturn
declare void @llvm.assume(i1 noundef) #12

; core::slice::memchr::memchr_aligned
; Function Attrs: nonlazybind uwtable
declare { i64, i64 } @_ZN4core5slice6memchr14memchr_aligned17h5d92e28ac54ef117E(i8 noundef, ptr noalias noundef nonnull readonly align 1, i64 noundef) unnamed_addr #1

; <std::io::error::Error as core::fmt::Debug>::fmt
; Function Attrs: nonlazybind uwtable
declare noundef zeroext i1 @"_ZN58_$LT$std..io..error..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h8b78aa37499eb01fE"(ptr noalias noundef readonly align 8 dereferenceable(8), ptr noalias noundef align 8 dereferenceable(64)) unnamed_addr #1

; core::result::unwrap_failed
; Function Attrs: cold noinline noreturn nonlazybind uwtable
declare void @_ZN4core6result13unwrap_failed17hdc73d4affce1d414E(ptr noalias noundef nonnull readonly align 1, i64 noundef, ptr noundef nonnull align 1, ptr noalias noundef readonly align 8 dereferenceable(24), ptr noalias noundef readonly align 8 dereferenceable(24)) unnamed_addr #7

; <alloc::ffi::c_str::NulError as core::fmt::Debug>::fmt
; Function Attrs: nonlazybind uwtable
declare noundef zeroext i1 @"_ZN64_$LT$alloc..ffi..c_str..NulError$u20$as$u20$core..fmt..Debug$GT$3fmt17h46aec0dfdbe4e538E"(ptr noalias noundef readonly align 8 dereferenceable(32), ptr noalias noundef align 8 dereferenceable(64)) unnamed_addr #1

; <redis::types::RedisError as core::fmt::Debug>::fmt
; Function Attrs: nonlazybind uwtable
declare noundef zeroext i1 @"_ZN61_$LT$redis..types..RedisError$u20$as$u20$core..fmt..Debug$GT$3fmt17hb973bd1f4a1d7f24E"(ptr noalias noundef readonly align 8 dereferenceable(56), ptr noalias noundef align 8 dereferenceable(64)) unnamed_addr #1

; alloc::string::<impl core::convert::From<alloc::string::String> for alloc::vec::Vec<u8>>::from
; Function Attrs: nonlazybind uwtable
declare void @"_ZN5alloc6string104_$LT$impl$u20$core..convert..From$LT$alloc..string..String$GT$$u20$for$u20$alloc..vec..Vec$LT$u8$GT$$GT$4from17hea10657225ca3aa5E"(ptr noalias nocapture noundef sret(%"alloc::vec::Vec<u8>") dereferenceable(24), ptr noalias nocapture noundef readonly dereferenceable(24)) unnamed_addr #1

; alloc::fmt::format::format_inner
; Function Attrs: nonlazybind uwtable
declare void @_ZN5alloc3fmt6format12format_inner17h499afee7b38b5a15E(ptr noalias nocapture noundef sret(%"alloc::string::String") dereferenceable(24), ptr noalias nocapture noundef readonly dereferenceable(48)) unnamed_addr #1

; alloc::alloc::handle_alloc_error
; Function Attrs: cold noreturn nonlazybind uwtable
declare void @_ZN5alloc5alloc18handle_alloc_error17h1f2182fad8da84c7E(i64 noundef, i64 noundef) unnamed_addr #13

; Function Attrs: nounwind nonlazybind allockind("alloc,uninitialized,aligned") allocsize(0) uwtable
declare noalias noundef ptr @__rust_alloc(i64 noundef, i64 allocalign noundef) unnamed_addr #14

; <redis::connection::Connection as redis::connection::ConnectionLike>::req_packed_command
; Function Attrs: nonlazybind uwtable
declare void @"_ZN83_$LT$redis..connection..Connection$u20$as$u20$redis..connection..ConnectionLike$GT$18req_packed_command17ha574c0c9bed78e8fE"(ptr noalias nocapture noundef sret(%"core::result::Result<redis::types::Value, redis::types::RedisError>") dereferenceable(56), ptr noalias noundef align 8 dereferenceable(88), ptr noalias noundef nonnull readonly align 1, i64 noundef) unnamed_addr #1

; redis::cmd::Cmd::write_packed_command
; Function Attrs: nonlazybind uwtable
declare void @_ZN5redis3cmd3Cmd20write_packed_command17h335349a4c3f61478E(ptr noalias noundef readonly align 8 dereferenceable(64), ptr noalias noundef align 8 dereferenceable(24)) unnamed_addr #1

; <alloc::string::String as redis::types::FromRedisValue>::from_redis_value
; Function Attrs: nonlazybind uwtable
declare void @"_ZN70_$LT$alloc..string..String$u20$as$u20$redis..types..FromRedisValue$GT$16from_redis_value17h764fc4ec7c118126E"(ptr noalias nocapture noundef sret(%"core::result::Result<alloc::string::String, redis::types::RedisError>") dereferenceable(56), ptr noalias noundef readonly align 8 dereferenceable(32)) unnamed_addr #1

; <() as redis::types::FromRedisValue>::from_redis_value
; Function Attrs: nonlazybind uwtable
declare void @"_ZN57_$LT$$LP$$RP$$u20$as$u20$redis..types..FromRedisValue$GT$16from_redis_value17h7cc1db2fba739b90E"(ptr noalias nocapture noundef sret(%"core::result::Result<(), redis::types::RedisError>") dereferenceable(56), ptr noalias noundef readonly align 8 dereferenceable(32)) unnamed_addr #1

; <&str as redis::connection::IntoConnectionInfo>::into_connection_info
; Function Attrs: nonlazybind uwtable
declare void @"_ZN65_$LT$$RF$str$u20$as$u20$redis..connection..IntoConnectionInfo$GT$20into_connection_info17h51c81c4e478998bcE"(ptr noalias nocapture noundef sret(%"core::result::Result<redis::connection::ConnectionInfo, redis::types::RedisError>") dereferenceable(88), ptr noalias noundef nonnull readonly align 1, i64 noundef) unnamed_addr #1

; redis::cmd::cmd
; Function Attrs: nonlazybind uwtable
declare void @_ZN5redis3cmd3cmd17h0f3121e002b2e6b0E(ptr noalias nocapture noundef sret(%"redis::cmd::Cmd") dereferenceable(64), ptr noalias noundef nonnull readonly align 1, i64 noundef) unnamed_addr #1

; redis::cmd::Cmd::new
; Function Attrs: nonlazybind uwtable
declare void @_ZN5redis3cmd3Cmd3new17h02c81ac25f6253f5E(ptr noalias nocapture noundef sret(%"redis::cmd::Cmd") dereferenceable(64)) unnamed_addr #1

; Function Attrs: nounwind nonlazybind allockind("free") uwtable
declare void @__rust_dealloc(ptr allocptr noundef, i64 noundef, i64 noundef) unnamed_addr #15

; Function Attrs: cold noreturn nounwind
declare void @llvm.trap() #16

; alloc::ffi::c_str::CString::_from_vec_unchecked
; Function Attrs: nonlazybind uwtable
declare { ptr, i64 } @_ZN5alloc3ffi5c_str7CString19_from_vec_unchecked17h53edb6e6aa33562fE(ptr noalias nocapture noundef dereferenceable(24)) unnamed_addr #1

; <dyn core::any::Any+core::marker::Send as core::fmt::Debug>::fmt
; Function Attrs: nonlazybind uwtable
declare noundef zeroext i1 @"_ZN82_$LT$dyn$u20$core..any..Any$u2b$core..marker..Send$u20$as$u20$core..fmt..Debug$GT$3fmt17h1a4efa3817931fb5E"(ptr noundef nonnull align 1, ptr noalias noundef readonly align 8 dereferenceable(24), ptr noalias noundef align 8 dereferenceable(64)) unnamed_addr #1

; <redis::cmd::Cmd as redis::types::RedisWrite>::write_arg
; Function Attrs: nonlazybind uwtable
declare void @"_ZN60_$LT$redis..cmd..Cmd$u20$as$u20$redis..types..RedisWrite$GT$9write_arg17h8270d42f2a1b25b1E"(ptr noalias noundef align 8 dereferenceable(64), ptr noalias noundef nonnull readonly align 1, i64 noundef) unnamed_addr #1

; Function Attrs: nonlazybind uwtable
declare noundef i32 @close(i32 noundef) unnamed_addr #1

; std::thread::scoped::ScopeData::decrement_num_running_threads
; Function Attrs: nonlazybind uwtable
declare void @_ZN3std6thread6scoped9ScopeData29decrement_num_running_threads17hd0b29bf4c04585f2E(ptr noundef nonnull align 8, i1 noundef zeroext) unnamed_addr #1

; std::sys::unix::stdio::panic_output
; Function Attrs: nonlazybind uwtable
declare noundef zeroext i1 @_ZN3std3sys4unix5stdio12panic_output17h10b27a13c39e27f7E() unnamed_addr #1

; <core::fmt::Arguments as core::fmt::Display>::fmt
; Function Attrs: nonlazybind uwtable
declare noundef zeroext i1 @"_ZN59_$LT$core..fmt..Arguments$u20$as$u20$core..fmt..Display$GT$3fmt17he38941b7d204d60dE"(ptr noalias noundef readonly align 8 dereferenceable(48), ptr noalias noundef align 8 dereferenceable(64)) unnamed_addr #1

; std::sys::unix::abort_internal
; Function Attrs: noreturn nonlazybind uwtable
declare void @_ZN3std3sys4unix14abort_internal17h7f37f07e4ed20c97E() unnamed_addr #17

; redis::client::Client::get_connection
; Function Attrs: nonlazybind uwtable
declare void @_ZN5redis6client6Client14get_connection17h0ec62c907cf206e1E(ptr noalias nocapture noundef sret(%"core::result::Result<redis::connection::Connection, redis::types::RedisError>") dereferenceable(88), ptr noalias noundef readonly align 8 dereferenceable(88)) unnamed_addr #1

; std::io::stdio::_print
; Function Attrs: nonlazybind uwtable
declare void @_ZN3std2io5stdio6_print17h96fa75218cf4f48dE(ptr noalias nocapture noundef readonly dereferenceable(48)) unnamed_addr #1

; Function Attrs: nonlazybind
define i32 @main(i32 %0, ptr %1) unnamed_addr #18 {
top:
  %_9.i = alloca ptr, align 8
  %2 = sext i32 %0 to i64
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %_9.i)
  store ptr @_ZN4demo4main17h3a2356faed25125dE, ptr %_9.i, align 8
; call std::rt::lang_start_internal
  %3 = call noundef i64 @_ZN3std2rt19lang_start_internal17hca9d5c7277f5b67cE(ptr noundef nonnull align 1 %_9.i, ptr noalias noundef nonnull readonly align 8 dereferenceable(24) @vtable.1, i64 noundef %2, ptr noundef %1, i8 noundef 0)
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %_9.i)
  %4 = trunc i64 %3 to i32
  ret i32 %4
}

; Function Attrs: argmemonly mustprogress nocallback nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #19

; Function Attrs: argmemonly mustprogress nocallback nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #19

; Function Attrs: inaccessiblememonly nocallback nofree nosync nounwind willreturn
declare void @llvm.experimental.noalias.scope.decl(metadata) #20

attributes #0 = { noinline nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #1 = { nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #2 = { inlinehint nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #3 = { nounwind nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #4 = { inlinehint mustprogress nofree norecurse nosync nounwind nonlazybind readnone willreturn uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #5 = { noinline nounwind nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #6 = { inlinehint nounwind nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #7 = { cold noinline noreturn nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #8 = { argmemonly mustprogress nocallback nofree nounwind willreturn }
attributes #9 = { cold noinline noreturn nounwind nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #10 = { cold nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #11 = { argmemonly mustprogress nocallback nofree nounwind willreturn writeonly }
attributes #12 = { inaccessiblememonly mustprogress nocallback nofree nosync nounwind willreturn }
attributes #13 = { cold noreturn nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #14 = { nounwind nonlazybind allockind("alloc,uninitialized,aligned") allocsize(0) uwtable "alloc-family"="__rust_alloc" "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #15 = { nounwind nonlazybind allockind("free") uwtable "alloc-family"="__rust_alloc" "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #16 = { cold noreturn nounwind }
attributes #17 = { noreturn nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #18 = { nonlazybind "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #19 = { argmemonly mustprogress nocallback nofree nosync nounwind willreturn }
attributes #20 = { inaccessiblememonly nocallback nofree nosync nounwind willreturn }
attributes #21 = { noinline }
attributes #22 = { noreturn }
attributes #23 = { noinline noreturn nounwind }
attributes #24 = { nounwind }

!llvm.module.flags = !{!0, !1, !2}

!0 = !{i32 7, !"PIC Level", i32 2}
!1 = !{i32 7, !"PIE Level", i32 2}
!2 = !{i32 2, !"RtLibUseGOT", i32 1}
!3 = !{!4}
!4 = distinct !{!4, !5, !"_ZN4demo16spawn_user_query28_$u7b$$u7b$closure$u7d$$u7d$17haf502634fafd28e6E: %_1"}
!5 = distinct !{!5, !"_ZN4demo16spawn_user_query28_$u7b$$u7b$closure$u7d$$u7d$17haf502634fafd28e6E"}
!6 = !{}
!7 = !{!8}
!8 = distinct !{!8, !9, !"_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17he4a1beae4b61d0deE: %t"}
!9 = distinct !{!9, !"_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17he4a1beae4b61d0deE"}
!10 = !{!11}
!11 = distinct !{!11, !9, !"_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17he4a1beae4b61d0deE: %self"}
!12 = !{i32 0, i32 3}
!13 = !{!8, !4}
!14 = !{!8, !11, !4}
!15 = !{!8, !11}
!16 = !{!17, !19, !20, !22, !23, !4}
!17 = distinct !{!17, !18, !"_ZN5alloc3fmt6format28_$u7b$$u7b$closure$u7d$$u7d$17h655f0ba1e6af2035E: argument 0"}
!18 = distinct !{!18, !"_ZN5alloc3fmt6format28_$u7b$$u7b$closure$u7d$$u7d$17h655f0ba1e6af2035E"}
!19 = distinct !{!19, !18, !"_ZN5alloc3fmt6format28_$u7b$$u7b$closure$u7d$$u7d$17h655f0ba1e6af2035E: argument 1"}
!20 = distinct !{!20, !21, !"_ZN4core6option15Option$LT$T$GT$11map_or_else17hbdc085a1083e17feE: argument 0"}
!21 = distinct !{!21, !"_ZN4core6option15Option$LT$T$GT$11map_or_else17hbdc085a1083e17feE"}
!22 = distinct !{!22, !21, !"_ZN4core6option15Option$LT$T$GT$11map_or_else17hbdc085a1083e17feE: argument 1"}
!23 = distinct !{!23, !21, !"_ZN4core6option15Option$LT$T$GT$11map_or_else17hbdc085a1083e17feE: %default"}
!24 = !{!17, !20, !22, !4}
!25 = !{!26, !28, !4}
!26 = distinct !{!26, !27, !"_ZN5redis8commands8Commands3get17h6f38e29dd9b53328E: argument 0"}
!27 = distinct !{!27, !"_ZN5redis8commands8Commands3get17h6f38e29dd9b53328E"}
!28 = distinct !{!28, !27, !"_ZN5redis8commands8Commands3get17h6f38e29dd9b53328E: %self"}
!29 = !{!30, !32, !26, !28, !4}
!30 = distinct !{!30, !31, !"_ZN5redis8commands33_$LT$impl$u20$redis..cmd..Cmd$GT$3get17h459b9983035c4a35E: argument 0"}
!31 = distinct !{!31, !"_ZN5redis8commands33_$LT$impl$u20$redis..cmd..Cmd$GT$3get17h459b9983035c4a35E"}
!32 = distinct !{!32, !31, !"_ZN5redis8commands33_$LT$impl$u20$redis..cmd..Cmd$GT$3get17h459b9983035c4a35E: argument 1"}
!33 = !{!30, !32, !26, !28}
!34 = !{!35}
!35 = distinct !{!35, !36, !"_ZN4core3mem7replace17h038456290ff847bdE: %result"}
!36 = distinct !{!36, !"_ZN4core3mem7replace17h038456290ff847bdE"}
!37 = !{!38}
!38 = distinct !{!38, !36, !"_ZN4core3mem7replace17h038456290ff847bdE: %src"}
!39 = !{!35, !40}
!40 = distinct !{!40, !36, !"_ZN4core3mem7replace17h038456290ff847bdE: %dest"}
!41 = !{!38, !32, !26, !28, !4}
!42 = !{!40, !38}
!43 = !{!35, !30, !32, !26, !28, !4}
!44 = !{!45, !47, !26, !28, !4}
!45 = distinct !{!45, !46, !"_ZN5redis3cmd3Cmd5query17h10696cbde2351150E: argument 0"}
!46 = distinct !{!46, !"_ZN5redis3cmd3Cmd5query17h10696cbde2351150E"}
!47 = distinct !{!47, !46, !"_ZN5redis3cmd3Cmd5query17h10696cbde2351150E: %self"}
!48 = !{!26}
!49 = !{i8 0, i8 5}
!50 = !{!51}
!51 = distinct !{!51, !52, !"_ZN5redis5types16from_redis_value17h5d4229c5f68c6305E: %v"}
!52 = distinct !{!52, !"_ZN5redis5types16from_redis_value17h5d4229c5f68c6305E"}
!53 = !{!54}
!54 = distinct !{!54, !55, !"_ZN78_$LT$core..option..Option$LT$T$GT$$u20$as$u20$redis..types..FromRedisValue$GT$16from_redis_value17hc295f1d45d380591E: %v"}
!55 = distinct !{!55, !"_ZN78_$LT$core..option..Option$LT$T$GT$$u20$as$u20$redis..types..FromRedisValue$GT$16from_redis_value17hc295f1d45d380591E"}
!56 = !{i64 0, i64 6}
!57 = !{!54, !51}
!58 = !{!59, !60, !45, !47, !26, !28, !4}
!59 = distinct !{!59, !55, !"_ZN78_$LT$core..option..Option$LT$T$GT$$u20$as$u20$redis..types..FromRedisValue$GT$16from_redis_value17hc295f1d45d380591E: argument 0"}
!60 = distinct !{!60, !52, !"_ZN5redis5types16from_redis_value17h5d4229c5f68c6305E: argument 0"}
!61 = !{!59, !54, !60, !51, !45, !47, !26, !28, !4}
!62 = !{!45, !26}
!63 = !{!64}
!64 = distinct !{!64, !65, !"_ZN79_$LT$core..result..Result$LT$T$C$E$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17h383592c4f16d06afE: argument 0"}
!65 = distinct !{!65, !"_ZN79_$LT$core..result..Result$LT$T$C$E$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17h383592c4f16d06afE"}
!66 = !{!67}
!67 = distinct !{!67, !65, !"_ZN79_$LT$core..result..Result$LT$T$C$E$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17h383592c4f16d06afE: %self"}
!68 = !{!64, !59, !54, !60, !51, !45, !47, !26, !28, !4}
!69 = !{!64, !67}
!70 = !{!54, !51, !47, !28, !4}
!71 = !{!47, !28, !4}
!72 = !{!73, !75, !76, !4}
!73 = distinct !{!73, !74, !"_ZN4core6result19Result$LT$T$C$E$GT$9unwrap_or17hae8e0c7c8fbb0851E: argument 0"}
!74 = distinct !{!74, !"_ZN4core6result19Result$LT$T$C$E$GT$9unwrap_or17hae8e0c7c8fbb0851E"}
!75 = distinct !{!75, !74, !"_ZN4core6result19Result$LT$T$C$E$GT$9unwrap_or17hae8e0c7c8fbb0851E: %self"}
!76 = distinct !{!76, !74, !"_ZN4core6result19Result$LT$T$C$E$GT$9unwrap_or17hae8e0c7c8fbb0851E: %default"}
!77 = !{!73, !76, !4}
!78 = !{!79, !81, !4}
!79 = distinct !{!79, !80, !"_ZN4demo16call_chatgpt_api17hd9321a2d12504473E: %res"}
!80 = distinct !{!80, !"_ZN4demo16call_chatgpt_api17hd9321a2d12504473E"}
!81 = distinct !{!81, !80, !"_ZN4demo16call_chatgpt_api17hd9321a2d12504473E: argument 1"}
!82 = !{!83, !85, !86, !88, !89, !79, !81, !4}
!83 = distinct !{!83, !84, !"_ZN5alloc3fmt6format28_$u7b$$u7b$closure$u7d$$u7d$17h655f0ba1e6af2035E: argument 0"}
!84 = distinct !{!84, !"_ZN5alloc3fmt6format28_$u7b$$u7b$closure$u7d$$u7d$17h655f0ba1e6af2035E"}
!85 = distinct !{!85, !84, !"_ZN5alloc3fmt6format28_$u7b$$u7b$closure$u7d$$u7d$17h655f0ba1e6af2035E: argument 1"}
!86 = distinct !{!86, !87, !"_ZN4core6option15Option$LT$T$GT$11map_or_else17hbdc085a1083e17feE: argument 0"}
!87 = distinct !{!87, !"_ZN4core6option15Option$LT$T$GT$11map_or_else17hbdc085a1083e17feE"}
!88 = distinct !{!88, !87, !"_ZN4core6option15Option$LT$T$GT$11map_or_else17hbdc085a1083e17feE: argument 1"}
!89 = distinct !{!89, !87, !"_ZN4core6option15Option$LT$T$GT$11map_or_else17hbdc085a1083e17feE: %default"}
!90 = !{!83, !86, !88, !79, !81, !4}
!91 = !{!92}
!92 = distinct !{!92, !93, !"_ZN4core3fmt9Arguments6new_v117hdcde62b43d9ade08E: argument 0"}
!93 = distinct !{!93, !"_ZN4core3fmt9Arguments6new_v117hdcde62b43d9ade08E"}
!94 = !{!95, !96, !4}
!95 = distinct !{!95, !93, !"_ZN4core3fmt9Arguments6new_v117hdcde62b43d9ade08E: %pieces.0"}
!96 = distinct !{!96, !93, !"_ZN4core3fmt9Arguments6new_v117hdcde62b43d9ade08E: %args.0"}
!97 = !{!98, !100, !101, !4}
!98 = distinct !{!98, !99, !"_ZN5redis8commands8Commands3set17hfadd54a15996b731E: argument 0"}
!99 = distinct !{!99, !"_ZN5redis8commands8Commands3set17hfadd54a15996b731E"}
!100 = distinct !{!100, !99, !"_ZN5redis8commands8Commands3set17hfadd54a15996b731E: %self"}
!101 = distinct !{!101, !99, !"_ZN5redis8commands8Commands3set17hfadd54a15996b731E: %value"}
!102 = !{!103, !105, !98, !100, !101, !4}
!103 = distinct !{!103, !104, !"_ZN5redis8commands33_$LT$impl$u20$redis..cmd..Cmd$GT$3set17h284181bf7b1d94e5E: argument 0"}
!104 = distinct !{!104, !"_ZN5redis8commands33_$LT$impl$u20$redis..cmd..Cmd$GT$3set17h284181bf7b1d94e5E"}
!105 = distinct !{!105, !104, !"_ZN5redis8commands33_$LT$impl$u20$redis..cmd..Cmd$GT$3set17h284181bf7b1d94e5E: %value"}
!106 = !{!103, !105, !98, !100, !101}
!107 = !{!98, !100, !4}
!108 = !{!109}
!109 = distinct !{!109, !110, !"_ZN5redis3cmd3Cmd3arg17h33f63d9ce6be49ffE: %arg"}
!110 = distinct !{!110, !"_ZN5redis3cmd3Cmd3arg17h33f63d9ce6be49ffE"}
!111 = !{!112, !103, !105, !98, !100, !101, !4}
!112 = distinct !{!112, !110, !"_ZN5redis3cmd3Cmd3arg17h33f63d9ce6be49ffE: %self"}
!113 = !{!109, !103, !105, !98, !100, !101}
!114 = !{!115}
!115 = distinct !{!115, !116, !"_ZN4core3mem7replace17h038456290ff847bdE: %result"}
!116 = distinct !{!116, !"_ZN4core3mem7replace17h038456290ff847bdE"}
!117 = !{!118}
!118 = distinct !{!118, !116, !"_ZN4core3mem7replace17h038456290ff847bdE: %src"}
!119 = !{!115, !120}
!120 = distinct !{!120, !116, !"_ZN4core3mem7replace17h038456290ff847bdE: %dest"}
!121 = !{!118, !105, !98, !100, !101, !4}
!122 = !{!120, !118}
!123 = !{!115, !103, !105, !98, !100, !101, !4}
!124 = !{!103, !98, !100, !101}
!125 = !{!126, !128, !98, !100, !101, !4}
!126 = distinct !{!126, !127, !"_ZN5redis3cmd3Cmd5query17h077a0fcabc1d6d2dE: argument 0"}
!127 = distinct !{!127, !"_ZN5redis3cmd3Cmd5query17h077a0fcabc1d6d2dE"}
!128 = distinct !{!128, !127, !"_ZN5redis3cmd3Cmd5query17h077a0fcabc1d6d2dE: %self"}
!129 = !{!98, !101}
!130 = !{!101}
!131 = !{!128, !100, !101, !4}
!132 = !{!126, !98, !101}
!133 = !{!134}
!134 = distinct !{!134, !135, !"_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17h8ce51ccde3ccefbaE: %self"}
!135 = distinct !{!135, !"_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17h8ce51ccde3ccefbaE"}
!136 = !{!134, !4}
!137 = !{!138}
!138 = distinct !{!138, !139, !"_ZN4core3fmt9Arguments6new_v117hdcde62b43d9ade08E: argument 0"}
!139 = distinct !{!139, !"_ZN4core3fmt9Arguments6new_v117hdcde62b43d9ade08E"}
!140 = !{!141, !142, !4}
!141 = distinct !{!141, !139, !"_ZN4core3fmt9Arguments6new_v117hdcde62b43d9ade08E: %pieces.0"}
!142 = distinct !{!142, !139, !"_ZN4core3fmt9Arguments6new_v117hdcde62b43d9ade08E: %args.0"}
!143 = !{!144}
!144 = distinct !{!144, !145, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h8df286fb36c045abE: %self"}
!145 = distinct !{!145, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h8df286fb36c045abE"}
!146 = !{!144, !4}
!147 = !{i32 4065588}
!148 = !{i64 8}
!149 = !{i64 0, i64 -9223372036854775808}
!150 = !{i64 1, i64 0}
!151 = !{!152}
!152 = distinct !{!152, !153, !"_ZN3std6thread18JoinInner$LT$T$GT$4join17h16e58e602d341610E: %self"}
!153 = distinct !{!153, !"_ZN3std6thread18JoinInner$LT$T$GT$4join17h16e58e602d341610E"}
!154 = !{!155}
!155 = distinct !{!155, !156, !"_ZN5alloc4sync12Arc$LT$T$GT$7get_mut17h163af9a81b25f004E: %this"}
!156 = distinct !{!156, !"_ZN5alloc4sync12Arc$LT$T$GT$7get_mut17h163af9a81b25f004E"}
!157 = !{!158}
!158 = distinct !{!158, !159, !"_ZN5alloc4sync12Arc$LT$T$GT$9is_unique17hc77ea7ed85afcc04E: %self"}
!159 = distinct !{!159, !"_ZN5alloc4sync12Arc$LT$T$GT$9is_unique17hc77ea7ed85afcc04E"}
!160 = !{!158, !155, !152}
!161 = !{!155, !152}
!162 = !{!163}
!163 = distinct !{!163, !164, !"_ZN4core3mem7replace17hc69c3638740e0659E: %result"}
!164 = distinct !{!164, !"_ZN4core3mem7replace17hc69c3638740e0659E"}
!165 = !{!166}
!166 = distinct !{!166, !164, !"_ZN4core3mem7replace17hc69c3638740e0659E: %src"}
!167 = !{!163, !168}
!168 = distinct !{!168, !164, !"_ZN4core3mem7replace17hc69c3638740e0659E: %dest"}
!169 = !{!166, !152}
!170 = !{!168, !166}
!171 = !{!163, !152}
!172 = !{!173}
!173 = distinct !{!173, !174, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h7a437f5927f79d4bE: %self"}
!174 = distinct !{!174, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h7a437f5927f79d4bE"}
!175 = !{!173, !152}
!176 = !{!177}
!177 = distinct !{!177, !178, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hfef7099c19bb28eaE: %self"}
!178 = distinct !{!178, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hfef7099c19bb28eaE"}
!179 = !{!177, !152}
!180 = !{i64 1}
!181 = !{!182}
!182 = distinct !{!182, !183, !"_ZN4core4char7methods15encode_utf8_raw17h25b1f82ed72141b2E: %dst.0"}
!183 = distinct !{!183, !"_ZN4core4char7methods15encode_utf8_raw17h25b1f82ed72141b2E"}
!184 = !{!185}
!185 = distinct !{!185, !186, !"_ZN3std6thread7Builder16spawn_unchecked_28_$u7b$$u7b$closure$u7d$$u7d$17h94a26f3067fe8a1dE: %_1"}
!186 = distinct !{!186, !"_ZN3std6thread7Builder16spawn_unchecked_28_$u7b$$u7b$closure$u7d$$u7d$17h94a26f3067fe8a1dE"}
!187 = !{!188}
!188 = distinct !{!188, !189, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hc9ec8e7e55201a76E: %self"}
!189 = distinct !{!189, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hc9ec8e7e55201a76E"}
!190 = !{!191, !193, !195, !197, !185}
!191 = distinct !{!191, !192, !"_ZN3std6thread7Builder16spawn_unchecked_28_$u7b$$u7b$closure$u7d$$u7d$28_$u7b$$u7b$closure$u7d$$u7d$17hcfc520e8d6da878fE: %_1"}
!192 = distinct !{!192, !"_ZN3std6thread7Builder16spawn_unchecked_28_$u7b$$u7b$closure$u7d$$u7d$28_$u7b$$u7b$closure$u7d$$u7d$17hcfc520e8d6da878fE"}
!193 = distinct !{!193, !194, !"_ZN115_$LT$core..panic..unwind_safe..AssertUnwindSafe$LT$F$GT$$u20$as$u20$core..ops..function..FnOnce$LT$$LP$$RP$$GT$$GT$9call_once17hfe35c8daa26fbec9E: %self"}
!194 = distinct !{!194, !"_ZN115_$LT$core..panic..unwind_safe..AssertUnwindSafe$LT$F$GT$$u20$as$u20$core..ops..function..FnOnce$LT$$LP$$RP$$GT$$GT$9call_once17hfe35c8daa26fbec9E"}
!195 = distinct !{!195, !196, !"_ZN3std9panicking3try17ha6ed38ba18ccbba7E: %f"}
!196 = distinct !{!196, !"_ZN3std9panicking3try17ha6ed38ba18ccbba7E"}
!197 = distinct !{!197, !198, !"_ZN3std5panic12catch_unwind17hc3a060a89ff3653fE: %f"}
!198 = distinct !{!198, !"_ZN3std5panic12catch_unwind17hc3a060a89ff3653fE"}
!199 = !{!195, !197, !185}
!200 = !{!195, !197}
!201 = !{i64 0, i64 2}
!202 = !{!203}
!203 = distinct !{!203, !204, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hfef7099c19bb28eaE: %self"}
!204 = distinct !{!204, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hfef7099c19bb28eaE"}
!205 = !{!206}
!206 = distinct !{!206, !207, !"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h657bb9ea592f471eE: %_1"}
!207 = distinct !{!207, !"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h657bb9ea592f471eE"}
!208 = !{!209}
!209 = distinct !{!209, !210, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h8b40639afc131966E: %self"}
!210 = distinct !{!210, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h8b40639afc131966E"}
!211 = !{!212}
!212 = distinct !{!212, !213, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hc9ec8e7e55201a76E: %self"}
!213 = distinct !{!213, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hc9ec8e7e55201a76E"}
!214 = !{!215}
!215 = distinct !{!215, !216, !"_ZN104_$LT$std..thread..Builder..spawn_unchecked_..MaybeDangling$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h8ff69f164c7953e4E: %self"}
!216 = distinct !{!216, !"_ZN104_$LT$std..thread..Builder..spawn_unchecked_..MaybeDangling$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h8ff69f164c7953e4E"}
!217 = !{!218}
!218 = distinct !{!218, !219, !"_ZN4core3mem12maybe_uninit20MaybeUninit$LT$T$GT$16assume_init_drop17hfac375a8fe0a9729E: %self"}
!219 = distinct !{!219, !"_ZN4core3mem12maybe_uninit20MaybeUninit$LT$T$GT$16assume_init_drop17hfac375a8fe0a9729E"}
!220 = !{!221}
!221 = distinct !{!221, !222, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h8df286fb36c045abE: %self"}
!222 = distinct !{!222, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h8df286fb36c045abE"}
!223 = !{!221, !218, !215}
!224 = !{!218, !215}
!225 = !{!226}
!226 = distinct !{!226, !227, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h7a437f5927f79d4bE: %self"}
!227 = distinct !{!227, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h7a437f5927f79d4bE"}
!228 = !{!229}
!229 = distinct !{!229, !230, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hc9ec8e7e55201a76E: %self"}
!230 = distinct !{!230, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hc9ec8e7e55201a76E"}
!231 = !{!232}
!232 = distinct !{!232, !233, !"_ZN104_$LT$std..thread..Builder..spawn_unchecked_..MaybeDangling$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h8ff69f164c7953e4E: %self"}
!233 = distinct !{!233, !"_ZN104_$LT$std..thread..Builder..spawn_unchecked_..MaybeDangling$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h8ff69f164c7953e4E"}
!234 = !{!235}
!235 = distinct !{!235, !236, !"_ZN4core3mem12maybe_uninit20MaybeUninit$LT$T$GT$16assume_init_drop17hfac375a8fe0a9729E: %self"}
!236 = distinct !{!236, !"_ZN4core3mem12maybe_uninit20MaybeUninit$LT$T$GT$16assume_init_drop17hfac375a8fe0a9729E"}
!237 = !{!238}
!238 = distinct !{!238, !239, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h8df286fb36c045abE: %self"}
!239 = distinct !{!239, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h8df286fb36c045abE"}
!240 = !{!238, !235, !232}
!241 = !{!235, !232}
!242 = !{!243}
!243 = distinct !{!243, !244, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hfef7099c19bb28eaE: %self"}
!244 = distinct !{!244, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hfef7099c19bb28eaE"}
!245 = !{!246}
!246 = distinct !{!246, !247, !"_ZN70_$LT$alloc..vec..Vec$LT$T$C$A$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h3b5f2b339ad5e867E: %self"}
!247 = distinct !{!247, !"_ZN70_$LT$alloc..vec..Vec$LT$T$C$A$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h3b5f2b339ad5e867E"}
!248 = !{!249}
!249 = distinct !{!249, !250, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h7a437f5927f79d4bE: %self"}
!250 = distinct !{!250, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h7a437f5927f79d4bE"}
!251 = !{i8 0, i8 3}
!252 = !{i8 0, i8 4}
!253 = !{!254}
!254 = distinct !{!254, !255, !"_ZN70_$LT$std..thread..Packet$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h6c6b5a190964ff04E: %self"}
!255 = distinct !{!255, !"_ZN70_$LT$std..thread..Packet$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h6c6b5a190964ff04E"}
!256 = !{!257}
!257 = distinct !{!257, !258, !"_ZN3std5panic12catch_unwind17h0b857b06566f36cbE: %f"}
!258 = distinct !{!258, !"_ZN3std5panic12catch_unwind17h0b857b06566f36cbE"}
!259 = !{!260}
!260 = distinct !{!260, !261, !"_ZN3std9panicking3try17h56fa823354c94857E: %f"}
!261 = distinct !{!261, !"_ZN3std9panicking3try17h56fa823354c94857E"}
!262 = !{!263}
!263 = distinct !{!263, !264, !"_ZN115_$LT$core..panic..unwind_safe..AssertUnwindSafe$LT$F$GT$$u20$as$u20$core..ops..function..FnOnce$LT$$LP$$RP$$GT$$GT$9call_once17hd6593dcf97725d09E: %self"}
!264 = distinct !{!264, !"_ZN115_$LT$core..panic..unwind_safe..AssertUnwindSafe$LT$F$GT$$u20$as$u20$core..ops..function..FnOnce$LT$$LP$$RP$$GT$$GT$9call_once17hd6593dcf97725d09E"}
!265 = !{!266}
!266 = distinct !{!266, !267, !"_ZN4core3ops8function6FnOnce9call_once17h921a89c5f278f416E: argument 0"}
!267 = distinct !{!267, !"_ZN4core3ops8function6FnOnce9call_once17h921a89c5f278f416E"}
!268 = !{!266, !263, !260, !257, !254}
!269 = !{!270}
!270 = distinct !{!270, !271, !"_ZN4core3fmt9Arguments6new_v117hdcde62b43d9ade08E: argument 0"}
!271 = distinct !{!271, !"_ZN4core3fmt9Arguments6new_v117hdcde62b43d9ade08E"}
!272 = !{!273, !274, !254}
!273 = distinct !{!273, !271, !"_ZN4core3fmt9Arguments6new_v117hdcde62b43d9ade08E: %pieces.0"}
!274 = distinct !{!274, !271, !"_ZN4core3fmt9Arguments6new_v117hdcde62b43d9ade08E: %args.0"}
!275 = !{!276}
!276 = distinct !{!276, !277, !"_ZN4core3fmt9Arguments6new_v117hdcde62b43d9ade08E: argument 0"}
!277 = distinct !{!277, !"_ZN4core3fmt9Arguments6new_v117hdcde62b43d9ade08E"}
!278 = !{!279, !280, !254}
!279 = distinct !{!279, !277, !"_ZN4core3fmt9Arguments6new_v117hdcde62b43d9ade08E: %pieces.0"}
!280 = distinct !{!280, !277, !"_ZN4core3fmt9Arguments6new_v117hdcde62b43d9ade08E: %args.0"}
!281 = !{!282}
!282 = distinct !{!282, !283, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h8b40639afc131966E: %self"}
!283 = distinct !{!283, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h8b40639afc131966E"}
!284 = !{!285}
!285 = distinct !{!285, !286, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h7a437f5927f79d4bE: %self"}
!286 = distinct !{!286, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h7a437f5927f79d4bE"}
!287 = !{!288}
!288 = distinct !{!288, !289, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hfef7099c19bb28eaE: %self"}
!289 = distinct !{!289, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hfef7099c19bb28eaE"}
!290 = !{!291}
!291 = distinct !{!291, !292, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h8df286fb36c045abE: %self"}
!292 = distinct !{!292, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h8df286fb36c045abE"}
!293 = !{!294}
!294 = distinct !{!294, !295, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h8df286fb36c045abE: %self"}
!295 = distinct !{!295, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h8df286fb36c045abE"}
!296 = !{!297}
!297 = distinct !{!297, !298, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hfef7099c19bb28eaE: %self"}
!298 = distinct !{!298, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hfef7099c19bb28eaE"}
!299 = !{!300}
!300 = distinct !{!300, !301, !"_ZN4core3fmt5Write10write_char17h208b4aa1c8599cdeE: %self"}
!301 = distinct !{!301, !"_ZN4core3fmt5Write10write_char17h208b4aa1c8599cdeE"}
!302 = !{!303}
!303 = distinct !{!303, !304, !"_ZN4core4char7methods15encode_utf8_raw17h25b1f82ed72141b2E: %dst.0"}
!304 = distinct !{!304, !"_ZN4core4char7methods15encode_utf8_raw17h25b1f82ed72141b2E"}
!305 = !{!306, !308}
!306 = distinct !{!306, !307, !"_ZN4core3fmt5Write9write_fmt17h62df01c67385dd35E: argument 0"}
!307 = distinct !{!307, !"_ZN4core3fmt5Write9write_fmt17h62df01c67385dd35E"}
!308 = distinct !{!308, !307, !"_ZN4core3fmt5Write9write_fmt17h62df01c67385dd35E: %args"}
!309 = !{!308}
!310 = !{!311}
!311 = distinct !{!311, !312, !"_ZN68_$LT$alloc..sync..Weak$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hc9f7089070b7483aE: %self"}
!312 = distinct !{!312, !"_ZN68_$LT$alloc..sync..Weak$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hc9f7089070b7483aE"}
!313 = !{!314}
!314 = distinct !{!314, !315, !"_ZN68_$LT$alloc..sync..Weak$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hbec430a00b211b3cE: %self"}
!315 = distinct !{!315, !"_ZN68_$LT$alloc..sync..Weak$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hbec430a00b211b3cE"}
!316 = !{!317}
!317 = distinct !{!317, !318, !"_ZN68_$LT$alloc..sync..Weak$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hf3a3e05fa47e1e35E: %self"}
!318 = distinct !{!318, !"_ZN68_$LT$alloc..sync..Weak$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hf3a3e05fa47e1e35E"}
!319 = !{!320}
!320 = distinct !{!320, !321, !"_ZN68_$LT$alloc..sync..Weak$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hdb51d05b68d1716dE: %self"}
!321 = distinct !{!321, !"_ZN68_$LT$alloc..sync..Weak$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hdb51d05b68d1716dE"}
!322 = !{!323}
!323 = distinct !{!323, !324, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h7a437f5927f79d4bE: %self"}
!324 = distinct !{!324, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h7a437f5927f79d4bE"}
!325 = !{!326}
!326 = distinct !{!326, !327, !"_ZN68_$LT$alloc..sync..Weak$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h12fb5670e268c93dE: %self"}
!327 = distinct !{!327, !"_ZN68_$LT$alloc..sync..Weak$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h12fb5670e268c93dE"}
!328 = !{!329}
!329 = distinct !{!329, !330, !"_ZN5redis3cmd3Cmd18get_packed_command17h84862f5b964b506dE: %cmd"}
!330 = distinct !{!330, !"_ZN5redis3cmd3Cmd18get_packed_command17h84862f5b964b506dE"}
!331 = !{!332}
!332 = distinct !{!332, !330, !"_ZN5redis3cmd3Cmd18get_packed_command17h84862f5b964b506dE: %self"}
!333 = !{!334, !336}
!334 = distinct !{!334, !335, !"_ZN3std2io5Write9write_all17h0f16b5bec31fa7c4E: %self"}
!335 = distinct !{!335, !"_ZN3std2io5Write9write_all17h0f16b5bec31fa7c4E"}
!336 = distinct !{!336, !335, !"_ZN3std2io5Write9write_all17h0f16b5bec31fa7c4E: argument 1"}
!337 = !{i8 0, i8 41}
!338 = !{!339, !341, !342, !344}
!339 = distinct !{!339, !340, !"_ZN52_$LT$T$u20$as$u20$alloc..slice..hack..ConvertVec$GT$6to_vec17hd7c48798b4222b77E: %v"}
!340 = distinct !{!340, !"_ZN52_$LT$T$u20$as$u20$alloc..slice..hack..ConvertVec$GT$6to_vec17hd7c48798b4222b77E"}
!341 = distinct !{!341, !340, !"_ZN52_$LT$T$u20$as$u20$alloc..slice..hack..ConvertVec$GT$6to_vec17hd7c48798b4222b77E: %s.0"}
!342 = distinct !{!342, !343, !"_ZN5alloc5slice64_$LT$impl$u20$alloc..borrow..ToOwned$u20$for$u20$$u5b$T$u5d$$GT$8to_owned17h4d6ee453a8c2ee98E: argument 0"}
!343 = distinct !{!343, !"_ZN5alloc5slice64_$LT$impl$u20$alloc..borrow..ToOwned$u20$for$u20$$u5b$T$u5d$$GT$8to_owned17h4d6ee453a8c2ee98E"}
!344 = distinct !{!344, !343, !"_ZN5alloc5slice64_$LT$impl$u20$alloc..borrow..ToOwned$u20$for$u20$$u5b$T$u5d$$GT$8to_owned17h4d6ee453a8c2ee98E: %self.0"}
!345 = !{!346, !348, !349, !351}
!346 = distinct !{!346, !347, !"_ZN52_$LT$T$u20$as$u20$alloc..slice..hack..ConvertVec$GT$6to_vec17hd7c48798b4222b77E: %v"}
!347 = distinct !{!347, !"_ZN52_$LT$T$u20$as$u20$alloc..slice..hack..ConvertVec$GT$6to_vec17hd7c48798b4222b77E"}
!348 = distinct !{!348, !347, !"_ZN52_$LT$T$u20$as$u20$alloc..slice..hack..ConvertVec$GT$6to_vec17hd7c48798b4222b77E: %s.0"}
!349 = distinct !{!349, !350, !"_ZN5alloc5slice64_$LT$impl$u20$alloc..borrow..ToOwned$u20$for$u20$$u5b$T$u5d$$GT$8to_owned17h4d6ee453a8c2ee98E: argument 0"}
!350 = distinct !{!350, !"_ZN5alloc5slice64_$LT$impl$u20$alloc..borrow..ToOwned$u20$for$u20$$u5b$T$u5d$$GT$8to_owned17h4d6ee453a8c2ee98E"}
!351 = distinct !{!351, !350, !"_ZN5alloc5slice64_$LT$impl$u20$alloc..borrow..ToOwned$u20$for$u20$$u5b$T$u5d$$GT$8to_owned17h4d6ee453a8c2ee98E: %self.0"}
!352 = !{!353}
!353 = distinct !{!353, !354, !"_ZN3std6thread5spawn17h04c5769a5d78a193E: argument 0"}
!354 = distinct !{!354, !"_ZN3std6thread5spawn17h04c5769a5d78a193E"}
!355 = !{!353, !356}
!356 = distinct !{!356, !354, !"_ZN3std6thread5spawn17h04c5769a5d78a193E: %f"}
!357 = !{!358}
!358 = distinct !{!358, !359, !"_ZN3std6thread7Builder5spawn17he27ddcbbd4ce5457E: %self"}
!359 = distinct !{!359, !"_ZN3std6thread7Builder5spawn17he27ddcbbd4ce5457E"}
!360 = !{!361, !362, !353, !356}
!361 = distinct !{!361, !359, !"_ZN3std6thread7Builder5spawn17he27ddcbbd4ce5457E: argument 0"}
!362 = distinct !{!362, !359, !"_ZN3std6thread7Builder5spawn17he27ddcbbd4ce5457E: %f"}
!363 = !{!364, !366, !367, !361, !358, !362, !353, !356}
!364 = distinct !{!364, !365, !"_ZN3std6thread7Builder15spawn_unchecked17hf5a1e2503d3727acE: argument 0"}
!365 = distinct !{!365, !"_ZN3std6thread7Builder15spawn_unchecked17hf5a1e2503d3727acE"}
!366 = distinct !{!366, !365, !"_ZN3std6thread7Builder15spawn_unchecked17hf5a1e2503d3727acE: %self"}
!367 = distinct !{!367, !365, !"_ZN3std6thread7Builder15spawn_unchecked17hf5a1e2503d3727acE: %f"}
!368 = !{!369, !371, !372, !364, !366, !367, !361, !358, !362, !353, !356}
!369 = distinct !{!369, !370, !"_ZN3std6thread7Builder16spawn_unchecked_17ha9c3622a6f60d70bE: argument 0"}
!370 = distinct !{!370, !"_ZN3std6thread7Builder16spawn_unchecked_17ha9c3622a6f60d70bE"}
!371 = distinct !{!371, !370, !"_ZN3std6thread7Builder16spawn_unchecked_17ha9c3622a6f60d70bE: %self"}
!372 = distinct !{!372, !370, !"_ZN3std6thread7Builder16spawn_unchecked_17ha9c3622a6f60d70bE: %f"}
!373 = !{!374, !376, !377, !379, !380, !382, !369, !371, !372, !364, !366, !367, !361, !358, !362, !353, !356}
!374 = distinct !{!374, !375, !"_ZN66_$LT$T$u20$as$u20$alloc..ffi..c_str..CString..new..SpecNewImpl$GT$13spec_new_impl17hff919ab1ce447f24E: argument 0"}
!375 = distinct !{!375, !"_ZN66_$LT$T$u20$as$u20$alloc..ffi..c_str..CString..new..SpecNewImpl$GT$13spec_new_impl17hff919ab1ce447f24E"}
!376 = distinct !{!376, !375, !"_ZN66_$LT$T$u20$as$u20$alloc..ffi..c_str..CString..new..SpecNewImpl$GT$13spec_new_impl17hff919ab1ce447f24E: %self"}
!377 = distinct !{!377, !378, !"_ZN5alloc3ffi5c_str7CString3new17ha764feb96f012dc7E: argument 0"}
!378 = distinct !{!378, !"_ZN5alloc3ffi5c_str7CString3new17ha764feb96f012dc7E"}
!379 = distinct !{!379, !378, !"_ZN5alloc3ffi5c_str7CString3new17ha764feb96f012dc7E: %t"}
!380 = distinct !{!380, !381, !"_ZN3std6thread7Builder16spawn_unchecked_28_$u7b$$u7b$closure$u7d$$u7d$17h8c6e246506240f52E: %name"}
!381 = distinct !{!381, !"_ZN3std6thread7Builder16spawn_unchecked_28_$u7b$$u7b$closure$u7d$$u7d$17h8c6e246506240f52E"}
!382 = distinct !{!382, !383, !"_ZN4core6option15Option$LT$T$GT$3map17h59116f81376cbe60E: %self"}
!383 = distinct !{!383, !"_ZN4core6option15Option$LT$T$GT$3map17h59116f81376cbe60E"}
!384 = !{!385, !387, !374, !376, !377, !379, !380, !382, !369, !371, !372, !364, !366, !367, !361, !358, !362, !353, !356}
!385 = distinct !{!385, !386, !"_ZN50_$LT$T$u20$as$u20$core..convert..Into$LT$U$GT$$GT$4into17h4b731270a3d2acbbE: argument 0"}
!386 = distinct !{!386, !"_ZN50_$LT$T$u20$as$u20$core..convert..Into$LT$U$GT$$GT$4into17h4b731270a3d2acbbE"}
!387 = distinct !{!387, !386, !"_ZN50_$LT$T$u20$as$u20$core..convert..Into$LT$U$GT$$GT$4into17h4b731270a3d2acbbE: %self"}
!388 = !{!389, !391}
!389 = distinct !{!389, !390, !"_ZN4core5slice6memchr12memchr_naive17h2f9ffde40830c78eE: %text.0"}
!390 = distinct !{!390, !"_ZN4core5slice6memchr12memchr_naive17h2f9ffde40830c78eE"}
!391 = distinct !{!391, !392, !"_ZN4core5slice6memchr6memchr17h4c31ce434bc182ddE: %text.0"}
!392 = distinct !{!392, !"_ZN4core5slice6memchr6memchr17h4c31ce434bc182ddE"}
!393 = !{!376, !379, !380, !382, !369, !371, !372, !364, !366, !367, !361, !358, !362, !353, !356}
!394 = !{!395, !380, !382, !369, !371, !372, !364, !366, !367, !361, !358, !362, !353, !356}
!395 = distinct !{!395, !396, !"_ZN4core6result19Result$LT$T$C$E$GT$6expect17hd076961bea2b5accE: %self"}
!396 = distinct !{!396, !"_ZN4core6result19Result$LT$T$C$E$GT$6expect17hd076961bea2b5accE"}
!397 = !{!380, !382, !369, !371, !372, !364, !366, !367, !361, !358, !362, !353, !356}
!398 = !{!399, !369, !371, !372, !364, !366, !367, !361, !358, !362, !353, !356}
!399 = distinct !{!399, !400, !"_ZN5alloc4sync12Arc$LT$T$GT$3new17h403bbdc0ef29a94aE: %data"}
!400 = distinct !{!400, !"_ZN5alloc4sync12Arc$LT$T$GT$3new17h403bbdc0ef29a94aE"}
!401 = !{!402, !369, !371, !372, !364, !366, !367, !361, !358, !362, !353, !356}
!402 = distinct !{!402, !403, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hc9ec8e7e55201a76E: %self"}
!403 = distinct !{!403, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hc9ec8e7e55201a76E"}
!404 = !{!369, !371, !364, !366, !367, !361, !358, !362, !353, !356}
!405 = !{!406}
!406 = distinct !{!406, !407, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hfef7099c19bb28eaE: %self"}
!407 = distinct !{!407, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hfef7099c19bb28eaE"}
!408 = !{!406, !369, !371, !372, !364, !366, !367, !361, !358, !362, !353, !356}
!409 = !{!410}
!410 = distinct !{!410, !411, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h7a437f5927f79d4bE: %self"}
!411 = distinct !{!411, !"_ZN67_$LT$alloc..sync..Arc$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h7a437f5927f79d4bE"}
!412 = !{!410, !369, !371, !372, !364, !366, !367, !361, !358, !362, !353, !356}
!413 = !{!414, !416, !353, !356}
!414 = distinct !{!414, !415, !"_ZN4core6result19Result$LT$T$C$E$GT$6expect17haffcd31c9d170b0aE: %t"}
!415 = distinct !{!415, !"_ZN4core6result19Result$LT$T$C$E$GT$6expect17haffcd31c9d170b0aE"}
!416 = distinct !{!416, !415, !"_ZN4core6result19Result$LT$T$C$E$GT$6expect17haffcd31c9d170b0aE: %self"}
!417 = !{!414}
!418 = !{!416}
!419 = !{!414, !416, !353}
!420 = !{!356}
!421 = !{!422, !424}
!422 = distinct !{!422, !423, !"_ZN5redis6client6Client4open17hbffc71bef666f1c6E: argument 0"}
!423 = distinct !{!423, !"_ZN5redis6client6Client4open17hbffc71bef666f1c6E"}
!424 = distinct !{!424, !423, !"_ZN5redis6client6Client4open17hbffc71bef666f1c6E: %params.0"}
!425 = !{!422}
!426 = !{!427}
!427 = distinct !{!427, !428, !"_ZN79_$LT$core..result..Result$LT$T$C$E$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17h6587e287ec085af1E: argument 0"}
!428 = distinct !{!428, !"_ZN79_$LT$core..result..Result$LT$T$C$E$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17h6587e287ec085af1E"}
!429 = !{!430}
!430 = distinct !{!430, !428, !"_ZN79_$LT$core..result..Result$LT$T$C$E$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17h6587e287ec085af1E: %self"}
!431 = !{!427, !422, !424}
!432 = !{!427, !430}
!433 = !{!424}
!434 = !{!435, !437, !438}
!435 = distinct !{!435, !436, !"_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17he89861419ab92940E: %t"}
!436 = distinct !{!436, !"_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17he89861419ab92940E"}
!437 = distinct !{!437, !436, !"_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17he89861419ab92940E: %self"}
!438 = distinct !{!438, !436, !"_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17he89861419ab92940E: argument 2"}
!439 = !{!435, !438}
!440 = !{!435, !437}
!441 = !{!435}
!442 = !{!437}
!443 = !{!438}
!444 = !{!445}
!445 = distinct !{!445, !446, !"_ZN5alloc4sync12Arc$LT$T$GT$3new17hfb073776e0193294E: %data"}
!446 = distinct !{!446, !"_ZN5alloc4sync12Arc$LT$T$GT$3new17hfb073776e0193294E"}
!447 = !{!448, !450}
!448 = distinct !{!448, !449, !"_ZN5redis6client6Client4open17hbffc71bef666f1c6E: argument 0"}
!449 = distinct !{!449, !"_ZN5redis6client6Client4open17hbffc71bef666f1c6E"}
!450 = distinct !{!450, !449, !"_ZN5redis6client6Client4open17hbffc71bef666f1c6E: %params.0"}
!451 = !{!452}
!452 = distinct !{!452, !453, !"_ZN79_$LT$core..result..Result$LT$T$C$E$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17h6587e287ec085af1E: argument 0"}
!453 = distinct !{!453, !"_ZN79_$LT$core..result..Result$LT$T$C$E$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17h6587e287ec085af1E"}
!454 = !{!455}
!455 = distinct !{!455, !453, !"_ZN79_$LT$core..result..Result$LT$T$C$E$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17h6587e287ec085af1E: %self"}
!456 = !{!452, !448, !450}
!457 = !{!452, !455}
!458 = !{!450}
!459 = !{!460, !462, !463}
!460 = distinct !{!460, !461, !"_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17he89861419ab92940E: %t"}
!461 = distinct !{!461, !"_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17he89861419ab92940E"}
!462 = distinct !{!462, !461, !"_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17he89861419ab92940E: %self"}
!463 = distinct !{!463, !461, !"_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17he89861419ab92940E: argument 2"}
!464 = !{!460, !463}
!465 = !{!460, !462}
!466 = !{!460}
!467 = !{!462}
!468 = !{!463}
!469 = !{!470}
!470 = distinct !{!470, !471, !"_ZN5alloc4sync12Arc$LT$T$GT$3new17hfb073776e0193294E: %data"}
!471 = distinct !{!471, !"_ZN5alloc4sync12Arc$LT$T$GT$3new17hfb073776e0193294E"}
!472 = !{!473, !475}
!473 = distinct !{!473, !474, !"_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17h7163facaafc2a113E: argument 0"}
!474 = distinct !{!474, !"_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17h7163facaafc2a113E"}
!475 = distinct !{!475, !474, !"_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17h7163facaafc2a113E: argument 1"}
!476 = !{!477, !479}
!477 = distinct !{!477, !478, !"_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17h7163facaafc2a113E: argument 0"}
!478 = distinct !{!478, !"_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17h7163facaafc2a113E"}
!479 = distinct !{!479, !478, !"_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17h7163facaafc2a113E: argument 1"}
