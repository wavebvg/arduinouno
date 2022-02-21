	.file "Timers.pas"
# Begin asmlist al_pure_assembler

.section .text.n_timers_ss_calcwordtimespwordssword,"ax"
.globl	TIMERS_ss_CALCWORDTIMEsPWORDssWORD
TIMERS_ss_CALCWORDTIMEsPWORDssWORD:
# [Timers.pas]
# [245] asm
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
# Var $result located at r28+2, size=OS_16
#  CPU AVR5
# [247] PUSH    R18  {OldTime}                   {1}
	push	r18
# [248] PUSH    R19  {OldTime}                   {1}
	push	r19
# [249] PUSH    R26  {X} {AOldTime}              {1}
	push	r26
# [250] PUSH    R27  {X} {AOldTime}              {1}
	push	r27
# [252] MOVW    R26, R24                         {1}
	movw	r26,r24
# [253] LD      R18, X+                          {2}
	ld	r18,x+
# [254] LD      R19, X                           {2}
	ld	r19,x
# [256] LDS     R25, TCNT1H {VCounter}           {3}
	lds	r25,(133)
# [257] LDS     R24, TCNT1L {VCounter}           {3}
	lds	r24,(132)
# [259] SUB     R24, R18                         {1}
	sub	r24,r18
# [260] SBC     R25, R19                         {1}
	sbc	r25,r19
# [262] POP     R27                              {1}
	pop	r27
# [263] POP     R26                              {1}
	pop	r26
# [264] POP     R19                              {1}
	pop	r19
# [265] POP     R18                              {1}
	pop	r18
#  CPU AVR5
# [267] end;
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
	.size	TIMERS_ss_CALCWORDTIMEsPWORDssWORD, .Le0 - TIMERS_ss_CALCWORDTIMEsPWORDssWORD

.section .text.n_timers_ss_abstracttimerdocompareeventstmethod,"ax"
TIMERS_ss_ABSTRACTTIMERDOCOMPAREEVENTsTMETHOD:
# [297] asm
#  CPU AVR5
# [298] PUSH    R26
	push	r26
# [299] PUSH    R27
	push	r27
# [300] PUSH    R30
	push	r30
# [301] PUSH    R31
	push	r31
# [303] MOVW    R26, R24
	movw	r26,r24
# [304] LD      R30, X+
	ld	r30,x+
# [305] LD      R31, X+
	ld	r31,x+
# [307] CP      R30, R1
	cp	r30,r1
# [308] CPC     R31, R1
	cpc	r31,r1
# [309] BREQ    exit
	breq	.Lj43
# [311] PUSH    R18
	push	r18
# [312] PUSH    R19
	push	r19
# [313] PUSH    R20
	push	r20
# [314] PUSH    R21
	push	r21
# [315] PUSH    R22
	push	r22
# [316] PUSH    R23
	push	r23
# [317] PUSH    R28
	push	r28
# [318] PUSH    R29
	push	r29
# [319] LD      R24, X+
	ld	r24,x+
# [320] LD      R25, X
	ld	r25,x
# [321] ICALL
	icall
# [322] POP     R29
	pop	r29
# [323] POP     R28
	pop	r28
# [324] POP     R23
	pop	r23
# [325] POP     R22
	pop	r22
# [326] POP     R21
	pop	r21
# [327] POP     R20
	pop	r20
# [328] POP     R19
	pop	r19
# [329] POP     R18
	pop	r18
.Lj43:
# [332] POP     R31
	pop	r31
# [333] POP     R30
	pop	r30
# [334] POP     R27
	pop	r27
# [335] POP     R26
	pop	r26
#  CPU AVR5
# [336] end;
	ret
.Le1:
	.size	TIMERS_ss_ABSTRACTTIMERDOCOMPAREEVENTsTMETHOD, .Le1 - TIMERS_ss_ABSTRACTTIMERDOCOMPAREEVENTsTMETHOD

.section .text.n_timers_ss_timer0_compa_isr,"ax"
.globl	TIMERS_ss_TIMER0_COMPA_ISR
TIMERS_ss_TIMER0_COMPA_ISR:
.globl	TIMER0_COMPA_ISR
TIMER0_COMPA_ISR:
# [733] asm
	push	r1
	push	r0
	in	r0,63
	push	r0
	clr	r1
#  CPU AVR5
# [734] PUSH    R24
	push	r24
# [735] PUSH    R25
	push	r25
# [737] LDI     R24,LO8(Timer0.FCompareAEvent)
	ldi	r24,lo8(U_sTIMERS_ss_TIMER0+34)
# [738] LDI     R25,HI8(Timer0.FCompareAEvent)
	ldi	r25,hi8(U_sTIMERS_ss_TIMER0+34)
# [739] RCALL   AbstractTimerDoCompareEvent
	rcall	TIMERS_ss_ABSTRACTTIMERDOCOMPAREEVENTsTMETHOD
# [741] POP     R25
	pop	r25
# [742] POP     R24
	pop	r24
#  CPU AVR5
# [743] end;
	pop	r0
	out	63,r0
	pop	r0
	pop	r1
	reti
.Le2:
	.size	TIMERS_ss_TIMER0_COMPA_ISR, .Le2 - TIMERS_ss_TIMER0_COMPA_ISR

.section .text.n_timers_ss_timer0_compb_isr,"ax"
.globl	TIMERS_ss_TIMER0_COMPB_ISR
TIMERS_ss_TIMER0_COMPB_ISR:
.globl	TIMER0_COMPB_ISR
TIMER0_COMPB_ISR:
# [746] asm
	push	r1
	push	r0
	in	r0,63
	push	r0
	clr	r1
#  CPU AVR5
# [747] PUSH    R24
	push	r24
# [748] PUSH    R25
	push	r25
# [750] LDI     R24,LO8(Timer0.FCompareBEvent)
	ldi	r24,lo8(U_sTIMERS_ss_TIMER0+38)
# [751] LDI     R25,HI8(Timer0.FCompareBEvent)
	ldi	r25,hi8(U_sTIMERS_ss_TIMER0+38)
# [752] RCALL   AbstractTimerDoCompareEvent
	rcall	TIMERS_ss_ABSTRACTTIMERDOCOMPAREEVENTsTMETHOD
# [754] POP     R25
	pop	r25
# [755] POP     R24
	pop	r24
#  CPU AVR5
# [756] end;
	pop	r0
	out	63,r0
	pop	r0
	pop	r1
	reti
.Le3:
	.size	TIMERS_ss_TIMER0_COMPB_ISR, .Le3 - TIMERS_ss_TIMER0_COMPB_ISR

.section .text.n_timers_ss_timer1_compa_isr,"ax"
.globl	TIMERS_ss_TIMER1_COMPA_ISR
TIMERS_ss_TIMER1_COMPA_ISR:
.globl	TIMER1_COMPA_ISR
TIMER1_COMPA_ISR:
# [764] asm
	push	r1
	push	r0
	in	r0,63
	push	r0
	clr	r1
#  CPU AVR5
# [765] PUSH    R24
	push	r24
# [766] PUSH    R25
	push	r25
# [767] LDI     R24,LO8(Timer1.FCompareAEvent)
	ldi	r24,lo8(U_sTIMERS_ss_TIMER1+34)
# [768] LDI     R25,HI8(Timer1.FCompareAEvent)
	ldi	r25,hi8(U_sTIMERS_ss_TIMER1+34)
# [769] RCALL   AbstractTimerDoCompareEvent
	rcall	TIMERS_ss_ABSTRACTTIMERDOCOMPAREEVENTsTMETHOD
# [770] POP     R25
	pop	r25
# [771] POP     R24
	pop	r24
#  CPU AVR5
# [772] end;
	pop	r0
	out	63,r0
	pop	r0
	pop	r1
	reti
.Le4:
	.size	TIMERS_ss_TIMER1_COMPA_ISR, .Le4 - TIMERS_ss_TIMER1_COMPA_ISR

.section .text.n_timers_ss_timer1_compb_isr,"ax"
.globl	TIMERS_ss_TIMER1_COMPB_ISR
TIMERS_ss_TIMER1_COMPB_ISR:
.globl	TIMER1_COMPB_ISR
TIMER1_COMPB_ISR:
# [775] asm
	push	r1
	push	r0
	in	r0,63
	push	r0
	clr	r1
#  CPU AVR5
# [776] PUSH    R24
	push	r24
# [777] PUSH    R25
	push	r25
# [778] LDI     R24,LO8(Timer1.FCompareBEvent)
	ldi	r24,lo8(U_sTIMERS_ss_TIMER1+38)
# [779] LDI     R25,HI8(Timer1.FCompareBEvent)
	ldi	r25,hi8(U_sTIMERS_ss_TIMER1+38)
# [780] RCALL   AbstractTimerDoCompareEvent
	rcall	TIMERS_ss_ABSTRACTTIMERDOCOMPAREEVENTsTMETHOD
# [781] POP     R25
	pop	r25
# [782] POP     R24
	pop	r24
#  CPU AVR5
# [783] end;
	pop	r0
	out	63,r0
	pop	r0
	pop	r1
	reti
.Le5:
	.size	TIMERS_ss_TIMER1_COMPB_ISR, .Le5 - TIMERS_ss_TIMER1_COMPB_ISR

.section .text.n_timers_ss_timer2_compa_isr,"ax"
.globl	TIMERS_ss_TIMER2_COMPA_ISR
TIMERS_ss_TIMER2_COMPA_ISR:
.globl	TIMER2_COMPA_ISR
TIMER2_COMPA_ISR:
# [791] asm
	push	r1
	push	r0
	in	r0,63
	push	r0
	clr	r1
#  CPU AVR5
# [792] PUSH    R24
	push	r24
# [793] PUSH    R25
	push	r25
# [794] LDI     R24,LO8(Timer2.FCompareAEvent)
	ldi	r24,lo8(U_sTIMERS_ss_TIMER2+34)
# [795] LDI     R25,HI8(Timer2.FCompareAEvent)
	ldi	r25,hi8(U_sTIMERS_ss_TIMER2+34)
# [796] RCALL   AbstractTimerDoCompareEvent
	rcall	TIMERS_ss_ABSTRACTTIMERDOCOMPAREEVENTsTMETHOD
# [797] POP     R25
	pop	r25
# [798] POP     R24
	pop	r24
#  CPU AVR5
# [799] end;
	pop	r0
	out	63,r0
	pop	r0
	pop	r1
	reti
.Le6:
	.size	TIMERS_ss_TIMER2_COMPA_ISR, .Le6 - TIMERS_ss_TIMER2_COMPA_ISR

.section .text.n_timers_ss_timer2_compb_isr,"ax"
.globl	TIMERS_ss_TIMER2_COMPB_ISR
TIMERS_ss_TIMER2_COMPB_ISR:
.globl	TIMER2_COMPB_ISR
TIMER2_COMPB_ISR:
# [802] asm
	push	r1
	push	r0
	in	r0,63
	push	r0
	clr	r1
#  CPU AVR5
# [803] PUSH    R24
	push	r24
# [804] PUSH    R25
	push	r25
# [805] LDI     R24,LO8(Timer2.FCompareBEvent)
	ldi	r24,lo8(U_sTIMERS_ss_TIMER2+38)
# [806] LDI     R25,HI8(Timer2.FCompareBEvent)
	ldi	r25,hi8(U_sTIMERS_ss_TIMER2+38)
# [807] RCALL   AbstractTimerDoCompareEvent
	rcall	TIMERS_ss_ABSTRACTTIMERDOCOMPAREEVENTsTMETHOD
# [808] POP     R25
	pop	r25
# [809] POP     R24
	pop	r24
#  CPU AVR5
# [810] end;
	pop	r0
	out	63,r0
	pop	r0
	pop	r1
	reti
.Le7:
	.size	TIMERS_ss_TIMER2_COMPB_ISR, .Le7 - TIMERS_ss_TIMER2_COMPB_ISR
# End asmlist al_pure_assembler
# Begin asmlist al_procedures

.section .text.n_timers_ss_pulseinsbytesbooleanslongwordsslongword,"ax"
.globl	TIMERS_ss_PULSEINsBYTEsBOOLEANsLONGWORDssLONGWORD
TIMERS_ss_PULSEINsBYTEsBOOLEANsLONGWORDssLONGWORD:
# [186] begin
	push	r29
	push	r28
	in	r28,61
	in	r29,62
	subi	r28,18
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var APin located at r28+2, size=OS_8
# Var AState located at r28+3, size=OS_8
# Var ATimeOut located at r28+4, size=OS_32
# Var $result located at r28+8, size=OS_32
# Var VBitMask located at r28+12, size=OS_8
# Var VStateMask located at r28+13, size=OS_8
# Var VPort located at r28+14, size=OS_16
# Var VCounter located at r28+16, size=OS_8
# Var VLastCounter located at r28+17, size=OS_8
	std	Y+2,r24
	std	Y+3,r22
	std	Y+4,r18
	std	Y+5,r19
	std	Y+6,r20
	std	Y+7,r21
# [187] Result := $FFFFFFFF;
	ldi	r18,-1
	ldi	r19,-1
	ldi	r20,-1
	ldi	r21,-1
	std	Y+8,r18
	std	Y+9,r19
	std	Y+10,r20
	std	Y+11,r21
# [188] VLastCounter := Timer0_Counter;
	in	r0,38
	std	Y+17,r0
# [189] ATimeOut := ATimeOut div 4;
	ldd	r18,Y+4
	ldd	r19,Y+5
	ldd	r20,Y+6
	ldd	r21,Y+7
	lsr	r21
	ror	r20
	ror	r19
	ror	r18
	lsr	r21
	ror	r20
	ror	r19
	ror	r18
	std	Y+4,r18
	std	Y+5,r19
	std	Y+6,r20
	std	Y+7,r21
# [190] VBitMask := DigitalPinToBitMask[APin];
	ldd	r19,Y+2
	mov	r18,r1
	ldi	r30,lo8(TC_sARDUINOTOOLS_ss_DIGITALPINTOBITMASK)
	ldi	r31,hi8(TC_sARDUINOTOOLS_ss_DIGITALPINTOBITMASK)
	add	r30,r19
	adc	r31,r18
	ld	r0,Z
	std	Y+12,r0
# [191] VPort := PortToInput[DigitalPinToPort[APin]];
	ldd	r19,Y+2
	mov	r18,r1
	ldi	r30,lo8(TC_sARDUINOTOOLS_ss_DIGITALPINTOPORT)
	ldi	r31,hi8(TC_sARDUINOTOOLS_ss_DIGITALPINTOPORT)
	add	r30,r19
	adc	r31,r18
	ld	r19,Z
	mov	r18,r1
	lsl	r19
	rol	r18
	ldi	r30,lo8(TC_sARDUINOTOOLS_ss_PORTTOINPUT)
	ldi	r31,hi8(TC_sARDUINOTOOLS_ss_PORTTOINPUT)
	add	r30,r19
	adc	r31,r18
	ld	r0,Z+
	std	Y+14,r0
	ld	r0,Z
	std	Y+15,r0
# [193] if AState then
	ldd	r18,Y+3
	cp	r18,r1
	breq	.Lj6
# [194] VStateMask := VBitMask
	ldd	r0,Y+12
	std	Y+13,r0
	rjmp	.Lj9
.Lj6:
# [196] VStateMask := 0;
	std	Y+13,r1
# [198] while VPort^ and VBitMask = VStateMask do
	rjmp	.Lj9
.Lj8:
# [200] VCounter := Timer0_Counter;
	in	r0,38
	std	Y+16,r0
# [201] VLastCounter := VCounter - VLastCounter;
	ldd	r18,Y+16
	ldd	r19,Y+17
	sub	r18,r19
	std	Y+17,r18
# [202] if ATimeOut <= VLastCounter then
	ldd	r22,Y+17
	mov	r19,r1
	mov	r20,r1
	mov	r18,r1
	ldd	r21,Y+4
	ldd	r25,Y+5
	ldd	r23,Y+6
	ldd	r24,Y+7
	cp	r22,r21
	cpc	r19,r25
	cpc	r20,r23
	cpc	r18,r24
	brlo	.Lj25
# [234] end;
	rjmp	.Lj3
.Lj25:
# [204] ATimeOut := ATimeOut - VLastCounter;
	ldd	r25,Y+17
	mov	r18,r1
	mov	r19,r1
	mov	r20,r1
	ldd	r21,Y+4
	ldd	r22,Y+5
	ldd	r23,Y+6
	ldd	r24,Y+7
	sub	r21,r25
	sbc	r22,r18
	sbc	r23,r19
	sbc	r24,r20
	std	Y+4,r21
	std	Y+5,r22
	std	Y+6,r23
	std	Y+7,r24
# [205] VLastCounter := VCounter;
	ldd	r0,Y+16
	std	Y+17,r0
.Lj9:
	ldd	r18,Y+14
	ldd	r19,Y+15
	movw	r30,r18
	ld	r19,Z
	ldd	r18,Y+12
	and	r18,r19
	ldd	r19,Y+13
	cp	r18,r19
	brne	.Lj26
	rjmp	.Lj8
.Lj26:
# [208] while VPort^ and VBitMask <> VStateMask do
	rjmp	.Lj14
.Lj13:
# [210] VCounter := Timer0_Counter;
	in	r0,38
	std	Y+16,r0
# [211] VLastCounter := VCounter - VLastCounter;
	ldd	r18,Y+16
	ldd	r19,Y+17
	sub	r18,r19
	std	Y+17,r18
# [212] if ATimeOut <= VLastCounter then
	ldd	r24,Y+17
	mov	r18,r1
	mov	r19,r1
	mov	r20,r1
	ldd	r25,Y+4
	ldd	r23,Y+5
	ldd	r21,Y+6
	ldd	r22,Y+7
	cp	r24,r25
	cpc	r18,r23
	cpc	r19,r21
	cpc	r20,r22
	brlo	.Lj27
	rjmp	.Lj3
.Lj27:
# [214] ATimeOut := ATimeOut - VLastCounter;
	ldd	r25,Y+17
	mov	r18,r1
	mov	r19,r1
	mov	r20,r1
	ldd	r21,Y+4
	ldd	r22,Y+5
	ldd	r23,Y+6
	ldd	r24,Y+7
	sub	r21,r25
	sbc	r22,r18
	sbc	r23,r19
	sbc	r24,r20
	std	Y+4,r21
	std	Y+5,r22
	std	Y+6,r23
	std	Y+7,r24
# [215] VLastCounter := VCounter;
	ldd	r0,Y+16
	std	Y+17,r0
.Lj14:
	ldd	r18,Y+14
	ldd	r19,Y+15
	movw	r30,r18
	ld	r19,Z
	ldd	r18,Y+12
	and	r18,r19
	ldd	r19,Y+13
	cp	r18,r19
	breq	.Lj28
	rjmp	.Lj13
.Lj28:
# [218] Result := 0;
	mov	r18,r1
	mov	r20,r1
	mov	r19,r1
	mov	r21,r1
	std	Y+8,r18
	std	Y+9,r20
	std	Y+10,r19
	std	Y+11,r21
# [219] while VPort^ and VBitMask = VStateMask do
	rjmp	.Lj19
.Lj18:
# [221] VCounter := Timer0_Counter;
	in	r0,38
	std	Y+16,r0
# [222] VLastCounter := VCounter - VLastCounter;
	ldd	r18,Y+16
	ldd	r19,Y+17
	sub	r18,r19
	std	Y+17,r18
# [223] Result := Result + VLastCounter;
	ldd	r25,Y+17
	mov	r19,r1
	mov	r18,r1
	mov	r20,r1
	ldd	r21,Y+8
	ldd	r22,Y+9
	ldd	r23,Y+10
	ldd	r24,Y+11
	add	r21,r25
	adc	r22,r19
	adc	r23,r18
	adc	r24,r20
	std	Y+8,r21
	std	Y+9,r22
	std	Y+10,r23
	std	Y+11,r24
# [224] VLastCounter := VCounter;
	ldd	r0,Y+16
	std	Y+17,r0
# [225] if ATimeOut <= Result then
	ldd	r21,Y+4
	ldd	r22,Y+5
	ldd	r23,Y+6
	ldd	r19,Y+7
	ldd	r18,Y+8
	ldd	r20,Y+9
	ldd	r24,Y+10
	ldd	r25,Y+11
	cp	r18,r21
	cpc	r20,r22
	cpc	r24,r23
	cpc	r25,r19
	brlo	.Lj19
# [227] Result := $FFFFFFFF;
	ldi	r18,-1
	ldi	r19,-1
	ldi	r20,-1
	ldi	r21,-1
	std	Y+8,r18
	std	Y+9,r19
	std	Y+10,r20
	std	Y+11,r21
# [228] Exit;
	rjmp	.Lj3
.Lj19:
	ldd	r18,Y+14
	ldd	r19,Y+15
	movw	r30,r18
	ld	r19,Z
	ldd	r18,Y+12
	and	r18,r19
	ldd	r19,Y+13
	cp	r18,r19
	brne	.Lj29
	rjmp	.Lj18
.Lj29:
# [232] if Result <> $FFFFFFFF then
	ldd	r18,Y+8
	ldd	r21,Y+9
	ldd	r20,Y+10
	ldd	r19,Y+11
	cpi	r18,-1
	ldi	r18,-1
	cpc	r21,r18
	ldi	r18,-1
	cpc	r20,r18
	ldi	r18,-1
	cpc	r19,r18
	breq	.Lj3
