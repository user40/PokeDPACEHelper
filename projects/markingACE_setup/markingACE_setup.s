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
    ldmia r0, {r0, r1, r2, r3}
    stmia r3!, {r0, r1, r2}
    add r3, #1
    bx r3
    .align 2, 0, 0
data:
    .word 0x99006827
    .word 0x47883109
    .word 0x00000000
    .word 0x0206DAB0
    @  206dab0:	6827      	ldr	r7, [r4, #0]
    @  206dab2:	9900      	ldr	r1, [sp, #0]
    @  206dab4:	3109      	adds	r1, #9
    @  206dab6:	4788      	blx	r1
    @  206dab8:	00000000 	.word	0x00000000
