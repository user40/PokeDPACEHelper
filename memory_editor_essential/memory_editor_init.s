@ The essential part of the memory editor

.macro _nop
    .short 0
.endm

.arch armv5te
.text
.code	16
.thumb_func
set_cursor_relative_entry:
    _nop @movs r0, #1
    _nop @b common
set_cursor_entry:
    movs r0, #0
    _nop @b common
write_entry:
@ If jumped from dot button, r0 == (address of somewhere) > 1
    _nop @movs r0, #2
    .align 2, 0, 0
common:
    adr r3, DAT_svPointer
    ldmia r3!, {r1-r2}          @ r3 = address of the cursor
    ldr r1, [r1]                @ r1 = base
    ldr r2, [r1,r2]             @ r2 = calc_value
    cmp r0, #1
    bgt write
    _nop @ blt set_cursor
set_cursor_relative:
    _nop @add r2, r1            @ r2 = base + calc_value
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

