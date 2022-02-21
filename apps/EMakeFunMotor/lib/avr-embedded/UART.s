	.file "UART.pas"
# Begin asmlist al_procedures

.section .text.n_uarts_stuart_s__ss_doblecompatible,"ax"
.globl	UARTs_sTUART_s__ss_DOBLECOMPATIBLE
UARTs_sTUART_s__ss_DOBLECOMPATIBLE:
# [UART.pas]
# [50] begin
	push	r29
	push	r28
	in	r28,61
	in	r29,62
	subi	r28,4
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var $self located at r28+2, size=OS_16
	std	Y+2,r24
	std	Y+3,r25
# [51] Inc(FBLECompatibleCounter);
	ldd	r18,Y+2
	ldd	r19,Y+3
	movw	r30,r18
	ld	r20,Z
	inc	r20
	movw	r30,r18
	st	Z,r20
# [52] if FBLECompatibleCounter = 20 then
	ldd	r18,Y+2
	ldd	r19,Y+3
	movw	r30,r18
	ld	r18,Z
	cpi	r18,20
	brne	.Lj6
# [54] FBLECompatibleCounter := 0;
	ldd	r18,Y+2
	ldd	r19,Y+3
	mov	r20,r1
	movw	r30,r18
	st	Z,r20
# [55] SleepMicroSecs(FBLECompatibleTime * 1000);
	ldd	r18,Y+2
	ldd	r19,Y+3
	movw	r30,r18
	ldd	r22,Z+1
	mov	r18,r1
	ldi	r19,-24
	ldi	r20,3
	mov	r21,r22
	mov	r23,r18
	mul	r19,r21
	mov	r22,r0
	mov	r18,r1
	mul	r23,r19
	add	r18,r0
	mul	r21,r20
	add	r18,r0
	clr	r1
	mov	r23,r18
	mov	r24,r1
	sbrc	r18,7
	com	r24
	mov	r25,r24
	call	ARDUINOTOOLS_ss_SLEEPMICROSECSsLONGWORD
.Lj6:
# [57] end;
	subi	r28,-4
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
	.size	UARTs_sTUART_s__ss_DOBLECOMPATIBLE, .Le0 - UARTs_sTUART_s__ss_DOBLECOMPATIBLE

.section .text.n_uarts_stuart_s__ss_getreadbufferemptyssboolean,"ax"
.globl	UARTs_sTUART_s__ss_GETREADBUFFEREMPTYssBOOLEAN
UARTs_sTUART_s__ss_GETREADBUFFEREMPTYssBOOLEAN:
# [60] begin
	push	r29
	push	r28
	in	r28,61
	in	r29,62
	subi	r28,5
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var $self located at r28+2, size=OS_16
# Var $result located at r28+4, size=OS_8
	std	Y+2,r24
	std	Y+3,r25
# [61] Result := True;
	ldi	r18,1
	std	Y+4,r18
# [62] end;
	ldd	r24,Y+4
	subi	r28,-5
	sbci	r29,-1
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
	pop	r28
	pop	r29
	ret
.Le1:
	.size	UARTs_sTUART_s__ss_GETREADBUFFEREMPTYssBOOLEAN, .Le1 - UARTs_sTUART_s__ss_GETREADBUFFEREMPTYssBOOLEAN

.section .text.n_uarts_stuart_s__ss_initswordsslongbool,"ax"
.globl	UARTs_sTUART_s__ss_INITsWORDssLONGBOOL
UARTs_sTUART_s__ss_INITsWORDssLONGBOOL:
# Temps allocated between r28+8 and r28+68
# [65] begin
	push	r29
	push	r28
	in	r28,61
	in	r29,62
	subi	r28,68
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var ABaudRate located at r28+2, size=OS_16
# Var $vmt located at r28+4, size=OS_16
# Var $self located at r28+6, size=OS_16
	std	Y+6,r24
	std	Y+7,r25
	std	Y+4,r22
	std	Y+5,r23
	std	Y+2,r20
	std	Y+3,r21
	ldi	r18,lo8(4)
	ldi	r23,hi8(4)
	add	r18,r28
	adc	r23,r29
	mov	r22,r18
	ldd	r24,Y+6
	ldd	r25,Y+7
	ldi	r18,2
	mov	r19,r1
	mov	r20,r1
	mov	r21,r1
	call	fpc_help_constructor
	std	Y+6,r24
	std	Y+7,r25
	ldd	r18,Y+6
	ldd	r19,Y+7
	cp	r18,r1
	cpc	r19,r1
	brne	.Lj21
# [70] end;
	rjmp	.Lj9
.Lj21:
	ldi	r20,lo8(8)
	ldi	r21,hi8(8)
	add	r20,r28
	adc	r21,r29
	ldi	r22,lo8(14)
	ldi	r23,hi8(14)
	add	r22,r28
	adc	r23,r29
	ldi	r24,1
	mov	r25,r1
	call	fpc_pushexceptaddr
	call	fpc_setjmp
	std	Y+37,r24
	cp	r24,r1
	breq	.Lj22
	rjmp	.Lj17
.Lj22:
# [66] UBRR0 := F_CPU div (16 * ABaudRate) - 1;
	ldd	r22,Y+2
	ldd	r23,Y+3
	mov	r24,r1
	mov	r25,r1
	ldi	r18,4
.Lj18:
	lsl	r22
	rol	r23
	rol	r24
	rol	r25
	dec	r18
	brne	.Lj18
	mov	r18,r1
	ldi	r19,36
	ldi	r20,-12
	mov	r21,r1
	call	fpc_div_longint
	subi	r22,1
	sbc	r23,r1
	sbc	r24,r1
	sbc	r25,r1
	sts	(197),r23
	sts	(196),r22
# [67] UCSR0A := 0;
	sts	(192),r1
# [68] UCSR0B := (1 shl TXEN0) or (1 shl RXEN0);
	ldi	r18,24
	sts	(193),r18
# [69] UCSR0C := (1 shl URSEL0) or (1 shl UCSZ0) or (1 shl UCSZ01);
	ldi	r18,-122
	sts	(194),r18
.Lj17:
	call	fpc_popaddrstack
	ldd	r18,Y+37
	cp	r18,r1
	brne	.Lj23
	rjmp	.Lj15
