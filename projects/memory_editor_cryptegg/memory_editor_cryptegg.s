@ Y -> write
@ L + Y -> set cursor
@ R + Y -> set cursor relative
.arch armv5te
.text
.code	16
.thumb_func
load:
    adr r0, data0
    ldmia r0!, {r1,r3}
    mov r2, #0x1a
    swi #0x0b
    add r1, #1              @ entry point + 1
    str r1, [r3]
    bx lr
    .align 2, 0, 0
data0:
    .word 0x02292800        @ entry point
    .word 0x020f90a0        @ townmap jump table
@ ============================================================
entry:
    push {r4, lr}
    adr r4, data1
    ldmia r4!, {r1-r3}          @ r4 = address of the cursor
    ldr r1, [r1]                @ r1 = base
    ldr r2, [r1,r2]             @ r2 = calc_value
keycheck:
    ldrb r3, [r3]
    lsl r0, r3, #31             @ N = bit0 of r3
    bmi set_cursor_relative
    lsl r0, r3, #30             @ N = bit1 of r3
    bmi set_cursor
write:
    ldr r0, [r4]
    stmia r0!, {r2}
    str r0, [r4]
    pop {r4, pc}
set_cursor_relative:
    add r2, r1                  @ r2 = base + calc_value
set_cursor:
    str r2, [r4]
    pop {r4, pc}
    .align 2, 0, 0
data1:
    .word 0x2108818             @ svPointer
    .word 0x112F00              @ calcurator offset
    .word 0x21c6151             @ key RLXY
    .word 0x2290000             @ cursor (variable)
