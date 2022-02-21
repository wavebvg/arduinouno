	.file "IRReceiver.pas"
# Begin asmlist al_pure_assembler

.section .text.n_irreceivers_stirreceiver_s_readsstirvalue_ss_reset1,"ax"
IRRECEIVERs_sTIRRECEIVER_s_READssTIRVALUE_ss_RESET1:
# [IRReceiver.pas]
# [320] asm
#  CPU AVR5
# [321] PUSH    R18
	push	r18
# [323] STD     VValue, R1
	std	Y+11,r1
# [325] LDI     R18,1
	ldi	r18,1
# [326] STD     VValueMask, R18
	std	Y+12,r18
# [328] STD     VInSpace, R1
	std	Y+9,r1
# [330] STD     VTime, R1
	std	Y+13,r1
# [331] STD     VTime + 1, R1
	std	Y+14,r1
# [333] STD     VDataTime, R1
	std	Y+15,r1
# [334] STD     VDataTime + 1, R1
	std	Y+16,r1
# [336] STD     VStage, R1
	std	Y+10,r1
# [338] STD     Result, R1
	std	Y+4,r1
# [339] STD     Result + 1, R1
	std	Y+5,r1
# [341] IN      R18,38
	in	r18,38
# [342] STD     VLastCounter, R18
	std	Y+6,r18
# [343] POP     R18
	pop	r18
#  CPU AVR5
# [344] end;
	ret
.Le0:
	.size	IRRECEIVERs_sTIRRECEIVER_s_READssTIRVALUE_ss_RESET1, .Le0 - IRRECEIVERs_sTIRRECEIVER_s_READssTIRVALUE_ss_RESET1
# End asmlist al_pure_assembler
# Begin asmlist al_procedures

.section .text.n_irreceivers_stirreceiver_s__ss_initsbytesslongbool,"ax"
.globl	IRRECEIVERs_sTIRRECEIVER_s__ss_INITsBYTEssLONGBOOL
IRRECEIVERs_sTIRRECEIVER_s__ss_INITsBYTEssLONGBOOL:
# Temps allocated between r28+9 and r28+70
# [60] begin
	push	r29
	push	r28
	push	r2
	in	r28,61
	in	r29,62
	subi	r28,70
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var APin located at r28+2, size=OS_8
# Var $vmt located at r28+3, size=OS_16
# Var $self located at r28+5, size=OS_16
# Var $_zero_$IRRECEIVER_$$_TIRVALUE located at r28+7, size=OS_16
	std	Y+5,r24
	std	Y+6,r25
	std	Y+3,r22
	std	Y+4,r23
	std	Y+2,r20
	ldi	r18,lo8(3)
	ldi	r23,hi8(3)
	add	r18,r28
	adc	r23,r29
	mov	r22,r18
	ldd	r24,Y+5
	ldd	r25,Y+6
	ldi	r18,2
	mov	r19,r1
	mov	r20,r1
	mov	r21,r1
	call	fpc_help_constructor
	std	Y+5,r24
	std	Y+6,r25
	ldd	r18,Y+5
	ldd	r19,Y+6
	cp	r18,r1
	cpc	r19,r1
	brne	.Lj16
# [63] end;
	rjmp	.Lj3
.Lj16:
	ldi	r20,lo8(9)
	ldi	r21,hi8(9)
	add	r20,r28
	adc	r21,r29
	ldi	r22,lo8(15)
	ldi	r23,hi8(15)
	add	r22,r28
	adc	r23,r29
	ldi	r24,1
	mov	r25,r1
	call	fpc_pushexceptaddr
	call	fpc_setjmp
	std	Y+38,r24
	cp	r24,r1
	brne	.Lj11
	ldi	r18,lo8(7)
	ldi	r19,hi8(7)
	add	r18,r28
	adc	r19,r29
	std	Y+40,r19
	std	Y+39,r18
	ldd	r24,Y+39
	ldd	r25,Y+40
	mov	r20,r1
	ldi	r22,2
	mov	r23,r1
	call	SYSTEM_ss_FILLCHARsformalsSMALLINTsBYTE
# [61] inherited;
	ldd	r24,Y+5
	ldd	r25,Y+6
	ldd	r20,Y+2
	mov	r22,r1
	mov	r23,r1
	call	ARDUINOTOOLSs_sTCUSTOMPININPUT_s__ss_INITsBYTEssLONGBOOL
# [62] FLastValue := Default(TIRValue);
	ldd	r18,Y+5
	ldd	r19,Y+6
	movw	r30,r18
	adiw	r30,4
	ldd	r0,Y+7
	st	Z+,r0
	ldd	r0,Y+8
	st	Z,r0
.Lj11:
	call	fpc_popaddrstack
	ldd	r18,Y+38
	cp	r18,r1
	brne	.Lj17
	rjmp	.Lj9
.Lj17:
	ldi	r20,lo8(41)
	ldi	r21,hi8(41)
	add	r20,r28
	adc	r21,r29
	ldi	r22,lo8(47)
	ldi	r23,hi8(47)
	add	r22,r28
	adc	r23,r29
	ldi	r24,1
	mov	r25,r1
	call	fpc_pushexceptaddr
	call	fpc_setjmp
	std	Y+39,r24
	cp	r24,r1
	brne	.Lj12
	ldd	r19,Y+3
	ldd	r18,Y+4
	cp	r19,r1
	cpc	r18,r1
	breq	.Lj14
	ldd	r22,Y+3
	ldd	r23,Y+4
	ldd	r24,Y+5
	ldd	r25,Y+6
	ldd	r18,Y+5
	ldd	r19,Y+6
	movw	r30,r18
	ldd	r18,Z+2
	ldd	r19,Z+3
	movw	r30,r18
	ldd	r18,Z+6
	ldd	r2,Z+7
	mov	r30,r18
	mov	r31,r2
	icall
.Lj14:
	call	fpc_popaddrstack
	call	fpc_reraise
.Lj12:
	call	fpc_popaddrstack
	ldd	r18,Y+39
	cp	r18,r1
	breq	.Lj15
	call	fpc_raise_nested
.Lj15:
	call	fpc_doneexception
.Lj9:
.Lj3:
	ldd	r24,Y+5
	ldd	r25,Y+6
	subi	r28,-70
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
.Le1:
	.size	IRRECEIVERs_sTIRRECEIVER_s__ss_INITsBYTEssLONGBOOL, .Le1 - IRRECEIVERs_sTIRRECEIVER_s__ss_INITsBYTEssLONGBOOL

.section .text.n_irreceiver_ss_calcevent1swordswordsstirevent,"ax"
IRRECEIVER_ss_CALCEVENT1sWORDsWORDssTIREVENT:
# [66] begin
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
# Var ADataTime located at r28+2, size=OS_16
# Var ASpaceTime located at r28+4, size=OS_16
# Var $result located at r28+6, size=OS_8
	std	Y+2,r24
	std	Y+3,r25
	std	Y+4,r22
	std	Y+5,r23
