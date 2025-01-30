
; COMPILING:
;   nasm -f win64 createfile.asm
;   link /subsystem:console /entry:WinMain createfile.obj kernel32.lib user32.lib

global WinMain
extern OpenProcess
extern TerminateProcess
extern GetLastError

section .data
    PID dq 12652 ;  hardcoding PID because i dont want to make the whole input thing, lol

section .text
WinMain:
    sub rsp, 40

    mov rcx, 0x0001
    xor rdx, rdx
    mov r8d, dword [rel PID]
    call OpenProcess
    test rax, rax
    js .error

    xor rcx, rcx

    mov rcx, rax
    xor rdx, rdx
    call TerminateProcess
    test rax, rax
    js .error

.success
    jmp .exit

.error
    call GetLastError

.exit 
    add rsp, 40
    xor rax, rax
    ret
