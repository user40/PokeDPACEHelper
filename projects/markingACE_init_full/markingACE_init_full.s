@ marking ACE entry point
@ When marking a pokemon, call the address of the pokemon + 8.
@ This function passes two arguments to the callee;
@ r0 is the starting address of the callee, and
@ r3 corresponds to the selected marks.
.arch armv5te
.text
.code	16
.thumb_func
ldrb r3, [r4]    @ r3 = marks    
ldr r0, [sp]
mov r1, r0
add r1, #0x9    @ 8 + 1
blx r1
.short 0
