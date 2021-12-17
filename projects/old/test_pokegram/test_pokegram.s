@ Duplicate a pokemon
@ no mark -> copy 1 times
@ n mark -> copy n times
.arch armv5te
.text
.thumb
.thumb_func
    mov r0, pc
    add r0, #80
    mov r1, r0
    mov r2, #44
    ldr r3, [sp, #4]    @ r1 = mark, loop counter
loop:
    add r1, #0x88
    swi #0xb
    sub r1, #1
    cmp r1, #0
    bgt loop
loop_end:
    bx lr


