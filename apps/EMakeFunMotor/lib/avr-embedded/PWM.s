	.file "PWM.pas"
# Begin asmlist al_pure_assembler

.section .text.n_pwm_ss_dotimer0servocompareb,"ax"
PWM_ss_DOTIMER0SERVOCOMPAREB:
# [PWM.pas]
# [227] asm
#  CPU AVR5
# [229] LDS     R26, CurrentSortedPWM
	lds	r26,(U_sPWM_ss_CURRENTSORTEDPWM)
# [230] LDS     R27, CurrentSortedPWM + 1
	lds	r27,(U_sPWM_ss_CURRENTSORTEDPWM+1)
# [231] LD      R19, X
	ld	r19,x
# [232] CP      R19, R1
	cp	r19,r1
# [233] BREQ    inits
	breq	.Lj73
# [234] RJMP    nexts
	rjmp	.Lj74
.Lj73:
# [238] LDS     R19, PWMChanged
	lds	r19,(U_sPWM_ss_PWMCHANGED)
# [239] CP      R19, R1
	cp	r19,r1
# [240] BREQ    nochanged
	breq	.Lj75
# [243] STS     PWMChanged, R1
	sts	(U_sPWM_ss_PWMCHANGED),r1
# [245] CALL    SortPWMs
	call	PWM_ss_SORTPWMS
.Lj75:
# [249] LDI     R26, LO8(SortedPWMs)
	ldi	r26,lo8(U_sPWM_ss_SORTEDPWMS)
# [250] LDI     R27, HI8(SortedPWMs)
	ldi	r27,hi8(U_sPWM_ss_SORTEDPWMS)
# [251] STS     CurrentSortedPWM, R26
	sts	(U_sPWM_ss_CURRENTSORTEDPWM),r26
# [252] STS     CurrentSortedPWM + 1, R27
	sts	(U_sPWM_ss_CURRENTSORTEDPWM+1),r27
# [262] IN      R18, 5
	in	r18,5
# [263] LDS     R19, PWMAllMaskB
	lds	r19,(U_sPWM_ss_PWMALLMASKB)
# [264] OR      R18, R19
	or	r18,r19
# [265] OUT     5, R18
	out	5,r18
# [267] IN      R18, 8
	in	r18,8
# [268] LDS     R19, PWMAllMaskC
	lds	r19,(U_sPWM_ss_PWMALLMASKC)
# [269] OR      R18, R19
	or	r18,r19
# [270] OUT     8, R18
	out	8,r18
# [272] IN      R18, 11
	in	r18,11
# [273] LDS     R19, PWMAllMaskD
	lds	r19,(U_sPWM_ss_PWMALLMASKD)
# [274] OR      R18, R19
	or	r18,r19
# [275] OUT     11, R18
	out	11,r18
# [277] LD      R18, X
	ld	r18,x
# [278] SBCI    R18, 2
	sbci	r18,2
# [279] IN      R19, 38
	in	r19,38
# [280] ADD     R19, R18
	add	r19,r18
# [281] OUT     40,  R19
	out	40,r19
# [283] RJMP    exit
	rjmp	.Lj76
.Lj74:
# [288] ADIW    R26, 1
	adiw	r26,1
# [310] LD      R19, X+
	ld	r19,x+
# [311] IN      R20, 5
	in	r20,5
# [312] AND     R20, R19
	and	r20,r19
# [313] OUT     5,   R20
	out	5,r20
# [315] LD      R19, X+
	ld	r19,x+
# [316] IN      R20, 8
	in	r20,8
# [317] AND     R20, R19
	and	r20,r19
# [318] OUT     8,   R20
	out	8,r20
# [320] LD      R19, X+
	ld	r19,x+
# [321] IN      R20, 11
	in	r20,11
# [322] AND     R20, R19
	and	r20,r19
# [323] OUT     11,   R20
	out	11,r20
# [325] LD      R19, X
	ld	r19,x
# [326] IN      R20, 40
	in	r20,40
# [327] ADD     R20, R19
	add	r20,r19
# [328] OUT     40,  R20
	out	40,r20
# [329] STS     CurrentSortedPWM, R26
	sts	(U_sPWM_ss_CURRENTSORTEDPWM),r26
# [330] STS     CurrentSortedPWM + 1, R27
	sts	(U_sPWM_ss_CURRENTSORTEDPWM+1),r27
.Lj76:
# [333] NOP
	nop
#  CPU AVR5
# [334] end;
	ret
.Le0:
	.size	PWM_ss_DOTIMER0SERVOCOMPAREB, .Le0 - PWM_ss_DOTIMER0SERVOCOMPAREB

.section .text.n_pwm_ss_dotimer0servocomparebold,"ax"
PWM_ss_DOTIMER0SERVOCOMPAREBOLD:
# [339] asm
#  CPU AVR5
# [341] LDS     R18, SortedPWMIndex
	lds	r18,(U_sPWM_ss_SORTEDPWMINDEX)
# [342] LDS     R19, SortedPWMCount
	lds	r19,(U_sPWM_ss_SORTEDPWMCOUNT)
# [343] CP      R18, R19
	cp	r18,r19
# [344] BREQ    inits
	breq	.Lj79
# [345] RJMP    nexts
	rjmp	.Lj80
.Lj79:
# [349] LDS     R19, PWMChanged
	lds	r19,(U_sPWM_ss_PWMCHANGED)
# [350] CP      R19, R1
	cp	r19,r1
# [351] BREQ    nochanged
	breq	.Lj81
# [354] STS     PWMChanged, R1
	sts	(U_sPWM_ss_PWMCHANGED),r1
# [356] CALL    SortPWMs
	call	PWM_ss_SORTPWMS
.Lj81:
# [360] STS     SortedPWMIndex,  R1
	sts	(U_sPWM_ss_SORTEDPWMINDEX),r1
# [362] IN      R18, 5
	in	r18,5
# [363] LDS     R19, PWMAllMaskB
	lds	r19,(U_sPWM_ss_PWMALLMASKB)
# [364] OR      R18, R19
	or	r18,r19
# [365] OUT     5, R18
	out	5,r18
# [367] IN      R18, 8
	in	r18,8
# [368] LDS     R19, PWMAllMaskC
	lds	r19,(U_sPWM_ss_PWMALLMASKC)
# [369] OR      R18, R19
	or	r18,r19
# [370] OUT     8, R18
	out	8,r18
# [372] IN      R18, 11
	in	r18,11
# [373] LDS     R19, PWMAllMaskD
	lds	r19,(U_sPWM_ss_PWMALLMASKD)
# [374] OR      R18, R19
	or	r18,r19
# [375] OUT     11, R18
	out	11,r18
# [388] LDS     R18, SortedPWMs
	lds	r18,(U_sPWM_ss_SORTEDPWMS)
# [389] SBCI    R18, 2
	sbci	r18,2
# [390] IN      R19, 38
	in	r19,38
# [391] ADD     R19, R18
	add	r19,r18
# [392] OUT     40,  R19
	out	40,r19
# [394] RJMP    exit
	rjmp	.Lj82
.Lj80:
# [399] MOV     R19, R18
	mov	r19,r18
# [400] LSL     R19
	lsl	r19
# [401] LSL     R19
	lsl	r19
# [402] LDI     R26, LO8(SortedPWMs + 1)
	ldi	r26,lo8(U_sPWM_ss_SORTEDPWMS+1)
# [403] LDI     R27, HI8(SortedPWMs + 1)
	ldi	r27,hi8(U_sPWM_ss_SORTEDPWMS+1)
# [404] ADD     R26, R19
	add	r26,r19
# [405] ADC     R27, R1
	adc	r27,r1
# [406] LD      R19, X+
	ld	r19,x+
# [407] IN      R20, 5
	in	r20,5
# [408] AND     R20, R19
	and	r20,r19
# [409] OUT     5,   R20
	out	5,r20
# [411] LD      R19, X+
	ld	r19,x+
# [412] IN      R20, 8
	in	r20,8