.Lj23:
	ldi	r20,lo8(38)
	ldi	r21,hi8(38)
	add	r20,r28
	adc	r21,r29
	ldi	r22,lo8(44)
	ldi	r23,hi8(44)
	add	r22,r28
	adc	r23,r29
	ldi	r24,1
	mov	r25,r1
	call	fpc_pushexceptaddr
	call	fpc_setjmp
	ldi	r30,lo8(67)
	ldi	r31,hi8(67)
	add	r30,r28
	adc	r31,r29
	st	Z,r24
	cp	r24,r1
	brne	.Lj19
	ldi	r22,lo8(4)
	ldi	r23,hi8(4)
	add	r22,r28
	adc	r23,r29
	ldd	r24,Y+6
	ldd	r25,Y+7
	ldi	r18,2
	mov	r19,r1
	mov	r20,r1
	mov	r21,r1
	call	fpc_help_fail
	call	fpc_popaddrstack
	call	fpc_reraise
.Lj19:
	call	fpc_popaddrstack
	ldi	r30,lo8(67)
	ldi	r31,hi8(67)
	add	r30,r28
	adc	r31,r29
	ld	r18,Z
	cp	r18,r1
	breq	.Lj20
	call	fpc_raise_nested
.Lj20:
	call	fpc_doneexception
.Lj15:
.Lj9:
	ldd	r24,Y+6
	ldd	r25,Y+7
	subi	r28,-68
	sbci	r29,-1
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
	pop	r28
	pop	r29
	ret
.Le2:
	.size	UARTs_sTUART_s__ss_INITsWORDssLONGBOOL, .Le2 - UARTs_sTUART_s__ss_INITsWORDssLONGBOOL

.section .text.n_uarts_stuart_s__ss_writebufferspcharsbyte,"ax"
.globl	UARTs_sTUART_s__ss_WRITEBUFFERsPCHARsBYTE
UARTs_sTUART_s__ss_WRITEBUFFERsPCHARsBYTE:
# [73] begin
	push	r29
	push	r28
	in	r28,61
	in	r29,62
	subi	r28,7
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var ABuffer located at r28+2, size=OS_16
# Var ASize located at r28+4, size=OS_8
# Var $self located at r28+5, size=OS_16
	std	Y+5,r24
	std	Y+6,r25
	std	Y+2,r22
	std	Y+3,r23
	std	Y+4,r20
# [74] while ASize > 0 do
	rjmp	.Lj27
.Lj29:
# [76] while UCSR0A and (1 shl UDRE0) = 0 do
	lds	r18,(192)
	andi	r18,32
	breq	.Lj29
# [78] UDR0 := Byte(ABuffer^);
	ldd	r18,Y+2
	ldd	r19,Y+3
	movw	r30,r18
	ld	r0,Z
	sts	(198),r0
# [79] Inc(ABuffer);
	ldd	r19,Y+2
	ldd	r20,Y+3
	ldi	r18,1
	add	r19,r18
	adc	r20,r1
	std	Y+2,r19
	std	Y+3,r20
# [80] Dec(ASize);
	ldd	r18,Y+4
	dec	r18
	std	Y+4,r18
# [81] if FBLECompatibleTime > 0 then
	ldd	r18,Y+5
	ldd	r19,Y+6
	movw	r30,r18
	ldd	r18,Z+1
	cp	r1,r18
	brsh	.Lj27
# [82] DoBLECompatible;
	ldd	r24,Y+5
	ldd	r25,Y+6
	call	UARTs_sTUART_s__ss_DOBLECOMPATIBLE
.Lj27:
	ldd	r18,Y+4
	cp	r1,r18
	brsh	.Lj34
# [84] end;
	rjmp	.Lj29
.Lj34:
	subi	r28,-7
	sbci	r29,-1
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
	pop	r28
	pop	r29
	ret
.Le3:
	.size	UARTs_sTUART_s__ss_WRITEBUFFERsPCHARsBYTE, .Le3 - UARTs_sTUART_s__ss_WRITEBUFFERsPCHARsBYTE

.section .text.n_uarts_stuart_s__ss_readbufferspcharsbyte,"ax"
.globl	UARTs_sTUART_s__ss_READBUFFERsPCHARsBYTE
UARTs_sTUART_s__ss_READBUFFERsPCHARsBYTE:
# [87] begin
	push	r29
	push	r28
	in	r28,61
	in	r29,62
	subi	r28,7
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var ABuffer located at r28+2, size=OS_16
# Var ASize located at r28+4, size=OS_8
# Var $self located at r28+5, size=OS_16
	std	Y+5,r24
	std	Y+6,r25
	std	Y+2,r22
	std	Y+3,r23
	std	Y+4,r20
# [88] while ASize > 0 do
	rjmp	.Lj38
.Lj40:
# [90] while UCSR0A and (1 shl RXC0) = 0 do
	lds	r18,(192)
	andi	r18,-128
	breq	.Lj40
# [92] ABuffer^ := Char(UDR0);
	ldd	r18,Y+2
	ldd	r19,Y+3
	movw	r30,r18
	lds	r0,(198)
	st	Z,r0
# [93] Inc(ABuffer);
	ldd	r19,Y+2
	ldd	r20,Y+3
	ldi	r18,1
	add	r19,r18
	adc	r20,r1
	std	Y+2,r19
	std	Y+3,r20
# [94] Dec(ASize);
	ldd	r18,Y+4
	dec	r18
	std	Y+4,r18
.Lj38:
	ldd	r18,Y+4
	cp	r1,r18
	brlo	.Lj40
# [96] end;
	subi	r28,-7
	sbci	r29,-1
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
	pop	r28
	pop	r29
	ret
.Le4:
	.size	UARTs_sTUART_s__ss_READBUFFERsPCHARsBYTE, .Le4 - UARTs_sTUART_s__ss_READBUFFERsPCHARsBYTE

.section .text.n_uarts_stuart_s__ss_writebytesbyte,"ax"
.globl	UARTs_sTUART_s__ss_WRITEBYTEsBYTE
UARTs_sTUART_s__ss_WRITEBYTEsBYTE:
# [99] begin
	push	r29
	push	r28
	push	r2
	in	r28,61
	in	r29,62
	subi	r28,5
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var AValue located at r28+2, size=OS_8
# Var $self located at r28+3, size=OS_16
	std	Y+3,r24
	std	Y+4,r25
	std	Y+2,r22
