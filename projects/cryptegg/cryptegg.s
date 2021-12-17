@ Encrypt the data at 0x02290000 - 0x02290088 and copy to box1,1
@ If marks > 0 then modify PID.
.arch armv5te
.text
.thumb
.thumb_func
entry:
    push {r4, r5, r6, lr}
    adr r0, data
    ldmia r0, {r0, r4, r5, r6}
copy:
    ldr r4, [r4]
    add r1, r4, r5      @ base + 0x3C18 (box1,1)
    mov r2, #0x44       @ half word count (=0x88 byte)
    swi #0xb
set_flag:
    mov r2, #6          @ bad egg & plaintext flag
    strb r2, [r1, #4]
    cmp r7, #0
    beq encrypt
    mov r2, #0x60       @ block shuffle type 3 ACDB
    strb r2, [r1, #1]
encrypt:
    mov r0, r1
    mov r1, #1
    blx r6
    pop {r4, r5, r6, pc}
    .align 2, 0, 0
data:
    .word 0x02290000
    .word 0x02108818
    .word 0x0000C318
    .word 0x0206EE41    @ encryption func