# [413] AND     R20, R19
	and	r20,r19
# [414] OUT     8,   R20
	out	8,r20
# [416] LD      R19, X+
	ld	r19,x+
# [417] IN      R20, 11
	in	r20,11
# [418] AND     R20, R19
	and	r20,r19
# [419] OUT     11,   R20
	out	11,r20
# [438] INC     R18
	inc	r18
# [439] STS     SortedPWMIndex, R18
	sts	(U_sPWM_ss_SORTEDPWMINDEX),r18
# [441] LD      R19, X
	ld	r19,x
# [442] IN      R20, 40
	in	r20,40
# [443] ADD     R20, R19
	add	r20,r19
# [444] OUT     40,  R20
	out	40,r20
.Lj82:
#  CPU AVR5
# [448] end;
	ret
.Le1:
	.size	PWM_ss_DOTIMER0SERVOCOMPAREBOLD, .Le1 - PWM_ss_DOTIMER0SERVOCOMPAREBOLD
# End asmlist al_pure_assembler
# Begin asmlist al_procedures

.section .text.n_pwm_ss_sortpwms,"ax"
PWM_ss_SORTPWMS:
# [69] begin
	push	r29
	push	r28
	push	r3
	push	r2
	in	r28,61
	in	r29,62
	subi	r28,17
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var i located at r28+2, size=OS_8
# Var j located at r28+3, size=OS_8
# Var VMask located at r28+4, size=OS_8
# Var VAllMaskB located at r28+5, size=OS_8
# Var VAllMaskC located at r28+6, size=OS_8
# Var VAllMaskD located at r28+7, size=OS_8
# Var VPort located at r28+8, size=OS_8
# Var VBuffer located at r28+9, size=OS_NO
# Var VComplete located at r28+12, size=OS_8
# Var VOldCounter located at r28+13, size=OS_16
# Var d located at r28+15, size=OS_16
# [71] if PWMCount > 1 then
	lds	r19,(U_sPWM_ss_PWMCOUNT)
	ldi	r18,1
	cp	r18,r19
	brlo	.Lj55
# [181] end;
	rjmp	.Lj6
.Lj55:
# [72] for i := 1 to PWMCount - 1 do
	lds	r19,(U_sPWM_ss_PWMCOUNT)
	dec	r19
	cpi	r19,1
	brsh	.Lj56
	rjmp	.Lj6
.Lj56:
	std	Y+2,r1
.Lj9:
	ldd	r18,Y+2
	inc	r18
	std	Y+2,r18
# [74] VComplete := True;
	ldi	r18,1
	std	Y+12,r18
# [75] for j := 1 to PWMCount - i do
	lds	r20,(U_sPWM_ss_PWMCOUNT)
	ldd	r18,Y+2
	sub	r20,r18
	cpi	r20,1
	brsh	.Lj57
	rjmp	.Lj13
.Lj57:
	std	Y+3,r1
.Lj14:
	ldd	r18,Y+3
	inc	r18
	std	Y+3,r18
# [76] if PWMPins[j - 1].Counter > PWMPins[j].Counter then
	ldd	r21,Y+3
	mov	r18,r1
	ldi	r22,3
	mov	r23,r1
	mov	r24,r21
	mov	r25,r18
	mul	r22,r24
	mov	r21,r0
	mov	r18,r1
	mul	r25,r22
	add	r18,r0
	mul	r24,r23
	add	r18,r0
	clr	r1
	ldd	r23,Y+3
	mov	r22,r1
	ldi	r24,3
	mov	r25,r1
	mov	r2,r23
	mov	r3,r22
	mul	r24,r2
	mov	r23,r0
	mov	r22,r1
	mul	r3,r24
	add	r22,r0
	mul	r2,r25
	add	r22,r0
	clr	r1
	ldi	r30,lo8(U_sPWM_ss_PWMPINS-2)
	ldi	r31,hi8(U_sPWM_ss_PWMPINS-2)
	add	r30,r21
	adc	r31,r18
	ld	r18,Z+
	ld	r21,Z
	ldi	r30,lo8(U_sPWM_ss_PWMPINS+1)
	ldi	r31,hi8(U_sPWM_ss_PWMPINS+1)
	add	r30,r23
	adc	r31,r22
	ld	r22,Z+
	ld	r23,Z
	cp	r22,r18
	cpc	r23,r21
	brlo	.Lj58
	rjmp	.Lj18
.Lj58:
# [78] VBuffer := PWMPins[j - 1];
	ldd	r21,Y+3
	mov	r18,r1
	ldi	r22,3
	mov	r23,r1
	mov	r24,r21
	mov	r25,r18
	mul	r22,r24
	mov	r21,r0
	mov	r18,r1
	mul	r25,r22
	add	r18,r0
	mul	r24,r23
	add	r18,r0
	clr	r1
	ldi	r30,lo8(U_sPWM_ss_PWMPINS-3)
	ldi	r31,hi8(U_sPWM_ss_PWMPINS-3)
	add	r30,r21
	adc	r31,r18
	ld	r0,Z+
	std	Y+9,r0
	ld	r0,Z+
	std	Y+10,r0
	ld	r0,Z
	std	Y+11,r0
# [79] PWMPins[j - 1] := PWMPins[j];
	ldd	r21,Y+3
	mov	r18,r1
	ldi	r22,3
	mov	r23,r1
	mov	r24,r21
	mov	r25,r18
	mul	r22,r24
	mov	r21,r0
	mov	r18,r1
	mul	r25,r22
	add	r18,r0
	mul	r24,r23
	add	r18,r0
	clr	r1
	ldd	r23,Y+3
	mov	r22,r1
	ldi	r24,3
	mov	r25,r1
	mov	r2,r23
	mov	r3,r22
	mul	r24,r2
	mov	r23,r0
	mov	r22,r1
	mul	r3,r24
	add	r22,r0
	mul	r2,r25
	add	r22,r0
	clr	r1
	ldi	r30,lo8(U_sPWM_ss_PWMPINS)
	ldi	r31,hi8(U_sPWM_ss_PWMPINS)
	add	r30,r23
	adc	r31,r22
	ldi	r22,lo8(U_sPWM_ss_PWMPINS-3)
	ldi	r23,hi8(U_sPWM_ss_PWMPINS-3)
	add	r22,r21
	adc	r23,r18
	movw	r26,r22
	ld	r0,Z+
	st	X+,r0
	ld	r0,Z+
	st	X+,r0
	ld	r0,Z
	st	X,r0
# [80] PWMPins[j] := VBuffer;
	ldd	r21,Y+3
	mov	r18,r1
	ldi	r22,3
	mov	r23,r1
	mov	r24,r21
	mov	r25,r18
	mul	r22,r24
	mov	r21,r0
	mov	r18,r1
	mul	r25,r22
	add	r18,r0
	mul	r24,r23
	add	r18,r0
	clr	r1
	ldi	r30,lo8(U_sPWM_ss_PWMPINS)
	ldi	r31,hi8(U_sPWM_ss_PWMPINS)
	add	r30,r21
	adc	r31,r18
	ldd	r0,Y+9
	st	Z+,r0
	ldd	r0,Y+10
	st	Z+,r0
	ldd	r0,Y+11
	st	Z,r0
# [81] VComplete := False;
	std	Y+12,r1
.Lj18:
	ldd	r18,Y+3
	cp	r18,r20
	brsh	.Lj59
	rjmp	.Lj14
.Lj59:
.Lj13:
# [83] if VComplete then
	ldd	r18,Y+12
	cp	r18,r1
	brne	.Lj6
	ldd	r18,Y+2
	cp	r18,r19
	brsh	.Lj60
	rjmp	.Lj9
.Lj60:
.Lj6:
# [87] j := 255;
	ldi	r18,-1
	std	Y+3,r18
# [88] VAllMaskB := 0;
	std	Y+5,r1
# [89] VAllMaskC := 0;
	std	Y+6,r1
# [90] VAllMaskD := 0;
	std	Y+7,r1