# [67] if ADataTime < IR_VALUE_DATA_TIME_MIN then
	ldd	r18,Y+2
	ldd	r19,Y+3
	cpi	r18,-100
	ldi	r18,1
	cpc	r19,r18
	brsh	.Lj21
# [69] Result := ireUndefined;
	std	Y+6,r1
	rjmp	.Lj22
.Lj21:
# [72] if ADataTime < IR_VALUE_DATA_TIME_MAX then
	ldd	r18,Y+2
	ldd	r19,Y+3
	cpi	r18,-56
	ldi	r18,2
	cpc	r19,r18
	brlo	.Lj56
# [114] end;
	rjmp	.Lj24
.Lj56:
# [74] if ASpaceTime < IR_SPACE0_DATA_TIME_MIN then
	ldd	r18,Y+4
	ldd	r19,Y+5
	cpi	r18,-100
	ldi	r18,1
	cpc	r19,r18
	brsh	.Lj26
# [75] Result := ireUndefined
	std	Y+6,r1
	rjmp	.Lj37
.Lj26:
# [77] if ASpaceTime < IR_SPACE0_DATA_TIME_MAX then
	ldd	r18,Y+4
	ldd	r19,Y+5
	cpi	r18,-56
	ldi	r18,2
	cpc	r19,r18
	brsh	.Lj29
# [78] Result := ireData0
	ldi	r18,2
	std	Y+6,r18
	rjmp	.Lj37
.Lj29:
# [80] if ASpaceTime < IR_SPACE1_DATA_TIME_MIN then
	ldd	r18,Y+4
	ldd	r19,Y+5
	cpi	r18,-43
	ldi	r18,4
	cpc	r19,r18
	brsh	.Lj32
# [81] Result := ireUndefined
	std	Y+6,r1
	rjmp	.Lj37
.Lj32:
# [83] if ASpaceTime < IR_SPACE1_DATA_TIME_MAX then
	ldd	r18,Y+4
	ldd	r19,Y+5
	cpi	r18,89
	ldi	r18,8
	cpc	r19,r18
	brsh	.Lj35
# [84] Result := ireData1
	ldi	r18,3
	std	Y+6,r18
	rjmp	.Lj37
.Lj35:
# [86] Result := ireUndefined;
	std	Y+6,r1
	rjmp	.Lj22
.Lj24:
# [89] if ADataTime < IR_META_DATA_TIME_MIN then
	ldd	r18,Y+2
	ldd	r19,Y+3
	cpi	r18,-56
	ldi	r18,25
	cpc	r19,r18
	brsh	.Lj39
# [91] Result := ireUndefined;
	std	Y+6,r1
	rjmp	.Lj22
.Lj39:
# [94] if ADataTime < IR_META_DATA_TIME_MAX then
	ldd	r18,Y+2
	ldd	r19,Y+3
	cpi	r18,-120
	ldi	r18,44
	cpc	r19,r18
	brlo	.Lj57
	rjmp	.Lj42
.Lj57:
# [96] if ASpaceTime < IR_REPEAT_SPACE_TIME_MIN then
	ldd	r18,Y+4
	ldd	r19,Y+5
	cpi	r18,114
	ldi	r18,6
	cpc	r19,r18
	brsh	.Lj44
# [97] Result := ireUndefined
	std	Y+6,r1
	rjmp	.Lj55
.Lj44:
# [99] if ASpaceTime < IR_REPEAT_SPACE_TIME_MAX then
	ldd	r18,Y+4
	ldd	r19,Y+5
	cpi	r18,34
	ldi	r18,11
	cpc	r19,r18
	brsh	.Lj47
# [100] Result := ireRepeat
	ldi	r18,4
	std	Y+6,r18
	rjmp	.Lj55
.Lj47:
# [102] if ASpaceTime < IR_PREAMBULE_SPACE_TIME_MIN then
	ldd	r18,Y+4
	ldd	r19,Y+5
	cpi	r18,-28
	ldi	r18,12
	cpc	r19,r18
	brsh	.Lj50
# [103] Result := ireUndefined
	std	Y+6,r1
	rjmp	.Lj55
.Lj50:
# [105] if ASpaceTime < IR_PREAMBULE_SPACE_TIME_MAX then
	ldd	r18,Y+4
	ldd	r19,Y+5
	cpi	r18,68
	ldi	r18,22
	cpc	r19,r18
	brsh	.Lj53
# [106] Result := irePreamble
	ldi	r18,1
	std	Y+6,r18
	rjmp	.Lj55
.Lj53:
# [108] Result := ireUndefined;
	std	Y+6,r1
	rjmp	.Lj22
.Lj42:
# [112] Result := ireUndefined;
	std	Y+6,r1
.Lj55:
.Lj37:
.Lj22:
	ldd	r24,Y+6
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
.Le2:
	.size	IRRECEIVER_ss_CALCEVENT1sWORDsWORDssTIREVENT, .Le2 - IRRECEIVER_ss_CALCEVENT1sWORDsWORDssTIREVENT

.section .text.n_irreceivers_stirreceiver_s__ss_readsstirvalue,"ax"
.globl	IRRECEIVERs_sTIRRECEIVER_s__ss_READssTIRVALUE
IRRECEIVERs_sTIRRECEIVER_s__ss_READssTIRVALUE:
# Temps allocated between r28+18 and r28+36
# [358] begin
	push	r29
	push	r28
	in	r28,61
	in	r29,62
	subi	r28,36
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var $self located at r28+2, size=OS_16
# Var $result located at r28+4, size=OS_16
# Var VLastCounter located at r28+6, size=OS_8
# Var VCounter located at r28+7, size=OS_8
# Var VInSignal located at r28+8, size=OS_8
# Var VInSpace located at r28+9, size=OS_8
# Var VStage located at r28+10, size=OS_8
# Var VValue located at r28+11, size=OS_8
# Var VValueMask located at r28+12, size=OS_8
# Var VTime located at r28+13, size=OS_16
# Var VDataTime located at r28+15, size=OS_16
# Var VEvent located at r28+17, size=OS_8
	std	Y+2,r24
	std	Y+3,r25
	std	Y+4,r22
	std	Y+5,r23
# [359] Reset;
	mov	r18,r28
	mov	r25,r29
	mov	r24,r18
	call	IRRECEIVERs_sTIRRECEIVER_s_READssTIRVALUE_ss_RESET
.Lj66:
# [361] if VStage = irsInvalid then
	ldd	r18,Y+10
	cpi	r18,6
	breq	.Lj109
# [471] end;
	rjmp	.Lj70