# [233] Result := Result * 4;
	ldd	r18,Y+8
	ldd	r19,Y+9
	ldd	r20,Y+10
	ldd	r21,Y+11
	lsl	r18
	rol	r19
	rol	r20
	rol	r21
	lsl	r18
	rol	r19
	rol	r20
	rol	r21
	std	Y+8,r18
	std	Y+9,r19
	std	Y+10,r20
	std	Y+11,r21
.Lj3:
	ldd	r22,Y+8
	ldd	r23,Y+9
	ldd	r24,Y+10
	ldd	r25,Y+11
	subi	r28,-18
	sbci	r29,-1
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
	pop	r28
	pop	r29
	ret
.Le8:
	.size	TIMERS_ss_PULSEINsBYTEsBOOLEANsLONGWORDssLONGWORD, .Le8 - TIMERS_ss_PULSEINsBYTEsBOOLEANsLONGWORDssLONGWORD

.section .text.n_timerss_stabstracttimer_s__ss_doovfevents,"ax"
.globl	TIMERSs_sTABSTRACTTIMER_s__ss_DOOVFEVENTS
TIMERSs_sTABSTRACTTIMER_s__ss_DOOVFEVENTS:
# [276] begin
	push	r29
	push	r28
	push	r3
	push	r2
	in	r28,61
	in	r29,62
	subi	r28,9
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var $self located at r28+2, size=OS_16
# Var i located at r28+4, size=OS_8
# Var VSubscriber located at r28+5, size=OS_32
	std	Y+2,r24
	std	Y+3,r25
# [277] for i := 0 to FSubscriberOFIndex - 1 do
	ldd	r18,Y+2
	ldd	r19,Y+3
	movw	r30,r18
	ldd	r2,Z+32
	dec	r2
	ldi	r18,-1
	std	Y+4,r18
.Lj34:
	ldd	r18,Y+4
	inc	r18
	std	Y+4,r18
# [279] VSubscriber := Self.FSubscriberOVFs[i];
	ldd	r18,Y+2
	ldd	r21,Y+3
	ldd	r20,Y+4
	mov	r19,r1
	lsl	r20
	rol	r19
	lsl	r20
	rol	r19
	mov	r30,r18
	mov	r31,r21
	add	r30,r20
	adc	r31,r19
	ld	r0,Z+
	std	Y+5,r0
	ld	r0,Z+
	std	Y+6,r0
	ld	r0,Z+
	std	Y+7,r0
	ld	r0,Z
	std	Y+8,r0
# [280] if VSubscriber.Data = nil then
	ldd	r19,Y+7
	ldd	r18,Y+8
	cp	r19,r1
	cpc	r18,r1
	brne	.Lj38
# [281] TTimerInterruptProc(VSubscriber.Code)()
	ldd	r18,Y+5
	ldd	r3,Y+6
	mov	r30,r18
	mov	r31,r3
	icall
	rjmp	.Lj39
.Lj38:
# [283] TTimerInterruptEvent(VSubscriber)();
	ldd	r24,Y+7
	ldd	r25,Y+8
	ldd	r18,Y+5
	ldd	r3,Y+6
	mov	r30,r18
	mov	r31,r3
	icall
.Lj39:
	ldd	r18,Y+4
	cp	r18,r2
	brsh	.Lj40
# [285] end;
	rjmp	.Lj34
.Lj40:
	subi	r28,-9
	sbci	r29,-1
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
	pop	r2
	pop	r3
	pop	r28
	pop	r29
	ret
.Le9:
	.size	TIMERSs_sTABSTRACTTIMER_s__ss_DOOVFEVENTS, .Le9 - TIMERSs_sTABSTRACTTIMER_s__ss_DOOVFEVENTS

.section .text.n_timerss_stabstracttimer_s__ss_initsslongbool,"ax"
.globl	TIMERSs_sTABSTRACTTIMER_s__ss_INITssLONGBOOL
TIMERSs_sTABSTRACTTIMER_s__ss_INITssLONGBOOL:
# Temps allocated between r28+38 and r28+99
# [340] begin
	push	r29
	push	r28
	in	r28,61
	in	r29,62
	subi	r28,99
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var $vmt located at r28+2, size=OS_16
# Var $self located at r28+4, size=OS_16
# Var $_zero_$TIMERS_$$_TTIMERSUBSCRIBEROFS located at r28+6, size=OS_NO
	std	Y+4,r24
	std	Y+5,r25
	std	Y+2,r22
	std	Y+3,r23
	ldi	r18,lo8(2)
	ldi	r23,hi8(2)
	add	r18,r28
	adc	r23,r29
	mov	r22,r18
	ldd	r24,Y+4
	ldd	r25,Y+5
	ldi	r18,42
	mov	r19,r1
	mov	r20,r1
	mov	r21,r1
	call	fpc_help_constructor
	std	Y+4,r24
	std	Y+5,r25
	ldd	r18,Y+4
	ldd	r19,Y+5
	cp	r18,r1
	cpc	r19,r1
	brne	.Lj56
# [342] end;
	rjmp	.Lj44
.Lj56:
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
	breq	.Lj57
	rjmp	.Lj52
.Lj57:
	ldi	r18,lo8(6)
	ldi	r19,hi8(6)
	add	r18,r28
	adc	r19,r29
	ldi	r30,lo8(68)
	ldi	r31,hi8(68)
	add	r30,r28
	adc	r31,r29
	st	Z+,r18
	st	Z,r19
	ldi	r30,lo8(68)
	ldi	r31,hi8(68)
	add	r30,r28
	adc	r31,r29
	ld	r24,Z+
	ld	r25,Z
	mov	r20,r1
	ldi	r22,32
	mov	r23,r1
	call	SYSTEM_ss_FILLCHARsformalsSMALLINTsBYTE
# [341] FSubscriberOVFs := Default(TTimerSubscriberOFs);
	ldd	r19,Y+4
	ldd	r20,Y+5
	ldi	r18,32
	ldi	r30,lo8(6)
	ldi	r31,hi8(6)
	add	r30,r28
	adc	r31,r29
	mov	r26,r19
	mov	r27,r20
.Lj53:
	ld	r0,Z+
	st	X+,r0
	dec	r18
	brne	.Lj53
.Lj52:
	call	fpc_popaddrstack
	ldi	r30,lo8(67)
	ldi	r31,hi8(67)
	add	r30,r28
	adc	r31,r29
	ld	r18,Z
	cp	r18,r1
	brne	.Lj58
	rjmp	.Lj50
.Lj58:
	ldi	r20,lo8(70)
	ldi	r21,hi8(70)
	add	r20,r28
	adc	r21,r29
	ldi	r22,lo8(76)
	ldi	r23,hi8(76)
	add	r22,r28
	adc	r23,r29
	ldi	r24,1
	mov	r25,r1
	call	fpc_pushexceptaddr
	call	fpc_setjmp
	ldi	r30,lo8(68)
	ldi	r31,hi8(68)
	add	r30,r28
	adc	r31,r29
	st	Z,r24
	cp	r24,r1
	brne	.Lj54
	ldi	r22,lo8(2)
	ldi	r23,hi8(2)
	add	r22,r28
	adc	r23,r29
	ldd	r24,Y+4
	ldd	r25,Y+5
	ldi	r18,42
	mov	r19,r1
	mov	r20,r1
	mov	r21,r1
	call	fpc_help_fail
	call	fpc_popaddrstack
	call	fpc_reraise
.Lj54:
	call	fpc_popaddrstack
	ldi	r30,lo8(68)
	ldi	r31,hi8(68)
	add	r30,r28
	adc	r31,r29
	ld	r18,Z
	cp	r18,r1
	breq	.Lj55
	call	fpc_raise_nested
.Lj55:
	call	fpc_doneexception
.Lj50:
.Lj44:
	ldd	r24,Y+4
	ldd	r25,Y+5
	subi	r28,-99
	sbci	r29,-1
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
	pop	r28
	pop	r29
	ret
.Le10:
	.size	TIMERSs_sTABSTRACTTIMER_s__ss_INITssLONGBOOL, .Le10 - TIMERSs_sTABSTRACTTIMER_s__ss_INITssLONGBOOL

.section .text.n_timerss_stabstracttimer_s__ss_indexofovfeventsttimerinterrupteventssshortint,"ax"
.globl	TIMERSs_sTABSTRACTTIMER_s__ss_INDEXOFOVFEVENTsTTIMERINTERRUPTEVENTssSHORTINT
TIMERSs_sTABSTRACTTIMER_s__ss_INDEXOFOVFEVENTsTTIMERINTERRUPTEVENTssSHORTINT:
# [347] begin
	push	r29
	push	r28
	in	r28,61
	in	r29,62
	subi	r28,10
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var AEvent located at r28+2, size=OS_32
# Var $self located at r28+6, size=OS_16
# Var $result located at r28+8, size=OS_S8
# Var i located at r28+9, size=OS_8
	std	Y+6,r24
	std	Y+7,r25
	std	Y+2,r20
	std	Y+3,r21
	std	Y+4,r22
	std	Y+5,r23
# [348] Result := -1;
	ldi	r18,-1
	std	Y+8,r18
# [349] for i := 1 to FSubscriberOFIndex do
	ldd	r18,Y+6
	ldd	r19,Y+7
	movw	r30,r18
	ldd	r22,Z+32
	cpi	r22,1
	brsh	.Lj69
# [355] end;
	rjmp	.Lj59
.Lj69:
	std	Y+9,r1
.Lj63:
	ldd	r18,Y+9
	inc	r18
	std	Y+9,r18
# [350] if (FSubscriberOVFs[i].Data = TMethod(AEvent).Data) and (FSubscriberOVFs[i].Code = TMethod(AEvent).Code) then
	ldd	r20,Y+6
	ldd	r18,Y+7
	ldd	r21,Y+9
	mov	r19,r1
	lsl	r21
	rol	r19
	lsl	r21
	rol	r19
	mov	r30,r20
	mov	r31,r18
	add	r30,r21
	adc	r31,r19
	adiw	r30,2
	ld	r18,Z+
	ld	r19,Z
	ldd	r20,Y+4
	ldd	r21,Y+5
	cp	r18,r20
	cpc	r19,r21
	brne	.Lj67
	ldd	r20,Y+6
	ldd	r21,Y+7
	ldd	r19,Y+9
	mov	r18,r1
	lsl	r19
	rol	r18
	lsl	r19
	rol	r18
	movw	r30,r20
	add	r30,r19
	adc	r31,r18
	ld	r19,Z+
	ld	r20,Z
	ldd	r21,Y+2
	ldd	r18,Y+3
	cp	r19,r21
	cpc	r20,r18
	brne	.Lj67
# [352] Result := i;
	ldd	r0,Y+9
	std	Y+8,r0
# [353] Exit;
	rjmp	.Lj59
.Lj67:
	ldd	r18,Y+9
	cp	r18,r22
	brsh	.Lj70
	rjmp	.Lj63
.Lj70:
.Lj59:
	ldd	r24,Y+8
	subi	r28,-10
	sbci	r29,-1
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
	pop	r28
	pop	r29
	ret
.Le11:
	.size	TIMERSs_sTABSTRACTTIMER_s__ss_INDEXOFOVFEVENTsTTIMERINTERRUPTEVENTssSHORTINT, .Le11 - TIMERSs_sTABSTRACTTIMER_s__ss_INDEXOFOVFEVENTsTTIMERINTERRUPTEVENTssSHORTINT

.section .text.n_timerss_stabstracttimer_s__ss_subscribeovfeventsttimerinterrupteventssshortint,"ax"
.globl	TIMERSs_sTABSTRACTTIMER_s__ss_SUBSCRIBEOVFEVENTsTTIMERINTERRUPTEVENTssSHORTINT
TIMERSs_sTABSTRACTTIMER_s__ss_SUBSCRIBEOVFEVENTsTTIMERINTERRUPTEVENTssSHORTINT:
# [358] begin
	push	r29
	push	r28
	push	r2
	in	r28,61
	in	r29,62
	subi	r28,9
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var AEvent located at r28+2, size=OS_32
# Var $self located at r28+6, size=OS_16
# Var $result located at r28+8, size=OS_S8
	std	Y+6,r24
	std	Y+7,r25
	std	Y+2,r20
	std	Y+3,r21
	std	Y+4,r22
	std	Y+5,r23
# [359] Result := -1;
	ldi	r18,-1
	std	Y+8,r18
# [360] if FSubscriberOFIndex = MAX_INTERRUPT_EVENT_SUBSCRIBES then
	ldd	r18,Y+6
	ldd	r19,Y+7
	movw	r30,r18
	ldd	r18,Z+32
	cpi	r18,8
	brne	.Lj79
# [371] end;
	rjmp	.Lj71
.Lj79:
# [362] Result := IndexOfOVFEvent(AEvent);
	ldd	r24,Y+6
	ldd	r25,Y+7
	ldd	r20,Y+2
	ldd	r21,Y+3
	ldd	r22,Y+4
	ldd	r23,Y+5
	call	TIMERSs_sTABSTRACTTIMER_s__ss_INDEXOFOVFEVENTsTTIMERINTERRUPTEVENTssSHORTINT
	std	Y+8,r24
# [363] if Result = -1 then
	ldd	r18,Y+8
	cpi	r18,-1
	breq	.Lj80
	rjmp	.Lj71
.Lj80:
# [365] FSubscriberOVFs[FSubscriberOFIndex] := TMethod(AEvent);
	ldd	r20,Y+6
	ldd	r21,Y+7
	ldd	r19,Y+6
	ldd	r18,Y+7
	mov	r30,r19
	mov	r31,r18
	ldd	r19,Z+32
	mov	r18,r1
	lsl	r19
	rol	r18
	lsl	r19
	rol	r18
	movw	r30,r20
	add	r30,r19
	adc	r31,r18
	ldd	r0,Y+2
	st	Z+,r0
	ldd	r0,Y+3
	st	Z+,r0
	ldd	r0,Y+4
	st	Z+,r0
	ldd	r0,Y+5
	st	Z,r0
# [366] Result := FSubscriberOFIndex;
	ldd	r18,Y+6
	ldd	r19,Y+7
	movw	r30,r18
	adiw	r30,32
	ld	r0,Z
	std	Y+8,r0
# [367] Inc(FSubscriberOFIndex);
	ldd	r18,Y+6
	ldd	r19,Y+7
	movw	r30,r18
	ldd	r20,Z+32
	inc	r20
	movw	r30,r18
	std	Z+32,r20
# [368] if FSubscriberOFIndex = 1 then
	ldd	r18,Y+6
	ldd	r19,Y+7
	movw	r30,r18
	ldd	r18,Z+32
	cpi	r18,1
	brne	.Lj71
# [369] SetCounterModes(CounterModes + [tcmOverflow]);
	ldd	r24,Y+6
	ldd	r25,Y+7
	ldd	r18,Y+6
	ldd	r19,Y+7
	movw	r30,r18
	ldd	r18,Z+42
	ldd	r19,Z+43
	movw	r30,r18
	ldd	r18,Z+6
	ldd	r2,Z+7
	mov	r30,r18
	mov	r31,r2
	icall
	mov	r22,r24
	ori	r22,1
	ldd	r24,Y+6
	ldd	r25,Y+7
	ldd	r18,Y+6
	ldd	r19,Y+7
	movw	r30,r18
	ldd	r18,Z+42
	ldd	r19,Z+43
	movw	r30,r18
	ldd	r18,Z+8
	ldd	r2,Z+9
	mov	r30,r18
	mov	r31,r2
	icall
.Lj71:
	ldd	r24,Y+8
	subi	r28,-9
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
.Le12:
	.size	TIMERSs_sTABSTRACTTIMER_s__ss_SUBSCRIBEOVFEVENTsTTIMERINTERRUPTEVENTssSHORTINT, .Le12 - TIMERSs_sTABSTRACTTIMER_s__ss_SUBSCRIBEOVFEVENTsTTIMERINTERRUPTEVENTssSHORTINT

.section .text.n_timerss_stabstracttimer_s__ss_subscribeovfprocsttimerinterruptprocssshortint,"ax"
.globl	TIMERSs_sTABSTRACTTIMER_s__ss_SUBSCRIBEOVFPROCsTTIMERINTERRUPTPROCssSHORTINT
TIMERSs_sTABSTRACTTIMER_s__ss_SUBSCRIBEOVFPROCsTTIMERINTERRUPTPROCssSHORTINT:
# [376] begin
	push	r29
	push	r28
	in	r28,61
	in	r29,62
	subi	r28,11
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var AProc located at r28+2, size=OS_16
# Var $self located at r28+4, size=OS_16
# Var $result located at r28+6, size=OS_S8
# Var VMethod located at r28+7, size=OS_32
	std	Y+4,r24
	std	Y+5,r25
	std	Y+2,r22
	std	Y+3,r23
# [377] VMethod.Data := nil;
	mov	r18,r1
	mov	r19,r1
	std	Y+9,r18
	std	Y+10,r19
# [378] VMethod.Code := AProc;
	ldd	r0,Y+2
	std	Y+7,r0
	ldd	r0,Y+3
	std	Y+8,r0
# [379] Result := SubscribeOVFEvent(TTimerInterruptEvent(VMethod));
	ldd	r20,Y+7
	ldd	r21,Y+8
	ldd	r22,Y+9
	ldd	r23,Y+10
	ldd	r24,Y+4
	ldd	r25,Y+5
	call	TIMERSs_sTABSTRACTTIMER_s__ss_SUBSCRIBEOVFEVENTsTTIMERINTERRUPTEVENTssSHORTINT
	std	Y+6,r24
# [380] end;
	ldd	r24,Y+6
	subi	r28,-11
	sbci	r29,-1
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
	pop	r28
	pop	r29
	ret
.Le13:
	.size	TIMERSs_sTABSTRACTTIMER_s__ss_SUBSCRIBEOVFPROCsTTIMERINTERRUPTPROCssSHORTINT, .Le13 - TIMERSs_sTABSTRACTTIMER_s__ss_SUBSCRIBEOVFPROCsTTIMERINTERRUPTPROCssSHORTINT

.section .text.n_timerss_stabstracttimer_s__ss_unsubscribeovfeventsttimerinterruptevent,"ax"
.globl	TIMERSs_sTABSTRACTTIMER_s__ss_UNSUBSCRIBEOVFEVENTsTTIMERINTERRUPTEVENT
TIMERSs_sTABSTRACTTIMER_s__ss_UNSUBSCRIBEOVFEVENTsTTIMERINTERRUPTEVENT:
# [385] begin
	push	r29
	push	r28
	push	r2
	in	r28,61
	in	r29,62
	subi	r28,9
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var AEvent located at r28+2, size=OS_32
# Var $self located at r28+6, size=OS_16
# Var i located at r28+8, size=OS_8
	std	Y+6,r24
	std	Y+7,r25
	std	Y+2,r20
	std	Y+3,r21
	std	Y+4,r22
	std	Y+5,r23
# [386] if FSubscriberOFIndex = 0 then
	ldd	r18,Y+6
	ldd	r19,Y+7
	movw	r30,r18
	ldd	r18,Z+32
	cp	r18,r1
	brne	.Lj95
# [397] end;
	rjmp	.Lj83
.Lj95:
# [388] for i := 1 to MAX_INTERRUPT_EVENT_SUBSCRIBES do
	ldi	r18,1
	std	Y+8,r18
.Lj87:
# [389] if (FSubscriberOVFs[i].Data = TMethod(AEvent).Data) and (FSubscriberOVFs[i].Code = TMethod(AEvent).Code) then
	ldd	r18,Y+6
	ldd	r19,Y+7
	ldd	r21,Y+8
	mov	r20,r1
	lsl	r21
	rol	r20
	lsl	r21
	rol	r20
	movw	r30,r18
	add	r30,r21
	adc	r31,r20
	adiw	r30,2
	ld	r20,Z+
	ld	r19,Z
	ldd	r21,Y+4
	ldd	r18,Y+5
	cp	r20,r21
	cpc	r19,r18
	breq	.Lj96
	rjmp	.Lj91
.Lj96:
	ldd	r20,Y+6
	ldd	r21,Y+7
	ldd	r19,Y+8
	mov	r18,r1
	lsl	r19
	rol	r18
	lsl	r19
	rol	r18
	movw	r30,r20
	add	r30,r19
	adc	r31,r18
	ld	r19,Z+
	ld	r20,Z
	ldd	r21,Y+2
	ldd	r18,Y+3
	cp	r19,r21
	cpc	r20,r18
	breq	.Lj97
	rjmp	.Lj91
.Lj97:
# [391] Move(FSubscriberOVFs[i + 1], FSubscriberOVFs[i], (FSubscriberOFIndex - i - 1));
	ldd	r18,Y+6
	ldd	r19,Y+7
	movw	r30,r18
	ldd	r20,Z+32
	mov	r21,r1
	ldd	r19,Y+8
	mov	r18,r1
	sub	r20,r19
	sbc	r21,r18
	subi	r20,1
	sbc	r21,r1
	ldd	r22,Y+6
	ldd	r23,Y+7
	ldd	r19,Y+8
	mov	r18,r1
	lsl	r19
	rol	r18
	lsl	r19
	rol	r18
	ldi	r24,lo8(4)
	ldi	r25,hi8(4)
	add	r24,r22
	adc	r25,r23
	add	r24,r19
	adc	r25,r18
	ldd	r22,Y+6
	ldd	r23,Y+7
	ldd	r19,Y+8
	mov	r18,r1
	lsl	r19
	rol	r18
	lsl	r19
	rol	r18
	add	r22,r19
	adc	r23,r18
	call	SYSTEM_ss_MOVEsformalsformalsSMALLINT
