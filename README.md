# python-readMBR
Read MBR using PYTHON(?) - (MBR공부용 삽질리포)

# 
MBR은 첫 512바이트로 구성되며, 부트로더와 파티션 테이블 정보를 포함하고 있습니다.

```
read_mbr(drive="\\\\.\\PhysicalDrive0")
```
위 함수를 사용하여 PhysicalDrive0 (C)드라이브에서 첫 512바이트를 추출후 hex코드로 반환합니다.