# [91] VOldCounter := 0;
	mov	r18,r1
	mov	r19,r1
	std	Y+13,r18
	std	Y+14,r19
# [92] i := 0;
	std	Y+2,r1
# [93] while i < PWMCount do
	rjmp	.Lj22
.Lj21:
# [95] VMask := DigitalPinToBitMask[PWMPins[i].Pin];
	ldd	r19,Y+2
	mov	r18,r1
	ldi	r20,3
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
	ldi	r30,lo8(U_sPWM_ss_PWMPINS)
	ldi	r31,hi8(U_sPWM_ss_PWMPINS)
	add	r30,r19
	adc	r31,r18
	ld	r19,Z
	mov	r18,r1
	ldi	r30,lo8(TC_sARDUINOTOOLS_ss_DIGITALPINTOBITMASK)
	ldi	r31,hi8(TC_sARDUINOTOOLS_ss_DIGITALPINTOBITMASK)
	add	r30,r19
	adc	r31,r18
	ld	r0,Z
	std	Y+4,r0
# [96] VPort := DigitalPinToPort[PWMPins[i].Pin];
	ldd	r19,Y+2
	mov	r18,r1
	ldi	r20,3
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
	ldi	r30,lo8(U_sPWM_ss_PWMPINS)
	ldi	r31,hi8(U_sPWM_ss_PWMPINS)
	add	r30,r19
	adc	r31,r18
	ld	r19,Z
	mov	r18,r1
	ldi	r30,lo8(TC_sARDUINOTOOLS_ss_DIGITALPINTOPORT)
	ldi	r31,hi8(TC_sARDUINOTOOLS_ss_DIGITALPINTOPORT)
	add	r30,r19
	adc	r31,r18
	ld	r0,Z
	std	Y+8,r0
# [97] case VPort of
	ldd	r19,Y+8
	cpi	r19,2
	brsh	.Lj61
	rjmp	.Lj24
.Lj61:
	mov	r18,r19
	subi	r19,2
	cpi	r18,2
	breq	.Lj25
	mov	r18,r19
	dec	r19
	cpi	r18,1
	breq	.Lj26
	mov	r18,r19
	dec	r19
	cpi	r18,1
	breq	.Lj27
	rjmp	.Lj24
.Lj25:
# [99] VAllMaskB := VAllMaskB or VMask;
	ldd	r19,Y+5
	ldd	r18,Y+4
	or	r18,r19
	std	Y+5,r18
	rjmp	.Lj24
.Lj26:
# [101] VAllMaskC := VAllMaskC or VMask;
	ldd	r19,Y+6
	ldd	r18,Y+4
	or	r18,r19
	std	Y+6,r18
	rjmp	.Lj24
.Lj27:
# [103] VAllMaskD := VAllMaskD or VMask;
	ldd	r19,Y+7
	ldd	r18,Y+4
	or	r18,r19
	std	Y+7,r18
.Lj24:
# [105] d := PWMPins[i].Counter - VOldCounter;
	ldd	r19,Y+2
	mov	r18,r1
	ldi	r20,3
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
	ldi	r30,lo8(U_sPWM_ss_PWMPINS+1)
	ldi	r31,hi8(U_sPWM_ss_PWMPINS+1)
	add	r30,r19
	adc	r31,r18
	ld	r18,Z+
	ld	r19,Z
	ldd	r20,Y+13
	ldd	r21,Y+14
	sub	r18,r20
	sbc	r19,r21
	std	Y+15,r18
	std	Y+16,r19
# [106] if (i = 0) or (d > 0) then
	ldd	r18,Y+2
	cp	r18,r1
	breq	.Lj28
	ldd	r18,Y+15
	ldd	r19,Y+16
	cp	r1,r18
	cpc	r1,r19
	brlo	.Lj62
	rjmp	.Lj30
.Lj62:
.Lj28:
# [108] Inc(j);
	ldd	r18,Y+3
	inc	r18
	std	Y+3,r18
# [109] SortedPWMs[j].NotMaskB := $FF;
	ldd	r19,Y+3
	mov	r18,r1
	lsl	r19
	rol	r18
	lsl	r19
	rol	r18
	ldi	r20,-1
	ldi	r30,lo8(U_sPWM_ss_SORTEDPWMS+1)
	ldi	r31,hi8(U_sPWM_ss_SORTEDPWMS+1)
	add	r30,r19
	adc	r31,r18
	st	Z,r20
# [110] SortedPWMs[j].NotMaskC := $FF;
	ldd	r19,Y+3
	mov	r18,r1
	lsl	r19
	rol	r18
	lsl	r19
	rol	r18
	ldi	r20,-1
	ldi	r30,lo8(U_sPWM_ss_SORTEDPWMS+2)
	ldi	r31,hi8(U_sPWM_ss_SORTEDPWMS+2)
	add	r30,r19
	adc	r31,r18
	st	Z,r20
# [111] SortedPWMs[j].NotMaskD := $FF;
	ldd	r19,Y+3
	mov	r18,r1
	lsl	r19
	rol	r18
	lsl	r19
	rol	r18
	ldi	r20,-1
	ldi	r30,lo8(U_sPWM_ss_SORTEDPWMS+3)
	ldi	r31,hi8(U_sPWM_ss_SORTEDPWMS+3)
	add	r30,r19
	adc	r31,r18
	st	Z,r20
# [112] if d > 285 then
	ldd	r20,Y+15
	ldd	r21,Y+16
	ldi	r18,29
	ldi	r19,1
	cp	r18,r20
	cpc	r19,r21
	brsh	.Lj32
# [114] SortedPWMs[j].Counter := 255;
	ldd	r19,Y+3
	mov	r18,r1
	lsl	r19
	rol	r18
	lsl	r19
	rol	r18
	ldi	r20,-1
	ldi	r30,lo8(U_sPWM_ss_SORTEDPWMS)
	ldi	r31,hi8(U_sPWM_ss_SORTEDPWMS)
	add	r30,r19
	adc	r31,r18
	st	Z,r20
# [115] Inc(VOldCounter, 255);
	ldd	r19,Y+13
	ldd	r20,Y+14
	ldi	r18,-1
	add	r19,r18
	adc	r20,r1
	std	Y+13,r19
	std	Y+14,r20
	rjmp	.Lj41
.Lj32:
# [118] if d > 255 then
	ldd	r21,Y+15
	ldd	r20,Y+16
	ldi	r19,-1
	mov	r18,r1
	cp	r19,r21
	cpc	r18,r20
	brsh	.Lj35
# [120] SortedPWMs[j].Counter := 128;
	ldd	r19,Y+3
	mov	r18,r1
	lsl	r19
	rol	r18
	lsl	r19
	rol	r18
	ldi	r20,-128
	ldi	r30,lo8(U_sPWM_ss_SORTEDPWMS)
	ldi	r31,hi8(U_sPWM_ss_SORTEDPWMS)
	add	r30,r19
	adc	r31,r18
	st	Z,r20
# [121] Inc(VOldCounter, 128);
	ldd	r19,Y+13
	ldd	r20,Y+14
	ldi	r18,-128
	add	r19,r18
	adc	r20,r1
	std	Y+13,r19
	std	Y+14,r20
	rjmp	.Lj41
.Lj35:
# [125] Inc(VOldCounter, d);
	ldd	r20,Y+15
	ldd	r19,Y+16
	ldd	r21,Y+13
	ldd	r18,Y+14
	add	r21,r20
	adc	r18,r19
	std	Y+13,r21
	std	Y+14,r18
# [126] SortedPWMs[j].Counter := d;
	ldd	r19,Y+3
	mov	r18,r1
	lsl	r19
	rol	r18
	lsl	r19
	rol	r18
	ldi	r30,lo8(U_sPWM_ss_SORTEDPWMS)
	ldi	r31,hi8(U_sPWM_ss_SORTEDPWMS)
	add	r30,r19
	adc	r31,r18
	ldd	r0,Y+15
	st	Z,r0
# [127] case VPort of
	ldd	r19,Y+8
	cpi	r19,2
	brsh	.Lj63
	rjmp	.Lj37
