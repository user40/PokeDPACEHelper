@ Y -> write
@ L + Y -> set cursor
@ R + Y -> set cursor relative
.arch armv5te
.text
.code	16
.thumb_func
load:
    adr r0, data
    ldmia r0!, {r1,r3}
    mov r2, #0x1a
    swi #0x0b
    add r1, #1              @ entry point + 1
    str r1, [r3]
townmap:
    bx lr
    .align 2, 0, 0
data:
    .word 0x02293000        @ entry point
    .word 0x020f90a0        @ townmap jump table
    .word 0xA409B5F0
    .word 0x6809CC0E
    .word 0x781D588A
    .word 0x42352601
    .word 0x2702D106
    .word 0xD104423D
    .word 0xC0046820
    .word 0xBDF06020
    .word 0x60221852
    .word 0x0000BDF0
    .word 0x02108818
    .word 0x00112F00
    .word 0x021C6151
@ 02293000 <entry>:
@  2293000:	b5f0      	push	{r4, r5, r6, r7, lr}
@  2293002:	a409      	add	r4, pc, #36	; (adr r4, 2293028 <data>)
@  2293004:	cc0e      	ldmia	r4!, {r1, r2, r3}
@  2293006:	6809      	ldr	r1, [r1, #0]
@  2293008:	588a      	ldr	r2, [r1, r2]

@ 0229300a <keycheck>:
@  229300a:	781d      	ldrb	r5, [r3, #0]
@  229300c:	2601      	movs	r6, #1
@  229300e:	4235      	tst	r5, r6
@  2293010:	d106      	bne.n	2293020 <set_cursor_relative>
@  2293012:	2702      	movs	r7, #2
@  2293014:	423d      	tst	r5, r7
@  2293016:	d104      	bne.n	2293022 <set_cursor>

@ 02293018 <write>:
@  2293018:	6820      	ldr	r0, [r4, #0]
@  229301a:	c004      	stmia	r0!, {r2}
@  229301c:	6020      	str	r0, [r4, #0]
@  229301e:	bdf0      	pop	{r4, r5, r6, r7, pc}

@ 02293020 <set_cursor_relative>:
@  2293020:	1852      	adds	r2, r2, r1

@ 02293022 <set_cursor>:
@  2293022:	6022      	str	r2, [r4, #0]
@  2293024:	bdf0      	pop	{r4, r5, r6, r7, pc}
@ 	...

@ 02293028 <data>:
@  2293028:	02108818 	.word	0x02108818
@  229302c:	00112f00 	.word	0x00112f00
@  2293030:	021c6151 	.word	0x021c6151
@  2293034:	00000000 	.word	0x00000000