.Lj109:
# [363] UARTConsole.WriteLnFormat('Date time %d, space time %d, event %d', [VDataTime, VTime, Ord(VEvent)]);
	ldd	r21,Y+15
	ldd	r20,Y+16
	mov	r18,r1
	mov	r19,r1
	std	Y+20,r21
	std	Y+21,r20
	std	Y+22,r18
	std	Y+23,r19
	mov	r18,r1
	mov	r19,r1
	std	Y+18,r18
	std	Y+19,r19
	ldd	r21,Y+13
	ldd	r20,Y+14
	mov	r18,r1
	mov	r19,r1
	std	Y+26,r21
	std	Y+27,r20
	std	Y+28,r18
	std	Y+29,r19
	mov	r18,r1
	mov	r19,r1
	std	Y+24,r18
	std	Y+25,r19
	ldd	r21,Y+17
	mov	r18,r1
	mov	r19,r1
	mov	r20,r1
	std	Y+32,r21
	std	Y+33,r18
	std	Y+34,r19
	std	Y+35,r20
	mov	r18,r1
	mov	r19,r1
	std	Y+30,r18
	std	Y+31,r19
	ldi	r20,lo8(18)
	ldi	r21,hi8(18)
	add	r20,r28
	adc	r21,r29
	ldi	r22,lo8(_sIRRECEIVERs_Ld1)
	ldi	r23,hi8(_sIRRECEIVERs_Ld1)
	ldi	r24,lo8(U_sUART_ss_UARTCONSOLE)
	ldi	r25,hi8(U_sUART_ss_UARTCONSOLE)
	ldi	r18,2
	mov	r19,r1
	call	UARTs_sTUART_s__ss_WRITELNFORMATsSHORTSTRINGsarray_of_const
# [364] SleepMicroSecs(108000);
	ldi	r22,-32
	ldi	r23,-91
	ldi	r24,1
	mov	r25,r1
	call	ARDUINOTOOLS_ss_SLEEPMICROSECSsLONGWORD
# [365] Reset;
	movw	r24,r28
	call	IRRECEIVERs_sTIRRECEIVER_s_READssTIRVALUE_ss_RESET
.Lj70:
# [367] VInSignal := DigitalRead(Pin);
	ldd	r18,Y+2
	ldd	r19,Y+3
	movw	r30,r18
	ld	r24,Z
	call	ARDUINOTOOLS_ss_DIGITALREADsBYTEssBOOLEAN
	std	Y+8,r24
# [368] VCounter := Timer0_Counter;
	in	r0,38
	std	Y+7,r0
# [369] VLastCounter := VCounter - VLastCounter;
	ldd	r19,Y+6
	ldd	r18,Y+7
	sub	r18,r19
	std	Y+6,r18
# [370] VTime := VTime + VLastCounter + VLastCounter + VLastCounter + VLastCounter;
	ldd	r19,Y+6
	mov	r18,r1
	ldd	r20,Y+13
	ldd	r21,Y+14
	add	r20,r19
	adc	r21,r18
	ldd	r22,Y+6
	mov	r19,r1
	add	r22,r20
	adc	r19,r21
	ldd	r20,Y+6
	mov	r18,r1
	add	r20,r22
	adc	r18,r19
	ldd	r21,Y+6
	mov	r19,r1
	add	r21,r20
	adc	r19,r18
	std	Y+13,r21
	std	Y+14,r19
# [371] VLastCounter := VCounter;
	ldd	r0,Y+7
	std	Y+6,r0
# [372] if VInSignal then
	ldd	r18,Y+8
	cp	r18,r1
	breq	.Lj72
# [374] if VInSpace then
	ldd	r18,Y+9
	cp	r18,r1
	brne	.Lj110
	rjmp	.Lj75
.Lj110:
# [376] VInSpace := False;
	std	Y+9,r1
# [377] VDataTime := VTime;
	ldd	r0,Y+13
	std	Y+15,r0
	ldd	r0,Y+14
	std	Y+16,r0
# [378] VTime := 0;
	mov	r18,r1
	mov	r19,r1
	std	Y+13,r18
	std	Y+14,r19
	rjmp	.Lj67
.Lj72:
# [383] if not VInSpace then
	ldd	r18,Y+9
	cp	r1,r18
	breq	.Lj111
	rjmp	.Lj67
.Lj111:
# [385] if VDataTime > 0 then
	ldd	r19,Y+15
	ldd	r18,Y+16
	cp	r1,r19
	cpc	r1,r18
	brlo	.Lj112
	rjmp	.Lj79
.Lj112:
# [387] VEvent := CalcEvent(VDataTime, VTime);
	ldd	r20,Y+13
	ldd	r21,Y+14
	ldd	r22,Y+15
	ldd	r23,Y+16
	movw	r24,r28
	call	IRRECEIVERs_sTIRRECEIVER_s_READssTIRVALUE_ss_CALCEVENTsWORDsWORDssTIREVENT
	std	Y+17,r24
# [388] case VEvent of
	ldd	r18,Y+17
	cp	r18,r1
	breq	.Lj81
	mov	r19,r18
	dec	r18
	cpi	r19,1
	breq	.Lj82
	mov	r19,r18
	dec	r18
	cpi	r19,1
	brsh	.Lj113
	rjmp	.Lj80
.Lj113:
	mov	r19,r18
	dec	r18
	ldi	r20,1
	cp	r20,r19
	brlo	.Lj114
	rjmp	.Lj83
.Lj114:
	mov	r19,r18
	dec	r18
	cpi	r19,1
	brne	.Lj115
	rjmp	.Lj84
.Lj115:
	rjmp	.Lj80
.Lj81:
# [391] VStage := irsInvalid;
	ldi	r18,6
	std	Y+10,r18
# [392] UARTConsole.WriteLnString('Invalid by event');
	ldi	r22,lo8(_sIRRECEIVERs_Ld2)
	ldi	r23,hi8(_sIRRECEIVERs_Ld2)
	ldi	r24,lo8(U_sUART_ss_UARTCONSOLE)
	ldi	r25,hi8(U_sUART_ss_UARTCONSOLE)
	call	UARTs_sTUART_s__ss_WRITELNSTRINGsPCHAR
# [393] Continue;
	rjmp	.Lj67
.Lj82:
# [396] if VStage = irsUndefined then
	ldd	r18,Y+10
	cp	r18,r1
	brne	.Lj86
# [398] VStage := irsAddress;
	ldi	r18,1
	std	Y+10,r18
# [399] VValueMask := 1;
	ldi	r18,1
	std	Y+12,r18
# [400] VValue := 0;
	std	Y+11,r1
	rjmp	.Lj80
.Lj86:
# [404] VStage := irsInvalid;
	ldi	r18,6
	std	Y+10,r18
# [405] UARTConsole.WriteLnString('Invalid by preamble');
	ldi	r22,lo8(_sIRRECEIVERs_Ld3)
	ldi	r23,hi8(_sIRRECEIVERs_Ld3)
	ldi	r24,lo8(U_sUART_ss_UARTCONSOLE)
	ldi	r25,hi8(U_sUART_ss_UARTCONSOLE)
	call	UARTs_sTUART_s__ss_WRITELNSTRINGsPCHAR
# [406] Continue;
	rjmp	.Lj67
.Lj83:
# [409] if VStage = irsUndefined then
	ldd	r18,Y+10
	cp	r18,r1
	brne	.Lj89
# [411] VStage := irsInvalid;
	ldi	r18,6
	std	Y+10,r18
