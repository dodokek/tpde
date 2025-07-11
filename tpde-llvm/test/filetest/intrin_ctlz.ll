; NOTE: Assertions have been autogenerated by test/update_tpde_llc_test_checks.py UTC_ARGS: --version 5
; SPDX-FileCopyrightText: 2025 Contributors to TPDE <https://tpde.org>
;
; SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

; RUN: tpde-llc --target=x86_64 %s | %objdump | FileCheck %s -check-prefixes=X64
; RUN: tpde-llc --target=aarch64 %s | %objdump | FileCheck %s -check-prefixes=ARM64
; XFAIL: llvm19.1

declare i8   @llvm.ctlz.i8  (i8, i1)
declare i16   @llvm.ctlz.i16  (i16, i1)
declare i32   @llvm.ctlz.i32  (i32, i1)
declare i64   @llvm.ctlz.i64  (i64, i1)

; COM: I trust clang to be able to do the subtraction correctly
; COM: though it does not compile the template to a call to llvm.ctlz.i8 :(
define void @ctlz_i8(i8 %0) {
; X64-LABEL: <ctlz_i8>:
; X64:         push rbp
; X64-NEXT:    mov rbp, rsp
; X64-NEXT:    nop word ptr [rax + rax]
; X64-NEXT:    sub rsp, 0x30
; X64-NEXT:    movzx edi, dil
; X64-NEXT:    bsr eax, edi
; X64-NEXT:    xor eax, 0x1f
; X64-NEXT:    add eax, -0x18
; X64-NEXT:    test dil, dil
; X64-NEXT:    mov edi, 0x8
; X64-NEXT:    cmovne edi, eax
; X64-NEXT:    add rsp, 0x30
; X64-NEXT:    pop rbp
; X64-NEXT:    ret
;
; ARM64-LABEL: <ctlz_i8>:
; ARM64:         sub sp, sp, #0xa0
; ARM64-NEXT:    stp x29, x30, [sp]
; ARM64-NEXT:    mov x29, sp
; ARM64-NEXT:    nop
; ARM64-NEXT:    ands w1, w0, #0xff
; ARM64-NEXT:    mov w2, #0x8 // =8
; ARM64-NEXT:    clz w1, w1
; ARM64-NEXT:    tst w0, #0xff
; ARM64-NEXT:    sub w1, w1, #0x18
; ARM64-NEXT:    csel w0, w2, w1, eq
; ARM64-NEXT:    ldp x29, x30, [sp]
; ARM64-NEXT:    add sp, sp, #0xa0
; ARM64-NEXT:    ret
  entry:
    %1 = call i8 @llvm.ctlz.i8(i8 %0, i1 0)
    ret void
}

define void @ctlz_i8_zero_poison(i8 %0) {
; X64-LABEL: <ctlz_i8_zero_poison>:
; X64:         push rbp
; X64-NEXT:    mov rbp, rsp
; X64-NEXT:    nop word ptr [rax + rax]
; X64-NEXT:    sub rsp, 0x30
; X64-NEXT:    movzx edi, dil
; X64-NEXT:    bsr edi, edi
; X64-NEXT:    xor edi, 0x1f
; X64-NEXT:    add edi, -0x18
; X64-NEXT:    add rsp, 0x30
; X64-NEXT:    pop rbp
; X64-NEXT:    ret
;
; ARM64-LABEL: <ctlz_i8_zero_poison>:
; ARM64:         sub sp, sp, #0xa0
; ARM64-NEXT:    stp x29, x30, [sp]
; ARM64-NEXT:    mov x29, sp
; ARM64-NEXT:    nop
; ARM64-NEXT:    and w0, w0, #0xff
; ARM64-NEXT:    clz w0, w0
; ARM64-NEXT:    sub w1, w0, #0x18
; ARM64-NEXT:    ldp x29, x30, [sp]
; ARM64-NEXT:    add sp, sp, #0xa0
; ARM64-NEXT:    ret
  entry:
    %1 = call i8 @llvm.ctlz.i8(i8 %0, i1 1)
    ret void
}

define void @ctlz_i16(i16 %0) {
; X64-LABEL: <ctlz_i16>:
; X64:         push rbp
; X64-NEXT:    mov rbp, rsp
; X64-NEXT:    nop word ptr [rax + rax]
; X64-NEXT:    sub rsp, 0x30
; X64-NEXT:    movzx edi, di
; X64-NEXT:    bsr eax, edi
; X64-NEXT:    xor eax, 0x1f
; X64-NEXT:    add eax, -0x10
; X64-NEXT:    test di, di
; X64-NEXT:    mov edi, 0x10
; X64-NEXT:    cmovne edi, eax
; X64-NEXT:    add rsp, 0x30
; X64-NEXT:    pop rbp
; X64-NEXT:    ret
;
; ARM64-LABEL: <ctlz_i16>:
; ARM64:         sub sp, sp, #0xa0
; ARM64-NEXT:    stp x29, x30, [sp]
; ARM64-NEXT:    mov x29, sp
; ARM64-NEXT:    nop
; ARM64-NEXT:    ands w1, w0, #0xffff
; ARM64-NEXT:    mov w2, #0x10 // =16
; ARM64-NEXT:    clz w1, w1
; ARM64-NEXT:    tst w0, #0xffff
; ARM64-NEXT:    sub w1, w1, #0x10
; ARM64-NEXT:    csel w0, w2, w1, eq
; ARM64-NEXT:    ldp x29, x30, [sp]
; ARM64-NEXT:    add sp, sp, #0xa0
; ARM64-NEXT:    ret
  entry:
    %1 = call i16 @llvm.ctlz.i16(i16 %0, i1 0)
    ret void
}

define void @ctlz_i16_zero_poison(i16 %0) {
; X64-LABEL: <ctlz_i16_zero_poison>:
; X64:         push rbp
; X64-NEXT:    mov rbp, rsp
; X64-NEXT:    nop word ptr [rax + rax]
; X64-NEXT:    sub rsp, 0x30
; X64-NEXT:    movzx edi, di
; X64-NEXT:    bsr edi, edi
; X64-NEXT:    xor edi, 0x1f
; X64-NEXT:    add edi, -0x10
; X64-NEXT:    add rsp, 0x30
; X64-NEXT:    pop rbp
; X64-NEXT:    ret
;
; ARM64-LABEL: <ctlz_i16_zero_poison>:
; ARM64:         sub sp, sp, #0xa0
; ARM64-NEXT:    stp x29, x30, [sp]
; ARM64-NEXT:    mov x29, sp
; ARM64-NEXT:    nop
; ARM64-NEXT:    and w0, w0, #0xffff
; ARM64-NEXT:    clz w0, w0
; ARM64-NEXT:    sub w1, w0, #0x10
; ARM64-NEXT:    ldp x29, x30, [sp]
; ARM64-NEXT:    add sp, sp, #0xa0
; ARM64-NEXT:    ret
  entry:
    %1 = call i16 @llvm.ctlz.i16(i16 %0, i1 1)
    ret void
}

define void @ctlz_i32(i32 %0) {
; X64-LABEL: <ctlz_i32>:
; X64:         push rbp
; X64-NEXT:    mov rbp, rsp
; X64-NEXT:    nop word ptr [rax + rax]
; X64-NEXT:    sub rsp, 0x30
; X64-NEXT:    mov eax, 0x3f
; X64-NEXT:    bsr eax, edi
; X64-NEXT:    xor eax, 0x1f
; X64-NEXT:    add rsp, 0x30
; X64-NEXT:    pop rbp
; X64-NEXT:    ret
;
; ARM64-LABEL: <ctlz_i32>:
; ARM64:         sub sp, sp, #0xa0
; ARM64-NEXT:    stp x29, x30, [sp]
; ARM64-NEXT:    mov x29, sp
; ARM64-NEXT:    nop
; ARM64-NEXT:    clz w0, w0
; ARM64-NEXT:    ldp x29, x30, [sp]
; ARM64-NEXT:    add sp, sp, #0xa0
; ARM64-NEXT:    ret
  entry:
    %1 = call i32 @llvm.ctlz.i32(i32 %0, i1 0)
    ret void
}

define void @ctlz_i32_zero_poison(i32 %0) {
; X64-LABEL: <ctlz_i32_zero_poison>:
; X64:         push rbp
; X64-NEXT:    mov rbp, rsp
; X64-NEXT:    nop word ptr [rax + rax]
; X64-NEXT:    sub rsp, 0x30
; X64-NEXT:    bsr edi, edi
; X64-NEXT:    xor edi, 0x1f
; X64-NEXT:    add rsp, 0x30
; X64-NEXT:    pop rbp
; X64-NEXT:    ret
;
; ARM64-LABEL: <ctlz_i32_zero_poison>:
; ARM64:         sub sp, sp, #0xa0
; ARM64-NEXT:    stp x29, x30, [sp]
; ARM64-NEXT:    mov x29, sp
; ARM64-NEXT:    nop
; ARM64-NEXT:    clz w0, w0
; ARM64-NEXT:    ldp x29, x30, [sp]
; ARM64-NEXT:    add sp, sp, #0xa0
; ARM64-NEXT:    ret
  entry:
    %1 = call i32 @llvm.ctlz.i32(i32 %0, i1 1)
    ret void
}

define void @ctlz_i64(i64 %0) {
; X64-LABEL: <ctlz_i64>:
; X64:         push rbp
; X64-NEXT:    mov rbp, rsp
; X64-NEXT:    nop word ptr [rax + rax]
; X64-NEXT:    sub rsp, 0x30
; X64-NEXT:    mov eax, 0x7f
; X64-NEXT:    bsr rax, rdi
; X64-NEXT:    xor rax, 0x3f
; X64-NEXT:    add rsp, 0x30
; X64-NEXT:    pop rbp
; X64-NEXT:    ret
;
; ARM64-LABEL: <ctlz_i64>:
; ARM64:         sub sp, sp, #0xa0
; ARM64-NEXT:    stp x29, x30, [sp]
; ARM64-NEXT:    mov x29, sp
; ARM64-NEXT:    nop
; ARM64-NEXT:    clz x0, x0
; ARM64-NEXT:    ldp x29, x30, [sp]
; ARM64-NEXT:    add sp, sp, #0xa0
; ARM64-NEXT:    ret
  entry:
    %1 = call i64 @llvm.ctlz.i64(i64 %0, i1 0)
    ret void
}

define void @ctlz_i64_zero_poison(i64 %0) {
; X64-LABEL: <ctlz_i64_zero_poison>:
; X64:         push rbp
; X64-NEXT:    mov rbp, rsp
; X64-NEXT:    nop word ptr [rax + rax]
; X64-NEXT:    sub rsp, 0x30
; X64-NEXT:    bsr rdi, rdi
; X64-NEXT:    xor rdi, 0x3f
; X64-NEXT:    add rsp, 0x30
; X64-NEXT:    pop rbp
; X64-NEXT:    ret
;
; ARM64-LABEL: <ctlz_i64_zero_poison>:
; ARM64:         sub sp, sp, #0xa0
; ARM64-NEXT:    stp x29, x30, [sp]
; ARM64-NEXT:    mov x29, sp
; ARM64-NEXT:    nop
; ARM64-NEXT:    clz x0, x0
; ARM64-NEXT:    ldp x29, x30, [sp]
; ARM64-NEXT:    add sp, sp, #0xa0
; ARM64-NEXT:    ret
  entry:
    %1 = call i64 @llvm.ctlz.i64(i64 %0, i1 1)
    ret void
}

define void @ctlz_i32_no_salvage(i32 %0) {
; X64-LABEL: <ctlz_i32_no_salvage>:
; X64:         push rbp
; X64-NEXT:    mov rbp, rsp
; X64-NEXT:    nop word ptr [rax + rax]
; X64-NEXT:    sub rsp, 0x30
; X64-NEXT:    mov eax, 0x3f
; X64-NEXT:    bsr eax, edi
; X64-NEXT:    xor eax, 0x1f
; X64-NEXT:    mov eax, 0x3f
; X64-NEXT:    bsr eax, edi
; X64-NEXT:    xor eax, 0x1f
; X64-NEXT:    add rsp, 0x30
; X64-NEXT:    pop rbp
; X64-NEXT:    ret
;
; ARM64-LABEL: <ctlz_i32_no_salvage>:
; ARM64:         sub sp, sp, #0xa0
; ARM64-NEXT:    stp x29, x30, [sp]
; ARM64-NEXT:    mov x29, sp
; ARM64-NEXT:    nop
; ARM64-NEXT:    clz w1, w0
; ARM64-NEXT:    clz w0, w0
; ARM64-NEXT:    ldp x29, x30, [sp]
; ARM64-NEXT:    add sp, sp, #0xa0
; ARM64-NEXT:    ret
  entry:
    %1 = call i32 @llvm.ctlz.i32(i32 %0, i1 0)
    %2 = call i32 @llvm.ctlz.i32(i32 %0, i1 0)
    ret void
}

define void @ctlz_i64_no_salvage(i64 %0) {
; X64-LABEL: <ctlz_i64_no_salvage>:
; X64:         push rbp
; X64-NEXT:    mov rbp, rsp
; X64-NEXT:    nop word ptr [rax + rax]
; X64-NEXT:    sub rsp, 0x30
; X64-NEXT:    mov eax, 0x7f
; X64-NEXT:    bsr rax, rdi
; X64-NEXT:    xor rax, 0x3f
; X64-NEXT:    mov eax, 0x7f
; X64-NEXT:    bsr rax, rdi
; X64-NEXT:    xor rax, 0x3f
; X64-NEXT:    add rsp, 0x30
; X64-NEXT:    pop rbp
; X64-NEXT:    ret
;
; ARM64-LABEL: <ctlz_i64_no_salvage>:
; ARM64:         sub sp, sp, #0xa0
; ARM64-NEXT:    stp x29, x30, [sp]
; ARM64-NEXT:    mov x29, sp
; ARM64-NEXT:    nop
; ARM64-NEXT:    clz x1, x0
; ARM64-NEXT:    clz x0, x0
; ARM64-NEXT:    ldp x29, x30, [sp]
; ARM64-NEXT:    add sp, sp, #0xa0
; ARM64-NEXT:    ret
  entry:
    %1 = call i64 @llvm.ctlz.i64(i64 %0, i1 0)
    %2 = call i64 @llvm.ctlz.i64(i64 %0, i1 0)
    ret void
}

define void @ctlz_i16_no_salvage(i16 %0) {
; X64-LABEL: <ctlz_i16_no_salvage>:
; X64:         push rbp
; X64-NEXT:    mov rbp, rsp
; X64-NEXT:    nop word ptr [rax + rax]
; X64-NEXT:    sub rsp, 0x30
; X64-NEXT:    movzx eax, di
; X64-NEXT:    bsr ecx, eax
; X64-NEXT:    xor ecx, 0x1f
; X64-NEXT:    add ecx, -0x10
; X64-NEXT:    test ax, ax
; X64-NEXT:    mov eax, 0x10
; X64-NEXT:    cmovne eax, ecx
; X64-NEXT:    movzx edi, di
; X64-NEXT:    bsr eax, edi
; X64-NEXT:    xor eax, 0x1f
; X64-NEXT:    add eax, -0x10
; X64-NEXT:    test di, di
; X64-NEXT:    mov edi, 0x10
; X64-NEXT:    cmovne edi, eax
; X64-NEXT:    add rsp, 0x30
; X64-NEXT:    pop rbp
; X64-NEXT:    ret
;
; ARM64-LABEL: <ctlz_i16_no_salvage>:
; ARM64:         sub sp, sp, #0xa0
; ARM64-NEXT:    stp x29, x30, [sp]
; ARM64-NEXT:    mov x29, sp
; ARM64-NEXT:    nop
; ARM64-NEXT:    ands w1, w0, #0xffff
; ARM64-NEXT:    mov w2, #0x10 // =16
; ARM64-NEXT:    clz w1, w1
; ARM64-NEXT:    tst w0, #0xffff
; ARM64-NEXT:    sub w1, w1, #0x10
; ARM64-NEXT:    csel w3, w2, w1, eq
; ARM64-NEXT:    ands w1, w0, #0xffff
; ARM64-NEXT:    mov w2, #0x10 // =16
; ARM64-NEXT:    clz w1, w1
; ARM64-NEXT:    tst w0, #0xffff
; ARM64-NEXT:    sub w1, w1, #0x10
; ARM64-NEXT:    csel w0, w2, w1, eq
; ARM64-NEXT:    ldp x29, x30, [sp]
; ARM64-NEXT:    add sp, sp, #0xa0
; ARM64-NEXT:    ret
  entry:
    %1 = call i16 @llvm.ctlz.i16(i16 %0, i1 0)
    %2 = call i16 @llvm.ctlz.i16(i16 %0, i1 0)
    ret void
}