# [100] WriteBuffer(@AValue, 1);
	ldi	r18,lo8(2)
	ldi	r23,hi8(2)
	add	r18,r28
	adc	r23,r29
	mov	r22,r18
	ldd	r24,Y+3
	ldd	r25,Y+4
	ldi	r20,1
	ldd	r19,Y+3
	ldd	r18,Y+4
	mov	r30,r19
	mov	r31,r18
	ldd	r18,Z+2
	ldd	r19,Z+3
	movw	r30,r18
	ldd	r18,Z+8
	ldd	r2,Z+9
	mov	r30,r18
	mov	r31,r2
	icall
# [101] end;
	subi	r28,-5
	sbci	r29,-1
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
	pop	r2
	pop	r28
	pop	r29
	ret
.Le5:
	.size	UARTs_sTUART_s__ss_WRITEBYTEsBYTE, .Le5 - UARTs_sTUART_s__ss_WRITEBYTEsBYTE

.section .text.n_uarts_stuart_s__ss_writecharschar,"ax"
.globl	UARTs_sTUART_s__ss_WRITECHARsCHAR
UARTs_sTUART_s__ss_WRITECHARsCHAR:
# [104] begin
	push	r29
	push	r28
	push	r2
	in	r28,61
	in	r29,62
	subi	r28,5
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var AValue located at r28+2, size=OS_8
# Var $self located at r28+3, size=OS_16
	std	Y+3,r24
	std	Y+4,r25
	std	Y+2,r22
# [105] WriteBuffer(@AValue, 1);
	ldi	r18,lo8(2)
	ldi	r23,hi8(2)
	add	r18,r28
	adc	r23,r29
	mov	r22,r18
	ldd	r24,Y+3
	ldd	r25,Y+4
	ldi	r20,1
	ldd	r19,Y+3
	ldd	r18,Y+4
	mov	r30,r19
	mov	r31,r18
	ldd	r18,Z+2
	ldd	r19,Z+3
	movw	r30,r18
	ldd	r18,Z+8
	ldd	r2,Z+9
	mov	r30,r18
	mov	r31,r2
	icall
# [106] end;
	subi	r28,-5
	sbci	r29,-1
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
	pop	r2
	pop	r28
	pop	r29
	ret
.Le6:
	.size	UARTs_sTUART_s__ss_WRITECHARsCHAR, .Le6 - UARTs_sTUART_s__ss_WRITECHARsCHAR

.section .text.n_uarts_stuart_s__ss_writestringsshortstring,"ax"
.globl	UARTs_sTUART_s__ss_WRITESTRINGsSHORTSTRING
UARTs_sTUART_s__ss_WRITESTRINGsSHORTSTRING:
# [109] begin
	push	r29
	push	r28
	push	r2
	in	r28,61
	in	r29,62
	subi	r28,6
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var AValue located at r28+2, size=OS_16
# Var $self located at r28+4, size=OS_16
	std	Y+4,r24
	std	Y+5,r25
	std	Y+2,r22
	std	Y+3,r23
# [110] WriteBuffer(@AValue[1], Length(AValue));
	ldd	r18,Y+2
	ldd	r19,Y+3
	ldi	r22,lo8(1)
	ldi	r23,hi8(1)
	add	r22,r18
	adc	r23,r19
	ldd	r18,Y+2
	ldd	r19,Y+3
	movw	r30,r18
	ld	r20,Z
	ldd	r24,Y+4
	ldd	r25,Y+5
	ldd	r18,Y+4
	ldd	r19,Y+5
	movw	r30,r18
	ldd	r18,Z+2
	ldd	r19,Z+3
	movw	r30,r18
	ldd	r18,Z+8
	ldd	r2,Z+9
	mov	r30,r18
	mov	r31,r2
	icall
# [111] end;
	subi	r28,-6
	sbci	r29,-1
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
	pop	r2
	pop	r28
	pop	r29
	ret
.Le7:
	.size	UARTs_sTUART_s__ss_WRITESTRINGsSHORTSTRING, .Le7 - UARTs_sTUART_s__ss_WRITESTRINGsSHORTSTRING

.section .text.n_uarts_stuart_s__ss_writeformatsshortstringsarray_of_const,"ax"
.globl	UARTs_sTUART_s__ss_WRITEFORMATsSHORTSTRINGsarray_of_const
UARTs_sTUART_s__ss_WRITEFORMATsSHORTSTRINGsarray_of_const:
# Temps allocated between r28+22 and r28+48
# [122] begin
	push	r29
	push	r28
	push	r4
	push	r3
	push	r2
	in	r28,61
	in	r29,62
	subi	r28,48
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var AFormat located at r28+2, size=OS_16
# Var AArgs located at r28+4, size=OS_16
# Var $highAARGS located at r28+6, size=OS_S16
# Var $self located at r28+8, size=OS_16
# Var s located at r28+10, size=OS_8
# Var p located at r28+11, size=OS_8
# Var b located at r28+12, size=OS_8
# Var e located at r28+13, size=OS_8
# Var i located at r28+14, size=OS_8
# Var c located at r28+15, size=OS_8
# Var VArg located at r28+16, size=OS_NO
	std	Y+8,r24
	std	Y+9,r25
	std	Y+2,r22
	std	Y+3,r23
	std	Y+4,r20
	std	Y+5,r21
	std	Y+6,r18
	std	Y+7,r19
# [123] if (Length(AFormat) > 1) and (Length(AArgs) > 0) then
	ldd	r18,Y+2
	ldd	r19,Y+3
	movw	r30,r18
	ld	r19,Z
	ldi	r18,1
	cp	r18,r19
	brlo	.Lj88
# [202] end;
	rjmp	.Lj52
.Lj88:
	ldd	r18,Y+6
	ldd	r19,Y+7
	ldi	r20,1
	add	r18,r20
	adc	r19,r1
	cp	r1,r18
	cpc	r1,r19
	brlt	.Lj89
	rjmp	.Lj52
.Lj89:
# [125] b := 1;
	ldi	r18,1
	std	Y+12,r18
