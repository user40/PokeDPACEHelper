# ===================================================================================================
# The name of .s file
TARGET			= cryptegg

# The address where you want to extract the binary
VMA             = 0x2290008

# Ignore 0 in the byte writing script(0007). Comment out to disable.
NOZERO			= --nozero

# Pointer code settings
POINTER			= 0x02108818
OFFSET			= 0xC320	# box1+8
POINTERFLAGS	= --pointer -a $(OFFSET) -p $(POINTER)
# ===================================================================================================
TARGET_VMA     = $(TARGET)_$(VMA)
BIN             = $(TARGET_VMA).bin

CC				= arm-none-eabi-gcc
CFLAGS		    = -nostartfiles -nostdlib #-ffreestanding
LDFLAGS			= -Wl,--section-start=.text=$(VMA)

PYTHON_SCRIPT   = ../../tools/converter/converter.py

all: clean par word par_rel
	
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

par_rel: bin
	python3 $(PYTHON_SCRIPT) -i $(BIN) -o $(TARGET)_par_rel.txt --mode=par $(POINTERFLAGS)

clean:
	rm -rf $(TARGET_VMA) *.txt *.bin


