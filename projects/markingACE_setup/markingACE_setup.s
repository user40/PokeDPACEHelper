@ Rewrite the marking function to setup marking ACE.
.arch armv5te
.text
.arm 
    blx start
    .word 0
.thumb
.thumb_func
start:
    sub sp, #4                  @ for pop {pc}
    adr r0, data
    ldmia r0, {r0-r5}           @ r4 and r5 will be recovered by the caller, so ok.
    @ change menu
    strh r5, [r4]
    @ rewrite the marking function
    stmia r3!, {r0-r2}
    add r3, #1
    bx r3
    .align 2, 0, 0
data:
    ldrb r3, [r4]    @ r3 = marks    
    ldr r0, [sp]
    mov r1, r0
    add r1, #0x9    @ 8 + 1
    blx r1
    .short 0
    .word 0x02038edc        @ menu setting address
    .word 0x20c0            @ mov r0 #0xc0
