@ Encrypt the next Pokemon after the Pokemon you marked.
.arch armv5te
.text
.thumb
.thumb_func
entry:
    push {lr}
    adr r0, data
    ldmia r0, {r0, r4, r5, r6}
copy:
    ldr r4, [r4]
    add r1, r4, r5      @ base + 0x3C18
    mov r2, #0x44       @ half word count
    swi #0xb
set_flag:
    mov r2, #6          @ bad egg & plaintext flag
    strh r2, [r1, #4]
encrypt:
    mov r0, r1
    mov r1, #1
    blx r6
    pop {pc}
    .align 2, 0, 0
data:
    .word 0x02290000
    .word 0x02108818
    .word 0x00003C18
    .word 0x0206EE41    @ encryption func
