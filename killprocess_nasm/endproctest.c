
//  Using to compare with the assembly-part, it actually helps a lot

#include <windows.h>
#include <stdio.h>

int main(int argc, char *argv[])
{
    DWORD dwDA = PROCESS_TERMINATE;
    DWORD PID;
    HANDLE hProcess = NULL;
    BOOL kTask;

    if (argc < 2)
    {
        printf("Usage: endproc.exe <PID> ");
        return 0;
    }

    PID = atoi(argv[1]);

    hProcess = OpenProcess(dwDA, 0, PID);
    if (hProcess == NULL)
    {
        printf("Error when opening process: %d", GetLastError());
        return 0;
    }
    kTask = TerminateProcess(hProcess, 0);
    if (kTask == 0)
    {
        printf("Error when Terminating Process: %d", GetLastError());
        return 0;
    }

    return 1;
}