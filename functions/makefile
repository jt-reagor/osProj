flags:= -fda


test:
	nasm $@.asm -f bin -o $@.bin
	qemu-system-x86_64 $@.bin

diskRead:
	nasm $@.asm -f bin -o $@.bin
	qemu-system-x86_64 $(flags) $@.bin

clean:
	rm *.bin