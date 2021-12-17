@ Initialize marking ACE.
@ Make sure that it's ARM mode after jumping.
.arch armv5te
.text
.code	16
.thumb_func
ldr r0, [sp]
blx r0
