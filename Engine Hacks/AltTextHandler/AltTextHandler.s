.thumb
.align

.equ NewTextReturn,0x805E9A3 @looking for offset in r0
.equ OldTextReturn,0x805EEE9
.equ NumberOfEntries,0x7FFF

@hook into text handler function at 0x805EEDE
@text entry is in r1

@check if bit 0x8000(lsl 0x80 by 8) is set
mov r0,#0x80
lsl r0,r0,#8
and r0,r5
lsr r0,r0,#8
cmp r0,#0x80
bne VanillaFunction
@now we know this should use the new table, so unset the highest bit to get an accurate table index
lsl r0,r0,#8
bic r5,r0
mov r0,#4
mul r5,r0
ldr r0,NewTextTable
add r0,r5
ldr r1,=NewTextReturn
bx r1



VanillaFunction:
lsr r0,r3,#8
lsl r0,r0,#0x18
lsr r0,r0,#0x16
add r0,r0,r2
ldr r4,[r0]
ldr r0,=OldTextReturn
bx r0

@following return:
@add r2,r2,r4
@lsl r0,r3,#0x18
@lsr r0,r0,#0x16
@add r0,r0,r2

.ltorg
.align

NewTextTable:
@POIN NewTextTable
