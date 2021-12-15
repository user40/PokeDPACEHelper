# ===================================================================================================
# The name of .s file
TARGET			= test_pokegram

# Pointer code settings
POINTER			= 0x02108818
OFFSET			= 0xC318
POINTERFLAGS	= --pointer -a $(OFFSET) -p $(POINTER)
# ===================================================================================================
BIN             = $(TARGET).bin
POKE			= $(TARGET)_poke.bin

CC				= arm-none-eabi-gcc
CFLAGS		    = -nostartfiles -nostdlib #-ffreestanding
LDFLAGS			= -Wl,--section-start=.text=$(OFFSET)

PYTHON_SCRIPT   = ../../tools/converter/converter.py
POKEGRAM		= ../../tools/pokegram/pokegram

all: clean par word wordDec
	
bin:
	$(CC) $(TARGET).s -o $(TARGET) $(CFLAGS) $(LDFLAGS)
	arm-none-eabi-objcopy -O binary $(TARGET) $(BIN)
	arm-none-eabi-objdump -d $(TARGET) > $(TARGET)_dump.txt
	rm $(TARGET)

poke: bin
	$(POKEGRAM) $(BIN)

par: poke
	python3 $(PYTHON_SCRIPT) -i $(POKE) -o $(TARGET)_par.txt -a $(OFFSET) --mode=par $(POINTERFLAGS)

word: poke
	python3 $(PYTHON_SCRIPT) -i $(POKE) -o $(TARGET)_word.txt --mode=word

wordDec: poke
	python3 $(PYTHON_SCRIPT) -i $(POKE) -o $(TARGET)_wordDec.txt --mode=wordDec

clean:
	rm -rf $(TARGET) *.txt *.bin


