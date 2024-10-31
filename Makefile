# Little driver makefile to make the complicated bootloader less of a hassle.

PROJECT=blink

TOOLCHAIN_PREFIX=arm-none-eabi-

# Board in use. e.g. adafruit_feather_rp2040 would be another popular one.
BOARD=pico

build/$(PROJECT).uf2:

flash : build/$(PROJECT).uf2
	picotool load $<
	picotool reboot

build/$(PROJECT).uf2 build/$(PROJECT).elf: build FORCE
	$(MAKE) -C build
	$(TOOLCHAIN_PREFIX)size build/$(PROJECT).elf
	$(TOOLCHAIN_PREFIX)nm --print-size --size-sort --radix=d build/$(PROJECT).elf | awk '{printf("%5d %s\n", $$2, $$4);}' | sort -nr | head -20

disasm: build/$(PROJECT).elf
	$(TOOLCHAIN_PREFIX)objdump -C -S build/$(PROJECT).elf

build:
	cmake -B build -DCMAKE_VERBOSE_MAKEFILE=ON -DPICO_BOARD=$(BOARD)

clean:
	rm -rf build

FORCE:
