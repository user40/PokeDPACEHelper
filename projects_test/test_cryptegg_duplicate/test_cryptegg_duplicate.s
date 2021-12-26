@ Duplicate a pokemon
@ no mark -> copy 1 time
@ marks corresponding to n -> copy n times
.arch armv5te
.text
.thumb
.thumb_func
dummy0:
    .word 0
    .word 0
start:
    mov r0, pc          @ r0 = boxdata +8 +4
    add r0, #0x7C
    mov r1, r0
    mov r2, #0x44
    ldrb r3, [r4]    @ r3 = mark, loop counter
loop:
    add r1, #0x88
    swi #0xb
    sub r3, #1
    cmp r3, #0
    bgt loop
loop_end:
    bx lr
    .align 7, 0, 0
dummy1:
    .word 0
    .word 0



