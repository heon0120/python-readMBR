section .data
    bootloader db 0xEB, 0x3C, 0x90
    msg db 'Hello, World!', 0x00
    boot_signature db 0x55, 0xAA
    disk_path db '\\\\.\\PhysicalDrive0', 0 ; 드라이브 정의

    ; API 함수이름
    createfile_name db 'CreateFileW', 0
    writefile_name db 'WriteFile', 0
    closehandle_name db 'CloseHandle', 0

section .bss
    bootloader_bytes resb 512
    bytes_written resd 1

section .text
    global _start
    extern CreateFileW, WriteFile, CloseHandle

; 문자열 정의
_start:
    mov byte [bootloader_bytes], 0xEB
    mov byte [bootloader_bytes + 1], 0x3C
    mov byte [bootloader_bytes + 2], 0x90

    mov byte [bootloader_bytes + 3], 'H'
    mov byte [bootloader_bytes + 4], 'e'
    mov byte [bootloader_bytes + 5], 'l'
    mov byte [bootloader_bytes + 6], 'l'
    mov byte [bootloader_bytes + 7], 'o'
    mov byte [bootloader_bytes + 8], ','
    mov byte [bootloader_bytes + 9], ' '
    mov byte [bootloader_bytes + 10], 'W'
    mov byte [bootloader_bytes + 11], 'o'
    mov byte [bootloader_bytes + 12], 'r'
    mov byte [bootloader_bytes + 13], 'l'
    mov byte [bootloader_bytes + 14], 'd'
    mov byte [bootloader_bytes + 15], '!'
    mov byte [bootloader_bytes + 16], 0x00

    mov ecx, 510 - 18
    mov edi, bootloader_bytes + 18
padding_loop:
    mov byte [edi], 0x00
    inc edi
    loop padding_loop

    mov byte [bootloader_bytes + 510], 0x55
    mov byte [bootloader_bytes + 511], 0xAA

    push 0
    push 0
    push 0
    push 0x80000000
    push disk_path
    call CreateFileW

    cmp eax, -1
    je  error_exit

    mov edi, eax

    push 0
    push bytes_written
    push 512
    push bootloader_bytes
    push edi
    call WriteFile

    cmp eax, 0
    je  error_exit

    push edi
    call CloseHandle

    mov eax, 1
    int 0x80

error_exit:
    mov eax, 1
    int 0x80