# [412] UARTConsole.WriteLnString('Invalid by data');
	ldi	r22,lo8(_sIRRECEIVERs_Ld4)
	ldi	r23,hi8(_sIRRECEIVERs_Ld4)
	ldi	r24,lo8(U_sUART_ss_UARTCONSOLE)
	ldi	r25,hi8(U_sUART_ss_UARTCONSOLE)
	call	UARTs_sTUART_s__ss_WRITELNSTRINGsPCHAR
# [413] Continue;
	rjmp	.Lj67
.Lj89:
# [417] if VEvent = ireData1 then
	ldd	r18,Y+17
	cpi	r18,3
	brne	.Lj92
# [418] VValue := VValue or VValueMask
	ldd	r19,Y+11
	ldd	r18,Y+12
	or	r18,r19
	std	Y+11,r18
	rjmp	.Lj93
.Lj92:
# [420] VValue := VValue and not VValueMask;
	ldd	r18,Y+12
	com	r18
	ldd	r19,Y+11
	and	r19,r18
	std	Y+11,r19
.Lj93:
# [421] if VValueMask = 128 then
	ldd	r18,Y+12
	cpi	r18,-128
	breq	.Lj116
	rjmp	.Lj95
.Lj116:
# [423] VValueMask := 1;
	ldi	r18,1
	std	Y+12,r18
# [424] case VStage of
	ldd	r19,Y+10
	cpi	r19,1
	brsh	.Lj117
	rjmp	.Lj96
.Lj117:
	mov	r18,r19
	dec	r19
	cpi	r18,1
	breq	.Lj97
	mov	r18,r19
	dec	r19
	cpi	r18,1
	breq	.Lj98
	mov	r18,r19
	dec	r19
	cpi	r18,1
	brne	.Lj118
	rjmp	.Lj99
.Lj118:
	mov	r18,r19
	dec	r19
	cpi	r18,1
	brne	.Lj119
	rjmp	.Lj100
.Lj119:
	rjmp	.Lj96
.Lj97:
# [426] Result.Address := VValue;
	ldd	r18,Y+4
	ldd	r19,Y+5
	movw	r30,r18
	ldd	r0,Y+11
	st	Z,r0
	rjmp	.Lj96
.Lj98:
# [428] if Result.Address xor VValue <> $FF then
	ldd	r18,Y+4
	ldd	r19,Y+5
	movw	r30,r18
	ld	r19,Z
	ldd	r18,Y+11
	eor	r18,r19
	cpi	r18,-1
	brne	.Lj120
	rjmp	.Lj96
.Lj120:
# [430] VStage := irsInvalid;
	ldi	r18,6
	std	Y+10,r18
# [431] UARTConsole.WriteLnFormat('Invalid by address XOR %d %d', [Result.Address, VValue]);
	ldd	r18,Y+4
	ldd	r19,Y+5
	movw	r30,r18
	ld	r21,Z
	mov	r20,r1
	mov	r18,r1
	mov	r19,r1
	std	Y+20,r21
	std	Y+21,r20
	std	Y+22,r18
	std	Y+23,r19
	mov	r18,r1
	mov	r19,r1
	std	Y+18,r18
	std	Y+19,r19
	ldd	r21,Y+11
	mov	r20,r1
	mov	r19,r1
	mov	r18,r1
	std	Y+26,r21
	std	Y+27,r20
	std	Y+28,r19
	std	Y+29,r18
	mov	r18,r1
	mov	r19,r1
	std	Y+24,r18
	std	Y+25,r19
	ldi	r20,lo8(18)
	ldi	r21,hi8(18)
	add	r20,r28
	adc	r21,r29
	ldi	r22,lo8(_sIRRECEIVERs_Ld5)
	ldi	r23,hi8(_sIRRECEIVERs_Ld5)
	ldi	r24,lo8(U_sUART_ss_UARTCONSOLE)
	ldi	r25,hi8(U_sUART_ss_UARTCONSOLE)
	ldi	r18,1
	mov	r19,r1
	call	UARTs_sTUART_s__ss_WRITELNFORMATsSHORTSTRINGsarray_of_const
# [432] Continue;
	rjmp	.Lj67
.Lj99:
# [435] Result.Command := VValue;
	ldd	r18,Y+4
	ldd	r19,Y+5
	movw	r30,r18
	adiw	r30,1
	ldd	r0,Y+11
	st	Z,r0
	rjmp	.Lj96
.Lj100:
# [437] if Result.Command xor VValue <> $FF then
	ldd	r18,Y+4
	ldd	r19,Y+5
	movw	r30,r18
	ldd	r19,Z+1
	ldd	r18,Y+11
	eor	r18,r19
	cpi	r18,-1
	breq	.Lj104
# [439] VStage := irsInvalid;
	ldi	r18,6
	std	Y+10,r18
# [440] UARTConsole.WriteLnString('Invalid by command XOR');
	ldi	r22,lo8(_sIRRECEIVERs_Ld6)
	ldi	r23,hi8(_sIRRECEIVERs_Ld6)
	ldi	r24,lo8(U_sUART_ss_UARTCONSOLE)
	ldi	r25,hi8(U_sUART_ss_UARTCONSOLE)
	call	UARTs_sTUART_s__ss_WRITELNSTRINGsPCHAR
# [441] Continue;
	rjmp	.Lj67
.Lj104:
.Lj96:
# [444] Inc(VStage);
	ldd	r18,Y+10
	inc	r18
	std	Y+10,r18
# [445] VValue := 0;
	std	Y+11,r1
	rjmp	.Lj80
.Lj95:
# [448] VValueMask := VValueMask shl 1;
	ldd	r18,Y+12
	lsl	r18
	std	Y+12,r18
	rjmp	.Lj80
.Lj84:
# [451] if VStage = irsUndefined then
	ldd	r18,Y+10
	cp	r18,r1
	brne	.Lj107
# [453] Result := FLastValue;
	ldd	r20,Y+4
	ldd	r21,Y+5
	ldd	r18,Y+2
	ldd	r19,Y+3
	movw	r30,r18
	adiw	r30,4
	movw	r26,r20
	ld	r0,Z+
	st	X+,r0
	ld	r0,Z
	st	X,r0
# [454] Exit;
	rjmp	.Lj58
.Lj107:
# [458] VStage := irsInvalid;
	ldi	r18,6
	std	Y+10,r18
# [459] UARTConsole.WriteLnString('Invalid by repeat');
	ldi	r22,lo8(_sIRRECEIVERs_Ld7)
	ldi	r23,hi8(_sIRRECEIVERs_Ld7)
	ldi	r24,lo8(U_sUART_ss_UARTCONSOLE)
	ldi	r25,hi8(U_sUART_ss_UARTCONSOLE)
	call	UARTs_sTUART_s__ss_WRITELNSTRINGsPCHAR
# [460] Continue;
	rjmp	.Lj67
.Lj80:
# [463] VDataTime := 0;
	mov	r19,r1
	mov	r18,r1
	std	Y+15,r19
	std	Y+16,r18
