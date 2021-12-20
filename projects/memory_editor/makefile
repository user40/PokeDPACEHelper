# ===================================================================================================
# The name of .s file
TARGET			= memory_editor

# The address where you want to extract the binary
VMA             = 0x2293000

# Ignore 0 in the byte writing script(0007). Comment out to disable.
NOZERO			= --nozero

# Pointer code settings
POINTER			= 0x02108818
OFFSET			= 0xC318	# box1+8
POINTERFLAGS	= --pointer -a $(OFFSET) -p $(POINTER)
# ===================================================================================================
TARGET_VMA     = $(TARGET)_$(VMA)
BIN             = $(TARGET_VMA).bin

CC				= arm-none-eabi-gcc
CFLAGS		    = -nostartfiles -nostdlib #-ffreestanding
LDFLAGS			= -Wl,--section-start=.text=$(VMA)

PYTHON_SCRIPT   = ../../tools/converter/converter.py
ENCRYPT			= ../../tools/encrypt/encrypt

all: clean par word wordDec script scriptDec box
	
bin:
	$(CC) $(TARGET).s -o $(TARGET_VMA) $(CFLAGS) $(LDFLAGS)
	arm-none-eabi-objcopy -O binary $(TARGET_VMA) $(BIN)
	arm-none-eabi-objdump -d $(TARGET_VMA) > $(TARGET_VMA)_dump.txt
	rm $(TARGET_VMA)

par: bin
	python3 $(PYTHON_SCRIPT) -i $(BIN) -o $(TARGET_VMA)_par.txt -a $(VMA) --mode=par

word: bin
	python3 $(PYTHON_SCRIPT) -i $(BIN) -o $(TARGET_VMA)_word.txt -a $(VMA) --mode=word

wordDec: bin
	python3 $(PYTHON_SCRIPT) -i $(BIN) -o $(TARGET_VMA)_wordDec.txt -a $(VMA) --mode=wordDec

script: bin
	python3 $(PYTHON_SCRIPT) -i $(BIN) -o $(TARGET_VMA)_script.txt -a $(VMA) --mode=script $(NOZERO)

scriptDec: bin
	python3 $(PYTHON_SCRIPT) -i $(BIN) -o $(TARGET_VMA)_scriptDec.txt -a $(VMA) --mode=scriptDec $(NOZERO)

box: bin
	$(ENCRYPT) $(BIN)
	python3 $(PYTHON_SCRIPT) -i $(TARGET_VMA)_poke0.bin -o $(TARGET)_box_par.txt $(POINTERFLAGS)

clean:
	rm -rf $(TARGET_VMA) *.txt *.bin


