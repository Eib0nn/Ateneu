section .text
global WinMain

WinMain:
    push ebp
    mov ebp, esp

    ; access the PID from the stack
    ; on x86, the first argument (exec_mem) is at [ebp + 8]
    ; the second argument (PID) is at [ebp + 12]
    mov ecx, [ebp + 12]  ; move PID into ECX (as expected by the shellcode)

    ; access the shellcode address (exec_mem) from the stack
    mov eax, [ebp + 8]   ; move exec_mem into EAX

    ; jump to the shellcode
    jmp eax
    mov esp, ebp
    pop ebp
    ret