.Lj79:
# [465] VInSpace := True;
	ldi	r18,1
	std	Y+9,r18
# [466] VTime := 0;
	mov	r18,r1
	mov	r19,r1
	std	Y+13,r18
	std	Y+14,r19
.Lj75:
.Lj67:
# [469] until VStage = irsComplete;
	ldd	r18,Y+10
	cpi	r18,5
	breq	.Lj121
	rjmp	.Lj66
.Lj121:
# [470] FLastValue := Result;
	ldd	r18,Y+4
	ldd	r19,Y+5
	ldd	r21,Y+2
	ldd	r20,Y+3
	movw	r30,r18
	ldi	r19,lo8(4)
	ldi	r18,hi8(4)
	add	r19,r21
	adc	r18,r20
	mov	r26,r19
	mov	r27,r18
	ld	r0,Z+
	st	X+,r0
	ld	r0,Z
	st	X,r0
.Lj58:
	subi	r28,-36
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
	.size	IRRECEIVERs_sTIRRECEIVER_s__ss_READssTIRVALUE, .Le3 - IRRECEIVERs_sTIRRECEIVER_s__ss_READssTIRVALUE

.section .text.n_irreceivers_stirreceiver_s_readsstirvalue_ss_reset,"ax"
IRRECEIVERs_sTIRRECEIVER_s_READssTIRVALUE_ss_RESET:
# Temps allocated between r28+6 and r28+8
# [347] begin
	push	r29
	push	r28
	in	r28,61
	in	r29,62
	subi	r28,8
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var $parentfp located at r28+2, size=OS_16
# Var $_zero_$IRRECEIVER_$$_TIRVALUE located at r28+4, size=OS_16
	std	Y+2,r24
	std	Y+3,r25
	ldi	r18,lo8(4)
	ldi	r19,hi8(4)
	add	r18,r28
	adc	r19,r29
	std	Y+6,r18
	std	Y+7,r19
	ldd	r24,Y+6
	ldd	r25,Y+7
	mov	r20,r1
	ldi	r22,2
	mov	r23,r1
	call	SYSTEM_ss_FILLCHARsformalsSMALLINTsBYTE
# [348] VValue := 0;
	ldd	r18,Y+2
	ldd	r19,Y+3
	mov	r20,r1
	movw	r30,r18
	std	Z+11,r20
# [349] VValueMask := 1;
	ldd	r18,Y+2
	ldd	r19,Y+3
	ldi	r20,1
	movw	r30,r18
	std	Z+12,r20
# [350] VInSpace := False;
	ldd	r18,Y+2
	ldd	r19,Y+3
	mov	r20,r1
	movw	r30,r18
	std	Z+9,r20
# [351] VTime := 0;
	ldd	r19,Y+2
	ldd	r20,Y+3
	mov	r21,r1
	mov	r18,r1
	mov	r30,r19
	mov	r31,r20
	std	Z+13,r21
	std	Z+14,r18
# [352] VDataTime := 0;
	ldd	r18,Y+2
	ldd	r19,Y+3
	mov	r20,r1
	mov	r21,r1
	movw	r30,r18
	std	Z+15,r20
	std	Z+16,r21
# [353] VStage := irsUndefined;
	ldd	r20,Y+2
	ldd	r19,Y+3
	mov	r18,r1
	mov	r30,r20
	mov	r31,r19
	std	Z+10,r18
# [354] Result := Default(TIRValue);
	ldd	r18,Y+2
	ldd	r19,Y+3
	movw	r30,r18
	ldd	r18,Z+4
	ldd	r19,Z+5
	movw	r30,r18
	ldd	r0,Y+4
	st	Z+,r0
	ldd	r0,Y+5
	st	Z,r0
# [355] VLastCounter := Timer0_Counter;
	ldd	r18,Y+2
	ldd	r19,Y+3
	movw	r30,r18
	adiw	r30,6
	in	r0,38
	st	Z,r0
# [356] end;
	subi	r28,-8
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
	.size	IRRECEIVERs_sTIRRECEIVER_s_READssTIRVALUE_ss_RESET, .Le4 - IRRECEIVERs_sTIRRECEIVER_s_READssTIRVALUE_ss_RESET

.section .text.n_irreceivers_stirreceiver_s_readsstirvalue_ss_calceventswordswordsstirevent,"ax"
IRRECEIVERs_sTIRRECEIVER_s_READssTIRVALUE_ss_CALCEVENTsWORDsWORDssTIREVENT:
# [269] begin
	push	r29
	push	r28
	in	r28,61
	in	r29,62
	subi	r28,9
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var ADataTime located at r28+2, size=OS_16
# Var ASpaceTime located at r28+4, size=OS_16
# Var $parentfp located at r28+6, size=OS_16
# Var $result located at r28+8, size=OS_8
	std	Y+6,r24
	std	Y+7,r25
	std	Y+2,r22
	std	Y+3,r23
	std	Y+4,r20
	std	Y+5,r21
# [270] if ADataTime < IR_VALUE_DATA_TIME_MIN then
	ldd	r18,Y+2
	ldd	r19,Y+3
	cpi	r18,-100
	ldi	r18,1
	cpc	r19,r18
	brsh	.Lj123
# [272] Result := ireUndefined;
	std	Y+8,r1
	rjmp	.Lj124
.Lj123:
# [275] if ADataTime < IR_VALUE_DATA_TIME_MAX then
	ldd	r18,Y+2
	ldd	r19,Y+3
	cpi	r18,-56
	ldi	r18,2
	cpc	r19,r18
	brlo	.Lj158
# [317] end;
	rjmp	.Lj126
.Lj158:
# [277] if ASpaceTime < IR_SPACE0_DATA_TIME_MIN then
	ldd	r18,Y+4
	ldd	r19,Y+5
	cpi	r18,-100
	ldi	r18,1
	cpc	r19,r18
	brsh	.Lj128
# [278] Result := ireUndefined
	std	Y+8,r1
	rjmp	.Lj139
.Lj128:
# [280] if ASpaceTime < IR_SPACE0_DATA_TIME_MAX then
	ldd	r18,Y+4
	ldd	r19,Y+5
	cpi	r18,-56
	ldi	r18,2
	cpc	r19,r18
	brsh	.Lj131
# [281] Result := ireData0
	ldi	r18,2
	std	Y+8,r18
	rjmp	.Lj139
.Lj131:
# [283] if ASpaceTime < IR_SPACE1_DATA_TIME_MIN then
	ldd	r18,Y+4
	ldd	r19,Y+5
	cpi	r18,-43
	ldi	r18,4
	cpc	r19,r18
	brsh	.Lj134
# [284] Result := ireUndefined
	std	Y+8,r1
	rjmp	.Lj139
.Lj134:
# [286] if ASpaceTime < IR_SPACE1_DATA_TIME_MAX then
	ldd	r18,Y+4
	ldd	r19,Y+5
	cpi	r18,89
	ldi	r18,8
	cpc	r19,r18
	brsh	.Lj137