# [126] e := Length(AFormat);
	ldd	r18,Y+2
	ldd	r19,Y+3
	movw	r30,r18
	ld	r0,Z
	std	Y+13,r0
# [127] p := 1;
	ldi	r18,1
	std	Y+11,r18
# [128] i := 0;
	std	Y+14,r1
# [129] s := [];
	std	Y+10,r1
.Lj54:
# [131] c := AFormat[p];
	ldd	r19,Y+2
	ldd	r20,Y+3
	ldd	r21,Y+11
	mov	r18,r1
	mov	r30,r19
	mov	r31,r20
	add	r30,r21
	adc	r31,r18
	ld	r0,Z
	std	Y+15,r0
# [132] if fsFind in s then
	ldd	r18,Y+10
	sbrs	r18,0
	rjmp	.Lj58
.Lj57:
# [134] VArg := AArgs[i];
	ldd	r24,Y+4
	ldd	r25,Y+5
	ldd	r19,Y+14
	mov	r18,r1
	ldi	r20,6
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
	movw	r30,r24
	add	r30,r19
	adc	r31,r18
	ld	r0,Z+
	std	Y+16,r0
	ld	r0,Z+
	std	Y+17,r0
	ld	r0,Z+
	std	Y+18,r0
	ld	r0,Z+
	std	Y+19,r0
	ld	r0,Z+
	std	Y+20,r0
	ld	r0,Z
	std	Y+21,r0
# [135] case c of
	ldd	r19,Y+15
	cpi	r19,37
	brsh	.Lj90
	rjmp	.Lj60
.Lj90:
	mov	r18,r19
	subi	r19,37
	cpi	r18,37
	breq	.Lj61
	mov	r18,r19
	subi	r19,63
	cpi	r18,63
	brne	.Lj91
	rjmp	.Lj63
.Lj91:
	mov	r18,r19
	subi	r19,12
	cpi	r18,12
	brne	.Lj92
	rjmp	.Lj64
.Lj92:
	mov	r18,r19
	subi	r19,3
	cpi	r18,3
	breq	.Lj62
	mov	r18,r19
	subi	r19,5
	cpi	r18,5
	brne	.Lj93
	rjmp	.Lj64
.Lj93:
	rjmp	.Lj60
.Lj61:
# [138] WriteBuffer('@#', 1);
	ldi	r22,lo8(_sUARTs_Ld1)
	ldi	r23,hi8(_sUARTs_Ld1)
	ldd	r24,Y+8
	ldd	r25,Y+9
	ldi	r20,1
	ldd	r18,Y+8
	ldd	r19,Y+9
	movw	r30,r18
	ldd	r18,Z+2
	ldd	r19,Z+3
	movw	r30,r18
	ldd	r18,Z+8
	ldd	r2,Z+9
	mov	r30,r18
	mov	r31,r2
	icall
	rjmp	.Lj59
.Lj62:
# [142] case VArg.VType of
	ldd	r20,Y+16
	ldd	r21,Y+17
	ldi	r19,2
	mov	r18,r1
	cp	r20,r19
	cpc	r21,r18
	brge	.Lj94
	rjmp	.Lj66
.Lj94:
	mov	r19,r20
	mov	r22,r21
	subi	r20,2
	sbc	r21,r1
	ldi	r23,2
	mov	r18,r1
	cp	r19,r23
	cpc	r22,r18
	brne	.Lj95
	rjmp	.Lj70
.Lj95:
	mov	r19,r20
	mov	r22,r21
	subi	r20,2
	sbc	r21,r1
	ldi	r23,2
	mov	r18,r1
	cp	r19,r23
	cpc	r22,r18
	breq	.Lj67
	mov	r19,r20
	mov	r22,r21
	subi	r20,2
	sbc	r21,r1
	ldi	r23,2
	mov	r18,r1
	cp	r19,r23
	cpc	r22,r18
	brne	.Lj96
	rjmp	.Lj69
.Lj96:
	mov	r19,r20
	mov	r22,r21
	subi	r20,5
	sbc	r21,r1
	ldi	r20,5
	mov	r18,r1
	cp	r19,r20
	cpc	r22,r18
	breq	.Lj68
	rjmp	.Lj66
.Lj67:
# [144] WriteBuffer(@VArg.VString^[1], Byte(VArg.VString^[0]));
	ldd	r18,Y+18
	ldd	r19,Y+19
	ldi	r22,lo8(1)
	ldi	r23,hi8(1)
	add	r22,r18
	adc	r23,r19
	ldd	r18,Y+18
	ldd	r19,Y+19
	movw	r30,r18
	ld	r20,Z
	ldd	r24,Y+8
	ldd	r25,Y+9
	ldd	r18,Y+8
	ldd	r19,Y+9
	movw	r30,r18
	ldd	r18,Z+2
	ldd	r19,Z+3
	movw	r30,r18
	ldd	r18,Z+8
	ldd	r2,Z+9
	mov	r30,r18
	mov	r31,r2
	icall
	rjmp	.Lj65
.Lj68:
# [146] WriteBuffer(VArg.VPChar, StrLen(VArg.VPChar));
	ldd	r24,Y+18
	ldd	r25,Y+19
	call	FPC_PCHAR_LENGTH
	mov	r20,r24
	ldd	r22,Y+18
	ldd	r23,Y+19
	ldd	r24,Y+8
	ldd	r25,Y+9
	ldd	r18,Y+8
	ldd	r19,Y+9
	movw	r30,r18
	ldd	r18,Z+2
	ldd	r19,Z+3
	movw	r30,r18
	ldd	r18,Z+8
	ldd	r2,Z+9
	mov	r30,r18
	mov	r31,r2
	icall
	rjmp	.Lj65
.Lj69:
# [148] WriteBuffer(VArg.VPChar, StrLen(VArg.VPChar));
	ldd	r24,Y+18
	ldd	r25,Y+19
	call	FPC_PCHAR_LENGTH
	mov	r20,r24
	ldd	r22,Y+18
	ldd	r23,Y+19
	ldd	r24,Y+8
	ldd	r25,Y+9
	ldd	r18,Y+8
	ldd	r19,Y+9
	movw	r30,r18
	ldd	r18,Z+2
	ldd	r19,Z+3
	movw	r30,r18
	ldd	r18,Z+8
	ldd	r2,Z+9
	mov	r30,r18
	mov	r31,r2
	icall
	rjmp	.Lj65
