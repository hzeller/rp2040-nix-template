# Little driver makefile to make the complicated bootloader less of a hassle.

PROJECT=blink

BOOTLOADER_PARTIION=/dev/sdb1   # or as whatever it shows up
BOOTLOADER_MOUNT_DIR= /run/media/$(USER)/RPI-RP2

build/$(PROJECT).uf2:

flash : build/$(PROJECT).uf2
	udisksctl mount -b $(BOOTLOADER_PARTIION)
	cp $< /run/media/$(USER)/RPI-RP2

build/$(PROJECT).uf2: run-cmake
	cmake --build build

run-cmake:
	cmake -B build

clean:
	rm -rf build