# [287] Result := ireData1
	ldi	r18,3
	std	Y+8,r18
	rjmp	.Lj139
.Lj137:
# [289] Result := ireUndefined;
	std	Y+8,r1
	rjmp	.Lj124
.Lj126:
# [292] if ADataTime < IR_META_DATA_TIME_MIN then
	ldd	r18,Y+2
	ldd	r19,Y+3
	cpi	r18,-56
	ldi	r18,25
	cpc	r19,r18
	brsh	.Lj141
# [294] Result := ireUndefined;
	std	Y+8,r1
	rjmp	.Lj124
.Lj141:
# [297] if ADataTime < IR_META_DATA_TIME_MAX then
	ldd	r18,Y+2
	ldd	r19,Y+3
	cpi	r18,-120
	ldi	r18,44
	cpc	r19,r18
	brlo	.Lj159
	rjmp	.Lj144
.Lj159:
# [299] if ASpaceTime < IR_REPEAT_SPACE_TIME_MIN then
	ldd	r18,Y+4
	ldd	r19,Y+5
	cpi	r18,114
	ldi	r18,6
	cpc	r19,r18
	brsh	.Lj146
# [300] Result := ireUndefined
	std	Y+8,r1
	rjmp	.Lj157
.Lj146:
# [302] if ASpaceTime < IR_REPEAT_SPACE_TIME_MAX then
	ldd	r18,Y+4
	ldd	r19,Y+5
	cpi	r18,34
	ldi	r18,11
	cpc	r19,r18
	brsh	.Lj149
# [303] Result := ireRepeat
	ldi	r18,4
	std	Y+8,r18
	rjmp	.Lj157
.Lj149:
# [305] if ASpaceTime < IR_PREAMBULE_SPACE_TIME_MIN then
	ldd	r18,Y+4
	ldd	r19,Y+5
	cpi	r18,-28
	ldi	r18,12
	cpc	r19,r18
	brsh	.Lj152
# [306] Result := ireUndefined
	std	Y+8,r1
	rjmp	.Lj157
.Lj152:
# [308] if ASpaceTime < IR_PREAMBULE_SPACE_TIME_MAX then
	ldd	r18,Y+4
	ldd	r19,Y+5
	cpi	r18,68
	ldi	r18,22
	cpc	r19,r18
	brsh	.Lj155
# [309] Result := irePreamble
	ldi	r18,1
	std	Y+8,r18
	rjmp	.Lj157
.Lj155:
# [311] Result := ireUndefined;
	std	Y+8,r1
	rjmp	.Lj124
.Lj144:
# [315] Result := ireUndefined;
	std	Y+8,r1
.Lj157:
.Lj139:
.Lj124:
	ldd	r24,Y+8
	subi	r28,-9
	sbci	r29,-1
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
	pop	r28
	pop	r29
	ret
.Le5:
	.size	IRRECEIVERs_sTIRRECEIVER_s_READssTIRVALUE_ss_CALCEVENTsWORDsWORDssTIREVENT, .Le5 - IRRECEIVERs_sTIRRECEIVER_s_READssTIRVALUE_ss_CALCEVENTsWORDsWORDssTIREVENT
# End asmlist al_procedures
# Begin asmlist al_globals

.section .data.n_VMT_sIRRECEIVER_ss_TIRRECEIVER
	.balign 2
.globl	VMT_sIRRECEIVER_ss_TIRRECEIVER
VMT_sIRRECEIVER_ss_TIRRECEIVER:
	.short	6,65530
	.short	VMT_sARDUINOTOOLS_ss_TCUSTOMPININPUTsindirect
	.short	gs(ARDUINOTOOLSs_sTCUSTOMPINED_s__ss_DEINIT)
	.short	gs(0)
# [473] end.
.Le6:
	.size	VMT_sIRRECEIVER_ss_TIRRECEIVER, .Le6 - VMT_sIRRECEIVER_ss_TIRRECEIVER
# End asmlist al_globals
# Begin asmlist al_typedconsts

.section .rodata.n__sIRRECEIVERs_Ld1
.globl	_sIRRECEIVERs_Ld1
_sIRRECEIVERs_Ld1:
	.ascii	"%Date time %d, space time %d, event %d\000"
.Le7:
	.size	_sIRRECEIVERs_Ld1, .Le7 - _sIRRECEIVERs_Ld1

.section .rodata.n__sIRRECEIVERs_Ld2
.globl	_sIRRECEIVERs_Ld2
_sIRRECEIVERs_Ld2:
	.ascii	"Invalid by event\000"
.Le8:
	.size	_sIRRECEIVERs_Ld2, .Le8 - _sIRRECEIVERs_Ld2

.section .rodata.n__sIRRECEIVERs_Ld3
.globl	_sIRRECEIVERs_Ld3
_sIRRECEIVERs_Ld3:
	.ascii	"Invalid by preamble\000"
.Le9:
	.size	_sIRRECEIVERs_Ld3, .Le9 - _sIRRECEIVERs_Ld3

.section .rodata.n__sIRRECEIVERs_Ld4
.globl	_sIRRECEIVERs_Ld4
_sIRRECEIVERs_Ld4:
	.ascii	"Invalid by data\000"
.Le10:
	.size	_sIRRECEIVERs_Ld4, .Le10 - _sIRRECEIVERs_Ld4

.section .rodata.n__sIRRECEIVERs_Ld5
.globl	_sIRRECEIVERs_Ld5
_sIRRECEIVERs_Ld5:
	.ascii	"\034Invalid by address XOR %d %d\000"
.Le11:
	.size	_sIRRECEIVERs_Ld5, .Le11 - _sIRRECEIVERs_Ld5

.section .rodata.n__sIRRECEIVERs_Ld6
.globl	_sIRRECEIVERs_Ld6
_sIRRECEIVERs_Ld6:
	.ascii	"Invalid by command XOR\000"
.Le12:
	.size	_sIRRECEIVERs_Ld6, .Le12 - _sIRRECEIVERs_Ld6

.section .rodata.n__sIRRECEIVERs_Ld7
.globl	_sIRRECEIVERs_Ld7
_sIRRECEIVERs_Ld7:
	.ascii	"Invalid by repeat\000"
.Le13:
	.size	_sIRRECEIVERs_Ld7, .Le13 - _sIRRECEIVERs_Ld7
# End asmlist al_typedconsts
# Begin asmlist al_rtti

.section .data.n_RTTI_sIRRECEIVER_ss_TIRSTAGE
.globl	RTTI_sIRRECEIVER_ss_TIRSTAGE
RTTI_sIRRECEIVER_ss_TIRSTAGE:
	.byte	3,8
# [475] 
	.ascii	"TIRStage"
	.short	0
	.byte	1
	.long	0,6
	.short	0
	.byte	12
	.ascii	"irsUndefined"
	.byte	10
	.ascii	"irsAddress"
	.byte	16
	.ascii	"irsAddressInvert"
	.byte	10
	.ascii	"irsCommand"
	.byte	16
	.ascii	"irsCommandInvert"
	.byte	11
	.ascii	"irsComplete"
	.byte	10
	.ascii	"irsInvalid"
	.byte	10
	.ascii	"IRReceiver"
	.byte	0
