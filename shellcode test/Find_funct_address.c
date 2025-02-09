/*
getaddr.c - get addresses of functions
(ExitProcess, WinExec) in memory
*/
#include <windows.h>
#include <stdio.h>

int main()
{
    HMODULE Kernel32Addr;    // kernel32.dll address
    unsigned long ExitProcessAddr; // ExitProcess address
    unsigned long WinExecAddr;     // WinExec address

    Kernel32Addr = GetModuleHandleW(L"kernel32.dll");
    printf("KERNEL32 address in memory: 0x%08p\n", Kernel32Addr);

    ExitProcessAddr = (UINT_PTR)GetProcAddress(Kernel32Addr, "ExitProcess");
    printf("ExitProcess address in memory is: 0x%08p\n", ExitProcessAddr);

    WinExecAddr =(UINT_PTR)GetProcAddress(Kernel32Addr, "WinExec");
    printf("WinExec address in memory is: 0x%08p\n", WinExecAddr);

    getchar();
    return 0;
}