	.file "KeyMap.pas"
# Begin asmlist al_procedures

.section .text.n_keymap_ss_getkeynamesbytessshortstring,"ax"
.globl	KEYMAP_ss_GETKEYNAMEsBYTEssSHORTSTRING
KEYMAP_ss_GETKEYNAMEsBYTEssSHORTSTRING:
# Temps allocated between r28+6 and r28+32
# [KeyMap.pas]
# [71] begin
	push	r29
	push	r28
	in	r28,61
	in	r29,62
	subi	r28,32
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var AKey located at r28+2, size=OS_8
# Var $result located at r28+3, size=OS_16
# Var i located at r28+5, size=OS_8
	std	Y+3,r24
	std	Y+4,r25
	std	Y+2,r22
# [72] for i := 0 to Length(Keys) - 1 do
	std	Y+5,r1
.Lj5:
# [73] if Keys[i].Value = AKey then
	ldd	r19,Y+5
	mov	r18,r1
	ldi	r20,7
	mov	r21,r1
	mov	r22,r19
	mov	r23,r18
	mul	r20,r22
	mov	r19,r0
	mov	r18,r1
	mul	r23,r20
	add	r18,r0
	mul	r22,r21
	add	r18,r0
	clr	r1
	ldi	r30,lo8(TC_sKEYMAP_ss_KEYS+6)
	ldi	r31,hi8(TC_sKEYMAP_ss_KEYS+6)
	add	r30,r19
	adc	r31,r18
	ld	r19,Z
	ldd	r18,Y+2
	cp	r19,r18
	brne	.Lj9
# [75] Result := Keys[i].Name;
	ldd	r19,Y+5
	mov	r18,r1
	ldi	r20,7
	mov	r21,r1
	mov	r22,r19
	mov	r23,r18
	mul	r20,r22
	mov	r19,r0
	mov	r18,r1
	mul	r23,r20
	add	r18,r0
	mul	r22,r21
	add	r18,r0
	clr	r1
	ldi	r20,lo8(TC_sKEYMAP_ss_KEYS)
	ldi	r21,hi8(TC_sKEYMAP_ss_KEYS)
	add	r20,r19
	adc	r21,r18
	ldd	r24,Y+3
	ldd	r25,Y+4
	ldi	r22,-1
	mov	r23,r1
	call	fpc_shortstr_to_shortstr
# [76] Exit;
	rjmp	.Lj3
.Lj9:
	ldd	r18,Y+5
	inc	r18
	std	Y+5,r18
	ldd	r19,Y+5
	ldi	r18,20
	cp	r18,r19
	brlo	.Lj11
# [80] end;
	rjmp	.Lj5
.Lj11:
# [78] Result := IntToStr(AKey);
	ldd	r20,Y+2
	mov	r21,r1
	mov	r22,r1
	mov	r23,r1
	ldi	r24,lo8(19)
	ldi	r25,hi8(19)
	add	r24,r28
	adc	r25,r29
	call	ARDUINOTOOLS_ss_INTTOSTRsLONGINTssTINTSTR
	ldd	r0,Y+19
	std	Y+6,r0
	ldd	r0,Y+20
	std	Y+7,r0
	ldd	r0,Y+21
	std	Y+8,r0
	ldd	r0,Y+22
	std	Y+9,r0
	ldd	r0,Y+23
	std	Y+10,r0
	ldd	r0,Y+24
	std	Y+11,r0
	ldd	r0,Y+25
	std	Y+12,r0
	ldd	r0,Y+26
	std	Y+13,r0
	ldd	r0,Y+27
	std	Y+14,r0
	ldd	r0,Y+28
	std	Y+15,r0
	ldd	r0,Y+29
	std	Y+16,r0
	ldd	r0,Y+30
	std	Y+17,r0
	ldd	r0,Y+31
	std	Y+18,r0
	ldd	r19,Y+3
	ldd	r20,Y+4
	mov	r18,r1
	mov	r30,r19
	mov	r31,r20
	st	Z,r18
	ldd	r20,Y+17
	ldd	r21,Y+18
	ldi	r18,1
	add	r20,r18
	adc	r21,r1
	ldd	r19,Y+3
	ldd	r18,Y+4
	ldi	r22,lo8(1)
	ldi	r23,hi8(1)
	add	r22,r19
	adc	r23,r18
	ldi	r24,lo8(6)
	ldi	r25,hi8(6)
	add	r24,r28
	adc	r25,r29
	call	SYSTEM_ss_MOVEsformalsformalsSMALLINT
	ldd	r20,Y+17
	mov	r21,r1
	sbrc	r20,7
	com	r21
	ldd	r24,Y+3
	ldd	r25,Y+4
	ldi	r22,-1
	mov	r23,r1
	call	fpc_shortstr_setlength
	ldd	r18,Y+3
	ldd	r18,Y+4
