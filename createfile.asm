
; COMPILING:
;   nasm -f win64 createfile.asm
;   link /subsystem:console /entry:WinMain createfile.obj kernel32.lib user32.lib


global WinMain
extern CreateFileA
extern GetLastError

section .data
    filename db "C:\Users\thierry\Desktop\hardc\test21.txt", 0

section .text
WinMain:
    sub rsp, 56                 ; align the stack and allocate space

    mov rcx, filename           ; lpFileName
    mov rdx, 0x40000000         ; dwDesiredAccess (GENERIC_WRITE)
    xor r8d, r8d                ; dwShareMode (0)
    xor r9, r9                  ; lpSecurityAttributes (NULL)
    mov qword [rsp+48], 0       ; hTemplateFile = NULL
    mov dword [rsp+40], 0x80    ; dwFlagsAndAttributes = FILE_ATTRIBUTE_NORMAL
    mov dword [rsp+32], 2       ; dwCreationDisposition = CREATE_ALWAYS

    call CreateFileA            
    test rax, rax               ; check if rax= -1 (failure)
    js .error                   ; jump to error handling if failed

.success:
    ; hndle success (RAX contains the file handle)
    jmp .exit

.error:
    call GetLastError          
    ; rax now contains the error code

.exit:
    add rsp, 56                 
    xor rax, rax
    ret