.Lj70:
# [150] WriteBuffer(@VArg.VChar, 1);
	ldi	r22,lo8(18)
	ldi	r23,hi8(18)
	add	r22,r28
	adc	r23,r29
	ldd	r24,Y+8
	ldd	r25,Y+9
	ldi	r20,1
	ldd	r18,Y+8
	ldd	r19,Y+9
	movw	r30,r18
	ldd	r18,Z+2
	ldd	r19,Z+3
	movw	r30,r18
	ldd	r18,Z+8
	ldd	r2,Z+9
	mov	r30,r18
	mov	r31,r2
	icall
	rjmp	.Lj65
.Lj66:
# [152] WriteBuffer('?', 1)
	ldi	r22,lo8(.Ld2)
	ldi	r23,hi8(.Ld2)
	ldd	r24,Y+8
	ldd	r25,Y+9
	ldi	r20,1
	ldd	r18,Y+8
	ldd	r19,Y+9
	movw	r30,r18
	ldd	r18,Z+2
	ldd	r19,Z+3
	movw	r30,r18
	ldd	r18,Z+8
	ldd	r2,Z+9
	mov	r30,r18
	mov	r31,r2
	icall
.Lj65:
# [154] Inc(i);
	ldd	r18,Y+14
	inc	r18
	std	Y+14,r18
	rjmp	.Lj59
.Lj63:
# [158] if VArg.VType = vtInteger then
	ldd	r18,Y+16
	ldd	r19,Y+17
	cp	r18,r1
	cpc	r19,r1
	breq	.Lj97
	rjmp	.Lj72
.Lj97:
# [159] with IntToStr(VArg.VInteger) do
	ldd	r20,Y+18
	ldd	r21,Y+19
	ldd	r22,Y+20
	ldd	r23,Y+21
	ldi	r24,lo8(35)
	ldi	r25,hi8(35)
	add	r24,r28
	adc	r25,r29
	call	ARDUINOTOOLS_ss_INTTOSTRsLONGINTssTINTSTR
	ldd	r0,Y+35
	std	Y+22,r0
	ldd	r0,Y+36
	std	Y+23,r0
	ldd	r0,Y+37
	std	Y+24,r0
	ldd	r0,Y+38
	std	Y+25,r0
	ldd	r0,Y+39
	std	Y+26,r0
	ldd	r0,Y+40
	std	Y+27,r0
	ldd	r0,Y+41
	std	Y+28,r0
	ldd	r0,Y+42
	std	Y+29,r0
	ldd	r0,Y+43
	std	Y+30,r0
	ldd	r0,Y+44
	std	Y+31,r0
	ldd	r0,Y+45
	std	Y+32,r0
	ldd	r0,Y+46
	std	Y+33,r0
	ldd	r0,Y+47
	std	Y+34,r0
	ldi	r19,lo8(22)
	ldi	r18,hi8(22)
	add	r19,r28
	adc	r18,r29
	mov	r3,r19
	mov	r2,r18
# [160] WriteBuffer(@Str[1], Length)
	mov	r22,r3
	mov	r23,r2
	mov	r30,r3
	mov	r31,r2
	ldd	r20,Z+11
	ldd	r24,Y+8
	ldd	r25,Y+9
	ldd	r18,Y+8
	ldd	r19,Y+9
	movw	r30,r18
	ldd	r18,Z+2
	ldd	r19,Z+3
	movw	r30,r18
	ldd	r18,Z+8
	ldd	r4,Z+9
	mov	r30,r18
	mov	r31,r4
	icall
	rjmp	.Lj73
.Lj72:
# [164] WriteBuffer('?', 1);
	ldi	r22,lo8(.Ld2)
	ldi	r23,hi8(.Ld2)
	ldd	r24,Y+8
	ldd	r25,Y+9
	ldi	r20,1
	ldd	r18,Y+8
	ldd	r19,Y+9
	movw	r30,r18
	ldd	r18,Z+2
	ldd	r19,Z+3
	movw	r30,r18
	ldd	r18,Z+8
	ldd	r2,Z+9
	mov	r30,r18
	mov	r31,r2
	icall
.Lj73:
# [165] Inc(i);
	ldd	r18,Y+14
	inc	r18
	std	Y+14,r18
	rjmp	.Lj59
.Lj64:
# [169] if VArg.VType = vtInteger then
	ldd	r19,Y+16
	ldd	r18,Y+17
	cp	r19,r1
	cpc	r18,r1
	breq	.Lj98
	rjmp	.Lj75
.Lj98:
# [170] with IntToHex(VArg.VInteger, 8) do
	ldd	r20,Y+18
	ldd	r21,Y+19
	ldd	r22,Y+20
	ldd	r23,Y+21
	ldi	r24,lo8(35)
	ldi	r25,hi8(35)
	add	r24,r28
	adc	r25,r29
	ldi	r26,8
	mov	r18,r26
	call	ARDUINOTOOLS_ss_INTTOHEXsLONGINTsBYTEssTINTSTR
	ldd	r0,Y+35
	std	Y+22,r0
	ldd	r0,Y+36
	std	Y+23,r0
	ldd	r0,Y+37
	std	Y+24,r0
	ldd	r0,Y+38
	std	Y+25,r0
	ldd	r0,Y+39
	std	Y+26,r0
	ldd	r0,Y+40
	std	Y+27,r0
	ldd	r0,Y+41
	std	Y+28,r0
	ldd	r0,Y+42
	std	Y+29,r0
	ldd	r0,Y+43
	std	Y+30,r0
	ldd	r0,Y+44
	std	Y+31,r0
	ldd	r0,Y+45
	std	Y+32,r0
	ldd	r0,Y+46
	std	Y+33,r0
	ldd	r0,Y+47
	std	Y+34,r0
	ldi	r19,lo8(22)
	ldi	r18,hi8(22)
	add	r19,r28
	adc	r18,r29
	mov	r3,r19
	mov	r2,r18
