
; COMPILING:
;   nasm -f win64 hello.asm
;   link /subsystem:console /entry:WinMain hello.asm

global WinMain
extern GetStdHandle
extern WriteConsoleA

section .data
    hello db "hello world", 0xa
    helloLen equ $-hello
    bytesWritten dq 0

section .text
WinMain:
    ; reserve stack space (windows x64 calling convention)
    sub rsp, 40

    ; Get the handle to the standard output
    mov rcx, -11             ; STD_OUTPUT_HANDLE
    call GetStdHandle

    ; write the string to the console
    mov rcx, rax             ; handle
    mov rdx, hello           ; buffer
    mov r8, helloLen         
    mov r9, bytesWritten     
    push 0                   ; reserved parameter
    sub rsp, 32              ; shadow space
    call WriteConsoleA
    add rsp, 40              ; restore stack

    ; exit the program
    xor rax, rax             ; return 0
    add rsp, 40
    ret