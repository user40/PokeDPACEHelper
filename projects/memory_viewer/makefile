CC				= arm-none-eabi-gcc
AS				= arm-none-eabi-as
# -Osはプログラムサイズを小さくする最適化
CFLAGS			= -march=armv5te -mthumb -Os
CFLAGS2			= -nostartfiles #-nostdlib #-ffreestanding
# 非ARM系のマシンでリンクするために必要
LDFLAGS			= --specs=nosys.specs
LDFLAGS2		= #-Wl,--section-start=.text=0 -Wl,--section-start=.data=0x3c
PROGRAM			= str
DST				= build

all:
	$(CC) $(CFLAGS) $(CFLAGS2) $(LDFLAGS) $(LDFLAGS2) $(PROGRAM).c -o $(DST)/$(PROGRAM)