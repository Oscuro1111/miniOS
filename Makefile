CC=gcc

TARGET=miniOS
C_FILES=./src/kernel.c
OBJS=$(C_FILES:./src/%.c=./objs/%.o)

ISO_IMG_DIR=./iso_img

FLG=-std=gnu99

all compile:$(TARGET)

all: finale

.PHONY:all compile clean finale

%.o:$(C_FILES)
	$(CC) $(FLG) -c $(C_FILES) -o $@ -ffreestanding -fno-exceptions -m32

$(TARGET):$(OBJS)
	$(shell nasm -f elf32 start.asm -o start.o)
	$(CC) $(FLG) -m32 -nostdlib -nodefaultlibs -lgcc start.o  $? -T linker.ld -o $(TARGET)

final:
	$(shell grub-file --is-x86-multiboot $(TARGET))
	$(shell cp $(TARGET) ./iso/boot/$(TARGET))
	$(shell grub-mkrescue iso --output=$(ISO_IMG_DIR)/$(TARGET).iso)

clean:
	rm -f *.o $(TARGET) $(ISO_IMG_DIR)/$(TARGET).iso
	find . -name \*.o|xargs --no-run-if-empty rm