# [392] Dec(FSubscriberOFIndex);
	ldd	r18,Y+6
	ldd	r19,Y+7
	movw	r30,r18
	ldd	r20,Z+32
	dec	r20
	movw	r30,r18
	std	Z+32,r20
# [393] if FSubscriberOFIndex = 0 then
	ldd	r18,Y+6
	ldd	r19,Y+7
	movw	r30,r18
	ldd	r18,Z+32
	cp	r18,r1
	breq	.Lj98
	rjmp	.Lj83
.Lj98:
# [394] SetCounterModes(CounterModes - [tcmOverflow]);
	ldd	r24,Y+6
	ldd	r25,Y+7
	ldd	r18,Y+6
	ldd	r19,Y+7
	movw	r30,r18
	ldd	r18,Z+42
	ldd	r19,Z+43
	movw	r30,r18
	ldd	r18,Z+6
	ldd	r2,Z+7
	mov	r30,r18
	mov	r31,r2
	icall
	mov	r22,r24
	andi	r22,-2
	ldd	r24,Y+6
	ldd	r25,Y+7
	ldd	r18,Y+6
	ldd	r19,Y+7
	movw	r30,r18
	ldd	r18,Z+42
	ldd	r19,Z+43
	movw	r30,r18
	ldd	r18,Z+8
	ldd	r2,Z+9
	mov	r30,r18
	mov	r31,r2
	icall
# [395] Exit;
	rjmp	.Lj83
.Lj91:
	ldd	r18,Y+8
	inc	r18
	std	Y+8,r18
	ldd	r19,Y+8
	ldi	r18,8
	cp	r18,r19
	brlo	.Lj99
	rjmp	.Lj87
.Lj99:
.Lj83:
	subi	r28,-9
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
.Le14:
	.size	TIMERSs_sTABSTRACTTIMER_s__ss_UNSUBSCRIBEOVFEVENTsTTIMERINTERRUPTEVENT, .Le14 - TIMERSs_sTABSTRACTTIMER_s__ss_UNSUBSCRIBEOVFEVENTsTTIMERINTERRUPTEVENT

.section .text.n_timerss_stabstracttimer_s__ss_unsubscribeovfprocsttimerinterruptproc,"ax"
.globl	TIMERSs_sTABSTRACTTIMER_s__ss_UNSUBSCRIBEOVFPROCsTTIMERINTERRUPTPROC
TIMERSs_sTABSTRACTTIMER_s__ss_UNSUBSCRIBEOVFPROCsTTIMERINTERRUPTPROC:
# [402] begin
	push	r29
	push	r28
	in	r28,61
	in	r29,62
	subi	r28,10
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var AProc located at r28+2, size=OS_16
# Var $self located at r28+4, size=OS_16
# Var VMethod located at r28+6, size=OS_32
	std	Y+4,r24
	std	Y+5,r25
	std	Y+2,r22
	std	Y+3,r23
# [403] VMethod.Code := AProc;
	ldd	r0,Y+2
	std	Y+6,r0
	ldd	r0,Y+3
	std	Y+7,r0
# [404] VMethod.Data := nil;
	mov	r18,r1
	mov	r19,r1
	std	Y+8,r18
	std	Y+9,r19
# [405] UnsubscribeOVFEvent(TTimerInterruptEvent(VMethod));
	ldd	r20,Y+6
	ldd	r21,Y+7
	ldd	r22,Y+8
	ldd	r23,Y+9
	ldd	r24,Y+4
	ldd	r25,Y+5
	call	TIMERSs_sTABSTRACTTIMER_s__ss_UNSUBSCRIBEOVFEVENTsTTIMERINTERRUPTEVENT
# [406] end;
	subi	r28,-10
	sbci	r29,-1
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
	pop	r28
	pop	r29
	ret
.Le15:
	.size	TIMERSs_sTABSTRACTTIMER_s__ss_UNSUBSCRIBEOVFPROCsTTIMERINTERRUPTPROC, .Le15 - TIMERSs_sTABSTRACTTIMER_s__ss_UNSUBSCRIBEOVFPROCsTTIMERINTERRUPTPROC

.section .text.n_timerss_stabstracttimer_s__ss_setcompareaeventsttimerinterruptevent,"ax"
.globl	TIMERSs_sTABSTRACTTIMER_s__ss_SETCOMPAREAEVENTsTTIMERINTERRUPTEVENT
TIMERSs_sTABSTRACTTIMER_s__ss_SETCOMPAREAEVENTsTTIMERINTERRUPTEVENT:
# [409] begin
	push	r29
	push	r28
	push	r2
	in	r28,61
	in	r29,62
	subi	r28,8
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var AEvent located at r28+2, size=OS_32
# Var $self located at r28+6, size=OS_16
	std	Y+6,r24
	std	Y+7,r25
	std	Y+2,r20
	std	Y+3,r21
	std	Y+4,r22
	std	Y+5,r23
# [410] if (AEvent <> nil) and (TMethod(AEvent).Code <> nil) then
	ldd	r18,Y+2
	ldd	r19,Y+3
	cp	r18,r1
	cpc	r19,r1
	brne	.Lj108
# [416] end;
	rjmp	.Lj105
.Lj108:
	ldd	r18,Y+2
	ldd	r19,Y+3
	cp	r18,r1
	cpc	r19,r1
	brne	.Lj109
	rjmp	.Lj105
.Lj109:
# [412] FCompareAEvent := AEvent;
	ldd	r18,Y+6
	ldd	r19,Y+7
	movw	r30,r18
	adiw	r30,34
	ldd	r0,Y+2
	st	Z+,r0
	ldd	r0,Y+3
	st	Z+,r0
	ldd	r0,Y+4
	st	Z+,r0
	ldd	r0,Y+5
	st	Z,r0
# [413] SetCounterModes(CounterModes + [tcmCompareA]);
	ldd	r24,Y+6
	ldd	r25,Y+7
	ldd	r18,Y+6
	ldd	r19,Y+7
	movw	r30,r18
	ldd	r18,Z+42
	ldd	r19,Z+43
	movw	r30,r18
	ldd	r18,Z+6
	ldd	r2,Z+7
	mov	r30,r18
	mov	r31,r2
	icall
	mov	r22,r24
	ori	r22,2
	ldd	r24,Y+6
	ldd	r25,Y+7
	ldd	r18,Y+6
	ldd	r19,Y+7
	movw	r30,r18
	ldd	r18,Z+42
	ldd	r19,Z+43
	movw	r30,r18
	ldd	r18,Z+8
	ldd	r2,Z+9
	mov	r30,r18
	mov	r31,r2
	icall
	rjmp	.Lj107
.Lj105:
# [415] ClearCompareAEvent;
	ldd	r24,Y+6
	ldd	r25,Y+7
	call	TIMERSs_sTABSTRACTTIMER_s__ss_CLEARCOMPAREAEVENT
.Lj107:
	subi	r28,-8
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
.Le16:
	.size	TIMERSs_sTABSTRACTTIMER_s__ss_SETCOMPAREAEVENTsTTIMERINTERRUPTEVENT, .Le16 - TIMERSs_sTABSTRACTTIMER_s__ss_SETCOMPAREAEVENTsTTIMERINTERRUPTEVENT

.section .text.n_timerss_stabstracttimer_s__ss_setcompareaprocsttimerinterruptproc,"ax"
.globl	TIMERSs_sTABSTRACTTIMER_s__ss_SETCOMPAREAPROCsTTIMERINTERRUPTPROC
TIMERSs_sTABSTRACTTIMER_s__ss_SETCOMPAREAPROCsTTIMERINTERRUPTPROC:
# [419] begin
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
# Var AProc located at r28+2, size=OS_16
# Var $self located at r28+4, size=OS_16
	std	Y+4,r24
	std	Y+5,r25
	std	Y+2,r22
	std	Y+3,r23
# [420] if AProc <> nil then
	ldd	r18,Y+2
	ldd	r19,Y+3
	cp	r18,r1
	cpc	r19,r1
	brne	.Lj115
# [427] end;
	rjmp	.Lj113
.Lj115:
# [422] TMethod(FCompareAEvent).Code := AProc;
	ldd	r18,Y+4
	ldd	r19,Y+5
	movw	r30,r18
	adiw	r30,34
	ldd	r0,Y+2
	st	Z+,r0
	ldd	r0,Y+3
	st	Z,r0
# [423] TMethod(FCompareAEvent).Data := nil;
	ldd	r20,Y+4
	ldd	r21,Y+5
	mov	r19,r1
	mov	r18,r1
	movw	r30,r20
	std	Z+37,r18
	std	Z+36,r19
# [424] SetCounterModes(CounterModes + [tcmCompareA]);
	ldd	r24,Y+4
	ldd	r25,Y+5
	ldd	r18,Y+4
	ldd	r19,Y+5
	movw	r30,r18
	ldd	r18,Z+42
	ldd	r19,Z+43
	movw	r30,r18
	ldd	r18,Z+6
	ldd	r2,Z+7
	mov	r30,r18
	mov	r31,r2
	icall
	mov	r22,r24
	ori	r22,2
	ldd	r24,Y+4
	ldd	r25,Y+5
	ldd	r18,Y+4
	ldd	r19,Y+5
	movw	r30,r18
	ldd	r18,Z+42
	ldd	r19,Z+43
	movw	r30,r18
	ldd	r18,Z+8
	ldd	r2,Z+9
	mov	r30,r18
	mov	r31,r2
	icall
	rjmp	.Lj114
.Lj113:
# [426] ClearCompareAEvent;
	ldd	r24,Y+4
	ldd	r25,Y+5
	call	TIMERSs_sTABSTRACTTIMER_s__ss_CLEARCOMPAREAEVENT
.Lj114:
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
.Le17:
	.size	TIMERSs_sTABSTRACTTIMER_s__ss_SETCOMPAREAPROCsTTIMERINTERRUPTPROC, .Le17 - TIMERSs_sTABSTRACTTIMER_s__ss_SETCOMPAREAPROCsTTIMERINTERRUPTPROC

.section .text.n_timerss_stabstracttimer_s__ss_clearcompareaevent,"ax"
.globl	TIMERSs_sTABSTRACTTIMER_s__ss_CLEARCOMPAREAEVENT
TIMERSs_sTABSTRACTTIMER_s__ss_CLEARCOMPAREAEVENT:
# Temps allocated between r28+8 and r28+10
# [430] begin
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
# Var $self located at r28+2, size=OS_16
# Var $_zero_$TIMERS_$$_TTIMERINTERRUPTEVENT located at r28+4, size=OS_32
	std	Y+2,r24
	std	Y+3,r25
	ldi	r18,lo8(4)
	ldi	r19,hi8(4)
	add	r18,r28
	adc	r19,r29
	std	Y+8,r18
	std	Y+9,r19
	ldd	r24,Y+8
	ldd	r25,Y+9
	mov	r20,r1
	ldi	r22,4
	mov	r23,r1
	call	SYSTEM_ss_FILLCHARsformalsSMALLINTsBYTE
# [431] FCompareAEvent := Default(TTimerInterruptEvent);
	ldd	r18,Y+2
	ldd	r19,Y+3
	movw	r30,r18
	adiw	r30,34
	ldd	r0,Y+4
	st	Z+,r0
	ldd	r0,Y+5
	st	Z+,r0
	ldd	r0,Y+6
	st	Z+,r0
	ldd	r0,Y+7
	st	Z,r0
# [432] SetCounterModes(CounterModes - [tcmCompareA]);
	ldd	r24,Y+2
	ldd	r25,Y+3
	ldd	r18,Y+2
	ldd	r19,Y+3
	movw	r30,r18
	ldd	r18,Z+42
	ldd	r19,Z+43
	movw	r30,r18
	ldd	r18,Z+6
	ldd	r2,Z+7
	mov	r30,r18
	mov	r31,r2
	icall
	mov	r22,r24
	andi	r22,-3
	ldd	r24,Y+2
	ldd	r25,Y+3
	ldd	r18,Y+2
	ldd	r19,Y+3
	movw	r30,r18
	ldd	r18,Z+42
	ldd	r19,Z+43
	movw	r30,r18
	ldd	r18,Z+8
	ldd	r2,Z+9
	mov	r30,r18
	mov	r31,r2
	icall
# [433] end;
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
.Le18:
	.size	TIMERSs_sTABSTRACTTIMER_s__ss_CLEARCOMPAREAEVENT, .Le18 - TIMERSs_sTABSTRACTTIMER_s__ss_CLEARCOMPAREAEVENT

.section .text.n_timerss_stabstracttimer_s__ss_setcomparebeventsttimerinterruptevent,"ax"
.globl	TIMERSs_sTABSTRACTTIMER_s__ss_SETCOMPAREBEVENTsTTIMERINTERRUPTEVENT
TIMERSs_sTABSTRACTTIMER_s__ss_SETCOMPAREBEVENTsTTIMERINTERRUPTEVENT:
# [436] begin
	push	r29
	push	r28
	push	r2
	in	r28,61
	in	r29,62
	subi	r28,8
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var AEvent located at r28+2, size=OS_32
# Var $self located at r28+6, size=OS_16
	std	Y+6,r24
	std	Y+7,r25
	std	Y+2,r20
	std	Y+3,r21
	std	Y+4,r22
	std	Y+5,r23
# [437] if (AEvent <> nil) and (TMethod(AEvent).Code <> nil) then
	ldd	r18,Y+2
	ldd	r19,Y+3
	cp	r18,r1
	cpc	r19,r1
	brne	.Lj124
# [443] end;
	rjmp	.Lj121
.Lj124:
	ldd	r18,Y+2
	ldd	r19,Y+3
	cp	r18,r1
	cpc	r19,r1
	brne	.Lj125
	rjmp	.Lj121
.Lj125:
# [439] FCompareBEvent := AEvent;
	ldd	r18,Y+6
	ldd	r19,Y+7
	movw	r30,r18
	adiw	r30,38
	ldd	r0,Y+2
	st	Z+,r0
	ldd	r0,Y+3
	st	Z+,r0
	ldd	r0,Y+4
	st	Z+,r0
	ldd	r0,Y+5
	st	Z,r0
# [440] SetCounterModes(CounterModes + [tcmCompareB]);
	ldd	r24,Y+6
	ldd	r25,Y+7
	ldd	r18,Y+6
	ldd	r19,Y+7
	movw	r30,r18
	ldd	r18,Z+42
	ldd	r19,Z+43
	movw	r30,r18
	ldd	r18,Z+6
	ldd	r2,Z+7
	mov	r30,r18
	mov	r31,r2
	icall
	mov	r22,r24
	ori	r22,4
	ldd	r24,Y+6
	ldd	r25,Y+7
	ldd	r18,Y+6
	ldd	r19,Y+7
	movw	r30,r18
	ldd	r18,Z+42
	ldd	r19,Z+43
	movw	r30,r18
	ldd	r18,Z+8
	ldd	r2,Z+9
	mov	r30,r18
	mov	r31,r2
	icall
	rjmp	.Lj123
.Lj121:
# [442] ClearCompareBEvent;
	ldd	r24,Y+6
	ldd	r25,Y+7
	call	TIMERSs_sTABSTRACTTIMER_s__ss_CLEARCOMPAREBEVENT
.Lj123:
	subi	r28,-8
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
.Le19:
	.size	TIMERSs_sTABSTRACTTIMER_s__ss_SETCOMPAREBEVENTsTTIMERINTERRUPTEVENT, .Le19 - TIMERSs_sTABSTRACTTIMER_s__ss_SETCOMPAREBEVENTsTTIMERINTERRUPTEVENT

.section .text.n_timerss_stabstracttimer_s__ss_setcomparebprocsttimerinterruptproc,"ax"
.globl	TIMERSs_sTABSTRACTTIMER_s__ss_SETCOMPAREBPROCsTTIMERINTERRUPTPROC
TIMERSs_sTABSTRACTTIMER_s__ss_SETCOMPAREBPROCsTTIMERINTERRUPTPROC:
# [446] begin
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
# Var AProc located at r28+2, size=OS_16
# Var $self located at r28+4, size=OS_16
	std	Y+4,r24
	std	Y+5,r25
	std	Y+2,r22
	std	Y+3,r23
# [447] if AProc <> nil then
	ldd	r18,Y+2
	ldd	r19,Y+3
	cp	r18,r1
	cpc	r19,r1
	brne	.Lj131
# [454] end;
	rjmp	.Lj129
.Lj131:
# [449] TMethod(FCompareBEvent).Code := AProc;
	ldd	r18,Y+4
	ldd	r19,Y+5
	movw	r30,r18
	adiw	r30,38
	ldd	r0,Y+2
	st	Z+,r0
	ldd	r0,Y+3
	st	Z,r0
# [450] TMethod(FCompareBEvent).Data := nil;
	ldd	r20,Y+4
	ldd	r21,Y+5
	mov	r19,r1
	mov	r18,r1
	movw	r30,r20
	std	Z+41,r18
	std	Z+40,r19
# [451] SetCounterModes(CounterModes + [tcmCompareB]);
	ldd	r24,Y+4
	ldd	r25,Y+5
	ldd	r18,Y+4
	ldd	r19,Y+5
	movw	r30,r18
	ldd	r18,Z+42
	ldd	r19,Z+43
	movw	r30,r18
	ldd	r18,Z+6
	ldd	r2,Z+7
	mov	r30,r18
	mov	r31,r2
	icall
	mov	r22,r24
	ori	r22,4
	ldd	r24,Y+4
	ldd	r25,Y+5
	ldd	r18,Y+4
	ldd	r19,Y+5
	movw	r30,r18
	ldd	r18,Z+42
	ldd	r19,Z+43
	movw	r30,r18
	ldd	r18,Z+8
	ldd	r2,Z+9
	mov	r30,r18
	mov	r31,r2
	icall
	rjmp	.Lj130
.Lj129:
# [453] ClearCompareBEvent;
	ldd	r24,Y+4
	ldd	r25,Y+5
	call	TIMERSs_sTABSTRACTTIMER_s__ss_CLEARCOMPAREBEVENT
.Lj130:
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
.Le20:
	.size	TIMERSs_sTABSTRACTTIMER_s__ss_SETCOMPAREBPROCsTTIMERINTERRUPTPROC, .Le20 - TIMERSs_sTABSTRACTTIMER_s__ss_SETCOMPAREBPROCsTTIMERINTERRUPTPROC

.section .text.n_timerss_stabstracttimer_s__ss_clearcomparebevent,"ax"
.globl	TIMERSs_sTABSTRACTTIMER_s__ss_CLEARCOMPAREBEVENT
TIMERSs_sTABSTRACTTIMER_s__ss_CLEARCOMPAREBEVENT:
# Temps allocated between r28+8 and r28+10
# [457] begin
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
# Var $self located at r28+2, size=OS_16
# Var $_zero_$TIMERS_$$_TTIMERINTERRUPTEVENT located at r28+4, size=OS_32
	std	Y+2,r24
	std	Y+3,r25
	ldi	r18,lo8(4)
	ldi	r19,hi8(4)
	add	r18,r28
	adc	r19,r29
	std	Y+8,r18
	std	Y+9,r19
	ldd	r24,Y+8
	ldd	r25,Y+9
	mov	r20,r1
	ldi	r22,4
	mov	r23,r1
	call	SYSTEM_ss_FILLCHARsformalsSMALLINTsBYTE
# [458] FCompareBEvent := Default(TTimerInterruptEvent);
	ldd	r18,Y+2
	ldd	r19,Y+3
	movw	r30,r18
	adiw	r30,38
	ldd	r0,Y+4
	st	Z+,r0
	ldd	r0,Y+5
	st	Z+,r0
	ldd	r0,Y+6
	st	Z+,r0
	ldd	r0,Y+7
	st	Z,r0
# [459] SetCounterModes(CounterModes - [tcmCompareB]);
	ldd	r24,Y+2
	ldd	r25,Y+3
	ldd	r18,Y+2
	ldd	r19,Y+3
	movw	r30,r18
	ldd	r18,Z+42
	ldd	r19,Z+43
	movw	r30,r18
	ldd	r18,Z+6
	ldd	r2,Z+7
	mov	r30,r18
	mov	r31,r2
	icall
	mov	r22,r24
	andi	r22,-5
	ldd	r24,Y+2
	ldd	r25,Y+3
	ldd	r18,Y+2
	ldd	r19,Y+3
	movw	r30,r18
	ldd	r18,Z+42
	ldd	r19,Z+43
	movw	r30,r18
	ldd	r18,Z+8
	ldd	r2,Z+9
	mov	r30,r18
	mov	r31,r2
	icall
# [460] end;
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
.Le21:
	.size	TIMERSs_sTABSTRACTTIMER_s__ss_CLEARCOMPAREBEVENT, .Le21 - TIMERSs_sTABSTRACTTIMER_s__ss_CLEARCOMPAREBEVENT

.section .text.n_timerss_sttimer0_s__ss_getcounterssbyte,"ax"
.globl	TIMERSs_sTTIMER0_s__ss_GETCOUNTERssBYTE
TIMERSs_sTTIMER0_s__ss_GETCOUNTERssBYTE:
# [465] begin
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
# [466] Result := TCNT0;
	in	r0,38
	std	Y+4,r0
# [467] end;
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
.Le22:
	.size	TIMERSs_sTTIMER0_s__ss_GETCOUNTERssBYTE, .Le22 - TIMERSs_sTTIMER0_s__ss_GETCOUNTERssBYTE

