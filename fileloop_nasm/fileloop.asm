section .data
    lpFN db "test%d.txt", 0
    buff db 20 dup(0)
    xint dd 5

section .txt
    global WinMain
    extern CreateFileA
    extern GetLastError
    extern CloseHandle
    extern wsprintfA

WinMain:
    sub rsp, 40
    lea rcx, [buffer]
    lea rdx, [lpFN]
    mov r8d, dword [xint]
    call wsprintfA

