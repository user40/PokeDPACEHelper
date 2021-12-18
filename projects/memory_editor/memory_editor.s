@ Y -> write
@ L + Y -> set cursor
@ R + Y -> set cursor relative
.arch armv5te
.text
.code	16
.thumb_func
entry:
    push {r4-r7, lr}
    adr r4, data
    ldmia r4!, {r1-r3}          @ r4 = address of the cursor
    ldr r1, [r1]                @ r1 = base
    ldr r2, [r1,r2]             @ r2 = calc_value
keycheck:
    ldrb r5, [r3]
    mov r6, #1                  @ R = 1
    tst r5, r6
    bne set_cursor_relative
    mov r7, #2                  @ L = 2
    tst r5, r7
    bne set_cursor
write:
    ldr r0, [r4]
    stmia r0!, {r2}
    str r0, [r4]
    pop {r4-r7, pc}
set_cursor_relative:
    add r2, r1                  @ r2 = base + calc_value
set_cursor:
    str r2, [r4]
    pop {r4-r7, pc}
    .align 2, 0, 0
data:
    .word 0x2108818             @ svPointer
    .word 0x112F00              @ offset
    .word 0x21c6151             @ key RLXY
    .word 0                     @ cursor (variable)