.section .text.n_timerss_sttimer0_s__ss_getvalueassbyte,"ax"
.globl	TIMERSs_sTTIMER0_s__ss_GETVALUEAssBYTE
TIMERSs_sTTIMER0_s__ss_GETVALUEAssBYTE:
# [470] begin
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
# [471] Result := OCR0A;
	in	r0,39
	std	Y+4,r0
# [472] end;
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
.Le23:
	.size	TIMERSs_sTTIMER0_s__ss_GETVALUEAssBYTE, .Le23 - TIMERSs_sTTIMER0_s__ss_GETVALUEAssBYTE

.section .text.n_timerss_sttimer0_s__ss_getvaluebssbyte,"ax"
.globl	TIMERSs_sTTIMER0_s__ss_GETVALUEBssBYTE
TIMERSs_sTTIMER0_s__ss_GETVALUEBssBYTE:
# [475] begin
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
# [476] Result := OCR0B;
	in	r0,40
	std	Y+4,r0
# [477] end;
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
.Le24:
	.size	TIMERSs_sTTIMER0_s__ss_GETVALUEBssBYTE, .Le24 - TIMERSs_sTTIMER0_s__ss_GETVALUEBssBYTE

.section .text.n_timerss_sttimer0_s__ss_setcountersbyte,"ax"
.globl	TIMERSs_sTTIMER0_s__ss_SETCOUNTERsBYTE
TIMERSs_sTTIMER0_s__ss_SETCOUNTERsBYTE:
# [480] begin
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
# Var AValue located at r28+2, size=OS_8
# Var $self located at r28+3, size=OS_16
	std	Y+3,r24
	std	Y+4,r25
	std	Y+2,r22
# [481] TCNT0 := AValue;
	ldd	r0,Y+2
	out	38,r0
# [482] end;
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
.Le25:
	.size	TIMERSs_sTTIMER0_s__ss_SETCOUNTERsBYTE, .Le25 - TIMERSs_sTTIMER0_s__ss_SETCOUNTERsBYTE

.section .text.n_timerss_sttimer0_s__ss_setvalueasbyte,"ax"
.globl	TIMERSs_sTTIMER0_s__ss_SETVALUEAsBYTE
TIMERSs_sTTIMER0_s__ss_SETVALUEAsBYTE:
# [485] begin
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
# Var AValue located at r28+2, size=OS_8
# Var $self located at r28+3, size=OS_16
	std	Y+3,r24
	std	Y+4,r25
	std	Y+2,r22
# [486] OCR0A := AValue;
	ldd	r0,Y+2
	out	39,r0
# [487] end;
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
.Le26:
	.size	TIMERSs_sTTIMER0_s__ss_SETVALUEAsBYTE, .Le26 - TIMERSs_sTTIMER0_s__ss_SETVALUEAsBYTE

.section .text.n_timerss_sttimer0_s__ss_setvaluebsbyte,"ax"
.globl	TIMERSs_sTTIMER0_s__ss_SETVALUEBsBYTE
TIMERSs_sTTIMER0_s__ss_SETVALUEBsBYTE:
# [490] begin
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
# Var AValue located at r28+2, size=OS_8
# Var $self located at r28+3, size=OS_16
	std	Y+3,r24
	std	Y+4,r25
	std	Y+2,r22
# [491] OCR0B := AValue;
	ldd	r0,Y+2
	out	40,r0
# [492] end;
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
.Le27:
	.size	TIMERSs_sTTIMER0_s__ss_SETVALUEBsBYTE, .Le27 - TIMERSs_sTTIMER0_s__ss_SETVALUEBsBYTE

.section .text.n_timerss_sttimer0_s__ss_getctcmodessboolean,"ax"
.globl	TIMERSs_sTTIMER0_s__ss_GETCTCMODEssBOOLEAN
TIMERSs_sTTIMER0_s__ss_GETCTCMODEssBOOLEAN:
# [495] begin
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
# [496] Result := TCCR0B and (1 shl WGM02) > 0;
	in	r18,37
	andi	r18,8
	cp	r1,r18
	ldi	r18,1
	brlo	.Lj148
	mov	r18,r1
.Lj148:
	std	Y+4,r18
# [497] end;
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
.Le28:
	.size	TIMERSs_sTTIMER0_s__ss_GETCTCMODEssBOOLEAN, .Le28 - TIMERSs_sTTIMER0_s__ss_GETCTCMODEssBOOLEAN

.section .text.n_timerss_sttimer0_s__ss_setctcmodesboolean,"ax"
.globl	TIMERSs_sTTIMER0_s__ss_SETCTCMODEsBOOLEAN
TIMERSs_sTTIMER0_s__ss_SETCTCMODEsBOOLEAN:
# [500] begin
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
# Var AValue located at r28+2, size=OS_8
# Var $self located at r28+3, size=OS_16
	std	Y+3,r24
	std	Y+4,r25
	std	Y+2,r22
# [501] TCCR0B := TCCR0B and not (1 shl WGM02) or (Byte(AValue) shr WGM02);
	in	r18,37
	andi	r18,-9
	ldd	r19,Y+2
	lsr	r19
	lsr	r19
	lsr	r19
	or	r19,r18
	out	37,r19
# [502] end;
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
.Le29:
	.size	TIMERSs_sTTIMER0_s__ss_SETCTCMODEsBOOLEAN, .Le29 - TIMERSs_sTTIMER0_s__ss_SETCTCMODEsBOOLEAN

.section .text.n_timerss_sttimer0_s__ss_getclkmodessttimerclkmode,"ax"
.globl	TIMERSs_sTTIMER0_s__ss_GETCLKMODEssTTIMERCLKMODE
TIMERSs_sTTIMER0_s__ss_GETCLKMODEssTTIMERCLKMODE:
# [505] begin
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
# [506] Result := TTimerCLKMode(TCCR0B and %00000111);
	in	r18,37
	andi	r18,7
	std	Y+4,r18
# [507] end;
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
.Le30:
	.size	TIMERSs_sTTIMER0_s__ss_GETCLKMODEssTTIMERCLKMODE, .Le30 - TIMERSs_sTTIMER0_s__ss_GETCLKMODEssTTIMERCLKMODE

.section .text.n_timerss_sttimer0_s__ss_getcountermodesssttimercountermodes,"ax"
.globl	TIMERSs_sTTIMER0_s__ss_GETCOUNTERMODESssTTIMERCOUNTERMODES
TIMERSs_sTTIMER0_s__ss_GETCOUNTERMODESssTTIMERCOUNTERMODES:
# [510] begin
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
# [511] Result := TTimerCounterModes(TIMSK0);
	lds	r0,(110)
	std	Y+4,r0
# [512] end;
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
.Le31:
	.size	TIMERSs_sTTIMER0_s__ss_GETCOUNTERMODESssTTIMERCOUNTERMODES, .Le31 - TIMERSs_sTTIMER0_s__ss_GETCOUNTERMODESssTTIMERCOUNTERMODES

.section .text.n_timerss_sttimer0_s__ss_getoutputmodesssttimeroutputmodes,"ax"
.globl	TIMERSs_sTTIMER0_s__ss_GETOUTPUTMODESssTTIMEROUTPUTMODES
TIMERSs_sTTIMER0_s__ss_GETOUTPUTMODESssTTIMEROUTPUTMODES:
# [515] begin
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
# [516] Result := TTimerOutputModes(TCCR0A);
	in	r0,36
	std	Y+4,r0
# [517] end;
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
.Le32:
	.size	TIMERSs_sTTIMER0_s__ss_GETOUTPUTMODESssTTIMEROUTPUTMODES, .Le32 - TIMERSs_sTTIMER0_s__ss_GETOUTPUTMODESssTTIMEROUTPUTMODES

.section .text.n_timerss_sttimer0_s__ss_setclkmodesttimerclkmode,"ax"
.globl	TIMERSs_sTTIMER0_s__ss_SETCLKMODEsTTIMERCLKMODE
TIMERSs_sTTIMER0_s__ss_SETCLKMODEsTTIMERCLKMODE:
# [520] begin
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
# Var AValue located at r28+2, size=OS_8
# Var $self located at r28+3, size=OS_16
	std	Y+3,r24
	std	Y+4,r25
	std	Y+2,r22
# [521] TCCR0B := TCCR0B and %11111000 or Byte(AValue);
	in	r18,37
	andi	r18,-8
	ldd	r19,Y+2
	or	r19,r18
	out	37,r19
# [522] end;
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
.Le33:
	.size	TIMERSs_sTTIMER0_s__ss_SETCLKMODEsTTIMERCLKMODE, .Le33 - TIMERSs_sTTIMER0_s__ss_SETCLKMODEsTTIMERCLKMODE

.section .text.n_timerss_sttimer0_s__ss_setcountermodessttimercountermodes,"ax"
.globl	TIMERSs_sTTIMER0_s__ss_SETCOUNTERMODESsTTIMERCOUNTERMODES
TIMERSs_sTTIMER0_s__ss_SETCOUNTERMODESsTTIMERCOUNTERMODES:
# [525] begin
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
# Var AValue located at r28+2, size=OS_8
# Var $self located at r28+3, size=OS_16
	std	Y+3,r24
	std	Y+4,r25
	std	Y+2,r22
# [526] TTimerCounterModes(TIMSK0) := AValue;
	ldd	r0,Y+2
	sts	(110),r0
# [527] end;
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
.Le34:
	.size	TIMERSs_sTTIMER0_s__ss_SETCOUNTERMODESsTTIMERCOUNTERMODES, .Le34 - TIMERSs_sTTIMER0_s__ss_SETCOUNTERMODESsTTIMERCOUNTERMODES

.section .text.n_timerss_sttimer0_s__ss_setoutputmodessttimeroutputmodes,"ax"
.globl	TIMERSs_sTTIMER0_s__ss_SETOUTPUTMODESsTTIMEROUTPUTMODES
TIMERSs_sTTIMER0_s__ss_SETOUTPUTMODESsTTIMEROUTPUTMODES:
# [530] begin
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
# Var AValue located at r28+2, size=OS_8
# Var $self located at r28+3, size=OS_16
	std	Y+3,r24
	std	Y+4,r25
	std	Y+2,r22
# [531] TTimerOutputModes(TCCR0A) := AValue;
	ldd	r0,Y+2
	out	36,r0
# [532] end;
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
.Le35:
	.size	TIMERSs_sTTIMER0_s__ss_SETOUTPUTMODESsTTIMEROUTPUTMODES, .Le35 - TIMERSs_sTTIMER0_s__ss_SETOUTPUTMODESsTTIMEROUTPUTMODES

.section .text.n_timerss_sttimer0_s__ss_bitsssbyte,"ax"
.globl	TIMERSs_sTTIMER0_s__ss_BITSssBYTE
TIMERSs_sTTIMER0_s__ss_BITSssBYTE:
# [535] begin
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
# [536] Result := 8;
	ldi	r18,8
	std	Y+4,r18
# [537] end;
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
.Le36:
	.size	TIMERSs_sTTIMER0_s__ss_BITSssBYTE, .Le36 - TIMERSs_sTTIMER0_s__ss_BITSssBYTE

.section .text.n_timerss_sttimer1_s__ss_getcounterssword,"ax"
.globl	TIMERSs_sTTIMER1_s__ss_GETCOUNTERssWORD
TIMERSs_sTTIMER1_s__ss_GETCOUNTERssWORD:
# [542] begin
	push	r29
	push	r28
	in	r28,61
	in	r29,62
	subi	r28,6
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var $self located at r28+2, size=OS_16
# Var $result located at r28+4, size=OS_16
	std	Y+2,r24
	std	Y+3,r25
# [543] Result := TCNT1;
	lds	r0,(132)
	std	Y+4,r0
	lds	r0,(133)
	std	Y+5,r0
# [544] end;
	ldd	r24,Y+4
	ldd	r25,Y+5
	subi	r28,-6
	sbci	r29,-1
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
	pop	r28
	pop	r29
	ret
.Le37:
	.size	TIMERSs_sTTIMER1_s__ss_GETCOUNTERssWORD, .Le37 - TIMERSs_sTTIMER1_s__ss_GETCOUNTERssWORD

.section .text.n_timerss_sttimer1_s__ss_getnoisecancelerssboolean,"ax"
.globl	TIMERSs_sTTIMER1_s__ss_GETNOISECANCELERssBOOLEAN
TIMERSs_sTTIMER1_s__ss_GETNOISECANCELERssBOOLEAN:
# [547] begin
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
# [548] Result := TCCR1B and (1 shl ICNC1) > 0;
	lds	r18,(129)
	andi	r18,-128
	cp	r1,r18
	ldi	r18,1
	brlo	.Lj169
	mov	r18,r1
.Lj169:
	std	Y+4,r18
# [549] end;
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
.Le38:
	.size	TIMERSs_sTTIMER1_s__ss_GETNOISECANCELERssBOOLEAN, .Le38 - TIMERSs_sTTIMER1_s__ss_GETNOISECANCELERssBOOLEAN

.section .text.n_timerss_sttimer1_s__ss_getvalueassword,"ax"
.globl	TIMERSs_sTTIMER1_s__ss_GETVALUEAssWORD
TIMERSs_sTTIMER1_s__ss_GETVALUEAssWORD:
# [552] begin
	push	r29
	push	r28
	in	r28,61
	in	r29,62
	subi	r28,6
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var $self located at r28+2, size=OS_16
# Var $result located at r28+4, size=OS_16
	std	Y+2,r24
	std	Y+3,r25
# [553] Result := OCR1A;
	lds	r0,(136)
	std	Y+4,r0
	lds	r0,(137)
	std	Y+5,r0
# [554] end;
	ldd	r24,Y+4
	ldd	r25,Y+5
	subi	r28,-6
	sbci	r29,-1
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
	pop	r28
	pop	r29
	ret
.Le39:
	.size	TIMERSs_sTTIMER1_s__ss_GETVALUEAssWORD, .Le39 - TIMERSs_sTTIMER1_s__ss_GETVALUEAssWORD

.section .text.n_timerss_sttimer1_s__ss_getvaluebssword,"ax"
.globl	TIMERSs_sTTIMER1_s__ss_GETVALUEBssWORD
TIMERSs_sTTIMER1_s__ss_GETVALUEBssWORD:
# [557] begin
	push	r29
	push	r28
	in	r28,61
	in	r29,62
	subi	r28,6
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var $self located at r28+2, size=OS_16
# Var $result located at r28+4, size=OS_16
	std	Y+2,r24
	std	Y+3,r25
# [558] Result := OCR1B;
	lds	r0,(138)
	std	Y+4,r0
	lds	r0,(139)
	std	Y+5,r0
# [559] end;
	ldd	r24,Y+4
	ldd	r25,Y+5
	subi	r28,-6
	sbci	r29,-1
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
	pop	r28
	pop	r29
	ret
.Le40:
	.size	TIMERSs_sTTIMER1_s__ss_GETVALUEBssWORD, .Le40 - TIMERSs_sTTIMER1_s__ss_GETVALUEBssWORD

.section .text.n_timerss_sttimer1_s__ss_setcountersword,"ax"
.globl	TIMERSs_sTTIMER1_s__ss_SETCOUNTERsWORD
TIMERSs_sTTIMER1_s__ss_SETCOUNTERsWORD:
# [562] begin
	push	r29
	push	r28
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
# [563] SetTEMPWord(TCNT1, AValue);
	ldi	r18,lo8(132)
	ldi	r25,hi8(132)
	ldd	r22,Y+2
	ldd	r23,Y+3
	mov	r24,r18
	call	ARDUINOTOOLS_ss_SETTEMPWORDsWORDsWORD
# [564] end;
	subi	r28,-6
	sbci	r29,-1
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
	pop	r28
	pop	r29
	ret
.Le41:
	.size	TIMERSs_sTTIMER1_s__ss_SETCOUNTERsWORD, .Le41 - TIMERSs_sTTIMER1_s__ss_SETCOUNTERsWORD

.section .text.n_timerss_sttimer1_s__ss_setnoisecancelersboolean,"ax"
.globl	TIMERSs_sTTIMER1_s__ss_SETNOISECANCELERsBOOLEAN
TIMERSs_sTTIMER1_s__ss_SETNOISECANCELERsBOOLEAN:
# [567] begin
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
# Var AValue located at r28+2, size=OS_8
# Var $self located at r28+3, size=OS_16
	std	Y+3,r24
	std	Y+4,r25
	std	Y+2,r22
# [568] TCCR1B := TCCR1B and not Byte(Byte(not AValue) shl ICNC1);
	ldd	r18,Y+2
	cp	r1,r18
	ldi	r18,1
	breq	.Lj178
	mov	r18,r1
.Lj178:
	lsl	r18
	lsl	r18
	lsl	r18
	lsl	r18
	lsl	r18
	lsl	r18
	lsl	r18
	com	r18
	lds	r19,(129)
	and	r19,r18
	sts	(129),r19
# [569] end;
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
.Le42:
	.size	TIMERSs_sTTIMER1_s__ss_SETNOISECANCELERsBOOLEAN, .Le42 - TIMERSs_sTTIMER1_s__ss_SETNOISECANCELERsBOOLEAN

.section .text.n_timerss_sttimer1_s__ss_setvalueasword,"ax"
.globl	TIMERSs_sTTIMER1_s__ss_SETVALUEAsWORD
TIMERSs_sTTIMER1_s__ss_SETVALUEAsWORD:
# [572] begin
	push	r29
	push	r28
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
# [573] SetTEMPWord(OCR1A, AValue);
	ldi	r18,lo8(136)
	ldi	r25,hi8(136)
	ldd	r22,Y+2
	ldd	r23,Y+3
	mov	r24,r18
	call	ARDUINOTOOLS_ss_SETTEMPWORDsWORDsWORD
# [574] end;
	subi	r28,-6
	sbci	r29,-1
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
	pop	r28
	pop	r29
	ret
.Le43:
	.size	TIMERSs_sTTIMER1_s__ss_SETVALUEAsWORD, .Le43 - TIMERSs_sTTIMER1_s__ss_SETVALUEAsWORD

.section .text.n_timerss_sttimer1_s__ss_setvaluebsword,"ax"
.globl	TIMERSs_sTTIMER1_s__ss_SETVALUEBsWORD
TIMERSs_sTTIMER1_s__ss_SETVALUEBsWORD:
# [577] begin
	push	r29
	push	r28
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
# [578] SetTEMPWord(OCR1B, AValue);
	ldi	r18,lo8(138)
	ldi	r25,hi8(138)
	ldd	r22,Y+2
	ldd	r23,Y+3
	mov	r24,r18
	call	ARDUINOTOOLS_ss_SETTEMPWORDsWORDsWORD
# [579] end;
	subi	r28,-6
	sbci	r29,-1
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
	pop	r28
	pop	r29
	ret
.Le44:
	.size	TIMERSs_sTTIMER1_s__ss_SETVALUEBsWORD, .Le44 - TIMERSs_sTTIMER1_s__ss_SETVALUEBsWORD

.section .text.n_timerss_sttimer1_s__ss_getctcmodessboolean,"ax"
.globl	TIMERSs_sTTIMER1_s__ss_GETCTCMODEssBOOLEAN
TIMERSs_sTTIMER1_s__ss_GETCTCMODEssBOOLEAN:
# [582] begin
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
# [583] Result := TCCR1B and (1 shl WGM12) > 0;
	lds	r18,(129)
	andi	r18,8
	cp	r1,r18
	ldi	r18,1
	brlo	.Lj185
	mov	r18,r1
.Lj185:
	std	Y+4,r18
# [584] end;
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
.Le45:
	.size	TIMERSs_sTTIMER1_s__ss_GETCTCMODEssBOOLEAN, .Le45 - TIMERSs_sTTIMER1_s__ss_GETCTCMODEssBOOLEAN

.section .text.n_timerss_sttimer1_s__ss_setctcmodesboolean,"ax"
.globl	TIMERSs_sTTIMER1_s__ss_SETCTCMODEsBOOLEAN
TIMERSs_sTTIMER1_s__ss_SETCTCMODEsBOOLEAN:
# [587] begin
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
# Var AValue located at r28+2, size=OS_8
# Var $self located at r28+3, size=OS_16
	std	Y+3,r24
	std	Y+4,r25
	std	Y+2,r22
# [588] TCCR1B := TCCR1B and not Byte(Byte(not AValue) shl WGM12){ or (Byte(AValue) shr WGM13)};
	ldd	r18,Y+2
	cp	r1,r18
	ldi	r18,1
	breq	.Lj188
	mov	r18,r1
.Lj188:
	lsl	r18
	lsl	r18
	lsl	r18
	com	r18
	lds	r19,(129)
	and	r19,r18
	sts	(129),r19
# [589] end;
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
.Le46:
	.size	TIMERSs_sTTIMER1_s__ss_SETCTCMODEsBOOLEAN, .Le46 - TIMERSs_sTTIMER1_s__ss_SETCTCMODEsBOOLEAN

.section .text.n_timerss_sttimer1_s__ss_getclkmodessttimerclkmode,"ax"
.globl	TIMERSs_sTTIMER1_s__ss_GETCLKMODEssTTIMERCLKMODE
TIMERSs_sTTIMER1_s__ss_GETCLKMODEssTTIMERCLKMODE:
# [592] begin
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
# [593] Result := TTimerCLKMode(TCCR1B and %00000111);
	lds	r18,(129)
	andi	r18,7
	std	Y+4,r18
# [594] end;
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
.Le47:
	.size	TIMERSs_sTTIMER1_s__ss_GETCLKMODEssTTIMERCLKMODE, .Le47 - TIMERSs_sTTIMER1_s__ss_GETCLKMODEssTTIMERCLKMODE