.Le14:
	.size	RTTI_sIRRECEIVER_ss_TIRSTAGE, .Le14 - RTTI_sIRRECEIVER_ss_TIRSTAGE

.section .data.n_RTTI_sIRRECEIVER_ss_TIRSTAGE_s2o
	.balign 2
.globl	RTTI_sIRRECEIVER_ss_TIRSTAGE_s2o
RTTI_sIRRECEIVER_ss_TIRSTAGE_s2o:
	.long	7,1
	.short	RTTI_sIRRECEIVER_ss_TIRSTAGE+36
	.long	2
	.short	RTTI_sIRRECEIVER_ss_TIRSTAGE+47
	.long	3
	.short	RTTI_sIRRECEIVER_ss_TIRSTAGE+64
	.long	4
	.short	RTTI_sIRRECEIVER_ss_TIRSTAGE+75
	.long	5
	.short	RTTI_sIRRECEIVER_ss_TIRSTAGE+92
	.long	6
	.short	RTTI_sIRRECEIVER_ss_TIRSTAGE+104
	.long	0
	.short	RTTI_sIRRECEIVER_ss_TIRSTAGE+23
.Le15:
	.size	RTTI_sIRRECEIVER_ss_TIRSTAGE_s2o, .Le15 - RTTI_sIRRECEIVER_ss_TIRSTAGE_s2o

.section .data.n_RTTI_sIRRECEIVER_ss_TIRSTAGE_o2s
	.balign 2
.globl	RTTI_sIRRECEIVER_ss_TIRSTAGE_o2s
RTTI_sIRRECEIVER_ss_TIRSTAGE_o2s:
	.long	0
	.short	RTTI_sIRRECEIVER_ss_TIRSTAGE+23
	.short	RTTI_sIRRECEIVER_ss_TIRSTAGE+36
	.short	RTTI_sIRRECEIVER_ss_TIRSTAGE+47
	.short	RTTI_sIRRECEIVER_ss_TIRSTAGE+64
	.short	RTTI_sIRRECEIVER_ss_TIRSTAGE+75
	.short	RTTI_sIRRECEIVER_ss_TIRSTAGE+92
	.short	RTTI_sIRRECEIVER_ss_TIRSTAGE+104
.Le16:
	.size	RTTI_sIRRECEIVER_ss_TIRSTAGE_o2s, .Le16 - RTTI_sIRRECEIVER_ss_TIRSTAGE_o2s

.section .data.n_RTTI_sIRRECEIVER_ss_TIREVENT
.globl	RTTI_sIRRECEIVER_ss_TIREVENT
RTTI_sIRRECEIVER_ss_TIREVENT:
	.byte	3,8
	.ascii	"TIREvent"
	.short	0
	.byte	1
	.long	0,4
	.short	0
	.byte	12
	.ascii	"ireUndefined"
	.byte	11
	.ascii	"irePreamble"
	.byte	8
	.ascii	"ireData0"
	.byte	8
	.ascii	"ireData1"
	.byte	9
	.ascii	"ireRepeat"
	.byte	10
	.ascii	"IRReceiver"
	.byte	0
.Le17:
	.size	RTTI_sIRRECEIVER_ss_TIREVENT, .Le17 - RTTI_sIRRECEIVER_ss_TIREVENT

.section .data.n_RTTI_sIRRECEIVER_ss_TIREVENT_s2o
	.balign 2
.globl	RTTI_sIRRECEIVER_ss_TIREVENT_s2o
RTTI_sIRRECEIVER_ss_TIREVENT_s2o:
	.long	5,2
	.short	RTTI_sIRRECEIVER_ss_TIREVENT+48
	.long	3
	.short	RTTI_sIRRECEIVER_ss_TIREVENT+57
	.long	1
	.short	RTTI_sIRRECEIVER_ss_TIREVENT+36
	.long	4
	.short	RTTI_sIRRECEIVER_ss_TIREVENT+66
	.long	0
	.short	RTTI_sIRRECEIVER_ss_TIREVENT+23
.Le18:
	.size	RTTI_sIRRECEIVER_ss_TIREVENT_s2o, .Le18 - RTTI_sIRRECEIVER_ss_TIREVENT_s2o

.section .data.n_RTTI_sIRRECEIVER_ss_TIREVENT_o2s
	.balign 2
.globl	RTTI_sIRRECEIVER_ss_TIREVENT_o2s
RTTI_sIRRECEIVER_ss_TIREVENT_o2s:
	.long	0
	.short	RTTI_sIRRECEIVER_ss_TIREVENT+23
	.short	RTTI_sIRRECEIVER_ss_TIREVENT+36
	.short	RTTI_sIRRECEIVER_ss_TIREVENT+48
	.short	RTTI_sIRRECEIVER_ss_TIREVENT+57
	.short	RTTI_sIRRECEIVER_ss_TIREVENT+66
.Le19:
	.size	RTTI_sIRRECEIVER_ss_TIREVENT_o2s, .Le19 - RTTI_sIRRECEIVER_ss_TIREVENT_o2s

.section .data.n_INIT_sIRRECEIVER_ss_TIRVALUE
.globl	INIT_sIRRECEIVER_ss_TIRVALUE
INIT_sIRRECEIVER_ss_TIRVALUE:
	.byte	13,8
	.ascii	"TIRValue"
	.short	0,0
	.long	2
	.short	0,0
	.long	0
.Le20:
	.size	INIT_sIRRECEIVER_ss_TIRVALUE, .Le20 - INIT_sIRRECEIVER_ss_TIRVALUE

.section .data.n_RTTI_sIRRECEIVER_ss_TIRVALUE
.globl	RTTI_sIRRECEIVER_ss_TIRVALUE
RTTI_sIRRECEIVER_ss_TIRVALUE:
	.byte	13,8
	.ascii	"TIRValue"
	.short	0
	.short	INIT_sIRRECEIVER_ss_TIRVALUE
	.long	2,2
	.short	RTTI_sSYSTEM_ss_BYTEsindirect
	.short	0
	.short	RTTI_sSYSTEM_ss_BYTEsindirect
	.short	1
.Le21:
	.size	RTTI_sIRRECEIVER_ss_TIRVALUE, .Le21 - RTTI_sIRRECEIVER_ss_TIRVALUE

.section .data.n_INIT_sIRRECEIVER_ss_TIRRECEIVER
.globl	INIT_sIRRECEIVER_ss_TIRRECEIVER
INIT_sIRRECEIVER_ss_TIRRECEIVER:
	.byte	16,11
	.ascii	"TIRReceiver"
	.short	0,0
	.long	6
	.short	0,0
	.long	0
.Le22:
	.size	INIT_sIRRECEIVER_ss_TIRRECEIVER, .Le22 - INIT_sIRRECEIVER_ss_TIRRECEIVER