.Lj63:
	mov	r18,r19
	subi	r19,2
	cpi	r18,2
	breq	.Lj38
	mov	r18,r19
	dec	r19
	cpi	r18,1
	brne	.Lj64
	rjmp	.Lj39
.Lj64:
	mov	r18,r19
	dec	r19
	cpi	r18,1
	brne	.Lj65
	rjmp	.Lj40
.Lj65:
	rjmp	.Lj37
.Lj38:
# [129] SortedPWMs[j].NotMaskB := SortedPWMs[j].NotMaskB and not VMask;
	ldd	r19,Y+3
	mov	r18,r1
	lsl	r19
	rol	r18
	lsl	r19
	rol	r18
	ldd	r20,Y+4
	com	r20
	ldi	r30,lo8(U_sPWM_ss_SORTEDPWMS+1)
	ldi	r31,hi8(U_sPWM_ss_SORTEDPWMS+1)
	add	r30,r19
	adc	r31,r18
	ld	r18,Z
	and	r20,r18
	ldd	r19,Y+3
	mov	r18,r1
	lsl	r19
	rol	r18
	lsl	r19
	rol	r18
	ldi	r30,lo8(U_sPWM_ss_SORTEDPWMS+1)
	ldi	r31,hi8(U_sPWM_ss_SORTEDPWMS+1)
	add	r30,r19
	adc	r31,r18
	st	Z,r20
	rjmp	.Lj37
.Lj39:
# [131] SortedPWMs[j].NotMaskC := SortedPWMs[j].NotMaskC and not VMask;
	ldd	r19,Y+3
	mov	r18,r1
	lsl	r19
	rol	r18
	lsl	r19
	rol	r18
	ldd	r20,Y+4
	com	r20
	ldi	r30,lo8(U_sPWM_ss_SORTEDPWMS+2)
	ldi	r31,hi8(U_sPWM_ss_SORTEDPWMS+2)
	add	r30,r19
	adc	r31,r18
	ld	r18,Z
	and	r20,r18
	ldd	r19,Y+3
	mov	r18,r1
	lsl	r19
	rol	r18
	lsl	r19
	rol	r18
	ldi	r30,lo8(U_sPWM_ss_SORTEDPWMS+2)
	ldi	r31,hi8(U_sPWM_ss_SORTEDPWMS+2)
	add	r30,r19
	adc	r31,r18
	st	Z,r20
	rjmp	.Lj37
.Lj40:
# [133] SortedPWMs[j].NotMaskD := SortedPWMs[j].NotMaskD and not VMask;
	ldd	r19,Y+3
	mov	r18,r1
	lsl	r19
	rol	r18
	lsl	r19
	rol	r18
	ldd	r20,Y+4
	com	r20
	ldi	r30,lo8(U_sPWM_ss_SORTEDPWMS+3)
	ldi	r31,hi8(U_sPWM_ss_SORTEDPWMS+3)
	add	r30,r19
	adc	r31,r18
	ld	r18,Z
	and	r20,r18
	ldd	r19,Y+3
	mov	r18,r1
	lsl	r19
	rol	r18
	lsl	r19
	rol	r18
	ldi	r30,lo8(U_sPWM_ss_SORTEDPWMS+3)
	ldi	r31,hi8(U_sPWM_ss_SORTEDPWMS+3)
	add	r30,r19
	adc	r31,r18
	st	Z,r20
.Lj37:
# [135] Inc(i);
	ldd	r18,Y+2
	inc	r18
	std	Y+2,r18
	rjmp	.Lj22
.Lj30:
# [140] case VPort of
	ldd	r19,Y+8
	cpi	r19,2
	brsh	.Lj66
	rjmp	.Lj42
.Lj66:
	mov	r18,r19
	subi	r19,2
	cpi	r18,2
	breq	.Lj43
	mov	r18,r19
	dec	r19
	cpi	r18,1
	brne	.Lj67
	rjmp	.Lj44
.Lj67:
	mov	r18,r19
	dec	r19
	cpi	r18,1
	brne	.Lj68
	rjmp	.Lj45
.Lj68:
	rjmp	.Lj42
.Lj43:
# [142] SortedPWMs[j].NotMaskB := SortedPWMs[j].NotMaskB and not VMask;
	ldd	r19,Y+3
	mov	r18,r1
	lsl	r19
	rol	r18
	lsl	r19
	rol	r18
	ldd	r20,Y+4
	com	r20
	ldi	r30,lo8(U_sPWM_ss_SORTEDPWMS+1)
	ldi	r31,hi8(U_sPWM_ss_SORTEDPWMS+1)
	add	r30,r19
	adc	r31,r18
	ld	r18,Z
	and	r20,r18
	ldd	r19,Y+3
	mov	r18,r1
	lsl	r19
	rol	r18
	lsl	r19
	rol	r18
	ldi	r30,lo8(U_sPWM_ss_SORTEDPWMS+1)
	ldi	r31,hi8(U_sPWM_ss_SORTEDPWMS+1)
	add	r30,r19
	adc	r31,r18
	st	Z,r20
	rjmp	.Lj42
.Lj44:
# [144] SortedPWMs[j].NotMaskC := SortedPWMs[j].NotMaskC and not VMask;
	ldd	r19,Y+3
	mov	r18,r1
	lsl	r19
	rol	r18
	lsl	r19
	rol	r18
	ldd	r20,Y+4
	com	r20
	ldi	r30,lo8(U_sPWM_ss_SORTEDPWMS+2)
	ldi	r31,hi8(U_sPWM_ss_SORTEDPWMS+2)
	add	r30,r19
	adc	r31,r18
	ld	r18,Z
	and	r20,r18
	ldd	r19,Y+3
	mov	r18,r1
	lsl	r19
	rol	r18
	lsl	r19
	rol	r18
	ldi	r30,lo8(U_sPWM_ss_SORTEDPWMS+2)
	ldi	r31,hi8(U_sPWM_ss_SORTEDPWMS+2)
	add	r30,r19
	adc	r31,r18
	st	Z,r20
	rjmp	.Lj42
.Lj45:
# [146] SortedPWMs[j].NotMaskD := SortedPWMs[j].NotMaskD and not VMask;
	ldd	r19,Y+3
	mov	r18,r1
	lsl	r19
	rol	r18
	lsl	r19
	rol	r18
	ldd	r20,Y+4
	com	r20
	ldi	r30,lo8(U_sPWM_ss_SORTEDPWMS+3)
	ldi	r31,hi8(U_sPWM_ss_SORTEDPWMS+3)
	add	r30,r19
	adc	r31,r18
	ld	r18,Z
	and	r20,r18
	ldd	r19,Y+3
	mov	r18,r1
	lsl	r19
	rol	r18
	lsl	r19
	rol	r18
	ldi	r30,lo8(U_sPWM_ss_SORTEDPWMS+3)
	ldi	r31,hi8(U_sPWM_ss_SORTEDPWMS+3)
	add	r30,r19
	adc	r31,r18
	st	Z,r20
.Lj42:
# [148] Inc(i);
	ldd	r18,Y+2
	inc	r18
	std	Y+2,r18
.Lj41:
.Lj22:
	lds	r19,(U_sPWM_ss_PWMCOUNT)
	ldd	r18,Y+2
	cp	r18,r19
	brsh	.Lj69
	rjmp	.Lj21
.Lj69:
# [151] while VOldCounter < CICLE_FULL_COUNT do
	rjmp	.Lj47
.Lj46:
# [153] Inc(j);
	ldd	r18,Y+3
	inc	r18
	std	Y+3,r18
# [154] SortedPWMs[j].NotMaskB := $FF;
	ldd	r19,Y+3
	mov	r18,r1
	lsl	r19
	rol	r18
	lsl	r19
	rol	r18
	ldi	r20,-1
	ldi	r30,lo8(U_sPWM_ss_SORTEDPWMS+1)
	ldi	r31,hi8(U_sPWM_ss_SORTEDPWMS+1)
	add	r30,r19
	adc	r31,r18
	st	Z,r20