.section .text.n_timerss_sttimer1_s__ss_getcountermodesssttimercountermodes,"ax"
.globl	TIMERSs_sTTIMER1_s__ss_GETCOUNTERMODESssTTIMERCOUNTERMODES
TIMERSs_sTTIMER1_s__ss_GETCOUNTERMODESssTTIMERCOUNTERMODES:
# [597] begin
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
# [598] Result := TTimerCounterModes(TIMSK1);
	lds	r0,(111)
	std	Y+4,r0
# [599] end;
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
.Le48:
	.size	TIMERSs_sTTIMER1_s__ss_GETCOUNTERMODESssTTIMERCOUNTERMODES, .Le48 - TIMERSs_sTTIMER1_s__ss_GETCOUNTERMODESssTTIMERCOUNTERMODES

.section .text.n_timerss_sttimer1_s__ss_getoutputmodesssttimeroutputmodes,"ax"
.globl	TIMERSs_sTTIMER1_s__ss_GETOUTPUTMODESssTTIMEROUTPUTMODES
TIMERSs_sTTIMER1_s__ss_GETOUTPUTMODESssTTIMEROUTPUTMODES:
# [602] begin
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
# [603] Result := TTimerOutputModes(TCCR1A);
	lds	r0,(128)
	std	Y+4,r0
# [604] end;
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
.Le49:
	.size	TIMERSs_sTTIMER1_s__ss_GETOUTPUTMODESssTTIMEROUTPUTMODES, .Le49 - TIMERSs_sTTIMER1_s__ss_GETOUTPUTMODESssTTIMEROUTPUTMODES

.section .text.n_timerss_sttimer1_s__ss_setclkmodesttimerclkmode,"ax"
.globl	TIMERSs_sTTIMER1_s__ss_SETCLKMODEsTTIMERCLKMODE
TIMERSs_sTTIMER1_s__ss_SETCLKMODEsTTIMERCLKMODE:
# [607] begin
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
# Var AValue located at r28+2, size=OS_8
# Var $self located at r28+3, size=OS_16
	std	Y+3,r24
	std	Y+4,r25
	std	Y+2,r22
# [608] TCCR1B := TCCR1B and %11111000 or Byte(AValue);
	lds	r18,(129)
	andi	r18,-8
	ldd	r19,Y+2
	or	r19,r18
	sts	(129),r19
# [609] end;
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
.Le50:
	.size	TIMERSs_sTTIMER1_s__ss_SETCLKMODEsTTIMERCLKMODE, .Le50 - TIMERSs_sTTIMER1_s__ss_SETCLKMODEsTTIMERCLKMODE

.section .text.n_timerss_sttimer1_s__ss_setcountermodessttimercountermodes,"ax"
.globl	TIMERSs_sTTIMER1_s__ss_SETCOUNTERMODESsTTIMERCOUNTERMODES
TIMERSs_sTTIMER1_s__ss_SETCOUNTERMODESsTTIMERCOUNTERMODES:
# [612] begin
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
# Var AValue located at r28+2, size=OS_8
# Var $self located at r28+3, size=OS_16
	std	Y+3,r24
	std	Y+4,r25
	std	Y+2,r22
# [613] TTimerCounterModes(TIMSK1) := AValue;
	ldd	r0,Y+2
	sts	(111),r0
# [614] end;
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
.Le51:
	.size	TIMERSs_sTTIMER1_s__ss_SETCOUNTERMODESsTTIMERCOUNTERMODES, .Le51 - TIMERSs_sTTIMER1_s__ss_SETCOUNTERMODESsTTIMERCOUNTERMODES

.section .text.n_timerss_sttimer1_s__ss_setoutputmodessttimeroutputmodes,"ax"
.globl	TIMERSs_sTTIMER1_s__ss_SETOUTPUTMODESsTTIMEROUTPUTMODES
TIMERSs_sTTIMER1_s__ss_SETOUTPUTMODESsTTIMEROUTPUTMODES:
# [617] begin
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
# Var AValue located at r28+2, size=OS_8
# Var $self located at r28+3, size=OS_16
	std	Y+3,r24
	std	Y+4,r25
	std	Y+2,r22
# [618] TTimerOutputModes(TCCR1A) := AValue;
	ldd	r0,Y+2
	sts	(128),r0
# [619] end;
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
.Le52:
	.size	TIMERSs_sTTIMER1_s__ss_SETOUTPUTMODESsTTIMEROUTPUTMODES, .Le52 - TIMERSs_sTTIMER1_s__ss_SETOUTPUTMODESsTTIMEROUTPUTMODES

.section .text.n_timerss_sttimer1_s__ss_bitsssbyte,"ax"
.globl	TIMERSs_sTTIMER1_s__ss_BITSssBYTE
TIMERSs_sTTIMER1_s__ss_BITSssBYTE:
# [622] begin
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
# [623] Result := 16;
	ldi	r18,16
	std	Y+4,r18
# [624] end;
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
.Le53:
	.size	TIMERSs_sTTIMER1_s__ss_BITSssBYTE, .Le53 - TIMERSs_sTTIMER1_s__ss_BITSssBYTE

.section .text.n_timerss_sttimer2_s__ss_getasyncmodessboolean,"ax"
.globl	TIMERSs_sTTIMER2_s__ss_GETASYNCMODEssBOOLEAN
TIMERSs_sTTIMER2_s__ss_GETASYNCMODEssBOOLEAN:
# [629] begin
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
# [630] Result := ASSR and (1 shl AS2) > 0;
	lds	r18,(182)
	andi	r18,32
	cp	r1,r18
	ldi	r18,1
	brlo	.Lj205
	mov	r18,r1
.Lj205:
	std	Y+4,r18
# [631] end;
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
.Le54:
	.size	TIMERSs_sTTIMER2_s__ss_GETASYNCMODEssBOOLEAN, .Le54 - TIMERSs_sTTIMER2_s__ss_GETASYNCMODEssBOOLEAN

.section .text.n_timerss_sttimer2_s__ss_getclkmodessttimer2clkmode,"ax"
.globl	TIMERSs_sTTIMER2_s__ss_GETCLKMODEssTTIMER2CLKMODE
TIMERSs_sTTIMER2_s__ss_GETCLKMODEssTTIMER2CLKMODE:
# [634] begin
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
# [635] Result := TTimer2CLKMode(TCCR2B and %00000111);
	lds	r18,(177)
	andi	r18,7
	std	Y+4,r18
# [636] end;
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
.Le55:
	.size	TIMERSs_sTTIMER2_s__ss_GETCLKMODEssTTIMER2CLKMODE, .Le55 - TIMERSs_sTTIMER2_s__ss_GETCLKMODEssTTIMER2CLKMODE

.section .text.n_timerss_sttimer2_s__ss_getcounterssbyte,"ax"
.globl	TIMERSs_sTTIMER2_s__ss_GETCOUNTERssBYTE
TIMERSs_sTTIMER2_s__ss_GETCOUNTERssBYTE:
# [639] begin
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
# [640] Result := TCNT2;
	lds	r0,(178)
	std	Y+4,r0
# [641] end;
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
.Le56:
	.size	TIMERSs_sTTIMER2_s__ss_GETCOUNTERssBYTE, .Le56 - TIMERSs_sTTIMER2_s__ss_GETCOUNTERssBYTE

.section .text.n_timerss_sttimer2_s__ss_getcountermodesssttimercountermodes,"ax"
.globl	TIMERSs_sTTIMER2_s__ss_GETCOUNTERMODESssTTIMERCOUNTERMODES
TIMERSs_sTTIMER2_s__ss_GETCOUNTERMODESssTTIMERCOUNTERMODES:
# [644] begin
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
# [645] Result := TTimerCounterModes(TIMSK2);
	lds	r0,(112)
	std	Y+4,r0
# [646] end;
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
.Le57:
	.size	TIMERSs_sTTIMER2_s__ss_GETCOUNTERMODESssTTIMERCOUNTERMODES, .Le57 - TIMERSs_sTTIMER2_s__ss_GETCOUNTERMODESssTTIMERCOUNTERMODES

.section .text.n_timerss_sttimer2_s__ss_getctcmodessboolean,"ax"
.globl	TIMERSs_sTTIMER2_s__ss_GETCTCMODEssBOOLEAN
TIMERSs_sTTIMER2_s__ss_GETCTCMODEssBOOLEAN:
# [649] begin
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
# [650] Result := TCCR2B and (1 shl WGM22) > 0;
	lds	r18,(177)
	andi	r18,8
	cp	r1,r18
	ldi	r18,1
	brlo	.Lj214
	mov	r18,r1
.Lj214:
	std	Y+4,r18
# [651] end;
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
.Le58:
	.size	TIMERSs_sTTIMER2_s__ss_GETCTCMODEssBOOLEAN, .Le58 - TIMERSs_sTTIMER2_s__ss_GETCTCMODEssBOOLEAN

.section .text.n_timerss_sttimer2_s__ss_getexternalmodessboolean,"ax"
.globl	TIMERSs_sTTIMER2_s__ss_GETEXTERNALMODEssBOOLEAN
TIMERSs_sTTIMER2_s__ss_GETEXTERNALMODEssBOOLEAN:
# [654] begin
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
# [655] Result := ASSR and (1 shl EXCLK) > 0;
	lds	r18,(182)
	andi	r18,64
	cp	r1,r18
	ldi	r18,1
	brlo	.Lj217
	mov	r18,r1
.Lj217:
	std	Y+4,r18
# [656] end;
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
.Le59:
	.size	TIMERSs_sTTIMER2_s__ss_GETEXTERNALMODEssBOOLEAN, .Le59 - TIMERSs_sTTIMER2_s__ss_GETEXTERNALMODEssBOOLEAN

.section .text.n_timerss_sttimer2_s__ss_getoutputmodesssttimeroutputmodes,"ax"
.globl	TIMERSs_sTTIMER2_s__ss_GETOUTPUTMODESssTTIMEROUTPUTMODES
TIMERSs_sTTIMER2_s__ss_GETOUTPUTMODESssTTIMEROUTPUTMODES:
# [659] begin
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
# [660] Result := TTimerOutputModes(TCCR0A);
	in	r0,36
	std	Y+4,r0
# [661] end;
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
.Le60:
	.size	TIMERSs_sTTIMER2_s__ss_GETOUTPUTMODESssTTIMEROUTPUTMODES, .Le60 - TIMERSs_sTTIMER2_s__ss_GETOUTPUTMODESssTTIMEROUTPUTMODES

.section .text.n_timerss_sttimer2_s__ss_getvalueassbyte,"ax"
.globl	TIMERSs_sTTIMER2_s__ss_GETVALUEAssBYTE
TIMERSs_sTTIMER2_s__ss_GETVALUEAssBYTE:
# [664] begin
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
# [665] Result := OCR2A;
	lds	r0,(179)
	std	Y+4,r0
# [666] end;
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
.Le61:
	.size	TIMERSs_sTTIMER2_s__ss_GETVALUEAssBYTE, .Le61 - TIMERSs_sTTIMER2_s__ss_GETVALUEAssBYTE

.section .text.n_timerss_sttimer2_s__ss_getvaluebssbyte,"ax"
.globl	TIMERSs_sTTIMER2_s__ss_GETVALUEBssBYTE
TIMERSs_sTTIMER2_s__ss_GETVALUEBssBYTE:
# [669] begin
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
# [670] Result := OCR2B;
	lds	r0,(180)
	std	Y+4,r0
# [671] end;
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
.Le62:
	.size	TIMERSs_sTTIMER2_s__ss_GETVALUEBssBYTE, .Le62 - TIMERSs_sTTIMER2_s__ss_GETVALUEBssBYTE

.section .text.n_timerss_sttimer2_s__ss_setasyncmodesboolean,"ax"
.globl	TIMERSs_sTTIMER2_s__ss_SETASYNCMODEsBOOLEAN
TIMERSs_sTTIMER2_s__ss_SETASYNCMODEsBOOLEAN:
# [674] begin
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
# Var AValue located at r28+2, size=OS_8
# Var $self located at r28+3, size=OS_16
	std	Y+3,r24
	std	Y+4,r25
	std	Y+2,r22
# [675] ASSR := ASSR and not Byte(Byte(not AValue) shl AS2);
	ldd	r18,Y+2
	cp	r1,r18
	ldi	r18,1
	breq	.Lj226
	mov	r18,r1
.Lj226:
	lsl	r18
	lsl	r18
	lsl	r18
	lsl	r18
	lsl	r18
	com	r18
	lds	r19,(182)
	and	r19,r18
	sts	(182),r19
# [676] end;
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
.Le63:
	.size	TIMERSs_sTTIMER2_s__ss_SETASYNCMODEsBOOLEAN, .Le63 - TIMERSs_sTTIMER2_s__ss_SETASYNCMODEsBOOLEAN

.section .text.n_timerss_sttimer2_s__ss_setclkmodesttimer2clkmode,"ax"
.globl	TIMERSs_sTTIMER2_s__ss_SETCLKMODEsTTIMER2CLKMODE
TIMERSs_sTTIMER2_s__ss_SETCLKMODEsTTIMER2CLKMODE:
# [679] begin
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
# Var AValue located at r28+2, size=OS_8
# Var $self located at r28+3, size=OS_16
	std	Y+3,r24
	std	Y+4,r25
	std	Y+2,r22
.Lj229:
# [680] while ASSR and (1 shl TCR2BUB) > 0 do
	lds	r18,(182)
	andi	r18,1
	cp	r1,r18
	brlo	.Lj229
# [682] TCCR2B := TCCR2B and %11111000 or Byte(AValue);
	lds	r18,(177)
	andi	r18,-8
	ldd	r19,Y+2
	or	r19,r18
	sts	(177),r19
# [683] end;
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
.Le64:
	.size	TIMERSs_sTTIMER2_s__ss_SETCLKMODEsTTIMER2CLKMODE, .Le64 - TIMERSs_sTTIMER2_s__ss_SETCLKMODEsTTIMER2CLKMODE

.section .text.n_timerss_sttimer2_s__ss_setcountersbyte,"ax"
.globl	TIMERSs_sTTIMER2_s__ss_SETCOUNTERsBYTE
TIMERSs_sTTIMER2_s__ss_SETCOUNTERsBYTE:
# [686] begin
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
# Var AValue located at r28+2, size=OS_8
# Var $self located at r28+3, size=OS_16
	std	Y+3,r24
	std	Y+4,r25
	std	Y+2,r22
.Lj234:
# [687] while ASSR and (1 shl TCN2UB) > 0 do
	lds	r18,(182)
	andi	r18,16
	cp	r1,r18
	brlo	.Lj234
# [689] TCNT2 := AValue;
	ldd	r0,Y+2
	sts	(178),r0
# [690] end;
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
.Le65:
	.size	TIMERSs_sTTIMER2_s__ss_SETCOUNTERsBYTE, .Le65 - TIMERSs_sTTIMER2_s__ss_SETCOUNTERsBYTE

.section .text.n_timerss_sttimer2_s__ss_setcountermodessttimercountermodes,"ax"
.globl	TIMERSs_sTTIMER2_s__ss_SETCOUNTERMODESsTTIMERCOUNTERMODES
TIMERSs_sTTIMER2_s__ss_SETCOUNTERMODESsTTIMERCOUNTERMODES:
# [693] begin
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
# Var AValue located at r28+2, size=OS_8
# Var $self located at r28+3, size=OS_16
	std	Y+3,r24
	std	Y+4,r25
	std	Y+2,r22
# [694] TTimerCounterModes(TIMSK2) := AValue;
	ldd	r0,Y+2
	sts	(112),r0
# [695] end;
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
.Le66:
	.size	TIMERSs_sTTIMER2_s__ss_SETCOUNTERMODESsTTIMERCOUNTERMODES, .Le66 - TIMERSs_sTTIMER2_s__ss_SETCOUNTERMODESsTTIMERCOUNTERMODES

.section .text.n_timerss_sttimer2_s__ss_setctcmodesboolean,"ax"
.globl	TIMERSs_sTTIMER2_s__ss_SETCTCMODEsBOOLEAN
TIMERSs_sTTIMER2_s__ss_SETCTCMODEsBOOLEAN:
# [698] begin
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
# Var AValue located at r28+2, size=OS_8
# Var $self located at r28+3, size=OS_16
	std	Y+3,r24
	std	Y+4,r25
	std	Y+2,r22
# [699] TCCR2B := TCCR2B and not Byte(Byte(not AValue) shl WGM22);
	ldd	r18,Y+2
	cp	r1,r18
	ldi	r18,1
	breq	.Lj241
	mov	r18,r1
.Lj241:
	lsl	r18
	lsl	r18
	lsl	r18
	com	r18
	lds	r19,(177)
	and	r19,r18
	sts	(177),r19
# [700] end;
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
.Le67:
	.size	TIMERSs_sTTIMER2_s__ss_SETCTCMODEsBOOLEAN, .Le67 - TIMERSs_sTTIMER2_s__ss_SETCTCMODEsBOOLEAN

.section .text.n_timerss_sttimer2_s__ss_setexternalmodesboolean,"ax"
.globl	TIMERSs_sTTIMER2_s__ss_SETEXTERNALMODEsBOOLEAN
TIMERSs_sTTIMER2_s__ss_SETEXTERNALMODEsBOOLEAN:
# [703] begin
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
# Var AValue located at r28+2, size=OS_8
# Var $self located at r28+3, size=OS_16
	std	Y+3,r24
	std	Y+4,r25
	std	Y+2,r22
# [704] ASSR := ASSR and not Byte(Byte(not AValue) shl EXCLK);
	ldd	r18,Y+2
	cp	r1,r18
	ldi	r18,1
	breq	.Lj244
	mov	r18,r1
.Lj244:
	lsl	r18
	lsl	r18
	lsl	r18
	lsl	r18
	lsl	r18
	lsl	r18
	com	r18
	lds	r19,(182)
	and	r19,r18
	sts	(182),r19
# [705] end;
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
.Le68:
	.size	TIMERSs_sTTIMER2_s__ss_SETEXTERNALMODEsBOOLEAN, .Le68 - TIMERSs_sTTIMER2_s__ss_SETEXTERNALMODEsBOOLEAN

.section .text.n_timerss_sttimer2_s__ss_setoutputmodessttimeroutputmodes,"ax"
.globl	TIMERSs_sTTIMER2_s__ss_SETOUTPUTMODESsTTIMEROUTPUTMODES
TIMERSs_sTTIMER2_s__ss_SETOUTPUTMODESsTTIMEROUTPUTMODES:
# [708] begin
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
# Var AValue located at r28+2, size=OS_8
# Var $self located at r28+3, size=OS_16
	std	Y+3,r24
	std	Y+4,r25
	std	Y+2,r22
# [709] TTimerOutputModes(TCCR2A) := AValue;
	ldd	r0,Y+2
	sts	(176),r0
# [710] end;
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
.Le69:
	.size	TIMERSs_sTTIMER2_s__ss_SETOUTPUTMODESsTTIMEROUTPUTMODES, .Le69 - TIMERSs_sTTIMER2_s__ss_SETOUTPUTMODESsTTIMEROUTPUTMODES

.section .text.n_timerss_sttimer2_s__ss_setvalueasbyte,"ax"
.globl	TIMERSs_sTTIMER2_s__ss_SETVALUEAsBYTE
TIMERSs_sTTIMER2_s__ss_SETVALUEAsBYTE:
# [713] begin
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
# Var AValue located at r28+2, size=OS_8
# Var $self located at r28+3, size=OS_16
	std	Y+3,r24
	std	Y+4,r25
	std	Y+2,r22
.Lj249:
# [714] while ASSR and (1 shl OCR2AUB) > 0 do
	lds	r18,(182)
	andi	r18,8
	cp	r1,r18
	brlo	.Lj249
# [716] OCR2A := AValue;
	ldd	r0,Y+2
	sts	(179),r0
# [717] end;
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
.Le70:
	.size	TIMERSs_sTTIMER2_s__ss_SETVALUEAsBYTE, .Le70 - TIMERSs_sTTIMER2_s__ss_SETVALUEAsBYTE

.section .text.n_timerss_sttimer2_s__ss_setvaluebsbyte,"ax"
.globl	TIMERSs_sTTIMER2_s__ss_SETVALUEBsBYTE
TIMERSs_sTTIMER2_s__ss_SETVALUEBsBYTE:
# [720] begin
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
# Var AValue located at r28+2, size=OS_8
# Var $self located at r28+3, size=OS_16
	std	Y+3,r24
	std	Y+4,r25
	std	Y+2,r22
.Lj254:
# [721] while ASSR and (1 shl OCR2BUB) > 0 do
	lds	r18,(182)
	andi	r18,4
	cp	r1,r18
	brlo	.Lj254
# [723] OCR2B := AValue;
	ldd	r0,Y+2
	sts	(180),r0
# [724] end;
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
.Le71:
	.size	TIMERSs_sTTIMER2_s__ss_SETVALUEBsBYTE, .Le71 - TIMERSs_sTTIMER2_s__ss_SETVALUEBsBYTE

.section .text.n_timerss_sttimer2_s__ss_bitsssbyte,"ax"
.globl	TIMERSs_sTTIMER2_s__ss_BITSssBYTE
TIMERSs_sTTIMER2_s__ss_BITSssBYTE:
# [727] begin
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
# [728] Result := 8;
	ldi	r18,8
	std	Y+4,r18
