arm-none-eabi-objcopy -O binary str str.bin
../../../tools/encrypt/encrypt str.bin
python3 ../../../tools/converter/converter.py -i str_poke0.bin -o str_poke0_par_rel.txt --pointer -a 0xC318 -p 0x02108818