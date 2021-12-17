@ Initialize marking ACE.
@ Make sure that it's ARM mode after jumping.
.arch armv5te
.text
.thumb
.thumb_func
pop {pc}
nop