# [171] WriteBuffer(@Str[1], Length)
	mov	r22,r3
	mov	r23,r2
	mov	r30,r3
	mov	r31,r2
	ldd	r20,Z+11
	ldd	r24,Y+8
	ldd	r25,Y+9
	ldd	r18,Y+8
	ldd	r19,Y+9
	movw	r30,r18
	ldd	r18,Z+2
	ldd	r19,Z+3
	movw	r30,r18
	ldd	r18,Z+8
	ldd	r4,Z+9
	mov	r30,r18
	mov	r31,r4
	icall
	rjmp	.Lj76
.Lj75:
# [173] if VArg.VType in [vtInteger, vtPointer] then
	ldd	r19,Y+16
	cp	r19,r1
	breq	.Lj77
	cpi	r19,5
	breq	.Lj99
	rjmp	.Lj78
.Lj99:
.Lj77:
# [174] with IntToHex(VArg.VPointer) do
	ldd	r22,Y+18
	ldd	r23,Y+19
	ldi	r24,lo8(35)
	ldi	r25,hi8(35)
	add	r24,r28
	adc	r25,r29
	call	ARDUINOTOOLS_ss_INTTOHEXsPOINTERssTINTSTR
	ldd	r0,Y+35
	std	Y+22,r0
	ldd	r0,Y+36
	std	Y+23,r0
	ldd	r0,Y+37
	std	Y+24,r0
	ldd	r0,Y+38
	std	Y+25,r0
	ldd	r0,Y+39
	std	Y+26,r0
	ldd	r0,Y+40
	std	Y+27,r0
	ldd	r0,Y+41
	std	Y+28,r0
	ldd	r0,Y+42
	std	Y+29,r0
	ldd	r0,Y+43
	std	Y+30,r0
	ldd	r0,Y+44
	std	Y+31,r0
	ldd	r0,Y+45
	std	Y+32,r0
	ldd	r0,Y+46
	std	Y+33,r0
	ldd	r0,Y+47
	std	Y+34,r0
	ldi	r18,lo8(22)
	ldi	r19,hi8(22)
	add	r18,r28
	adc	r19,r29
	movw	r2,r18
# [175] WriteBuffer(@Str[1], Length)
	movw	r22,r2
	movw	r30,r2
	ldd	r20,Z+11
	ldd	r24,Y+8
	ldd	r25,Y+9
	ldd	r18,Y+8
	ldd	r19,Y+9
	movw	r30,r18
	ldd	r18,Z+2
	ldd	r19,Z+3
	movw	r30,r18
	ldd	r18,Z+8
	ldd	r4,Z+9
	mov	r30,r18
	mov	r31,r4
	icall
	rjmp	.Lj76
.Lj78:
# [177] WriteBuffer('?', 1);
	ldi	r22,lo8(.Ld2)
	ldi	r23,hi8(.Ld2)
	ldd	r24,Y+8
	ldd	r25,Y+9
	ldi	r20,1
	ldd	r18,Y+8
	ldd	r19,Y+9
	movw	r30,r18
	ldd	r18,Z+2
	ldd	r19,Z+3
	movw	r30,r18
	ldd	r18,Z+8
	ldd	r2,Z+9
	mov	r30,r18
	mov	r31,r2
	icall
.Lj76:
# [178] Inc(i);
	ldd	r18,Y+14
	inc	r18
	std	Y+14,r18
	rjmp	.Lj59
.Lj60:
# [182] WriteBuffer('?', 1);
	ldi	r22,lo8(.Ld2)
	ldi	r23,hi8(.Ld2)
	ldd	r24,Y+8
	ldd	r25,Y+9
	ldi	r20,1
	ldd	r18,Y+8
	ldd	r19,Y+9
	movw	r30,r18
	ldd	r18,Z+2
	ldd	r19,Z+3
	movw	r30,r18
	ldd	r18,Z+8
	ldd	r2,Z+9
	mov	r30,r18
	mov	r31,r2
	icall
.Lj59:
# [185] b := p + 1;
	ldd	r18,Y+11
	inc	r18
	std	Y+12,r18
# [186] s := [];
	std	Y+10,r1
	rjmp	.Lj80
.Lj58:
# [189] if c = '%' then
	ldd	r18,Y+15
	cpi	r18,37
	brne	.Lj80
# [191] if p > b then
	ldd	r18,Y+11
	ldd	r19,Y+12
	cp	r19,r18
	brsh	.Lj84
# [192] WriteBuffer(@AFormat[b], p - b);
	ldd	r22,Y+2
	ldd	r23,Y+3
	ldd	r19,Y+12
	mov	r18,r1
	add	r22,r19
	adc	r23,r18
	ldd	r20,Y+11
	ldd	r18,Y+12
	sub	r20,r18
	ldd	r24,Y+8
	ldd	r25,Y+9
	ldd	r18,Y+8
	ldd	r19,Y+9
	movw	r30,r18
	ldd	r18,Z+2
	ldd	r19,Z+3
	movw	r30,r18
	ldd	r18,Z+8
	ldd	r2,Z+9
	mov	r30,r18
	mov	r31,r2
	icall
.Lj84:
# [193] s := [fsFind];
	ldi	r18,1
	std	Y+10,r18
.Lj80:
# [195] Inc(p);
	ldd	r18,Y+11
	inc	r18
	std	Y+11,r18
# [196] until p > e;
	ldd	r19,Y+11
	ldd	r18,Y+13
	cp	r18,r19
	brlo	.Lj100
	rjmp	.Lj54
.Lj100:
# [197] if p > b then
	ldd	r18,Y+11
	ldd	r19,Y+12
	cp	r19,r18
	brlo	.Lj101
	rjmp	.Lj87
.Lj101:
# [198] WriteBuffer(@AFormat[b], p - b);
	ldd	r22,Y+2
	ldd	r23,Y+3
	ldd	r19,Y+12
	mov	r18,r1
	add	r22,r19
	adc	r23,r18
	ldd	r20,Y+11
	ldd	r18,Y+12
	sub	r20,r18
	ldd	r24,Y+8
	ldd	r25,Y+9
	ldd	r18,Y+8
	ldd	r19,Y+9
	movw	r30,r18
	ldd	r18,Z+2
	ldd	r19,Z+3
	movw	r30,r18
	ldd	r18,Z+8
	ldd	r2,Z+9
	mov	r30,r18
	mov	r31,r2
	icall
	rjmp	.Lj87
