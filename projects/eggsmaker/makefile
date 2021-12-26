NAME=eggsmaker
SRCS=eggsmaker.c

CC				= arm-none-eabi-gcc
AS				= arm-none-eabi-as
CFLAGS			= -mcpu=arm946e-s -mthumb -Os -nostartfiles -nodefaultlibs -fno-builtin
LDFLAGS			= --specs=nosys.specs
LDFLAGS2		= #-Wl,--section-start=.text=0 -Wl,--section-start=.data=0x3c
INC				= -I../../include
LIB				=

TOOLS			= ../../tools/bin

all:
	$(CC) $(CFLAGS) $(INC) $(LDFLAGS) $(LDFLAGS2) $(SRCS) -o $(NAME)
	arm-none-eabi-objcopy -O binary $(NAME) $(NAME).bin
	arm-none-eabi-objdump -d $(NAME) > $(NAME)_dump.txt
	$(TOOLS)/toEgg.sh $(NAME).bin
	$(TOOLS)/toScript.sh $(NAME).bin

clean:
	rm -rf $(NAME) *.txt *.bin