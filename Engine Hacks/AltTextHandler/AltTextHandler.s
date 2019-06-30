.thumb
.align

.equ NewTextReturn,0x805EF1B @looking for offset in r0
.equ OldTextReturn,0x805EEC3
.equ DontEvenKnow,0x89CD924
.equ NumberOfEntries,0x7FFF

@hook into text handler function at 0x805EEBC

@text entry is in r1
@mov r7,r0
mov r3,r1
strh r3,[r7,#8]
@check if bit 0x8000(lsl 0x80 by 8) is set
mov r0,#0x80
lsl r0,r0,#8
and r0,r1
lsr r0,r0,#8
cmp r0,#0x80
bne VanillaFunction
@now we know this should use the new table, so unset the highest bit to get an accurate table index
lsl r0,r0,#8
bic r1,r0
mov r0,#4
mul r1,r0
ldr r0,NewTextTable
add r0,r1
ldr r0,[r0]
ldr r2,=NewTextTable
ldr r4,=NumberOfEntries
ldr r1,=NewTextReturn
bx r1



VanillaFunction:
mov r0,#0x80
lsl r0,r0,#0x12
ldrb r1,[r0,#7]
ldr r0,=OldTextReturn
bx r0


.ltorg
.align

NewTextTable:
@POIN NewTextTable
