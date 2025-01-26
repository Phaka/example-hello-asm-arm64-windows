; ARM64 assembly for Windows
; Windows requires us to use the Windows API rather than direct system calls
        
extern GetStdHandle
extern WriteConsoleA
extern ExitProcess

section .data
    message db "Hello, World!", 13, 10
    message_len equ $ - message
    written dd 0

section .text
global main

main:
    ; Save registers according to Windows ARM64 ABI
    stp x29, x30, [sp, #-16]!
    mov x29, sp

    ; Get stdout handle
    mov x0, -11                 ; STD_OUTPUT_HANDLE = -11
    bl GetStdHandle
    mov x19, x0                 ; Save handle for later

    ; Write to console
    mov x0, x19                 ; Console handle
    adr x1, message            ; Message buffer
    mov x2, message_len        ; Message length
    adr x3, written           ; Bytes written
    mov x4, 0                  ; Reserved parameter (must be 0)
    bl WriteConsoleA

    ; Exit program
    mov x0, 0                  ; Exit code 0
    bl ExitProcess

    ; We won't reach here, but for completeness
    ldp x29, x30, [sp], #16
    ret