# [155] SortedPWMs[j].NotMaskC := $FF;
	ldd	r19,Y+3
	mov	r18,r1
	lsl	r19
	rol	r18
	lsl	r19
	rol	r18
	ldi	r20,-1
	ldi	r30,lo8(U_sPWM_ss_SORTEDPWMS+2)
	ldi	r31,hi8(U_sPWM_ss_SORTEDPWMS+2)
	add	r30,r19
	adc	r31,r18
	st	Z,r20
# [156] SortedPWMs[j].NotMaskD := $FF;
	ldd	r19,Y+3
	mov	r18,r1
	lsl	r19
	rol	r18
	lsl	r19
	rol	r18
	ldi	r20,-1
	ldi	r30,lo8(U_sPWM_ss_SORTEDPWMS+3)
	ldi	r31,hi8(U_sPWM_ss_SORTEDPWMS+3)
	add	r30,r19
	adc	r31,r18
	st	Z,r20
# [157] d := CICLE_FULL_COUNT - VOldCounter;
	ldd	r25,Y+13
	ldd	r24,Y+14
	mov	r20,r1
	mov	r18,r1
	ldi	r22,-2
	ldi	r23,1
	mov	r19,r1
	mov	r21,r1
	sub	r22,r25
	sbc	r23,r24
	sbc	r19,r20
	sbc	r21,r18
	std	Y+15,r22
	std	Y+16,r23
# [158] if d > 285 then
	ldd	r21,Y+15
	ldd	r20,Y+16
	ldi	r18,29
	ldi	r19,1
	cp	r18,r21
	cpc	r19,r20
	brsh	.Lj50
# [160] SortedPWMs[j].Counter := 255;
	ldd	r19,Y+3
	mov	r18,r1
	lsl	r19
	rol	r18
	lsl	r19
	rol	r18
	ldi	r20,-1
	ldi	r30,lo8(U_sPWM_ss_SORTEDPWMS)
	ldi	r31,hi8(U_sPWM_ss_SORTEDPWMS)
	add	r30,r19
	adc	r31,r18
	st	Z,r20
# [161] Inc(VOldCounter, 255);
	ldd	r20,Y+13
	ldd	r19,Y+14
	ldi	r18,-1
	add	r20,r18
	adc	r19,r1
	std	Y+13,r20
	std	Y+14,r19
	rjmp	.Lj47
.Lj50:
# [164] if d > 255 then
	ldd	r21,Y+15
	ldd	r20,Y+16
	ldi	r19,-1
	mov	r18,r1
	cp	r19,r21
	cpc	r18,r20
	brsh	.Lj53
# [166] SortedPWMs[j].Counter := 128;
	ldd	r19,Y+3
	mov	r18,r1
	lsl	r19
	rol	r18
	lsl	r19
	rol	r18
	ldi	r20,-128
	ldi	r30,lo8(U_sPWM_ss_SORTEDPWMS)
	ldi	r31,hi8(U_sPWM_ss_SORTEDPWMS)
	add	r30,r19
	adc	r31,r18
	st	Z,r20
# [167] Inc(VOldCounter, 128);
	ldd	r19,Y+13
	ldd	r20,Y+14
	ldi	r18,-128
	add	r19,r18
	adc	r20,r1
	std	Y+13,r19
	std	Y+14,r20
	rjmp	.Lj47
.Lj53:
# [171] Inc(VOldCounter, d);
	ldd	r21,Y+15
	ldd	r18,Y+16
	ldd	r19,Y+13
	ldd	r20,Y+14
	add	r19,r21
	adc	r20,r18
	std	Y+13,r19
	std	Y+14,r20
# [172] SortedPWMs[j].Counter := d;
	ldd	r19,Y+3
	mov	r18,r1
	lsl	r19
	rol	r18
	lsl	r19
	rol	r18
	ldi	r30,lo8(U_sPWM_ss_SORTEDPWMS)
	ldi	r31,hi8(U_sPWM_ss_SORTEDPWMS)
	add	r30,r19
	adc	r31,r18
	ldd	r0,Y+15
	st	Z,r0
.Lj47:
	ldd	r18,Y+13
	ldd	r19,Y+14
	cpi	r18,-2
	ldi	r18,1
	cpc	r19,r18
	brsh	.Lj70
	rjmp	.Lj46
.Lj70:
# [175] Inc(j);
	ldd	r18,Y+3
	inc	r18
	std	Y+3,r18
# [176] SortedPWMs[j].Counter := 0;
	ldd	r20,Y+3
	mov	r19,r1
	lsl	r20
	rol	r19
	lsl	r20
	rol	r19
	mov	r18,r1
	ldi	r30,lo8(U_sPWM_ss_SORTEDPWMS)
	ldi	r31,hi8(U_sPWM_ss_SORTEDPWMS)
	add	r30,r20
	adc	r31,r19
	st	Z,r18
# [177] SortedPWMCount := j;
	ldd	r0,Y+3
	sts	(U_sPWM_ss_SORTEDPWMCOUNT),r0
# [178] PWMAllMaskB := VAllMaskB;
	ldd	r0,Y+5
	sts	(U_sPWM_ss_PWMALLMASKB),r0
# [179] PWMAllMaskC := VAllMaskC;
	ldd	r0,Y+6
	sts	(U_sPWM_ss_PWMALLMASKC),r0
# [180] PWMAllMaskD := VAllMaskD;
	ldd	r0,Y+7
	sts	(U_sPWM_ss_PWMALLMASKD),r0
	subi	r28,-17
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
.Le2:
	.size	PWM_ss_SORTPWMS, .Le2 - PWM_ss_SORTPWMS

.section .text.n_pwm_ss_pwmportdeletesbyte,"ax"
PWM_ss_PWMPORTDELETEsBYTE:
# [455] begin
	push	r29
	push	r28
	push	r2
	in	r28,61
	in	r29,62
	subi	r28,4
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var AIndex located at r28+2, size=OS_8
# Var i located at r28+3, size=OS_8
	std	Y+2,r24
# [456] IPause;
	call	ARDUINOTOOLS_ss_IPAUSE
# [457] Dec(PWMCount);
	lds	r18,(U_sPWM_ss_PWMCOUNT)
	dec	r18
	sts	(U_sPWM_ss_PWMCOUNT),r18
# [458] for i := AIndex + 1 to PWMCount do
	ldd	r18,Y+2
	inc	r18
	lds	r24,(U_sPWM_ss_PWMCOUNT)
	cp	r24,r18
	brsh	.Lj90
# [461] end;
	rjmp	.Lj86
.Lj90:
	std	Y+3,r18
	ldd	r18,Y+3
	dec	r18
	std	Y+3,r18
.Lj87:
	ldd	r18,Y+3
	inc	r18
	std	Y+3,r18
# [459] PWMPins[i - 1] := PWMPins[i];
	ldd	r19,Y+3
	mov	r18,r1
	ldi	r20,3
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
	ldd	r21,Y+3
	mov	r20,r1
	ldi	r22,3
	mov	r23,r1
	mov	r25,r21
	mov	r2,r20
	mul	r22,r25
	mov	r21,r0
	mov	r20,r1
	mul	r2,r22
	add	r20,r0
	mul	r25,r23
	add	r20,r0
	clr	r1
	ldi	r30,lo8(U_sPWM_ss_PWMPINS)
	ldi	r31,hi8(U_sPWM_ss_PWMPINS)
	add	r30,r21
	adc	r31,r20
	ldi	r21,lo8(U_sPWM_ss_PWMPINS-3)
	ldi	r20,hi8(U_sPWM_ss_PWMPINS-3)
	add	r21,r19
	adc	r20,r18
	mov	r26,r21
	mov	r27,r20
	ld	r0,Z+
	st	X+,r0
	ld	r0,Z+
	st	X+,r0
	ld	r0,Z
	st	X,r0
	ldd	r18,Y+3
	cp	r18,r24
	brsh	.Lj91
	rjmp	.Lj87
