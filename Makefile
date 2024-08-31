# Little driver makefile to make the complicated bootloader less of a hassle.

PROJECT=blink

BOOTLOADER_PARTIION=/dev/disk/by-label/RPI-RP2   # block device it shows up as.
BOOTLOADER_MOUNT_DIR=/run/media/$(USER)/RPI-RP2  # where udisksctl mounts it.

TOOLCHAIN_PREFIX=arm-none-eabi-

build/$(PROJECT).uf2:

flash : build/$(PROJECT).uf2
	udisksctl mount -b $(BOOTLOADER_PARTIION)
	cp $< $(BOOTLOADER_MOUNT_DIR)

build/$(PROJECT).uf2 build/$(PROJECT).elf: build FORCE
	$(MAKE) -C build
	$(TOOLCHAIN_PREFIX)size build/$(PROJECT).elf
	$(TOOLCHAIN_PREFIX)nm --print-size --size-sort --radix=d build/$(PROJECT).elf | awk '{printf("%5d %s\n", $$2, $$4);}' | sort -nr | head -20

disasm: build/$(PROJECT).elf
	$(TOOLCHAIN_PREFIX)objdump -C -S build/$(PROJECT).elf

build:
	cmake -B build -DCMAKE_VERBOSE_MAKEFILE=ON

clean:
	rm -rf build

FORCE:
