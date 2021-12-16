@ NO LONGER USED
@ Switch cpu mode to thumb form arm
.arch armv5te
.text
.thumb
.thumb_func
entry:
    blx start
    .align 3, 0, 0
start:
    adr r0, data
    ldmia r0!, {r0, r1, r2, r3}
    stmia r3!, {r0, r1, r2}
    add r3, #1
    bx r3
    .align 2, 0, 0
data:
    .word 0x30099800
    .word 0x00004780
    .word 0x00000000
    .word 0x0206DAB0
    @ 206dab0:	9800      	ldr	r0, [sp, #0]
    @ 206dab2:	3009      	adds	r0, #9
    @ 206dab4:	4780      	blx	r0
    @ 206dab6:	0000      	.short	0x0000
    @ 206dab8:	00000000 	.word	0x00000000