.section .data.n_RTTI_sIRRECEIVER_ss_TIRRECEIVER
.globl	RTTI_sIRRECEIVER_ss_TIRRECEIVER
RTTI_sIRRECEIVER_ss_TIRRECEIVER:
	.byte	16,11
	.ascii	"TIRReceiver"
	.short	0
	.short	INIT_sIRRECEIVER_ss_TIRRECEIVER
	.long	6,2
	.short	RTTI_sARDUINOTOOLS_ss_TCUSTOMPININPUTsindirect
	.short	0
	.short	RTTI_sIRRECEIVER_ss_TIRVALUEsindirect
	.short	4
.Le23:
	.size	RTTI_sIRRECEIVER_ss_TIRRECEIVER, .Le23 - RTTI_sIRRECEIVER_ss_TIRRECEIVER
# End asmlist al_rtti
# Begin asmlist al_indirectglobals

.section .data.n_VMT_sIRRECEIVER_ss_TIRRECEIVER
	.balign 2
.globl	VMT_sIRRECEIVER_ss_TIRRECEIVERsindirect
VMT_sIRRECEIVER_ss_TIRRECEIVERsindirect:
	.short	VMT_sIRRECEIVER_ss_TIRRECEIVER
.Le24:
	.size	VMT_sIRRECEIVER_ss_TIRRECEIVERsindirect, .Le24 - VMT_sIRRECEIVER_ss_TIRRECEIVERsindirect

.section .data.n_RTTI_sIRRECEIVER_ss_TIRSTAGE
	.balign 2
.globl	RTTI_sIRRECEIVER_ss_TIRSTAGEsindirect
RTTI_sIRRECEIVER_ss_TIRSTAGEsindirect:
	.short	RTTI_sIRRECEIVER_ss_TIRSTAGE
.Le25:
	.size	RTTI_sIRRECEIVER_ss_TIRSTAGEsindirect, .Le25 - RTTI_sIRRECEIVER_ss_TIRSTAGEsindirect

.section .data.n_RTTI_sIRRECEIVER_ss_TIRSTAGE_s2o
	.balign 2
.globl	RTTI_sIRRECEIVER_ss_TIRSTAGE_s2osindirect
RTTI_sIRRECEIVER_ss_TIRSTAGE_s2osindirect:
	.short	RTTI_sIRRECEIVER_ss_TIRSTAGE_s2o
.Le26:
	.size	RTTI_sIRRECEIVER_ss_TIRSTAGE_s2osindirect, .Le26 - RTTI_sIRRECEIVER_ss_TIRSTAGE_s2osindirect

.section .data.n_RTTI_sIRRECEIVER_ss_TIRSTAGE_o2s
	.balign 2
.globl	RTTI_sIRRECEIVER_ss_TIRSTAGE_o2ssindirect
RTTI_sIRRECEIVER_ss_TIRSTAGE_o2ssindirect:
	.short	RTTI_sIRRECEIVER_ss_TIRSTAGE_o2s
.Le27:
	.size	RTTI_sIRRECEIVER_ss_TIRSTAGE_o2ssindirect, .Le27 - RTTI_sIRRECEIVER_ss_TIRSTAGE_o2ssindirect

.section .data.n_RTTI_sIRRECEIVER_ss_TIREVENT
	.balign 2
.globl	RTTI_sIRRECEIVER_ss_TIREVENTsindirect
RTTI_sIRRECEIVER_ss_TIREVENTsindirect:
	.short	RTTI_sIRRECEIVER_ss_TIREVENT
.Le28:
	.size	RTTI_sIRRECEIVER_ss_TIREVENTsindirect, .Le28 - RTTI_sIRRECEIVER_ss_TIREVENTsindirect

.section .data.n_RTTI_sIRRECEIVER_ss_TIREVENT_s2o
	.balign 2
.globl	RTTI_sIRRECEIVER_ss_TIREVENT_s2osindirect
RTTI_sIRRECEIVER_ss_TIREVENT_s2osindirect:
	.short	RTTI_sIRRECEIVER_ss_TIREVENT_s2o
.Le29:
	.size	RTTI_sIRRECEIVER_ss_TIREVENT_s2osindirect, .Le29 - RTTI_sIRRECEIVER_ss_TIREVENT_s2osindirect

.section .data.n_RTTI_sIRRECEIVER_ss_TIREVENT_o2s
	.balign 2
.globl	RTTI_sIRRECEIVER_ss_TIREVENT_o2ssindirect
RTTI_sIRRECEIVER_ss_TIREVENT_o2ssindirect:
	.short	RTTI_sIRRECEIVER_ss_TIREVENT_o2s
.Le30:
	.size	RTTI_sIRRECEIVER_ss_TIREVENT_o2ssindirect, .Le30 - RTTI_sIRRECEIVER_ss_TIREVENT_o2ssindirect

.section .data.n_INIT_sIRRECEIVER_ss_TIRVALUE
	.balign 2
.globl	INIT_sIRRECEIVER_ss_TIRVALUEsindirect
INIT_sIRRECEIVER_ss_TIRVALUEsindirect:
	.short	INIT_sIRRECEIVER_ss_TIRVALUE
.Le31:
	.size	INIT_sIRRECEIVER_ss_TIRVALUEsindirect, .Le31 - INIT_sIRRECEIVER_ss_TIRVALUEsindirect

.section .data.n_RTTI_sIRRECEIVER_ss_TIRVALUE
	.balign 2
.globl	RTTI_sIRRECEIVER_ss_TIRVALUEsindirect
RTTI_sIRRECEIVER_ss_TIRVALUEsindirect:
	.short	RTTI_sIRRECEIVER_ss_TIRVALUE
.Le32:
	.size	RTTI_sIRRECEIVER_ss_TIRVALUEsindirect, .Le32 - RTTI_sIRRECEIVER_ss_TIRVALUEsindirect

.section .data.n_INIT_sIRRECEIVER_ss_TIRRECEIVER
	.balign 2
.globl	INIT_sIRRECEIVER_ss_TIRRECEIVERsindirect
INIT_sIRRECEIVER_ss_TIRRECEIVERsindirect:
	.short	INIT_sIRRECEIVER_ss_TIRRECEIVER
.Le33:
	.size	INIT_sIRRECEIVER_ss_TIRRECEIVERsindirect, .Le33 - INIT_sIRRECEIVER_ss_TIRRECEIVERsindirect

.section .data.n_RTTI_sIRRECEIVER_ss_TIRRECEIVER
	.balign 2
.globl	RTTI_sIRRECEIVER_ss_TIRRECEIVERsindirect
RTTI_sIRRECEIVER_ss_TIRRECEIVERsindirect:
	.short	RTTI_sIRRECEIVER_ss_TIRRECEIVER
.Le34:
	.size	RTTI_sIRRECEIVER_ss_TIRRECEIVERsindirect, .Le34 - RTTI_sIRRECEIVER_ss_TIRRECEIVERsindirect
# End asmlist al_indirectglobals

