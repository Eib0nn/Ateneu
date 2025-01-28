#include <windows.h>
#include <stdio.h>

extern void WinMain(void *shellcode, DWORD PID);

int main()
{
    unsigned char shellcode[] = {
        // shitty
    };

    DWORD PID = 1234; 

    void *exec_mem = VirtualAlloc(0, 4096, MEM_COMMIT | MEM_RESERVE, PAGE_EXECUTE_READWRITE);
    if (exec_mem == NULL)
    {
        printf("Failed to allocate memory\n");
        return 1;
    }

    memcpy(exec_mem, shellcode, sizeof(shellcode));
    WinMain(exec_mem, PID);

    return 0;
}