# [729] end;
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
.Le72:
	.size	TIMERSs_sTTIMER2_s__ss_BITSssBYTE, .Le72 - TIMERSs_sTTIMER2_s__ss_BITSssBYTE

.section .text.n_timers_ss_timer0_ovf_isr,"ax"
.globl	TIMERS_ss_TIMER0_OVF_ISR
TIMERS_ss_TIMER0_OVF_ISR:
.globl	TIMER0_OVF_ISR
TIMER0_OVF_ISR:
# [759] begin
	push	r31
	push	r30
	push	r27
	push	r26
	push	r25
	push	r24
	push	r23
	push	r22
	push	r21
	push	r20
	push	r19
	push	r18
	push	r1
	push	r0
	in	r0,63
	push	r0
	clr	r1
# [760] Timer0.DoOVFEvents;
	ldi	r18,lo8(U_sTIMERS_ss_TIMER0)
	ldi	r25,hi8(U_sTIMERS_ss_TIMER0)
	mov	r24,r18
	call	TIMERSs_sTABSTRACTTIMER_s__ss_DOOVFEVENTS
# [761] end;
	pop	r0
	out	63,r0
	pop	r0
	pop	r1
	pop	r18
	pop	r19
	pop	r20
	pop	r21
	pop	r22
	pop	r23
	pop	r24
	pop	r25
	pop	r26
	pop	r27
	pop	r30
	pop	r31
	reti
.Le73:
	.size	TIMERS_ss_TIMER0_OVF_ISR, .Le73 - TIMERS_ss_TIMER0_OVF_ISR

.section .text.n_timers_ss_timer1_ovf_isr,"ax"
.globl	TIMERS_ss_TIMER1_OVF_ISR
TIMERS_ss_TIMER1_OVF_ISR:
.globl	TIMER1_OVF_ISR
TIMER1_OVF_ISR:
# [786] begin
	push	r31
	push	r30
	push	r27
	push	r26
	push	r25
	push	r24
	push	r23
	push	r22
	push	r21
	push	r20
	push	r19
	push	r18
	push	r1
	push	r0
	in	r0,63
	push	r0
	clr	r1
# [787] Timer1.DoOVFEvents;
	ldi	r18,lo8(U_sTIMERS_ss_TIMER1)
	ldi	r25,hi8(U_sTIMERS_ss_TIMER1)
	mov	r24,r18
	call	TIMERSs_sTABSTRACTTIMER_s__ss_DOOVFEVENTS
# [788] end;
	pop	r0
	out	63,r0
	pop	r0
	pop	r1
	pop	r18
	pop	r19
	pop	r20
	pop	r21
	pop	r22
	pop	r23
	pop	r24
	pop	r25
	pop	r26
	pop	r27
	pop	r30
	pop	r31
	reti
.Le74:
	.size	TIMERS_ss_TIMER1_OVF_ISR, .Le74 - TIMERS_ss_TIMER1_OVF_ISR

.section .text.n_timers_ss_timer2_ovf_isr,"ax"
.globl	TIMERS_ss_TIMER2_OVF_ISR
TIMERS_ss_TIMER2_OVF_ISR:
.globl	TIMER2_OVF_ISR
TIMER2_OVF_ISR:
# [813] begin
	push	r31
	push	r30
	push	r27
	push	r26
	push	r25
	push	r24
	push	r23
	push	r22
	push	r21
	push	r20
	push	r19
	push	r18
	push	r1
	push	r0
	in	r0,63
	push	r0
	clr	r1
# [814] Timer2.DoOVFEvents;
	ldi	r18,lo8(U_sTIMERS_ss_TIMER2)
	ldi	r25,hi8(U_sTIMERS_ss_TIMER2)
	mov	r24,r18
	call	TIMERSs_sTABSTRACTTIMER_s__ss_DOOVFEVENTS
# [815] end;
	pop	r0
	out	63,r0
	pop	r0
	pop	r1
	pop	r18
	pop	r19
	pop	r20
	pop	r21
	pop	r22
	pop	r23
	pop	r24
	pop	r25
	pop	r26
	pop	r27
	pop	r30
	pop	r31
	reti
.Le75:
	.size	TIMERS_ss_TIMER2_OVF_ISR, .Le75 - TIMERS_ss_TIMER2_OVF_ISR

.section .text.n_timerss_stabstracttimer_s__ss_getcountermodesssttimercountermodes,"ax"
.globl	TIMERSs_sTABSTRACTTIMER_s__ss_GETCOUNTERMODESssTTIMERCOUNTERMODES
TIMERSs_sTABSTRACTTIMER_s__ss_GETCOUNTERMODESssTTIMERCOUNTERMODES:
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
	call	FPC_ABSTRACTERROR
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
.Le76:
	.size	TIMERSs_sTABSTRACTTIMER_s__ss_GETCOUNTERMODESssTTIMERCOUNTERMODES, .Le76 - TIMERSs_sTABSTRACTTIMER_s__ss_GETCOUNTERMODESssTTIMERCOUNTERMODES

.section .text.n_timerss_stabstracttimer_s__ss_setcountermodessttimercountermodes,"ax"
.globl	TIMERSs_sTABSTRACTTIMER_s__ss_SETCOUNTERMODESsTTIMERCOUNTERMODES
TIMERSs_sTABSTRACTTIMER_s__ss_SETCOUNTERMODESsTTIMERCOUNTERMODES:
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
# Var AValue located at r28+2, size=OS_8
# Var $self located at r28+3, size=OS_16
	std	Y+3,r24
	std	Y+4,r25
	std	Y+2,r22
	call	FPC_ABSTRACTERROR
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
.Le77:
	.size	TIMERSs_sTABSTRACTTIMER_s__ss_SETCOUNTERMODESsTTIMERCOUNTERMODES, .Le77 - TIMERSs_sTABSTRACTTIMER_s__ss_SETCOUNTERMODESsTTIMERCOUNTERMODES

.section .text.n_timerss_stabstracttimer_s__ss_getoutputmodesssttimeroutputmodes,"ax"
.globl	TIMERSs_sTABSTRACTTIMER_s__ss_GETOUTPUTMODESssTTIMEROUTPUTMODES
TIMERSs_sTABSTRACTTIMER_s__ss_GETOUTPUTMODESssTTIMEROUTPUTMODES:
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
	call	FPC_ABSTRACTERROR
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
.Le78:
	.size	TIMERSs_sTABSTRACTTIMER_s__ss_GETOUTPUTMODESssTTIMEROUTPUTMODES, .Le78 - TIMERSs_sTABSTRACTTIMER_s__ss_GETOUTPUTMODESssTTIMEROUTPUTMODES

.section .text.n_timerss_stabstracttimer_s__ss_setoutputmodessttimeroutputmodes,"ax"
.globl	TIMERSs_sTABSTRACTTIMER_s__ss_SETOUTPUTMODESsTTIMEROUTPUTMODES
TIMERSs_sTABSTRACTTIMER_s__ss_SETOUTPUTMODESsTTIMEROUTPUTMODES:
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
# Var AValue located at r28+2, size=OS_8
# Var $self located at r28+3, size=OS_16
	std	Y+3,r24
	std	Y+4,r25
	std	Y+2,r22
	call	FPC_ABSTRACTERROR
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
.Le79:
	.size	TIMERSs_sTABSTRACTTIMER_s__ss_SETOUTPUTMODESsTTIMEROUTPUTMODES, .Le79 - TIMERSs_sTABSTRACTTIMER_s__ss_SETOUTPUTMODESsTTIMEROUTPUTMODES

.section .text.n_timerss_stabstracttimer_s__ss_getctcmodessboolean,"ax"
.globl	TIMERSs_sTABSTRACTTIMER_s__ss_GETCTCMODEssBOOLEAN
TIMERSs_sTABSTRACTTIMER_s__ss_GETCTCMODEssBOOLEAN:
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
	call	FPC_ABSTRACTERROR
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
.Le80:
	.size	TIMERSs_sTABSTRACTTIMER_s__ss_GETCTCMODEssBOOLEAN, .Le80 - TIMERSs_sTABSTRACTTIMER_s__ss_GETCTCMODEssBOOLEAN

.section .text.n_timerss_stabstracttimer_s__ss_setctcmodesboolean,"ax"
.globl	TIMERSs_sTABSTRACTTIMER_s__ss_SETCTCMODEsBOOLEAN
TIMERSs_sTABSTRACTTIMER_s__ss_SETCTCMODEsBOOLEAN:
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
# Var AValue located at r28+2, size=OS_8
# Var $self located at r28+3, size=OS_16
	std	Y+3,r24
	std	Y+4,r25
	std	Y+2,r22
	call	FPC_ABSTRACTERROR
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
.Le81:
	.size	TIMERSs_sTABSTRACTTIMER_s__ss_SETCTCMODEsBOOLEAN, .Le81 - TIMERSs_sTABSTRACTTIMER_s__ss_SETCTCMODEsBOOLEAN

.section .text.n_timerss_stabstracttimer_s__ss_bitsssbyte,"ax"
.globl	TIMERSs_sTABSTRACTTIMER_s__ss_BITSssBYTE
TIMERSs_sTABSTRACTTIMER_s__ss_BITSssBYTE:
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
	call	FPC_ABSTRACTERROR
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
.Le82:
	.size	TIMERSs_sTABSTRACTTIMER_s__ss_BITSssBYTE, .Le82 - TIMERSs_sTABSTRACTTIMER_s__ss_BITSssBYTE

.section .text.n_timerss_stsynctimer_s__ss_getclkmodessttimerclkmode,"ax"
.globl	TIMERSs_sTSYNCTIMER_s__ss_GETCLKMODEssTTIMERCLKMODE
TIMERSs_sTSYNCTIMER_s__ss_GETCLKMODEssTTIMERCLKMODE:
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
	call	FPC_ABSTRACTERROR
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
.Le83:
	.size	TIMERSs_sTSYNCTIMER_s__ss_GETCLKMODEssTTIMERCLKMODE, .Le83 - TIMERSs_sTSYNCTIMER_s__ss_GETCLKMODEssTTIMERCLKMODE

.section .text.n_timerss_stsynctimer_s__ss_setclkmodesttimerclkmode,"ax"
.globl	TIMERSs_sTSYNCTIMER_s__ss_SETCLKMODEsTTIMERCLKMODE
TIMERSs_sTSYNCTIMER_s__ss_SETCLKMODEsTTIMERCLKMODE:
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
# Var AValue located at r28+2, size=OS_8
# Var $self located at r28+3, size=OS_16
	std	Y+3,r24
	std	Y+4,r25
	std	Y+2,r22
	call	FPC_ABSTRACTERROR
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
.Le84:
	.size	TIMERSs_sTSYNCTIMER_s__ss_SETCLKMODEsTTIMERCLKMODE, .Le84 - TIMERSs_sTSYNCTIMER_s__ss_SETCLKMODEsTTIMERCLKMODE

.section .text.n_timers_ss_inits,"ax"
.globl	TIMERS_ss_inits
TIMERS_ss_inits:
.globl	INITs_sTIMERS
INITs_sTIMERS:
# [Timers.pas]
# [818] initialization
# [819] Timer0.Init;
	ldi	r18,lo8(VMT_sTIMERS_ss_TTIMER0)
	ldi	r23,hi8(VMT_sTIMERS_ss_TTIMER0)
	mov	r22,r18
	ldi	r24,lo8(U_sTIMERS_ss_TIMER0)
	ldi	r25,hi8(U_sTIMERS_ss_TIMER0)
	call	TIMERSs_sTABSTRACTTIMER_s__ss_INITssLONGBOOL
# [820] Timer1.Init;
	ldi	r22,lo8(VMT_sTIMERS_ss_TTIMER1)
	ldi	r23,hi8(VMT_sTIMERS_ss_TTIMER1)
	ldi	r24,lo8(U_sTIMERS_ss_TIMER1)
	ldi	r25,hi8(U_sTIMERS_ss_TIMER1)
	call	TIMERSs_sTABSTRACTTIMER_s__ss_INITssLONGBOOL
# [821] Timer2.Init;
	ldi	r22,lo8(VMT_sTIMERS_ss_TTIMER2)
	ldi	r23,hi8(VMT_sTIMERS_ss_TTIMER2)
	ldi	r24,lo8(U_sTIMERS_ss_TIMER2)
	ldi	r25,hi8(U_sTIMERS_ss_TIMER2)
	call	TIMERSs_sTABSTRACTTIMER_s__ss_INITssLONGBOOL
# [823] end.
	ret
.Le85:
	.size	TIMERS_ss_inits, .Le85 - TIMERS_ss_inits
# End asmlist al_procedures
# Begin asmlist al_globals

.section .bss.n_u_stimers_ss_timer0,"aw",%nobits
# [169] Timer0: TTimer0;
	.globl U_sTIMERS_ss_TIMER0
	.size U_sTIMERS_ss_TIMER0,44
U_sTIMERS_ss_TIMER0:
	.zero 44

.section .bss.n_u_stimers_ss_timer1,"aw",%nobits
# [170] Timer1: TTimer1;
	.globl U_sTIMERS_ss_TIMER1
	.size U_sTIMERS_ss_TIMER1,44
U_sTIMERS_ss_TIMER1:
	.zero 44

.section .bss.n_u_stimers_ss_timer2,"aw",%nobits
# [171] Timer2: TTimer2;
	.globl U_sTIMERS_ss_TIMER2
	.size U_sTIMERS_ss_TIMER2,44
U_sTIMERS_ss_TIMER2:
	.zero 44

.section .data.n_VMT_sTIMERS_ss_TABSTRACTTIMER
	.balign 2
.globl	VMT_sTIMERS_ss_TABSTRACTTIMER
VMT_sTIMERS_ss_TABSTRACTTIMER:
	.short	44,65492,0
	.short	gs(FPC_ABSTRACTERROR)
	.short	gs(FPC_ABSTRACTERROR)
	.short	gs(FPC_ABSTRACTERROR)
	.short	gs(FPC_ABSTRACTERROR)
	.short	gs(FPC_ABSTRACTERROR)
	.short	gs(FPC_ABSTRACTERROR)
	.short	gs(FPC_ABSTRACTERROR)
	.short	gs(0)
.Le86:
	.size	VMT_sTIMERS_ss_TABSTRACTTIMER, .Le86 - VMT_sTIMERS_ss_TABSTRACTTIMER

.section .data.n_VMT_sTIMERS_ss_TSYNCTIMER
	.balign 2
.globl	VMT_sTIMERS_ss_TSYNCTIMER
VMT_sTIMERS_ss_TSYNCTIMER:
	.short	44,65492
	.short	VMT_sTIMERS_ss_TABSTRACTTIMERsindirect
	.short	gs(FPC_ABSTRACTERROR)
	.short	gs(FPC_ABSTRACTERROR)
	.short	gs(FPC_ABSTRACTERROR)
	.short	gs(FPC_ABSTRACTERROR)
	.short	gs(FPC_ABSTRACTERROR)
	.short	gs(FPC_ABSTRACTERROR)
	.short	gs(FPC_ABSTRACTERROR)
	.short	gs(FPC_ABSTRACTERROR)
	.short	gs(FPC_ABSTRACTERROR)
	.short	gs(0)
.Le87:
	.size	VMT_sTIMERS_ss_TSYNCTIMER, .Le87 - VMT_sTIMERS_ss_TSYNCTIMER

.section .data.n_VMT_sTIMERS_ss_TTIMER0
	.balign 2
.globl	VMT_sTIMERS_ss_TTIMER0
VMT_sTIMERS_ss_TTIMER0:
	.short	44,65492
	.short	VMT_sTIMERS_ss_TSYNCTIMERsindirect
	.short	gs(TIMERSs_sTTIMER0_s__ss_GETCOUNTERMODESssTTIMERCOUNTERMODES)
	.short	gs(TIMERSs_sTTIMER0_s__ss_SETCOUNTERMODESsTTIMERCOUNTERMODES)
	.short	gs(TIMERSs_sTTIMER0_s__ss_GETOUTPUTMODESssTTIMEROUTPUTMODES)
	.short	gs(TIMERSs_sTTIMER0_s__ss_SETOUTPUTMODESsTTIMEROUTPUTMODES)
	.short	gs(TIMERSs_sTTIMER0_s__ss_GETCTCMODEssBOOLEAN)
	.short	gs(TIMERSs_sTTIMER0_s__ss_SETCTCMODEsBOOLEAN)
	.short	gs(TIMERSs_sTTIMER0_s__ss_BITSssBYTE)
	.short	gs(TIMERSs_sTTIMER0_s__ss_GETCLKMODEssTTIMERCLKMODE)
	.short	gs(TIMERSs_sTTIMER0_s__ss_SETCLKMODEsTTIMERCLKMODE)
	.short	gs(0)
.Le88:
	.size	VMT_sTIMERS_ss_TTIMER0, .Le88 - VMT_sTIMERS_ss_TTIMER0

.section .data.n_VMT_sTIMERS_ss_TTIMER1
	.balign 2
.globl	VMT_sTIMERS_ss_TTIMER1
VMT_sTIMERS_ss_TTIMER1:
	.short	44,65492
	.short	VMT_sTIMERS_ss_TSYNCTIMERsindirect
	.short	gs(TIMERSs_sTTIMER1_s__ss_GETCOUNTERMODESssTTIMERCOUNTERMODES)
	.short	gs(TIMERSs_sTTIMER1_s__ss_SETCOUNTERMODESsTTIMERCOUNTERMODES)
	.short	gs(TIMERSs_sTTIMER1_s__ss_GETOUTPUTMODESssTTIMEROUTPUTMODES)
	.short	gs(TIMERSs_sTTIMER1_s__ss_SETOUTPUTMODESsTTIMEROUTPUTMODES)
	.short	gs(TIMERSs_sTTIMER1_s__ss_GETCTCMODEssBOOLEAN)
	.short	gs(TIMERSs_sTTIMER1_s__ss_SETCTCMODEsBOOLEAN)
	.short	gs(TIMERSs_sTTIMER1_s__ss_BITSssBYTE)
	.short	gs(TIMERSs_sTTIMER1_s__ss_GETCLKMODEssTTIMERCLKMODE)
	.short	gs(TIMERSs_sTTIMER1_s__ss_SETCLKMODEsTTIMERCLKMODE)
	.short	gs(0)
.Le89:
	.size	VMT_sTIMERS_ss_TTIMER1, .Le89 - VMT_sTIMERS_ss_TTIMER1

.section .data.n_VMT_sTIMERS_ss_TTIMER2
	.balign 2
.globl	VMT_sTIMERS_ss_TTIMER2
VMT_sTIMERS_ss_TTIMER2:
	.short	44,65492
	.short	VMT_sTIMERS_ss_TABSTRACTTIMERsindirect
	.short	gs(TIMERSs_sTTIMER2_s__ss_GETCOUNTERMODESssTTIMERCOUNTERMODES)
	.short	gs(TIMERSs_sTTIMER2_s__ss_SETCOUNTERMODESsTTIMERCOUNTERMODES)
	.short	gs(TIMERSs_sTTIMER2_s__ss_GETOUTPUTMODESssTTIMEROUTPUTMODES)
	.short	gs(TIMERSs_sTTIMER2_s__ss_SETOUTPUTMODESsTTIMEROUTPUTMODES)
	.short	gs(TIMERSs_sTTIMER2_s__ss_GETCTCMODEssBOOLEAN)
	.short	gs(TIMERSs_sTTIMER2_s__ss_SETCTCMODEsBOOLEAN)
	.short	gs(TIMERSs_sTTIMER2_s__ss_BITSssBYTE)
	.short	gs(0)
.Le90:
	.size	VMT_sTIMERS_ss_TTIMER2, .Le90 - VMT_sTIMERS_ss_TTIMER2
# End asmlist al_globals
# Begin asmlist al_rtti

.section .data.n_RTTI_sTIMERS_ss_TTIMERCOUNTERMODE
.globl	RTTI_sTIMERS_ss_TTIMERCOUNTERMODE
RTTI_sTIMERS_ss_TTIMERCOUNTERMODE:
	.byte	3,17
# [824] 
	.ascii	"TTimerCounterMode"
	.short	0
	.byte	1
	.long	0,5
	.short	0
	.byte	11
	.ascii	"tcmOverflow"
	.byte	11
	.ascii	"tcmCompareA"
	.byte	11
	.ascii	"tcmCompareB"
	.byte	13
	.ascii	"tcmUndefined3"
	.byte	13
	.ascii	"tcmUndefined4"
	.byte	10
	.ascii	"tcmCapture"
	.byte	6
	.ascii	"Timers"
	.byte	0
.Le91:
	.size	RTTI_sTIMERS_ss_TTIMERCOUNTERMODE, .Le91 - RTTI_sTIMERS_ss_TTIMERCOUNTERMODE

.section .data.n_RTTI_sTIMERS_ss_TTIMERCOUNTERMODE_s2o
	.balign 2
.globl	RTTI_sTIMERS_ss_TTIMERCOUNTERMODE_s2o
RTTI_sTIMERS_ss_TTIMERCOUNTERMODE_s2o:
	.long	6,5
	.short	RTTI_sTIMERS_ss_TTIMERCOUNTERMODE+96
	.long	1
	.short	RTTI_sTIMERS_ss_TTIMERCOUNTERMODE+44
	.long	2
	.short	RTTI_sTIMERS_ss_TTIMERCOUNTERMODE+56
	.long	0
	.short	RTTI_sTIMERS_ss_TTIMERCOUNTERMODE+32
	.long	3
	.short	RTTI_sTIMERS_ss_TTIMERCOUNTERMODE+68
	.long	4
	.short	RTTI_sTIMERS_ss_TTIMERCOUNTERMODE+82
