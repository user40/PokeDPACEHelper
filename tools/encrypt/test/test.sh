../encrypt buizeru_plaintext_abcd.bin
cmp buizeru_ciph.bin buizeru_plaintext_abcd_poke0.bin -i 6
echo $?