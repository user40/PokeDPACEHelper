@ marking ACE entry point

.arch armv5te
.text
.code	16
.thumb_func
ldr r0, [sp]
add r0, #0x9     @ 8 + 1
blx r0
.short 0
.short 0
.short 0
