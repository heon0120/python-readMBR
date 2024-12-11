def read_mbr(drive="\\\\.\\PhysicalDrive0"):
    try:
        with open(drive, "rb") as disk:
            mbr = disk.read(512)  # MBR은 첫 512바이트

        print("MBR 읽기 완료!")
        return mbr
    except PermissionError:
        print("권한이 필요합니다. 관리자 권한으로 실행하세요.")
    except FileNotFoundError:
        print("디스크 경로가 잘못되었습니다. 유효한 디스크를 지정하세요.")
    except Exception as e:
        print(f"오류 발생: {e}")
        return None

def main():
    print("===== MBR 읽기 프로그램 =====")
    mbr = read_mbr()
    if mbr:
        print(f"MBR 데이터 (16진수):\n{mbr.hex()}")

if __name__ == "__main__":
    main()
