
; COMPILING:
;   nasm -f win64 fileloop.asm
;   link /subsystem:console /entry:WinMain createfile.obj kernel32.lib user32.lib

;   i really needed to do black magic to make this shit work, lol


section .data
    lpFN db "test%d.txt", 0        ; format string for wsprintfA
    buffer db 20 dup(0)            ; buffer for formatted filenames

section .text
    global WinMain
    extern CreateFileA, GetLastError, ExitProcess, wsprintfA

WinMain:
    ; align stack and preserve non-volatile registers
    and rsp, -16                   ; align stack to 16 bytes
    push rbx                       ; save rbx (non-volatile)

    mov ebx, 1                     ; loop counter starts at 1 (test1.txt to test5.txt)

.loop_start:
    cmp ebx, 5                     ; check if counter exceeds 5
    jg .exit                       ; exit loop if > 5

    ; clear buffer
    mov rdi, buffer
    mov ecx, 20
    xor eax, eax
    rep stosb

    ; prepare and call wsprintfA
    lea rcx, [rel buffer]          ; destination buffer
    lea rdx, [rel lpFN]            ; format string
    mov r8d, ebx                   ; current counter value
    call wsprintfA

    ; prepare CreateFileA parameters
    sub rsp, 32                    ; allocate shadow space
    lea rcx, [rel buffer]          ; lpFileName
    mov edx, 0x40000000            ; GENERIC_WRITE
    xor r8, r8                     ; dwShareMode = 0
    xor r9, r9                     ; lpSecurityAttributes = NULL
    mov qword [rsp+0x20], 2        ; CREATE_ALWAYS
    mov qword [rsp+0x28], 0x80     ; FILE_ATTRIBUTE_NORMAL
    mov qword [rsp+0x30], 0        ; hTemplateFile = NULL
    call CreateFileA
    add rsp, 32                    ; cleanup shadow space

    cmp rax, -1
    je .error                      ; handle error

    inc ebx                        ; increment counter for next file
    jmp .loop_start

.exit:
    pop rbx                        ; restore rbx before exiting
    xor ecx, ecx
    call ExitProcess

.error:
    call GetLastError
    pop rbx                        ; ensure rbx is restored
    jmp .exit