section .data
    PID db 0

section .text
global _start

_start:
    mov PID, ecx