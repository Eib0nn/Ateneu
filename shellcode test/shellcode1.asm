
; shellcode to open calc.exe

; COMPILING:

;   nasm -f elf32 -o shellcode1.o shellcode1.asm
;   ld -m elf_i386 -o shellcode1 shellcode1.o
;   from cocomelon shellcode tutorial

global WinMain

section .data

section .bss

section .text

WinMain:

    xor ecx, ecx
    push ecx
    push 0x6578652e
    push 0x636c6163

    mov eax, esp

    inc ecx
    push ecx
    push eax
    mov ebx, 0xef708820
    call ebx

    xor eax, eax
    push eax
    mov eax, 0xef6be3e0
    jmp eax



