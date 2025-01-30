#include <windows.h>
#include <stdio.h>

int main()
{
    char lpFN[20]; // Buffer for filename
    HANDLE hFile;
    int x = 0;

    while (x <= 5)
    {
        sprintf(lpFN, "test%d.txt", x); // Create "test0.txt", "test1.txt", etc.

        hFile = CreateFileA(lpFN, GENERIC_READ | GENERIC_WRITE, FILE_SHARE_READ, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
        if (hFile == INVALID_HANDLE_VALUE) // Correct error check
        {
            printf("Error when creating file: %d\n", GetLastError());
            return 1;
        }

        printf("Created file: %s\n", lpFN);
        CloseHandle(hFile); // Always close the file handle

        x++;
    }

    return 0;
}