.Lj52:
# [201] WriteBuffer(@AFormat[1], Length(AFormat));
	ldd	r18,Y+2
	ldd	r19,Y+3
	ldi	r22,lo8(1)
	ldi	r23,hi8(1)
	add	r22,r18
	adc	r23,r19
	ldd	r18,Y+2
	ldd	r19,Y+3
	movw	r30,r18
	ld	r20,Z
	ldd	r24,Y+8
	ldd	r25,Y+9
	ldd	r18,Y+8
	ldd	r19,Y+9
	movw	r30,r18
	ldd	r18,Z+2
	ldd	r19,Z+3
	movw	r30,r18
	ldd	r18,Z+8
	ldd	r2,Z+9
	mov	r30,r18
	mov	r31,r2
	icall
.Lj87:
	subi	r28,-48
	sbci	r29,-1
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
	pop	r2
	pop	r3
	pop	r4
	pop	r28
	pop	r29
	ret
.Le8:
	.size	UARTs_sTUART_s__ss_WRITEFORMATsSHORTSTRINGsarray_of_const, .Le8 - UARTs_sTUART_s__ss_WRITEFORMATsSHORTSTRINGsarray_of_const

.section .text.n_uarts_stuart_s__ss_writelnstringspchar,"ax"
.globl	UARTs_sTUART_s__ss_WRITELNSTRINGsPCHAR
UARTs_sTUART_s__ss_WRITELNSTRINGsPCHAR:
# [205] begin
	push	r29
	push	r28
	push	r2
	in	r28,61
	in	r29,62
	subi	r28,6
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var AValue located at r28+2, size=OS_16
# Var $self located at r28+4, size=OS_16
	std	Y+4,r24
	std	Y+5,r25
	std	Y+2,r22
	std	Y+3,r23
# [206] WriteBuffer(AValue, Length(AValue));
	ldd	r18,Y+2
	ldd	r25,Y+3
	mov	r24,r18
	call	fpc_pchar_length
	mov	r20,r24
	ldd	r24,Y+4
	ldd	r25,Y+5
	ldd	r22,Y+2
	ldd	r23,Y+3
	ldd	r19,Y+4
	ldd	r18,Y+5
	mov	r30,r19
	mov	r31,r18
	ldd	r18,Z+2
	ldd	r19,Z+3
	movw	r30,r18
	ldd	r18,Z+8
	ldd	r2,Z+9
	mov	r30,r18
	mov	r31,r2
	icall
# [207] WriteBuffer(#10#13, 2);
	ldi	r22,lo8(_sUARTs_Ld3)
	ldi	r23,hi8(_sUARTs_Ld3)
	ldd	r24,Y+4
	ldd	r25,Y+5
	ldi	r20,2
	ldd	r19,Y+4
	ldd	r18,Y+5
	mov	r30,r19
	mov	r31,r18
	ldd	r18,Z+2
	ldd	r19,Z+3
	movw	r30,r18
	ldd	r18,Z+8
	ldd	r2,Z+9
	mov	r30,r18
	mov	r31,r2
	icall
# [208] end;
	subi	r28,-6
	sbci	r29,-1
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
	pop	r2
	pop	r28
	pop	r29
	ret
.Le9:
	.size	UARTs_sTUART_s__ss_WRITELNSTRINGsPCHAR, .Le9 - UARTs_sTUART_s__ss_WRITELNSTRINGsPCHAR

.section .text.n_uarts_stuart_s__ss_writelnformatsshortstringsarray_of_const,"ax"
.globl	UARTs_sTUART_s__ss_WRITELNFORMATsSHORTSTRINGsarray_of_const
UARTs_sTUART_s__ss_WRITELNFORMATsSHORTSTRINGsarray_of_const:
# [211] begin
	push	r29
	push	r28
	push	r2
	in	r28,61
	in	r29,62
	subi	r28,10
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var AFormat located at r28+2, size=OS_16
# Var AArgs located at r28+4, size=OS_16
# Var $highAARGS located at r28+6, size=OS_S16
# Var $self located at r28+8, size=OS_16
	std	Y+8,r24
	std	Y+9,r25
	std	Y+2,r22
	std	Y+3,r23
	std	Y+4,r20
	std	Y+5,r21
	std	Y+6,r18
	std	Y+7,r19
# [212] WriteFormat(AFormat, AArgs);
	ldd	r18,Y+4
	ldd	r21,Y+5
	mov	r20,r18
	ldd	r22,Y+2
	ldd	r23,Y+3
	ldd	r24,Y+8
	ldd	r25,Y+9
	ldd	r18,Y+6
	ldd	r19,Y+7
	call	UARTs_sTUART_s__ss_WRITEFORMATsSHORTSTRINGsarray_of_const
# [213] WriteBuffer(#10#13, 2);
	ldi	r22,lo8(_sUARTs_Ld3)
	ldi	r23,hi8(_sUARTs_Ld3)
	ldd	r24,Y+8
	ldd	r25,Y+9
	ldi	r20,2
	ldd	r19,Y+8
	ldd	r18,Y+9
	mov	r30,r19
	mov	r31,r18
	ldd	r18,Z+2
	ldd	r19,Z+3
	movw	r30,r18
	ldd	r18,Z+8
	ldd	r2,Z+9
	mov	r30,r18
	mov	r31,r2
	icall
# [214] end;
	subi	r28,-10
	sbci	r29,-1
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
	pop	r2
	pop	r28
	pop	r29
	ret
.Le10:
	.size	UARTs_sTUART_s__ss_WRITELNFORMATsSHORTSTRINGsarray_of_const, .Le10 - UARTs_sTUART_s__ss_WRITELNFORMATsSHORTSTRINGsarray_of_const

.section .text.n_uarts_stuart_s__ss_readbytessbyte,"ax"
.globl	UARTs_sTUART_s__ss_READBYTEssBYTE
UARTs_sTUART_s__ss_READBYTEssBYTE:
# [217] begin
	push	r29
	push	r28
	push	r2
	in	r28,61
	in	r29,62
	subi	r28,5
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var $self located at r28+2, size=OS_16
# Var $result located at r28+4, size=OS_8
	std	Y+2,r24
	std	Y+3,r25