.Le92:
	.size	RTTI_sTIMERS_ss_TTIMERCOUNTERMODE_s2o, .Le92 - RTTI_sTIMERS_ss_TTIMERCOUNTERMODE_s2o

.section .data.n_RTTI_sTIMERS_ss_TTIMERCOUNTERMODE_o2s
	.balign 2
.globl	RTTI_sTIMERS_ss_TTIMERCOUNTERMODE_o2s
RTTI_sTIMERS_ss_TTIMERCOUNTERMODE_o2s:
	.long	0
	.short	RTTI_sTIMERS_ss_TTIMERCOUNTERMODE+32
	.short	RTTI_sTIMERS_ss_TTIMERCOUNTERMODE+44
	.short	RTTI_sTIMERS_ss_TTIMERCOUNTERMODE+56
	.short	RTTI_sTIMERS_ss_TTIMERCOUNTERMODE+68
	.short	RTTI_sTIMERS_ss_TTIMERCOUNTERMODE+82
	.short	RTTI_sTIMERS_ss_TTIMERCOUNTERMODE+96
.Le93:
	.size	RTTI_sTIMERS_ss_TTIMERCOUNTERMODE_o2s, .Le93 - RTTI_sTIMERS_ss_TTIMERCOUNTERMODE_o2s

.section .data.n_RTTI_sTIMERS_ss_TTIMERCOUNTERMODES
.globl	RTTI_sTIMERS_ss_TTIMERCOUNTERMODES
RTTI_sTIMERS_ss_TTIMERCOUNTERMODES:
	.byte	5,18
	.ascii	"TTimerCounterModes"
	.short	0
	.byte	1
	.short	1
	.short	RTTI_sTIMERS_ss_TTIMERCOUNTERMODEsindirect
.Le94:
	.size	RTTI_sTIMERS_ss_TTIMERCOUNTERMODES, .Le94 - RTTI_sTIMERS_ss_TTIMERCOUNTERMODES

.section .data.n_RTTI_sTIMERS_ss_TTIMEROUTPUTMODE
.globl	RTTI_sTIMERS_ss_TTIMEROUTPUTMODE
RTTI_sTIMERS_ss_TTIMEROUTPUTMODE:
	.byte	3,16
	.ascii	"TTimerOutputMode"
	.short	0
	.byte	1
	.long	0,7
	.short	0
	.byte	11
	.ascii	"tomWaveForm"
	.byte	13
	.ascii	"tomUndefined1"
	.byte	13
	.ascii	"tomUndefined2"
	.byte	13
	.ascii	"tomUndefined3"
	.byte	10
	.ascii	"tomFastPWM"
	.byte	13
	.ascii	"tomUndefined5"
	.byte	18
	.ascii	"tomPhaseCorrectPWM"
	.byte	13
	.ascii	"tomUndefined7"
	.byte	6
	.ascii	"Timers"
	.byte	0
.Le95:
	.size	RTTI_sTIMERS_ss_TTIMEROUTPUTMODE, .Le95 - RTTI_sTIMERS_ss_TTIMEROUTPUTMODE

.section .data.n_RTTI_sTIMERS_ss_TTIMEROUTPUTMODE_s2o
	.balign 2
.globl	RTTI_sTIMERS_ss_TTIMEROUTPUTMODE_s2o
RTTI_sTIMERS_ss_TTIMEROUTPUTMODE_s2o:
	.long	8,4
	.short	RTTI_sTIMERS_ss_TTIMEROUTPUTMODE+85
	.long	6
	.short	RTTI_sTIMERS_ss_TTIMEROUTPUTMODE+110
	.long	1
	.short	RTTI_sTIMERS_ss_TTIMEROUTPUTMODE+43
	.long	2
	.short	RTTI_sTIMERS_ss_TTIMEROUTPUTMODE+57
	.long	3
	.short	RTTI_sTIMERS_ss_TTIMEROUTPUTMODE+71
	.long	5
	.short	RTTI_sTIMERS_ss_TTIMEROUTPUTMODE+96
	.long	7
	.short	RTTI_sTIMERS_ss_TTIMEROUTPUTMODE+129
	.long	0
	.short	RTTI_sTIMERS_ss_TTIMEROUTPUTMODE+31
.Le96:
	.size	RTTI_sTIMERS_ss_TTIMEROUTPUTMODE_s2o, .Le96 - RTTI_sTIMERS_ss_TTIMEROUTPUTMODE_s2o

.section .data.n_RTTI_sTIMERS_ss_TTIMEROUTPUTMODE_o2s
	.balign 2
.globl	RTTI_sTIMERS_ss_TTIMEROUTPUTMODE_o2s
RTTI_sTIMERS_ss_TTIMEROUTPUTMODE_o2s:
	.long	0
	.short	RTTI_sTIMERS_ss_TTIMEROUTPUTMODE+31
	.short	RTTI_sTIMERS_ss_TTIMEROUTPUTMODE+43
	.short	RTTI_sTIMERS_ss_TTIMEROUTPUTMODE+57
	.short	RTTI_sTIMERS_ss_TTIMEROUTPUTMODE+71
	.short	RTTI_sTIMERS_ss_TTIMEROUTPUTMODE+85
	.short	RTTI_sTIMERS_ss_TTIMEROUTPUTMODE+96
	.short	RTTI_sTIMERS_ss_TTIMEROUTPUTMODE+110
	.short	RTTI_sTIMERS_ss_TTIMEROUTPUTMODE+129
.Le97:
	.size	RTTI_sTIMERS_ss_TTIMEROUTPUTMODE_o2s, .Le97 - RTTI_sTIMERS_ss_TTIMEROUTPUTMODE_o2s

.section .data.n_RTTI_sTIMERS_ss_TTIMEROUTPUTMODES
.globl	RTTI_sTIMERS_ss_TTIMEROUTPUTMODES
RTTI_sTIMERS_ss_TTIMEROUTPUTMODES:
	.byte	5,17
	.ascii	"TTimerOutputModes"
	.short	0
	.byte	1
	.short	1
	.short	RTTI_sTIMERS_ss_TTIMEROUTPUTMODEsindirect
.Le98:
	.size	RTTI_sTIMERS_ss_TTIMEROUTPUTMODES, .Le98 - RTTI_sTIMERS_ss_TTIMEROUTPUTMODES

.section .data.n_RTTI_sTIMERS_ss_TTIMERCLKMODE
.globl	RTTI_sTIMERS_ss_TTIMERCLKMODE
RTTI_sTIMERS_ss_TTIMERCLKMODE:
	.byte	3,13
	.ascii	"TTimerCLKMode"
	.short	0
	.byte	1
	.long	0,7
	.short	0
	.byte	8
	.ascii	"tclkmOff"
	.byte	6
	.ascii	"tclkm1"
	.byte	6
	.ascii	"tclkm8"
	.byte	7
	.ascii	"tclkm64"
	.byte	8
	.ascii	"tclkm256"
	.byte	9
	.ascii	"tclkm1024"
	.byte	9
	.ascii	"tclkmT1Up"
	.byte	11
	.ascii	"tclkmT1Down"
	.byte	6
	.ascii	"Timers"
	.byte	0
.Le99:
	.size	RTTI_sTIMERS_ss_TTIMERCLKMODE, .Le99 - RTTI_sTIMERS_ss_TTIMERCLKMODE

.section .data.n_RTTI_sTIMERS_ss_TTIMERCLKMODE_s2o
	.balign 2
.globl	RTTI_sTIMERS_ss_TTIMERCLKMODE_s2o
RTTI_sTIMERS_ss_TTIMERCLKMODE_s2o:
	.long	8,1
	.short	RTTI_sTIMERS_ss_TTIMERCLKMODE+37
	.long	5
	.short	RTTI_sTIMERS_ss_TTIMERCLKMODE+68
	.long	4
	.short	RTTI_sTIMERS_ss_TTIMERCLKMODE+59
	.long	3
	.short	RTTI_sTIMERS_ss_TTIMERCLKMODE+51
	.long	2
	.short	RTTI_sTIMERS_ss_TTIMERCLKMODE+44
	.long	0
	.short	RTTI_sTIMERS_ss_TTIMERCLKMODE+28
	.long	7
	.short	RTTI_sTIMERS_ss_TTIMERCLKMODE+88
	.long	6
	.short	RTTI_sTIMERS_ss_TTIMERCLKMODE+78
.Le100:
	.size	RTTI_sTIMERS_ss_TTIMERCLKMODE_s2o, .Le100 - RTTI_sTIMERS_ss_TTIMERCLKMODE_s2o

.section .data.n_RTTI_sTIMERS_ss_TTIMERCLKMODE_o2s
	.balign 2
.globl	RTTI_sTIMERS_ss_TTIMERCLKMODE_o2s
RTTI_sTIMERS_ss_TTIMERCLKMODE_o2s:
	.long	0
	.short	RTTI_sTIMERS_ss_TTIMERCLKMODE+28
	.short	RTTI_sTIMERS_ss_TTIMERCLKMODE+37
	.short	RTTI_sTIMERS_ss_TTIMERCLKMODE+44
	.short	RTTI_sTIMERS_ss_TTIMERCLKMODE+51
	.short	RTTI_sTIMERS_ss_TTIMERCLKMODE+59
	.short	RTTI_sTIMERS_ss_TTIMERCLKMODE+68
	.short	RTTI_sTIMERS_ss_TTIMERCLKMODE+78
	.short	RTTI_sTIMERS_ss_TTIMERCLKMODE+88
.Le101:
	.size	RTTI_sTIMERS_ss_TTIMERCLKMODE_o2s, .Le101 - RTTI_sTIMERS_ss_TTIMERCLKMODE_o2s

.section .data.n_RTTI_sTIMERS_ss_TTIMER2CLKMODE
.globl	RTTI_sTIMERS_ss_TTIMER2CLKMODE
RTTI_sTIMERS_ss_TTIMER2CLKMODE:
	.byte	3,14
	.ascii	"TTimer2CLKMode"
	.short	0
	.byte	1
	.long	0,7
	.short	0
	.byte	9
	.ascii	"t2clkmOff"
	.byte	7
	.ascii	"t2clkm1"
	.byte	7
	.ascii	"t2clkm8"
	.byte	8
	.ascii	"t2clkm32"
	.byte	8
	.ascii	"t2clkm64"
	.byte	9
	.ascii	"t2clkm128"
	.byte	9
	.ascii	"t2clkm256"
	.byte	10
	.ascii	"t2clkm1024"
	.byte	6
	.ascii	"Timers"
	.byte	0
.Le102:
	.size	RTTI_sTIMERS_ss_TTIMER2CLKMODE, .Le102 - RTTI_sTIMERS_ss_TTIMER2CLKMODE

.section .data.n_RTTI_sTIMERS_ss_TTIMER2CLKMODE_s2o
	.balign 2
.globl	RTTI_sTIMERS_ss_TTIMER2CLKMODE_s2o
RTTI_sTIMERS_ss_TTIMER2CLKMODE_s2o:
	.long	8,1
	.short	RTTI_sTIMERS_ss_TTIMER2CLKMODE+39
	.long	7
	.short	RTTI_sTIMERS_ss_TTIMER2CLKMODE+93
	.long	5
	.short	RTTI_sTIMERS_ss_TTIMER2CLKMODE+73
	.long	6
	.short	RTTI_sTIMERS_ss_TTIMER2CLKMODE+83
	.long	3
	.short	RTTI_sTIMERS_ss_TTIMER2CLKMODE+55
	.long	4
	.short	RTTI_sTIMERS_ss_TTIMER2CLKMODE+64
	.long	2
	.short	RTTI_sTIMERS_ss_TTIMER2CLKMODE+47
	.long	0
	.short	RTTI_sTIMERS_ss_TTIMER2CLKMODE+29
.Le103:
	.size	RTTI_sTIMERS_ss_TTIMER2CLKMODE_s2o, .Le103 - RTTI_sTIMERS_ss_TTIMER2CLKMODE_s2o

.section .data.n_RTTI_sTIMERS_ss_TTIMER2CLKMODE_o2s
	.balign 2
.globl	RTTI_sTIMERS_ss_TTIMER2CLKMODE_o2s
RTTI_sTIMERS_ss_TTIMER2CLKMODE_o2s:
	.long	0
	.short	RTTI_sTIMERS_ss_TTIMER2CLKMODE+29
	.short	RTTI_sTIMERS_ss_TTIMER2CLKMODE+39
	.short	RTTI_sTIMERS_ss_TTIMER2CLKMODE+47
	.short	RTTI_sTIMERS_ss_TTIMER2CLKMODE+55
	.short	RTTI_sTIMERS_ss_TTIMER2CLKMODE+64
	.short	RTTI_sTIMERS_ss_TTIMER2CLKMODE+73
	.short	RTTI_sTIMERS_ss_TTIMER2CLKMODE+83
	.short	RTTI_sTIMERS_ss_TTIMER2CLKMODE+93
.Le104:
	.size	RTTI_sTIMERS_ss_TTIMER2CLKMODE_o2s, .Le104 - RTTI_sTIMERS_ss_TTIMER2CLKMODE_o2s

.section .data.n_RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPE
.globl	RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPE
RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPE:
	.byte	3,24
	.ascii	"TTimerSubscribeEventType"
	.short	0
	.byte	1
	.long	0,2
	.short	0
	.byte	12
	.ascii	"tsetCompareA"
	.byte	12
	.ascii	"tsetCompareB"
	.byte	12
	.ascii	"tsetOverflow"
	.byte	6
	.ascii	"Timers"
	.byte	0
.Le105:
	.size	RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPE, .Le105 - RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPE

.section .data.n_RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPE_s2o
	.balign 2
.globl	RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPE_s2o
RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPE_s2o:
	.long	3,0
	.short	RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPE+39
	.long	1
	.short	RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPE+52
	.long	2
	.short	RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPE+65
.Le106:
	.size	RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPE_s2o, .Le106 - RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPE_s2o

.section .data.n_RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPE_o2s
	.balign 2
.globl	RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPE_o2s
RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPE_o2s:
	.long	0
	.short	RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPE+39
	.short	RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPE+52
	.short	RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPE+65
.Le107:
	.size	RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPE_o2s, .Le107 - RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPE_o2s

.section .data.n_RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPES
.globl	RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPES
RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPES:
	.byte	5,25
	.ascii	"TTimerSubscribeEventTypes"
	.short	0
	.byte	1
	.short	1
	.short	RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPEsindirect
.Le108:
	.size	RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPES, .Le108 - RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPES

.section .data.n_RTTI_sTIMERS_ss_TTIMERSUBSCRIBEROFS
.globl	RTTI_sTIMERS_ss_TTIMERSUBSCRIBEROFS
RTTI_sTIMERS_ss_TTIMERSUBSCRIBEROFS:
	.byte	12,19
	.ascii	"TTimerSubscriberOFs"
	.short	0,32,8
	.short	RTTI_sSYSTEM_ss_TMETHODsindirect
	.byte	1
	.short	RTTI_sSYSTEM_ss_SHORTINTsindirect
.Le109:
	.size	RTTI_sTIMERS_ss_TTIMERSUBSCRIBEROFS, .Le109 - RTTI_sTIMERS_ss_TTIMERSUBSCRIBEROFS

.section .data.n_RTTI_sTIMERS_ss_TTIMERINTERRUPTEVENT
.globl	RTTI_sTIMERS_ss_TTIMERINTERRUPTEVENT
RTTI_sTIMERS_ss_TTIMERINTERRUPTEVENT:
	.byte	6,20
	.ascii	"TTimerInterruptEvent"
	.short	0
	.byte	0,1
	.short	640
	.byte	5
	.ascii	"$self"
	.byte	7
	.ascii	"Pointer"
	.byte	3
	.short	RTTI_sSYSTEM_ss_POINTERsindirect
.Le110:
	.size	RTTI_sTIMERS_ss_TTIMERINTERRUPTEVENT, .Le110 - RTTI_sTIMERS_ss_TTIMERINTERRUPTEVENT

.section .data.n_INIT_sTIMERS_ss_TABSTRACTTIMER
.globl	INIT_sTIMERS_ss_TABSTRACTTIMER
INIT_sTIMERS_ss_TABSTRACTTIMER:
	.byte	16,14
	.ascii	"TAbstractTimer"
	.short	0,0
	.long	44
	.short	0,0
	.long	0
.Le111:
	.size	INIT_sTIMERS_ss_TABSTRACTTIMER, .Le111 - INIT_sTIMERS_ss_TABSTRACTTIMER

.section .data.n_RTTI_sTIMERS_ss_TABSTRACTTIMER
.globl	RTTI_sTIMERS_ss_TABSTRACTTIMER
RTTI_sTIMERS_ss_TABSTRACTTIMER:
	.byte	16,14
	.ascii	"TAbstractTimer"
	.short	0
	.short	INIT_sTIMERS_ss_TABSTRACTTIMER
	.long	44,5
	.short	RTTI_sTIMERS_ss_TTIMERSUBSCRIBEROFSsindirect
	.short	0
	.short	RTTI_sSYSTEM_ss_BYTEsindirect
	.short	32
	.short	RTTI_sTIMERS_ss_TTIMERINTERRUPTEVENTsindirect
	.short	34
	.short	RTTI_sTIMERS_ss_TTIMERINTERRUPTEVENTsindirect
	.short	38
	.short	RTTI_sSYSTEM_ss_POINTERsindirect
	.short	42
.Le112:
	.size	RTTI_sTIMERS_ss_TABSTRACTTIMER, .Le112 - RTTI_sTIMERS_ss_TABSTRACTTIMER

.section .data.n_RTTI_sTIMERS_ss_PTIMER
.globl	RTTI_sTIMERS_ss_PTIMER
RTTI_sTIMERS_ss_PTIMER:
	.byte	29,6
	.ascii	"PTimer"
	.short	0
	.short	RTTI_sTIMERS_ss_TABSTRACTTIMERsindirect
.Le113:
	.size	RTTI_sTIMERS_ss_PTIMER, .Le113 - RTTI_sTIMERS_ss_PTIMER

.section .data.n_RTTI_sTIMERS_ss_TTIMERINTERRUPTPROC
.globl	RTTI_sTIMERS_ss_TTIMERINTERRUPTPROC
RTTI_sTIMERS_ss_TTIMERINTERRUPTPROC:
	.byte	23,19
	.ascii	"TTimerInterruptProc"
	.short	0
	.byte	0,3
	.short	0
	.byte	0
.Le114:
	.size	RTTI_sTIMERS_ss_TTIMERINTERRUPTPROC, .Le114 - RTTI_sTIMERS_ss_TTIMERINTERRUPTPROC

.section .data.n_INIT_sTIMERS_ss_TTIMERSUBSCRIBEROFS
.globl	INIT_sTIMERS_ss_TTIMERSUBSCRIBEROFS
INIT_sTIMERS_ss_TTIMERSUBSCRIBEROFS:
	.byte	12,19
	.ascii	"TTimerSubscriberOFs"
	.short	0,32,8
	.short	INIT_sSYSTEM_ss_TMETHODsindirect
	.byte	1
	.short	RTTI_sSYSTEM_ss_SHORTINTsindirect
.Le115:
	.size	INIT_sTIMERS_ss_TTIMERSUBSCRIBEROFS, .Le115 - INIT_sTIMERS_ss_TTIMERSUBSCRIBEROFS

.section .data.n_INIT_sTIMERS_ss_TSYNCTIMER
.globl	INIT_sTIMERS_ss_TSYNCTIMER
INIT_sTIMERS_ss_TSYNCTIMER:
	.byte	16,10
	.ascii	"TSyncTimer"
	.short	0,0
	.long	44
	.short	0,0
	.long	0
.Le116:
	.size	INIT_sTIMERS_ss_TSYNCTIMER, .Le116 - INIT_sTIMERS_ss_TSYNCTIMER

.section .data.n_RTTI_sTIMERS_ss_TSYNCTIMER
.globl	RTTI_sTIMERS_ss_TSYNCTIMER
RTTI_sTIMERS_ss_TSYNCTIMER:
	.byte	16,10
	.ascii	"TSyncTimer"
	.short	0
	.short	INIT_sTIMERS_ss_TSYNCTIMER
	.long	44,1
	.short	RTTI_sTIMERS_ss_TABSTRACTTIMERsindirect
	.short	0
.Le117:
	.size	RTTI_sTIMERS_ss_TSYNCTIMER, .Le117 - RTTI_sTIMERS_ss_TSYNCTIMER

.section .data.n_INIT_sTIMERS_ss_TTIMER0
.globl	INIT_sTIMERS_ss_TTIMER0
INIT_sTIMERS_ss_TTIMER0:
	.byte	16,7
	.ascii	"TTimer0"
	.short	0,0
	.long	44
	.short	0,0
	.long	0
.Le118:
	.size	INIT_sTIMERS_ss_TTIMER0, .Le118 - INIT_sTIMERS_ss_TTIMER0

.section .data.n_RTTI_sTIMERS_ss_TTIMER0
.globl	RTTI_sTIMERS_ss_TTIMER0
RTTI_sTIMERS_ss_TTIMER0:
	.byte	16,7
	.ascii	"TTimer0"
	.short	0
	.short	INIT_sTIMERS_ss_TTIMER0
	.long	44,1
	.short	RTTI_sTIMERS_ss_TSYNCTIMERsindirect
	.short	0
