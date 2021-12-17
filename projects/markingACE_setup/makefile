# ===================================================================================================
# The name of .s file
TARGET			= markingACE_setup

# The address where you want to extract the binary
VMA             = 0x2290000

# Ignore 0 in the byte writing script(0007). Comment out to disable.
NOZERO			= --nozero

# ===================================================================================================
TARGET_VMA     = $(TARGET)_$(VMA)
BIN             = $(TARGET_VMA).bin

CC				= arm-none-eabi-gcc
CFLAGS		    = -nostartfiles -nostdlib #-ffreestanding
LDFLAGS			= -Wl,--section-start=.text=$(VMA)

PYTHON_SCRIPT   = ../../tools/converter/converter.py

# all: clean par word wordDec script scriptDec
all: clean par word
	
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

clean:
	rm -rf $(TARGET_VMA) *.txt *.bin