# [79] Result := '#' + Result;
	ldd	r18,Y+3
	ldd	r19,Y+4
	ldi	r20,lo8(_sKEYMAPs_Ld2)
	ldi	r21,hi8(_sKEYMAPs_Ld2)
	ldd	r24,Y+3
	ldd	r25,Y+4
	ldi	r22,-1
	mov	r23,r1
	call	fpc_shortstr_concat
.Lj3:
	subi	r28,-32
	sbci	r29,-1
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
	pop	r28
	pop	r29
	ret
.Le0:
	.size	KEYMAP_ss_GETKEYNAMEsBYTEssSHORTSTRING, .Le0 - KEYMAP_ss_GETKEYNAMEsBYTEssSHORTSTRING
# End asmlist al_procedures
# Begin asmlist al_typedconsts

.section .data.n_TC_sKEYMAP_ss_KEYS
TC_sKEYMAP_ss_KEYS:
	.byte	1
# [45] (Name: 'A'; Value: KeyA),
	.ascii	"A\000   "
	.byte	69,1
# [46] (Name: 'B'; Value: KeyB),
	.ascii	"B\000   "
	.byte	70,1
# [47] (Name: 'C'; Value: KeyC),
	.ascii	"C\000   "
	.byte	71,1
# [48] (Name: 'D'; Value: KeyD),
	.ascii	"D\000   "
	.byte	68,2
# [49] (Name: 'up'; Value: KeyUP),
	.ascii	"up\000  "
	.byte	64,1
# [50] (Name: '+'; Value: KeyPLUS),
	.ascii	"+\000   "
	.byte	67,4
# [51] (Name: 'left'; Value: KeyLEFT),
	.ascii	"left\000"
	.byte	7,2
# [52] (Name: 'ok'; Value: KeyOK),
	.ascii	"ok\000  "
	.byte	21,5
# [53] (Name: 'right'; Value: KeyRIGHT),
	.ascii	"right"
	.byte	9,1
# [54] (Name: '0'; Value: Key0),
	.ascii	"0\000   "
	.byte	22,4
# [55] (Name: 'down'; Value: KeyDOWN),
	.ascii	"down\000"
	.byte	25,1
# [56] (Name: '-'; Value: KeyMINUS),
	.ascii	"-\000   "
	.byte	13,1
# [57] (Name: '1'; Value: Key1),
	.ascii	"1\000   "
	.byte	12,1
# [58] (Name: '2'; Value: Key2),
	.ascii	"2\000   "
	.byte	24,1
# [59] (Name: '3'; Value: Key3),
	.ascii	"3\000   "
	.byte	94,1
# [60] (Name: '4'; Value: Key4),
	.ascii	"4\000   "
	.byte	8,1
# [61] (Name: '5'; Value: Key5),
	.ascii	"5\000   "
	.byte	28,1
# [62] (Name: '6'; Value: Key6),
	.ascii	"6\000   "
	.byte	90,1
# [63] (Name: '7'; Value: Key7),
	.ascii	"7\000   "
	.byte	66,1
# [64] (Name: '8'; Value: Key8),
	.ascii	"8\000   "
	.byte	82,1
# [65] (Name: '9'; Value: Key9)
	.ascii	"9\000   "
	.byte	74
# [68] function GetKeyName(const AKey: Byte): String;
.Le1:
	.size	TC_sKEYMAP_ss_KEYS, .Le1 - TC_sKEYMAP_ss_KEYS

.section .rodata.n__sKEYMAPs_Ld1
.globl	_sKEYMAPs_Ld1
_sKEYMAPs_Ld1:
	.ascii	"\000\000"
.Le2:
	.size	_sKEYMAPs_Ld1, .Le2 - _sKEYMAPs_Ld1

.section .rodata.n__sKEYMAPs_Ld2
.globl	_sKEYMAPs_Ld2
_sKEYMAPs_Ld2:
	.ascii	"\001#\000"
.Le3:
	.size	_sKEYMAPs_Ld2, .Le3 - _sKEYMAPs_Ld2
# End asmlist al_typedconsts