.Lj91:
.Lj86:
# [460] IResume;
	call	ARDUINOTOOLS_ss_IRESUME
	subi	r28,-4
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
.Le3:
	.size	PWM_ss_PWMPORTDELETEsBYTE, .Le3 - PWM_ss_PWMPORTDELETEsBYTE

.section .text.n_pwm_ss_pwmportchangesbytesbyte,"ax"
PWM_ss_PWMPORTCHANGEsBYTEsBYTE:
# [464] begin
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
# Var AIndex located at r28+2, size=OS_8
# Var AValue located at r28+3, size=OS_8
	std	Y+2,r24
	std	Y+3,r22
# [465] PWMPins[AIndex].Counter := Word(AValue) * CICLE_STEP_COUNT;
	ldd	r18,Y+3
	mov	r21,r1
	mov	r19,r18
	mov	r18,r1
	mov	r20,r1
	lsl	r19
	rol	r21
	rol	r18
	rol	r20
	ldd	r20,Y+2
	mov	r18,r1
	ldi	r22,3
	mov	r23,r1
	mov	r24,r20
	mov	r25,r18
	mul	r22,r24
	mov	r20,r0
	mov	r18,r1
	mul	r25,r22
	add	r18,r0
	mul	r24,r23
	add	r18,r0
	clr	r1
	ldi	r30,lo8(U_sPWM_ss_PWMPINS+1)
	ldi	r31,hi8(U_sPWM_ss_PWMPINS+1)
	add	r30,r20
	adc	r31,r18
	st	Z+,r19
	st	Z,r21
# [466] end;
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
.Le4:
	.size	PWM_ss_PWMPORTCHANGEsBYTEsBYTE, .Le4 - PWM_ss_PWMPORTCHANGEsBYTEsBYTE

.section .text.n_pwm_ss_pwmportaddsbytesbyte,"ax"
PWM_ss_PWMPORTADDsBYTEsBYTE:
# [469] begin
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
# Var APin located at r28+2, size=OS_8
# Var AValue located at r28+3, size=OS_8
	std	Y+2,r24
	std	Y+3,r22
# [470] PWMPins[PWMCount].Pin := APin;
	lds	r18,(U_sPWM_ss_PWMCOUNT)
	mov	r19,r1
	ldi	r20,3
	mov	r21,r1
	movw	r22,r18
	mul	r20,r22
	movw	r18,r0
	mul	r23,r20
	add	r19,r0
	mul	r22,r21
	add	r19,r0
	clr	r1
	ldi	r30,lo8(U_sPWM_ss_PWMPINS)
	ldi	r31,hi8(U_sPWM_ss_PWMPINS)
	add	r30,r18
	adc	r31,r19
	ldd	r0,Y+2
	st	Z,r0
# [471] PWMPins[PWMCount].Counter := Word(AValue) * CICLE_STEP_COUNT;
	ldd	r21,Y+3
	mov	r20,r1
	mov	r19,r1
	mov	r18,r1
	lsl	r21
	rol	r20
	rol	r19
	rol	r18
	lds	r19,(U_sPWM_ss_PWMCOUNT)
	mov	r18,r1
	ldi	r22,3
	mov	r23,r1
	mov	r24,r19
	mov	r25,r18
	mul	r22,r24
	mov	r19,r0
	mov	r18,r1
	mul	r25,r22
	add	r18,r0
	mul	r24,r23
	add	r18,r0
	clr	r1
	ldi	r30,lo8(U_sPWM_ss_PWMPINS+1)
	ldi	r31,hi8(U_sPWM_ss_PWMPINS+1)
	add	r30,r19
	adc	r31,r18
	st	Z+,r21
	st	Z,r20
# [472] Inc(PWMCount);
	lds	r18,(U_sPWM_ss_PWMCOUNT)
	inc	r18
	sts	(U_sPWM_ss_PWMCOUNT),r18
# [473] end;
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
.Le5:
	.size	PWM_ss_PWMPORTADDsBYTEsBYTE, .Le5 - PWM_ss_PWMPORTADDsBYTEsBYTE

.section .text.n_pwm_ss_analogwritesbytesbyte,"ax"
.globl	PWM_ss_ANALOGWRITEsBYTEsBYTE
PWM_ss_ANALOGWRITEsBYTEsBYTE:
# [479] begin
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
# Var APin located at r28+2, size=OS_8
# Var AValue located at r28+3, size=OS_8
# Var i located at r28+4, size=OS_S16
# Var NeedInit located at r28+6, size=OS_8
	std	Y+2,r24
	std	Y+3,r22
# [480] i := PWMCount - 1;
	lds	r19,(U_sPWM_ss_PWMCOUNT)
	mov	r18,r1
	subi	r19,1
	sbc	r18,r1
	std	Y+4,r19
	std	Y+5,r18
# [481] while (i >= 0) and (PWMPins[i].Pin <> APin) do
	rjmp	.Lj99
.Lj98:
# [482] Dec(i);
	ldd	r18,Y+4
	ldd	r19,Y+5
	subi	r18,1
	sbc	r19,r1
	std	Y+4,r18
	std	Y+5,r19
.Lj99:
	ldd	r18,Y+4
	ldd	r18,Y+5
	cp	r18,r1
	brlt	.Lj102
	ldd	r18,Y+4
	ldd	r19,Y+5
	ldi	r20,3
	mov	r21,r1
	movw	r22,r18
	mul	r20,r22
	movw	r18,r0
	mul	r23,r20
	add	r19,r0
	mul	r22,r21
	add	r19,r0
	clr	r1
	ldi	r30,lo8(U_sPWM_ss_PWMPINS)
	ldi	r31,hi8(U_sPWM_ss_PWMPINS)
	add	r30,r18
	adc	r31,r19
	ld	r18,Z
	ldd	r19,Y+2
	cp	r18,r19
	brne	.Lj98
.Lj102:
# [483] if AValue in [0, 255] then
	ldd	r19,Y+3
	cp	r19,r1
	breq	.Lj104
	cpi	r19,-1
	brne	.Lj105
.Lj104:
# [485] NeedInit := False;
	std	Y+6,r1
# [486] if i >= 0 then
	ldd	r18,Y+4
	ldd	r18,Y+5
	cp	r18,r1
	brlt	.Lj107
# [487] PWMPortDelete(i);
	ldd	r24,Y+4
	call	PWM_ss_PWMPORTDELETEsBYTE
.Lj107:
# [488] DigitalWrite(APin, AValue = 255);
	ldd	r18,Y+3
	cpi	r18,-1
	ldi	r22,1
	breq	.Lj108
	mov	r22,r1
.Lj108:
	ldd	r24,Y+2
	call	ARDUINOTOOLS_ss_DIGITALWRITEsBYTEsBOOLEAN
	rjmp	.Lj109
.Lj105:
# [492] NeedInit := PWMCount = 0;
	lds	r18,(U_sPWM_ss_PWMCOUNT)
	cp	r18,r1
	ldi	r18,1
	breq	.Lj110
	mov	r18,r1
.Lj110:
	std	Y+6,r18
# [493] if i >= 0 then
	ldd	r18,Y+4
	ldd	r18,Y+5
	cp	r18,r1
	brlt	.Lj112
# [494] PWMPortChange(i, AValue)
	ldd	r24,Y+4
	ldd	r22,Y+3
	call	PWM_ss_PWMPORTCHANGEsBYTEsBYTE
	rjmp	.Lj109
.Lj112:
# [496] PWMPortAdd(APin, AValue);
	ldd	r22,Y+3
	ldd	r24,Y+2
	call	PWM_ss_PWMPORTADDsBYTEsBYTE
.Lj109:
# [498] PWMChanged := True;
	ldi	r18,1
	sts	(U_sPWM_ss_PWMCHANGED),r18
# [499] if NeedInit then
	ldd	r18,Y+6
	cp	r18,r1
	breq	.Lj115
# [501] Timer0_ValueB := Timer0_Counter + 5;
	in	r18,38
	ldi	r19,5
	add	r18,r19
