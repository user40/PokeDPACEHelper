@ Rewrite the marking function to setup marking ACE.
.arch armv5te
.text
@ .arm 
@     blx start
@     .align 7, 0, 0
@     .word 0
@     .word 0
@     .word 0
@     .word 0
@ 0:	fa000022 	blx	90 <start>
.thumb
.thumb_func
start:
    sub sp, #4
    adr r0, data
    ldmia r0, {r0, r1, r2, r3}
    stmia r3!, {r0, r1, r2}
    add r3, #1
    bx r3
    .align 2, 0, 0
data:
    .word 0x30919800
    .word 0x00004780
    .word 0x00000000
    .word 0x0206DAB0
    @ 206dab0:	9800      	ldr	r0, [sp, #0]
    @ 206dab2:	3009      	adds	r0, #0x91
    @ 206dab4:	4780      	blx	r0
    @ 206dab6:	0000      	.short	0x0000
    @ 206dab8:	00000000 	.word	0x00000000
