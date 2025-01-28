#include <windows.h>
#include <stdio.h>

int main()
{
    HMODULE Kernel32Addr;          
    unsigned long ExitProcessAddr; 
    unsigned long OpenProcessAddr; 
    unsigned long TerminateProcessAddr; 

    Kernel32Addr = GetModuleHandleW(L"kernel32.dll");
    printf("KERNEL32 address in memory: 0x%08p\n", Kernel32Addr);

    OpenProcessAddr = (UINT_PTR)GetProcAddress(Kernel32Addr, "OpenProcess");
    printf("OpenProcess address in memory is: 0x%08p\n", OpenProcessAddr);

    TerminateProcessAddr = (UINT_PTR)GetProcAddress(Kernel32Addr, "TerminateProcess");
    printf("TerminateProcess address in memory is: 0x%08p\n", TerminateProcessAddr);

    ExitProcessAddr = (UINT_PTR)GetProcAddress(Kernel32Addr, "ExitProcess");
    printf("ExitProcess address in memory is: 0x%08p\n", ExitProcessAddr);

    getchar();
    return 0;
}