# [TimersMacro.inc]
# [4] {$define Timer0_ValueB  := OCR0B}
	out	40,r18
# [PWM.pas]
# [502] Timer0.SetCompareBProc(@DoTimer0ServoCompareB);
	ldi	r22,lo8(gs(PWM_ss_DOTIMER0SERVOCOMPAREB))
	ldi	r23,hi8(gs(PWM_ss_DOTIMER0SERVOCOMPAREB))
	ldi	r24,lo8(U_sTIMERS_ss_TIMER0)
	ldi	r25,hi8(U_sTIMERS_ss_TIMER0)
	call	TIMERSs_sTABSTRACTTIMER_s__ss_SETCOMPAREBPROCsTTIMERINTERRUPTPROC
	rjmp	.Lj116
.Lj115:
# [505] if PWMCount = 0 then
	lds	r18,(U_sPWM_ss_PWMCOUNT)
	cp	r18,r1
	brne	.Lj116
# [507] Timer0.ClearCompareBEvent;
	ldi	r24,lo8(U_sTIMERS_ss_TIMER0)
	ldi	r25,hi8(U_sTIMERS_ss_TIMER0)
	call	TIMERSs_sTABSTRACTTIMER_s__ss_CLEARCOMPAREBEVENT
.Lj116:
# [509] end;
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
.Le6:
	.size	PWM_ss_ANALOGWRITEsBYTEsBYTE, .Le6 - PWM_ss_ANALOGWRITEsBYTEsBYTE

.section .text.n_pwm_ss_inits,"ax"
.globl	PWM_ss_inits
PWM_ss_inits:
.globl	INITs_sPWM
INITs_sPWM:
# [511] initialization
# [512] FillByte(SortedPWMs, SizeOf(SortedPWMs), 0);
	ldi	r18,lo8(U_sPWM_ss_SORTEDPWMS)
	ldi	r25,hi8(U_sPWM_ss_SORTEDPWMS)
	mov	r20,r1
	ldi	r22,52
	mov	r23,r1
	mov	r24,r18
	call	SYSTEM_ss_FILLBYTEsformalsSMALLINTsBYTE
# [513] CurrentSortedPWM := @SortedPWMs[Length(SortedPWMs) - 1];
	ldi	r18,lo8(U_sPWM_ss_SORTEDPWMS+48)
	ldi	r19,hi8(U_sPWM_ss_SORTEDPWMS+48)
	sts	(U_sPWM_ss_CURRENTSORTEDPWM),r18
	sts	(U_sPWM_ss_CURRENTSORTEDPWM+1),r19
# [515] end.
	ret
.Le7:
	.size	PWM_ss_inits, .Le7 - PWM_ss_inits
# End asmlist al_procedures
# Begin asmlist al_globals

.section .bss.n_u_spwm_ss_pwmcount,"aw",%nobits
# [38] PWMCount: Byte;
	.globl U_sPWM_ss_PWMCOUNT
	.size U_sPWM_ss_PWMCOUNT,1
U_sPWM_ss_PWMCOUNT:
	.zero 1

.section .bss.n_u_spwm_ss_pwmpins,"aw",%nobits
# [39] PWMPins: TPWMPins;
	.globl U_sPWM_ss_PWMPINS
	.size U_sPWM_ss_PWMPINS,24
U_sPWM_ss_PWMPINS:
	.zero 24

.section .bss.n_u_spwm_ss_pwmchanged,"aw",%nobits
# [40] PWMChanged: Boolean;
	.globl U_sPWM_ss_PWMCHANGED
	.size U_sPWM_ss_PWMCHANGED,1
U_sPWM_ss_PWMCHANGED:
	.zero 1

.section .bss.n_u_spwm_ss_pwmallmaskb,"aw",%nobits
# [41] PWMAllMaskB, PWMAllMaskC, PWMAllMaskD: Byte;
	.globl U_sPWM_ss_PWMALLMASKB
	.size U_sPWM_ss_PWMALLMASKB,1
U_sPWM_ss_PWMALLMASKB:
	.zero 1

.section .bss.n_u_spwm_ss_pwmallmaskc,"aw",%nobits
	.globl U_sPWM_ss_PWMALLMASKC
	.size U_sPWM_ss_PWMALLMASKC,1
U_sPWM_ss_PWMALLMASKC:
	.zero 1

.section .bss.n_u_spwm_ss_pwmallmaskd,"aw",%nobits
	.globl U_sPWM_ss_PWMALLMASKD
	.size U_sPWM_ss_PWMALLMASKD,1
U_sPWM_ss_PWMALLMASKD:
	.zero 1

.section .bss.n_u_spwm_ss_sortedpwms,"aw",%nobits
# [42] SortedPWMs: TSortedPWMPins;
	.globl U_sPWM_ss_SORTEDPWMS
	.size U_sPWM_ss_SORTEDPWMS,52
U_sPWM_ss_SORTEDPWMS:
	.zero 52

.section .bss.n_u_spwm_ss_sortedpwmcount,"aw",%nobits
# [43] SortedPWMCount: Byte;
	.globl U_sPWM_ss_SORTEDPWMCOUNT
	.size U_sPWM_ss_SORTEDPWMCOUNT,1
U_sPWM_ss_SORTEDPWMCOUNT:
	.zero 1

.section .bss.n_u_spwm_ss_sortedpwmindex,"aw",%nobits
# [44] SortedPWMIndex: Byte;
	.globl U_sPWM_ss_SORTEDPWMINDEX
	.size U_sPWM_ss_SORTEDPWMINDEX,1
U_sPWM_ss_SORTEDPWMINDEX:
	.zero 1

.section .bss.n_u_spwm_ss_currentsortedpwm,"aw",%nobits
# [45] CurrentSortedPWM: PByte;
	.globl U_sPWM_ss_CURRENTSORTEDPWM
	.size U_sPWM_ss_CURRENTSORTEDPWM,2
U_sPWM_ss_CURRENTSORTEDPWM:
	.zero 2
# End asmlist al_globals
# Begin asmlist al_rtti

.section .data.n_INIT_sPWM_ss_TPWMPIN
.globl	INIT_sPWM_ss_TPWMPIN
INIT_sPWM_ss_TPWMPIN:
	.byte	13,7
# [516] 
	.ascii	"TPWMPin"
	.short	0,0
	.long	3
	.short	0,0
	.long	0
.Le8:
	.size	INIT_sPWM_ss_TPWMPIN, .Le8 - INIT_sPWM_ss_TPWMPIN

.section .data.n_RTTI_sPWM_ss_TPWMPIN
.globl	RTTI_sPWM_ss_TPWMPIN
RTTI_sPWM_ss_TPWMPIN:
	.byte	13,7
	.ascii	"TPWMPin"
	.short	0
	.short	INIT_sPWM_ss_TPWMPIN
	.long	3,2
	.short	RTTI_sSYSTEM_ss_BYTEsindirect
	.short	0
	.short	RTTI_sSYSTEM_ss_WORDsindirect
	.short	1
.Le9:
	.size	RTTI_sPWM_ss_TPWMPIN, .Le9 - RTTI_sPWM_ss_TPWMPIN

.section .data.n_INIT_sPWM_ss_TSORTEDPWMPIN
.globl	INIT_sPWM_ss_TSORTEDPWMPIN
INIT_sPWM_ss_TSORTEDPWMPIN:
	.byte	13,13
	.ascii	"TSortedPWMPin"
	.short	0,0
	.long	4
	.short	0,0
	.long	0
.Le10:
	.size	INIT_sPWM_ss_TSORTEDPWMPIN, .Le10 - INIT_sPWM_ss_TSORTEDPWMPIN