.Le119:
	.size	RTTI_sTIMERS_ss_TTIMER0, .Le119 - RTTI_sTIMERS_ss_TTIMER0

.section .data.n_INIT_sTIMERS_ss_TTIMER1
.globl	INIT_sTIMERS_ss_TTIMER1
INIT_sTIMERS_ss_TTIMER1:
	.byte	16,7
	.ascii	"TTimer1"
	.short	0,0
	.long	44
	.short	0,0
	.long	0
.Le120:
	.size	INIT_sTIMERS_ss_TTIMER1, .Le120 - INIT_sTIMERS_ss_TTIMER1

.section .data.n_RTTI_sTIMERS_ss_TTIMER1
.globl	RTTI_sTIMERS_ss_TTIMER1
RTTI_sTIMERS_ss_TTIMER1:
	.byte	16,7
	.ascii	"TTimer1"
	.short	0
	.short	INIT_sTIMERS_ss_TTIMER1
	.long	44,1
	.short	RTTI_sTIMERS_ss_TSYNCTIMERsindirect
	.short	0
.Le121:
	.size	RTTI_sTIMERS_ss_TTIMER1, .Le121 - RTTI_sTIMERS_ss_TTIMER1

.section .data.n_INIT_sTIMERS_ss_TTIMER2
.globl	INIT_sTIMERS_ss_TTIMER2
INIT_sTIMERS_ss_TTIMER2:
	.byte	16,7
	.ascii	"TTimer2"
	.short	0,0
	.long	44
	.short	0,0
	.long	0
.Le122:
	.size	INIT_sTIMERS_ss_TTIMER2, .Le122 - INIT_sTIMERS_ss_TTIMER2

.section .data.n_RTTI_sTIMERS_ss_TTIMER2
.globl	RTTI_sTIMERS_ss_TTIMER2
RTTI_sTIMERS_ss_TTIMER2:
	.byte	16,7
	.ascii	"TTimer2"
	.short	0
	.short	INIT_sTIMERS_ss_TTIMER2
	.long	44,1
	.short	RTTI_sTIMERS_ss_TABSTRACTTIMERsindirect
	.short	0
.Le123:
	.size	RTTI_sTIMERS_ss_TTIMER2, .Le123 - RTTI_sTIMERS_ss_TTIMER2
# End asmlist al_rtti
# Begin asmlist al_indirectglobals

.section .data.n_VMT_sTIMERS_ss_TABSTRACTTIMER
	.balign 2
.globl	VMT_sTIMERS_ss_TABSTRACTTIMERsindirect
VMT_sTIMERS_ss_TABSTRACTTIMERsindirect:
	.short	VMT_sTIMERS_ss_TABSTRACTTIMER
.Le124:
	.size	VMT_sTIMERS_ss_TABSTRACTTIMERsindirect, .Le124 - VMT_sTIMERS_ss_TABSTRACTTIMERsindirect

.section .data.n_VMT_sTIMERS_ss_TSYNCTIMER
	.balign 2
.globl	VMT_sTIMERS_ss_TSYNCTIMERsindirect
VMT_sTIMERS_ss_TSYNCTIMERsindirect:
	.short	VMT_sTIMERS_ss_TSYNCTIMER
.Le125:
	.size	VMT_sTIMERS_ss_TSYNCTIMERsindirect, .Le125 - VMT_sTIMERS_ss_TSYNCTIMERsindirect

.section .data.n_VMT_sTIMERS_ss_TTIMER0
	.balign 2
.globl	VMT_sTIMERS_ss_TTIMER0sindirect
VMT_sTIMERS_ss_TTIMER0sindirect:
	.short	VMT_sTIMERS_ss_TTIMER0
.Le126:
	.size	VMT_sTIMERS_ss_TTIMER0sindirect, .Le126 - VMT_sTIMERS_ss_TTIMER0sindirect

.section .data.n_VMT_sTIMERS_ss_TTIMER1
	.balign 2
.globl	VMT_sTIMERS_ss_TTIMER1sindirect
VMT_sTIMERS_ss_TTIMER1sindirect:
	.short	VMT_sTIMERS_ss_TTIMER1
.Le127:
	.size	VMT_sTIMERS_ss_TTIMER1sindirect, .Le127 - VMT_sTIMERS_ss_TTIMER1sindirect

.section .data.n_VMT_sTIMERS_ss_TTIMER2
	.balign 2
.globl	VMT_sTIMERS_ss_TTIMER2sindirect
VMT_sTIMERS_ss_TTIMER2sindirect:
	.short	VMT_sTIMERS_ss_TTIMER2
.Le128:
	.size	VMT_sTIMERS_ss_TTIMER2sindirect, .Le128 - VMT_sTIMERS_ss_TTIMER2sindirect

.section .data.n_RTTI_sTIMERS_ss_TTIMERCOUNTERMODE
	.balign 2
.globl	RTTI_sTIMERS_ss_TTIMERCOUNTERMODEsindirect
RTTI_sTIMERS_ss_TTIMERCOUNTERMODEsindirect:
	.short	RTTI_sTIMERS_ss_TTIMERCOUNTERMODE
.Le129:
	.size	RTTI_sTIMERS_ss_TTIMERCOUNTERMODEsindirect, .Le129 - RTTI_sTIMERS_ss_TTIMERCOUNTERMODEsindirect

.section .data.n_RTTI_sTIMERS_ss_TTIMERCOUNTERMODE_s2o
	.balign 2
.globl	RTTI_sTIMERS_ss_TTIMERCOUNTERMODE_s2osindirect
RTTI_sTIMERS_ss_TTIMERCOUNTERMODE_s2osindirect:
	.short	RTTI_sTIMERS_ss_TTIMERCOUNTERMODE_s2o
.Le130:
	.size	RTTI_sTIMERS_ss_TTIMERCOUNTERMODE_s2osindirect, .Le130 - RTTI_sTIMERS_ss_TTIMERCOUNTERMODE_s2osindirect

.section .data.n_RTTI_sTIMERS_ss_TTIMERCOUNTERMODE_o2s
	.balign 2
.globl	RTTI_sTIMERS_ss_TTIMERCOUNTERMODE_o2ssindirect
RTTI_sTIMERS_ss_TTIMERCOUNTERMODE_o2ssindirect:
	.short	RTTI_sTIMERS_ss_TTIMERCOUNTERMODE_o2s
.Le131:
	.size	RTTI_sTIMERS_ss_TTIMERCOUNTERMODE_o2ssindirect, .Le131 - RTTI_sTIMERS_ss_TTIMERCOUNTERMODE_o2ssindirect

.section .data.n_RTTI_sTIMERS_ss_TTIMERCOUNTERMODES
	.balign 2
.globl	RTTI_sTIMERS_ss_TTIMERCOUNTERMODESsindirect
RTTI_sTIMERS_ss_TTIMERCOUNTERMODESsindirect:
	.short	RTTI_sTIMERS_ss_TTIMERCOUNTERMODES
.Le132:
	.size	RTTI_sTIMERS_ss_TTIMERCOUNTERMODESsindirect, .Le132 - RTTI_sTIMERS_ss_TTIMERCOUNTERMODESsindirect

.section .data.n_RTTI_sTIMERS_ss_TTIMEROUTPUTMODE
	.balign 2
.globl	RTTI_sTIMERS_ss_TTIMEROUTPUTMODEsindirect
RTTI_sTIMERS_ss_TTIMEROUTPUTMODEsindirect:
	.short	RTTI_sTIMERS_ss_TTIMEROUTPUTMODE
.Le133:
	.size	RTTI_sTIMERS_ss_TTIMEROUTPUTMODEsindirect, .Le133 - RTTI_sTIMERS_ss_TTIMEROUTPUTMODEsindirect

.section .data.n_RTTI_sTIMERS_ss_TTIMEROUTPUTMODE_s2o
	.balign 2
.globl	RTTI_sTIMERS_ss_TTIMEROUTPUTMODE_s2osindirect
RTTI_sTIMERS_ss_TTIMEROUTPUTMODE_s2osindirect:
	.short	RTTI_sTIMERS_ss_TTIMEROUTPUTMODE_s2o
.Le134:
	.size	RTTI_sTIMERS_ss_TTIMEROUTPUTMODE_s2osindirect, .Le134 - RTTI_sTIMERS_ss_TTIMEROUTPUTMODE_s2osindirect

.section .data.n_RTTI_sTIMERS_ss_TTIMEROUTPUTMODE_o2s
	.balign 2
.globl	RTTI_sTIMERS_ss_TTIMEROUTPUTMODE_o2ssindirect
RTTI_sTIMERS_ss_TTIMEROUTPUTMODE_o2ssindirect:
	.short	RTTI_sTIMERS_ss_TTIMEROUTPUTMODE_o2s
.Le135:
	.size	RTTI_sTIMERS_ss_TTIMEROUTPUTMODE_o2ssindirect, .Le135 - RTTI_sTIMERS_ss_TTIMEROUTPUTMODE_o2ssindirect

.section .data.n_RTTI_sTIMERS_ss_TTIMEROUTPUTMODES
	.balign 2
.globl	RTTI_sTIMERS_ss_TTIMEROUTPUTMODESsindirect
RTTI_sTIMERS_ss_TTIMEROUTPUTMODESsindirect:
	.short	RTTI_sTIMERS_ss_TTIMEROUTPUTMODES
.Le136:
	.size	RTTI_sTIMERS_ss_TTIMEROUTPUTMODESsindirect, .Le136 - RTTI_sTIMERS_ss_TTIMEROUTPUTMODESsindirect

.section .data.n_RTTI_sTIMERS_ss_TTIMERCLKMODE
	.balign 2
.globl	RTTI_sTIMERS_ss_TTIMERCLKMODEsindirect
RTTI_sTIMERS_ss_TTIMERCLKMODEsindirect:
	.short	RTTI_sTIMERS_ss_TTIMERCLKMODE
.Le137:
	.size	RTTI_sTIMERS_ss_TTIMERCLKMODEsindirect, .Le137 - RTTI_sTIMERS_ss_TTIMERCLKMODEsindirect

.section .data.n_RTTI_sTIMERS_ss_TTIMERCLKMODE_s2o
	.balign 2
.globl	RTTI_sTIMERS_ss_TTIMERCLKMODE_s2osindirect
RTTI_sTIMERS_ss_TTIMERCLKMODE_s2osindirect:
	.short	RTTI_sTIMERS_ss_TTIMERCLKMODE_s2o
.Le138:
	.size	RTTI_sTIMERS_ss_TTIMERCLKMODE_s2osindirect, .Le138 - RTTI_sTIMERS_ss_TTIMERCLKMODE_s2osindirect

.section .data.n_RTTI_sTIMERS_ss_TTIMERCLKMODE_o2s
	.balign 2
.globl	RTTI_sTIMERS_ss_TTIMERCLKMODE_o2ssindirect
RTTI_sTIMERS_ss_TTIMERCLKMODE_o2ssindirect:
	.short	RTTI_sTIMERS_ss_TTIMERCLKMODE_o2s
.Le139:
	.size	RTTI_sTIMERS_ss_TTIMERCLKMODE_o2ssindirect, .Le139 - RTTI_sTIMERS_ss_TTIMERCLKMODE_o2ssindirect

.section .data.n_RTTI_sTIMERS_ss_TTIMER2CLKMODE
	.balign 2
.globl	RTTI_sTIMERS_ss_TTIMER2CLKMODEsindirect
RTTI_sTIMERS_ss_TTIMER2CLKMODEsindirect:
	.short	RTTI_sTIMERS_ss_TTIMER2CLKMODE
.Le140:
	.size	RTTI_sTIMERS_ss_TTIMER2CLKMODEsindirect, .Le140 - RTTI_sTIMERS_ss_TTIMER2CLKMODEsindirect

.section .data.n_RTTI_sTIMERS_ss_TTIMER2CLKMODE_s2o
	.balign 2
.globl	RTTI_sTIMERS_ss_TTIMER2CLKMODE_s2osindirect
RTTI_sTIMERS_ss_TTIMER2CLKMODE_s2osindirect:
	.short	RTTI_sTIMERS_ss_TTIMER2CLKMODE_s2o
.Le141:
	.size	RTTI_sTIMERS_ss_TTIMER2CLKMODE_s2osindirect, .Le141 - RTTI_sTIMERS_ss_TTIMER2CLKMODE_s2osindirect

.section .data.n_RTTI_sTIMERS_ss_TTIMER2CLKMODE_o2s
	.balign 2
.globl	RTTI_sTIMERS_ss_TTIMER2CLKMODE_o2ssindirect
RTTI_sTIMERS_ss_TTIMER2CLKMODE_o2ssindirect:
	.short	RTTI_sTIMERS_ss_TTIMER2CLKMODE_o2s
.Le142:
	.size	RTTI_sTIMERS_ss_TTIMER2CLKMODE_o2ssindirect, .Le142 - RTTI_sTIMERS_ss_TTIMER2CLKMODE_o2ssindirect

.section .data.n_RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPE
	.balign 2
.globl	RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPEsindirect
RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPEsindirect:
	.short	RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPE
.Le143:
	.size	RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPEsindirect, .Le143 - RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPEsindirect

.section .data.n_RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPE_s2o
	.balign 2
.globl	RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPE_s2osindirect
RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPE_s2osindirect:
	.short	RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPE_s2o
.Le144:
	.size	RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPE_s2osindirect, .Le144 - RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPE_s2osindirect

.section .data.n_RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPE_o2s
	.balign 2
.globl	RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPE_o2ssindirect
RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPE_o2ssindirect:
	.short	RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPE_o2s
.Le145:
	.size	RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPE_o2ssindirect, .Le145 - RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPE_o2ssindirect

.section .data.n_RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPES
	.balign 2
.globl	RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPESsindirect
RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPESsindirect:
	.short	RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPES
.Le146:
	.size	RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPESsindirect, .Le146 - RTTI_sTIMERS_ss_TTIMERSUBSCRIBEEVENTTYPESsindirect

.section .data.n_RTTI_sTIMERS_ss_TTIMERSUBSCRIBEROFS
	.balign 2
.globl	RTTI_sTIMERS_ss_TTIMERSUBSCRIBEROFSsindirect
RTTI_sTIMERS_ss_TTIMERSUBSCRIBEROFSsindirect:
	.short	RTTI_sTIMERS_ss_TTIMERSUBSCRIBEROFS
.Le147:
	.size	RTTI_sTIMERS_ss_TTIMERSUBSCRIBEROFSsindirect, .Le147 - RTTI_sTIMERS_ss_TTIMERSUBSCRIBEROFSsindirect

.section .data.n_RTTI_sTIMERS_ss_TTIMERINTERRUPTEVENT
	.balign 2
.globl	RTTI_sTIMERS_ss_TTIMERINTERRUPTEVENTsindirect
RTTI_sTIMERS_ss_TTIMERINTERRUPTEVENTsindirect:
	.short	RTTI_sTIMERS_ss_TTIMERINTERRUPTEVENT
.Le148:
	.size	RTTI_sTIMERS_ss_TTIMERINTERRUPTEVENTsindirect, .Le148 - RTTI_sTIMERS_ss_TTIMERINTERRUPTEVENTsindirect

.section .data.n_INIT_sTIMERS_ss_TABSTRACTTIMER
	.balign 2
.globl	INIT_sTIMERS_ss_TABSTRACTTIMERsindirect
INIT_sTIMERS_ss_TABSTRACTTIMERsindirect:
	.short	INIT_sTIMERS_ss_TABSTRACTTIMER
.Le149:
	.size	INIT_sTIMERS_ss_TABSTRACTTIMERsindirect, .Le149 - INIT_sTIMERS_ss_TABSTRACTTIMERsindirect

.section .data.n_RTTI_sTIMERS_ss_TABSTRACTTIMER
	.balign 2
.globl	RTTI_sTIMERS_ss_TABSTRACTTIMERsindirect
RTTI_sTIMERS_ss_TABSTRACTTIMERsindirect:
	.short	RTTI_sTIMERS_ss_TABSTRACTTIMER
.Le150:
	.size	RTTI_sTIMERS_ss_TABSTRACTTIMERsindirect, .Le150 - RTTI_sTIMERS_ss_TABSTRACTTIMERsindirect

.section .data.n_RTTI_sTIMERS_ss_PTIMER
	.balign 2
.globl	RTTI_sTIMERS_ss_PTIMERsindirect
RTTI_sTIMERS_ss_PTIMERsindirect:
	.short	RTTI_sTIMERS_ss_PTIMER
.Le151:
	.size	RTTI_sTIMERS_ss_PTIMERsindirect, .Le151 - RTTI_sTIMERS_ss_PTIMERsindirect

.section .data.n_RTTI_sTIMERS_ss_TTIMERINTERRUPTPROC
	.balign 2
.globl	RTTI_sTIMERS_ss_TTIMERINTERRUPTPROCsindirect
RTTI_sTIMERS_ss_TTIMERINTERRUPTPROCsindirect:
	.short	RTTI_sTIMERS_ss_TTIMERINTERRUPTPROC
.Le152:
	.size	RTTI_sTIMERS_ss_TTIMERINTERRUPTPROCsindirect, .Le152 - RTTI_sTIMERS_ss_TTIMERINTERRUPTPROCsindirect

.section .data.n_INIT_sTIMERS_ss_TTIMERSUBSCRIBEROFS
	.balign 2
.globl	INIT_sTIMERS_ss_TTIMERSUBSCRIBEROFSsindirect
INIT_sTIMERS_ss_TTIMERSUBSCRIBEROFSsindirect:
	.short	INIT_sTIMERS_ss_TTIMERSUBSCRIBEROFS
.Le153:
	.size	INIT_sTIMERS_ss_TTIMERSUBSCRIBEROFSsindirect, .Le153 - INIT_sTIMERS_ss_TTIMERSUBSCRIBEROFSsindirect

.section .data.n_INIT_sTIMERS_ss_TSYNCTIMER
	.balign 2
.globl	INIT_sTIMERS_ss_TSYNCTIMERsindirect
INIT_sTIMERS_ss_TSYNCTIMERsindirect:
	.short	INIT_sTIMERS_ss_TSYNCTIMER
.Le154:
	.size	INIT_sTIMERS_ss_TSYNCTIMERsindirect, .Le154 - INIT_sTIMERS_ss_TSYNCTIMERsindirect

.section .data.n_RTTI_sTIMERS_ss_TSYNCTIMER
	.balign 2
.globl	RTTI_sTIMERS_ss_TSYNCTIMERsindirect
RTTI_sTIMERS_ss_TSYNCTIMERsindirect:
	.short	RTTI_sTIMERS_ss_TSYNCTIMER
.Le155:
	.size	RTTI_sTIMERS_ss_TSYNCTIMERsindirect, .Le155 - RTTI_sTIMERS_ss_TSYNCTIMERsindirect

.section .data.n_INIT_sTIMERS_ss_TTIMER0
	.balign 2
.globl	INIT_sTIMERS_ss_TTIMER0sindirect
INIT_sTIMERS_ss_TTIMER0sindirect:
	.short	INIT_sTIMERS_ss_TTIMER0
.Le156:
	.size	INIT_sTIMERS_ss_TTIMER0sindirect, .Le156 - INIT_sTIMERS_ss_TTIMER0sindirect

.section .data.n_RTTI_sTIMERS_ss_TTIMER0
	.balign 2
.globl	RTTI_sTIMERS_ss_TTIMER0sindirect
RTTI_sTIMERS_ss_TTIMER0sindirect:
	.short	RTTI_sTIMERS_ss_TTIMER0
.Le157:
	.size	RTTI_sTIMERS_ss_TTIMER0sindirect, .Le157 - RTTI_sTIMERS_ss_TTIMER0sindirect

.section .data.n_INIT_sTIMERS_ss_TTIMER1
	.balign 2
.globl	INIT_sTIMERS_ss_TTIMER1sindirect
INIT_sTIMERS_ss_TTIMER1sindirect:
	.short	INIT_sTIMERS_ss_TTIMER1
.Le158:
	.size	INIT_sTIMERS_ss_TTIMER1sindirect, .Le158 - INIT_sTIMERS_ss_TTIMER1sindirect

.section .data.n_RTTI_sTIMERS_ss_TTIMER1
	.balign 2
.globl	RTTI_sTIMERS_ss_TTIMER1sindirect
RTTI_sTIMERS_ss_TTIMER1sindirect:
	.short	RTTI_sTIMERS_ss_TTIMER1
.Le159:
	.size	RTTI_sTIMERS_ss_TTIMER1sindirect, .Le159 - RTTI_sTIMERS_ss_TTIMER1sindirect

.section .data.n_INIT_sTIMERS_ss_TTIMER2
	.balign 2
.globl	INIT_sTIMERS_ss_TTIMER2sindirect
INIT_sTIMERS_ss_TTIMER2sindirect:
	.short	INIT_sTIMERS_ss_TTIMER2
.Le160:
	.size	INIT_sTIMERS_ss_TTIMER2sindirect, .Le160 - INIT_sTIMERS_ss_TTIMER2sindirect

.section .data.n_RTTI_sTIMERS_ss_TTIMER2
	.balign 2
.globl	RTTI_sTIMERS_ss_TTIMER2sindirect
RTTI_sTIMERS_ss_TTIMER2sindirect:
	.short	RTTI_sTIMERS_ss_TTIMER2
.Le161:
	.size	RTTI_sTIMERS_ss_TTIMER2sindirect, .Le161 - RTTI_sTIMERS_ss_TTIMER2sindirect
# End asmlist al_indirectglobals

