.arch armv5te
.text
.code	16
.thumb_func
set_cursor_relative_entry:
    movs r3, #2
    b common
set_cursor_entry:
    movs r3, #1
    b common
write_entry:
    movs r3, #0
    @ fall through
common:
    adr r0, DAT_svPointer
    ldmia r0!, {r1-r2}          @ r0 = address of the cursor
    ldr r1, [r1]                @ r1 = base
    ldr r2, [r1,r2]             @ r2 = calc_value
    cmp r3, #0
    beq write
    cmp r3, #1
    beq set_cursor
    @ fall through
set_cursor_relative:
    add r2, r1                  @ r2 = base + calc_value
    @ fall through
set_cursor:
    str r2, [r0]
    bx lr
write:
    ldr r3, [r0]
    stmia r3!, {r2}
    str r3, [r0]
    bx lr
    .align 2, 0, 0
DAT_svPointer:
    .word 0x2108818
DAT_offset:
    .word 0x112F00
DAT_cursor:
    .word =set_cursor