.section .data.n_RTTI_sPWM_ss_TSORTEDPWMPIN
.globl	RTTI_sPWM_ss_TSORTEDPWMPIN
RTTI_sPWM_ss_TSORTEDPWMPIN:
	.byte	13,13
	.ascii	"TSortedPWMPin"
	.short	0
	.short	INIT_sPWM_ss_TSORTEDPWMPIN
	.long	4,4
	.short	RTTI_sSYSTEM_ss_BYTEsindirect
	.short	0
	.short	RTTI_sSYSTEM_ss_BYTEsindirect
	.short	1
	.short	RTTI_sSYSTEM_ss_BYTEsindirect
	.short	2
	.short	RTTI_sSYSTEM_ss_BYTEsindirect
	.short	3
.Le11:
	.size	RTTI_sPWM_ss_TSORTEDPWMPIN, .Le11 - RTTI_sPWM_ss_TSORTEDPWMPIN

.section .data.n_RTTI_sPWM_ss_PSORTEDPWMPIN
.globl	RTTI_sPWM_ss_PSORTEDPWMPIN
RTTI_sPWM_ss_PSORTEDPWMPIN:
	.byte	29,13
	.ascii	"PSortedPWMPin"
	.short	0
	.short	RTTI_sPWM_ss_TSORTEDPWMPINsindirect
.Le12:
	.size	RTTI_sPWM_ss_PSORTEDPWMPIN, .Le12 - RTTI_sPWM_ss_PSORTEDPWMPIN

.section .data.n_INIT_sPWM_ss_TSORTEDPWMPINS
.globl	INIT_sPWM_ss_TSORTEDPWMPINS
INIT_sPWM_ss_TSORTEDPWMPINS:
	.byte	12,14
	.ascii	"TSortedPWMPins"
	.short	0,52,13
	.short	INIT_sPWM_ss_TSORTEDPWMPINsindirect
	.byte	1
	.short	RTTI_sSYSTEM_ss_SHORTINTsindirect
.Le13:
	.size	INIT_sPWM_ss_TSORTEDPWMPINS, .Le13 - INIT_sPWM_ss_TSORTEDPWMPINS

.section .data.n_RTTI_sPWM_ss_TSORTEDPWMPINS
.globl	RTTI_sPWM_ss_TSORTEDPWMPINS
RTTI_sPWM_ss_TSORTEDPWMPINS:
	.byte	12,14
	.ascii	"TSortedPWMPins"
	.short	0,52,13
	.short	RTTI_sPWM_ss_TSORTEDPWMPINsindirect
	.byte	1
	.short	RTTI_sSYSTEM_ss_SHORTINTsindirect
.Le14:
	.size	RTTI_sPWM_ss_TSORTEDPWMPINS, .Le14 - RTTI_sPWM_ss_TSORTEDPWMPINS

.section .data.n_INIT_sPWM_ss_TPWMPINS
.globl	INIT_sPWM_ss_TPWMPINS
INIT_sPWM_ss_TPWMPINS:
	.byte	12,8
	.ascii	"TPWMPins"
	.short	0,24,8
	.short	INIT_sPWM_ss_TPWMPINsindirect
	.byte	1
	.short	RTTI_sSYSTEM_ss_SHORTINTsindirect
.Le15:
	.size	INIT_sPWM_ss_TPWMPINS, .Le15 - INIT_sPWM_ss_TPWMPINS

.section .data.n_RTTI_sPWM_ss_TPWMPINS
.globl	RTTI_sPWM_ss_TPWMPINS
RTTI_sPWM_ss_TPWMPINS:
	.byte	12,8
	.ascii	"TPWMPins"
	.short	0,24,8
	.short	RTTI_sPWM_ss_TPWMPINsindirect
	.byte	1
	.short	RTTI_sSYSTEM_ss_SHORTINTsindirect
.Le16:
	.size	RTTI_sPWM_ss_TPWMPINS, .Le16 - RTTI_sPWM_ss_TPWMPINS
# End asmlist al_rtti
# Begin asmlist al_indirectglobals

.section .data.n_INIT_sPWM_ss_TPWMPIN
	.balign 2
.globl	INIT_sPWM_ss_TPWMPINsindirect
INIT_sPWM_ss_TPWMPINsindirect:
	.short	INIT_sPWM_ss_TPWMPIN
.Le17:
	.size	INIT_sPWM_ss_TPWMPINsindirect, .Le17 - INIT_sPWM_ss_TPWMPINsindirect

.section .data.n_RTTI_sPWM_ss_TPWMPIN
	.balign 2
.globl	RTTI_sPWM_ss_TPWMPINsindirect
RTTI_sPWM_ss_TPWMPINsindirect:
	.short	RTTI_sPWM_ss_TPWMPIN
.Le18:
	.size	RTTI_sPWM_ss_TPWMPINsindirect, .Le18 - RTTI_sPWM_ss_TPWMPINsindirect

.section .data.n_INIT_sPWM_ss_TSORTEDPWMPIN
	.balign 2
.globl	INIT_sPWM_ss_TSORTEDPWMPINsindirect
INIT_sPWM_ss_TSORTEDPWMPINsindirect:
	.short	INIT_sPWM_ss_TSORTEDPWMPIN
.Le19:
	.size	INIT_sPWM_ss_TSORTEDPWMPINsindirect, .Le19 - INIT_sPWM_ss_TSORTEDPWMPINsindirect

.section .data.n_RTTI_sPWM_ss_TSORTEDPWMPIN
	.balign 2
.globl	RTTI_sPWM_ss_TSORTEDPWMPINsindirect
RTTI_sPWM_ss_TSORTEDPWMPINsindirect:
	.short	RTTI_sPWM_ss_TSORTEDPWMPIN
.Le20:
	.size	RTTI_sPWM_ss_TSORTEDPWMPINsindirect, .Le20 - RTTI_sPWM_ss_TSORTEDPWMPINsindirect

.section .data.n_RTTI_sPWM_ss_PSORTEDPWMPIN
	.balign 2
.globl	RTTI_sPWM_ss_PSORTEDPWMPINsindirect
RTTI_sPWM_ss_PSORTEDPWMPINsindirect:
	.short	RTTI_sPWM_ss_PSORTEDPWMPIN
.Le21:
	.size	RTTI_sPWM_ss_PSORTEDPWMPINsindirect, .Le21 - RTTI_sPWM_ss_PSORTEDPWMPINsindirect

.section .data.n_INIT_sPWM_ss_TSORTEDPWMPINS
	.balign 2
.globl	INIT_sPWM_ss_TSORTEDPWMPINSsindirect
INIT_sPWM_ss_TSORTEDPWMPINSsindirect:
	.short	INIT_sPWM_ss_TSORTEDPWMPINS
.Le22:
	.size	INIT_sPWM_ss_TSORTEDPWMPINSsindirect, .Le22 - INIT_sPWM_ss_TSORTEDPWMPINSsindirect

.section .data.n_RTTI_sPWM_ss_TSORTEDPWMPINS
	.balign 2
.globl	RTTI_sPWM_ss_TSORTEDPWMPINSsindirect
RTTI_sPWM_ss_TSORTEDPWMPINSsindirect:
	.short	RTTI_sPWM_ss_TSORTEDPWMPINS
.Le23:
	.size	RTTI_sPWM_ss_TSORTEDPWMPINSsindirect, .Le23 - RTTI_sPWM_ss_TSORTEDPWMPINSsindirect

.section .data.n_INIT_sPWM_ss_TPWMPINS
	.balign 2
.globl	INIT_sPWM_ss_TPWMPINSsindirect
INIT_sPWM_ss_TPWMPINSsindirect:
	.short	INIT_sPWM_ss_TPWMPINS
.Le24:
	.size	INIT_sPWM_ss_TPWMPINSsindirect, .Le24 - INIT_sPWM_ss_TPWMPINSsindirect

.section .data.n_RTTI_sPWM_ss_TPWMPINS
	.balign 2
.globl	RTTI_sPWM_ss_TPWMPINSsindirect
RTTI_sPWM_ss_TPWMPINSsindirect:
	.short	RTTI_sPWM_ss_TPWMPINS
.Le25:
	.size	RTTI_sPWM_ss_TPWMPINSsindirect, .Le25 - RTTI_sPWM_ss_TPWMPINSsindirect
# End asmlist al_indirectglobals