# [218] ReadBuffer(@Result, 1);
	ldi	r18,lo8(4)
	ldi	r23,hi8(4)
	add	r18,r28
	adc	r23,r29
	mov	r22,r18
	ldd	r24,Y+2
	ldd	r25,Y+3
	ldi	r20,1
	ldd	r19,Y+2
	ldd	r18,Y+3
	mov	r30,r19
	mov	r31,r18
	ldd	r18,Z+2
	ldd	r19,Z+3
	movw	r30,r18
	ldd	r18,Z+10
	ldd	r2,Z+11
	mov	r30,r18
	mov	r31,r2
	icall
# [219] end;
	ldd	r24,Y+4
	subi	r28,-5
	sbci	r29,-1
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
	pop	r2
	pop	r28
	pop	r29
	ret
.Le11:
	.size	UARTs_sTUART_s__ss_READBYTEssBYTE, .Le11 - UARTs_sTUART_s__ss_READBYTEssBYTE

.section .text.n_uarts_stuart_s__ss_readcharsschar,"ax"
.globl	UARTs_sTUART_s__ss_READCHARssCHAR
UARTs_sTUART_s__ss_READCHARssCHAR:
# [222] begin
	push	r29
	push	r28
	in	r28,61
	in	r29,62
	subi	r28,5
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var $self located at r28+2, size=OS_16
# Var $result located at r28+4, size=OS_8
	std	Y+2,r24
	std	Y+3,r25
# [223] Result := Char(ReadByte);
	ldd	r18,Y+2
	ldd	r25,Y+3
	mov	r24,r18
	call	UARTs_sTUART_s__ss_READBYTEssBYTE
	std	Y+4,r24
# [224] end;
	ldd	r24,Y+4
	subi	r28,-5
	sbci	r29,-1
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
	pop	r28
	pop	r29
	ret
.Le12:
	.size	UARTs_sTUART_s__ss_READCHARssCHAR, .Le12 - UARTs_sTUART_s__ss_READCHARssCHAR
# End asmlist al_procedures
# Begin asmlist al_globals

.section .bss.n_u_suart_ss_uartconsole,"aw",%nobits
# [39] UARTConsole: TUART;
	.globl U_sUART_ss_UARTCONSOLE
	.size U_sUART_ss_UARTCONSOLE,4
U_sUART_ss_UARTCONSOLE:
	.zero 4

.section .data.n_VMT_sUART_ss_TUART
	.balign 2
.globl	VMT_sUART_ss_TUART
VMT_sUART_ss_TUART:
	.short	4,65532,0
	.short	gs(UARTs_sTUART_s__ss_GETREADBUFFEREMPTYssBOOLEAN)
	.short	gs(UARTs_sTUART_s__ss_WRITEBUFFERsPCHARsBYTE)
	.short	gs(UARTs_sTUART_s__ss_READBUFFERsPCHARsBYTE)
	.short	gs(0)
# [226] end.
.Le13:
	.size	VMT_sUART_ss_TUART, .Le13 - VMT_sUART_ss_TUART
# End asmlist al_globals
# Begin asmlist al_typedconsts

.section .rodata.n__sUARTs_Ld1
.globl	_sUARTs_Ld1
_sUARTs_Ld1:
	.ascii	"@#\000"
.Le14:
	.size	_sUARTs_Ld1, .Le14 - _sUARTs_Ld1

.section .rodata.n_.Ld2
.Ld2sstrlab:
	.short	0,1,-1,1
.Ld2:
	.ascii	"?\000"
.Le15:
	.size	.Ld2sstrlab, .Le15 - .Ld2sstrlab

.section .rodata.n__sUARTs_Ld3
.globl	_sUARTs_Ld3
_sUARTs_Ld3:
	.ascii	"\012\015\000"
.Le16:
	.size	_sUARTs_Ld3, .Le16 - _sUARTs_Ld3
# End asmlist al_typedconsts
# Begin asmlist al_rtti

.section .data.n_INIT_sUART_ss_TUART
.globl	INIT_sUART_ss_TUART
INIT_sUART_ss_TUART:
	.byte	16,5
# [227] 
	.ascii	"TUART"
	.short	0,0
	.long	4
	.short	0,0
	.long	0
.Le17:
	.size	INIT_sUART_ss_TUART, .Le17 - INIT_sUART_ss_TUART

.section .data.n_RTTI_sUART_ss_TUART
.globl	RTTI_sUART_ss_TUART
RTTI_sUART_ss_TUART:
	.byte	16,5
	.ascii	"TUART"
	.short	0
	.short	INIT_sUART_ss_TUART
	.long	4,3
	.short	RTTI_sSYSTEM_ss_BYTEsindirect
	.short	0
	.short	RTTI_sSYSTEM_ss_BYTEsindirect
	.short	1
	.short	RTTI_sSYSTEM_ss_POINTERsindirect
	.short	2
.Le18:
	.size	RTTI_sUART_ss_TUART, .Le18 - RTTI_sUART_ss_TUART
# End asmlist al_rtti
# Begin asmlist al_indirectglobals

.section .data.n_VMT_sUART_ss_TUART
	.balign 2
.globl	VMT_sUART_ss_TUARTsindirect
VMT_sUART_ss_TUARTsindirect:
	.short	VMT_sUART_ss_TUART
.Le19:
	.size	VMT_sUART_ss_TUARTsindirect, .Le19 - VMT_sUART_ss_TUARTsindirect

.section .data.n_INIT_sUART_ss_TUART
	.balign 2
.globl	INIT_sUART_ss_TUARTsindirect
INIT_sUART_ss_TUARTsindirect:
	.short	INIT_sUART_ss_TUART
.Le20:
	.size	INIT_sUART_ss_TUARTsindirect, .Le20 - INIT_sUART_ss_TUARTsindirect

.section .data.n_RTTI_sUART_ss_TUART
	.balign 2
.globl	RTTI_sUART_ss_TUARTsindirect
RTTI_sUART_ss_TUARTsindirect:
	.short	RTTI_sUART_ss_TUART
.Le21:
	.size	RTTI_sUART_ss_TUARTsindirect, .Le21 - RTTI_sUART_ss_TUARTsindirect
# End asmlist al_indirectglobals

