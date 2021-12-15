.arch armv5te
.text
.code	16
.thumb_func
set_cursor_relative_entry:
    movs r0, #1
    b common
set_cursor_entry:
    movs r0, #0
    b common
write_entry:
    movs r0, #2
    .align 2, 0, 0
common:
    adr r3, DAT_svPointer
    ldmia r3!, {r1-r2}          @ r3 = address of the cursor
    ldr r1, [r1]                @ r1 = base
    ldr r2, [r1,r2]             @ r2 = calc_value
    cmp r0, #1
    bgt write                   @ case r0 > 1
    blt set_cursor              @ case r0 < 1
set_cursor_relative:
    add r2, r1                  @ r2 = base + calc_value
set_cursor:
    str r2, [r3]
    bx lr
write:
    ldr r0, [r3]
    stmia r0!, {r2}
    str r0, [r3]
    bx lr
    .align 2, 0, 0
DAT_svPointer:
    .word 0x2108818
DAT_offset:
    .word 0x112F00
DAT_cursor:
    .word 0
