
CC				= arm-none-eabi-gcc
AS				= arm-none-eabi-as
CFLAGS			= -mcpu=arm946e-s -mthumb -Os -nostartfiles -nodefaultlibs -fno-builtin
LDFLAGS			= --specs=nosys.specs -T linker.ld
INC				= -I../../include
LIB				=

TOOLS			= ../../tools/bin

all:
	$(CC) $(CFLAGS) $(INC) $(LDFLAGS) $(SRCS) -o $(NAME)
	arm-none-eabi-objcopy -O binary $(NAME) $(NAME).bin
	arm-none-eabi-objdump -d $(NAME) > $(NAME)_dump.txt
	$(TOOLS)/toEgg.sh $(NAME).bin
	$(TOOLS)/toScript.sh $(NAME).bin

clean:
	rm -rf $(NAME) *.txt *.bin