@ marking ACE entry point
@ r3 corresponding to selected marks
.arch armv5te
.text
.code	16
.thumb_func
ldrb r3, [r4]    @ r3 = marks    
ldr r1, [sp]
add r1, #0x9    @ 8 + 1
blx r1
.short 0
.short 0
