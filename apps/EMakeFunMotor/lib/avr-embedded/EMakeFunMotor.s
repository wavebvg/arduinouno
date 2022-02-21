	.file "EMakeFunMotor.lpr"
# Begin asmlist al_procedures

.section .text.n_psemakefunmotors_stbot_s__ss_initsslongbool,"ax"
.globl	PsEMAKEFUNMOTORs_sTBOT_s__ss_INITssLONGBOOL
PsEMAKEFUNMOTORs_sTBOT_s__ss_INITssLONGBOOL:
# Temps allocated between r28+6 and r28+66
# [EMakeFunMotor.lpr]
# [44] begin
	push	r29
	push	r28
	in	r28,61
	in	r29,62
	subi	r28,66
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var $vmt located at r28+2, size=OS_16
# Var $self located at r28+4, size=OS_16
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
	mov	r18,r1
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
	brne	.Lj14
# [56] end;
	rjmp	.Lj3
.Lj14:
	ldi	r20,lo8(6)
	ldi	r21,hi8(6)
	add	r20,r28
	adc	r21,r29
	ldi	r22,lo8(12)
	ldi	r23,hi8(12)
	add	r22,r28
	adc	r23,r29
	ldi	r24,1
	mov	r25,r1
	call	fpc_pushexceptaddr
	call	fpc_setjmp
	std	Y+35,r24
	cp	r24,r1
	breq	.Lj15
	rjmp	.Lj11
.Lj15:
# [45] PinMode(IN1_PIN, avrmOutput);
	mov	r22,r1
	ldi	r26,6
	mov	r24,r26
	call	ARDUINOTOOLS_ss_PINMODEsBYTEsTAVRPINMODE
# [46] AnalogWrite(IN1_PIN, 0);
	mov	r22,r1
	ldi	r26,6
	mov	r24,r26
	call	PWM_ss_ANALOGWRITEsBYTEsBYTE
# [48] PinMode(IN2_PIN, avrmOutput);
	mov	r22,r1
	ldi	r26,10
	mov	r24,r26
	call	ARDUINOTOOLS_ss_PINMODEsBYTEsTAVRPINMODE
# [49] AnalogWrite(IN2_PIN, 0);
	mov	r22,r1
	ldi	r26,10
	mov	r24,r26
	call	PWM_ss_ANALOGWRITEsBYTEsBYTE
# [51] PinMode(IN3_PIN, avrmOutput);
	mov	r22,r1
	ldi	r26,5
	mov	r24,r26
	call	ARDUINOTOOLS_ss_PINMODEsBYTEsTAVRPINMODE
# [52] AnalogWrite(IN3_PIN, 0);
	mov	r22,r1
	ldi	r26,5
	mov	r24,r26
	call	PWM_ss_ANALOGWRITEsBYTEsBYTE
# [54] PinMode(IN4_PIN, avrmOutput);
	mov	r22,r1
	ldi	r26,9
	mov	r24,r26
	call	ARDUINOTOOLS_ss_PINMODEsBYTEsTAVRPINMODE
# [55] AnalogWrite(IN4_PIN, 0);
	mov	r22,r1
	ldi	r26,9
	mov	r24,r26
	call	PWM_ss_ANALOGWRITEsBYTEsBYTE
.Lj11:
	call	fpc_popaddrstack
	ldd	r18,Y+35
	cp	r18,r1
	brne	.Lj16
	rjmp	.Lj9
.Lj16:
	ldi	r20,lo8(36)
	ldi	r21,hi8(36)
	add	r20,r28
	adc	r21,r29
	ldi	r22,lo8(42)
	ldi	r23,hi8(42)
	add	r22,r28
	adc	r23,r29
	ldi	r24,1
	mov	r25,r1
	call	fpc_pushexceptaddr
	call	fpc_setjmp
	ldi	r30,lo8(65)
	ldi	r31,hi8(65)
	add	r30,r28
	adc	r31,r29
	st	Z,r24
	cp	r24,r1
	brne	.Lj12
	ldi	r22,lo8(2)
	ldi	r23,hi8(2)
	add	r22,r28
	adc	r23,r29
	ldd	r24,Y+4
	ldd	r25,Y+5
	mov	r18,r1
	mov	r19,r1
	mov	r20,r1
	mov	r21,r1
	call	fpc_help_fail
	call	fpc_popaddrstack
	call	fpc_reraise
.Lj12:
	call	fpc_popaddrstack
	ldi	r30,lo8(65)
	ldi	r31,hi8(65)
	add	r30,r28
	adc	r31,r29
	ld	r18,Z
	cp	r18,r1
	breq	.Lj13
	call	fpc_raise_nested
.Lj13:
	call	fpc_doneexception
.Lj9:
.Lj3:
	ldd	r24,Y+4
	ldd	r25,Y+5
	subi	r28,-66
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
	.size	PsEMAKEFUNMOTORs_sTBOT_s__ss_INITssLONGBOOL, .Le0 - PsEMAKEFUNMOTORs_sTBOT_s__ss_INITssLONGBOOL

.section .text.n_psemakefunmotors_stbot_s__ss_up,"ax"
.globl	PsEMAKEFUNMOTORs_sTBOT_s__ss_UP
PsEMAKEFUNMOTORs_sTBOT_s__ss_UP:
# [59] begin
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
# [60] AnalogWrite(IN1_PIN, 200);
	ldi	r18,-56
	ldi	r24,6
	mov	r22,r18
	call	PWM_ss_ANALOGWRITEsBYTEsBYTE
# [61] AnalogWrite(IN2_PIN, 0);
	mov	r22,r1
	ldi	r26,10
	mov	r24,r26
	call	PWM_ss_ANALOGWRITEsBYTEsBYTE
# [62] AnalogWrite(IN3_PIN, 0);
	mov	r22,r1
	ldi	r26,5
	mov	r24,r26
	call	PWM_ss_ANALOGWRITEsBYTEsBYTE
# [63] AnalogWrite(IN4_PIN, 200);
	ldi	r22,-56
	ldi	r26,9
	mov	r24,r26
	call	PWM_ss_ANALOGWRITEsBYTEsBYTE
# [64] end;
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
.Le1:
	.size	PsEMAKEFUNMOTORs_sTBOT_s__ss_UP, .Le1 - PsEMAKEFUNMOTORs_sTBOT_s__ss_UP

.section .text.n_psemakefunmotors_stbot_s__ss_down,"ax"
.globl	PsEMAKEFUNMOTORs_sTBOT_s__ss_DOWN
PsEMAKEFUNMOTORs_sTBOT_s__ss_DOWN:
# [67] begin
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
# [68] AnalogWrite(IN1_PIN, 0);
	mov	r18,r1
	ldi	r24,6
	mov	r22,r18
	call	PWM_ss_ANALOGWRITEsBYTEsBYTE
# [69] AnalogWrite(IN2_PIN, 200);
	ldi	r22,-56
	ldi	r26,10
	mov	r24,r26
	call	PWM_ss_ANALOGWRITEsBYTEsBYTE
# [70] AnalogWrite(IN3_PIN, 200);
	ldi	r22,-56
	ldi	r26,5
	mov	r24,r26
	call	PWM_ss_ANALOGWRITEsBYTEsBYTE
# [71] AnalogWrite(IN4_PIN, 0);
	mov	r22,r1
	ldi	r26,9
	mov	r24,r26
	call	PWM_ss_ANALOGWRITEsBYTEsBYTE
# [72] end;
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
.Le2:
	.size	PsEMAKEFUNMOTORs_sTBOT_s__ss_DOWN, .Le2 - PsEMAKEFUNMOTORs_sTBOT_s__ss_DOWN

.section .text.n_psemakefunmotors_stbot_s__ss_left,"ax"
.globl	PsEMAKEFUNMOTORs_sTBOT_s__ss_LEFT
PsEMAKEFUNMOTORs_sTBOT_s__ss_LEFT:
# [75] begin
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
# [76] AnalogWrite(IN1_PIN, 200);
	ldi	r18,-56
	ldi	r24,6
	mov	r22,r18
	call	PWM_ss_ANALOGWRITEsBYTEsBYTE
# [77] AnalogWrite(IN2_PIN, 0);
	mov	r22,r1
	ldi	r26,10
	mov	r24,r26
	call	PWM_ss_ANALOGWRITEsBYTEsBYTE
# [78] AnalogWrite(IN3_PIN, 200);
	ldi	r22,-56
	ldi	r26,5
	mov	r24,r26
	call	PWM_ss_ANALOGWRITEsBYTEsBYTE
# [79] AnalogWrite(IN4_PIN, 0);
	mov	r22,r1
	ldi	r26,9
	mov	r24,r26
	call	PWM_ss_ANALOGWRITEsBYTEsBYTE
# [80] end;
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
.Le3:
	.size	PsEMAKEFUNMOTORs_sTBOT_s__ss_LEFT, .Le3 - PsEMAKEFUNMOTORs_sTBOT_s__ss_LEFT

.section .text.n_psemakefunmotors_stbot_s__ss_right,"ax"
.globl	PsEMAKEFUNMOTORs_sTBOT_s__ss_RIGHT
PsEMAKEFUNMOTORs_sTBOT_s__ss_RIGHT:
# [83] begin
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
# [84] AnalogWrite(IN1_PIN, 0);
	mov	r18,r1
	ldi	r24,6
	mov	r22,r18
	call	PWM_ss_ANALOGWRITEsBYTEsBYTE
# [85] AnalogWrite(IN2_PIN, 200);
	ldi	r22,-56
	ldi	r26,10
	mov	r24,r26
	call	PWM_ss_ANALOGWRITEsBYTEsBYTE
# [86] AnalogWrite(IN3_PIN, 0);
	mov	r22,r1
	ldi	r26,5
	mov	r24,r26
	call	PWM_ss_ANALOGWRITEsBYTEsBYTE
# [87] AnalogWrite(IN4_PIN, 200);
	ldi	r22,-56
	ldi	r26,9
	mov	r24,r26
	call	PWM_ss_ANALOGWRITEsBYTEsBYTE
# [88] end;
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
	.size	PsEMAKEFUNMOTORs_sTBOT_s__ss_RIGHT, .Le4 - PsEMAKEFUNMOTORs_sTBOT_s__ss_RIGHT

.section .text.n_psemakefunmotors_stbot_s__ss_stop,"ax"
.globl	PsEMAKEFUNMOTORs_sTBOT_s__ss_STOP
PsEMAKEFUNMOTORs_sTBOT_s__ss_STOP:
# [91] begin
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
# [92] AnalogWrite(IN1_PIN, 255);
	ldi	r18,-1
	ldi	r24,6
	mov	r22,r18
	call	PWM_ss_ANALOGWRITEsBYTEsBYTE
# [93] AnalogWrite(IN2_PIN, 255);
	ldi	r22,-1
	ldi	r26,10
	mov	r24,r26
	call	PWM_ss_ANALOGWRITEsBYTEsBYTE
# [94] AnalogWrite(IN3_PIN, 255);
	ldi	r22,-1
	ldi	r26,5
	mov	r24,r26
	call	PWM_ss_ANALOGWRITEsBYTEsBYTE
# [95] AnalogWrite(IN4_PIN, 255);
	ldi	r22,-1
	ldi	r26,9
	mov	r24,r26
	call	PWM_ss_ANALOGWRITEsBYTEsBYTE
# [96] end;
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
	.size	PsEMAKEFUNMOTORs_sTBOT_s__ss_STOP, .Le5 - PsEMAKEFUNMOTORs_sTBOT_s__ss_STOP

.section .text.n_main,"ax"
.globl	main
main:
.globl	PASCALMAIN
PASCALMAIN:
# Temps allocated between r28+2 and r28+4
# [103] begin
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
	call	FPC_INIT_FUNC_TABLE
# [104] UARTConsole.Init(9600);
	ldi	r18,lo8(VMT_sUART_ss_TUART)
	ldi	r23,hi8(VMT_sUART_ss_TUART)
	mov	r22,r18
	ldi	r24,lo8(U_sUART_ss_UARTCONSOLE)
	ldi	r25,hi8(U_sUART_ss_UARTCONSOLE)
	ldi	r20,-128
	ldi	r26,37
	mov	r21,r26
	call	UARTs_sTUART_s__ss_INITsWORDssLONGBOOL
# [105] IR.Init(IR_PIN_PORT);
	ldi	r22,lo8(VMT_sIRRECEIVER_ss_TIRRECEIVER)
	ldi	r23,hi8(VMT_sIRRECEIVER_ss_TIRRECEIVER)
	ldi	r24,lo8(U_sPsEMAKEFUNMOTOR_ss_IR)
	ldi	r25,hi8(U_sPsEMAKEFUNMOTOR_ss_IR)
	ldi	r26,11
	mov	r20,r26
	call	IRRECEIVERs_sTIRRECEIVER_s__ss_INITsBYTEssLONGBOOL
# [107] Timer0.OutputModes := [];
	mov	r22,r1
	ldi	r24,lo8(U_sTIMERS_ss_TIMER0)
	ldi	r25,hi8(U_sTIMERS_ss_TIMER0)
	lds	r19,(U_sTIMERS_ss_TIMER0+42)
	lds	r18,(U_sTIMERS_ss_TIMER0+43)
	mov	r30,r19
	mov	r31,r18
	ldd	r18,Z+12
	ldd	r2,Z+13
	mov	r30,r18
	mov	r31,r2
	icall
# [108] Timer0.CLKMode := tclkm64;
	ldi	r24,lo8(U_sTIMERS_ss_TIMER0)
	ldi	r25,hi8(U_sTIMERS_ss_TIMER0)
	ldi	r22,3
	lds	r18,(U_sTIMERS_ss_TIMER0+42)
	lds	r19,(U_sTIMERS_ss_TIMER0+43)
	movw	r30,r18
	ldd	r18,Z+22
	ldd	r2,Z+23
	mov	r30,r18
	mov	r31,r2
	icall
# [110] IEnable;
	call	ARDUINOTOOLS_ss_IENABLE
# [111] UARTConsole.WriteLnString('start');
	ldi	r22,lo8(_sEMAKEFUNMOTORs_Ld1)
	ldi	r23,hi8(_sEMAKEFUNMOTORs_Ld1)
	ldi	r24,lo8(U_sUART_ss_UARTCONSOLE)
	ldi	r25,hi8(U_sUART_ss_UARTCONSOLE)
	call	UARTs_sTUART_s__ss_WRITELNSTRINGsPCHAR
.Lj27:
# [113] Command := IR.Read;
	ldi	r22,lo8(2)
	ldi	r23,hi8(2)
	add	r22,r28
	adc	r23,r29
	ldi	r24,lo8(U_sPsEMAKEFUNMOTOR_ss_IR)
	ldi	r25,hi8(U_sPsEMAKEFUNMOTOR_ss_IR)
	call	IRRECEIVERs_sTIRRECEIVER_s__ss_READssTIRVALUE
	ldd	r0,Y+2
	sts	(U_sPsEMAKEFUNMOTOR_ss_COMMAND),r0
	ldd	r0,Y+3
	sts	(U_sPsEMAKEFUNMOTOR_ss_COMMAND+1),r0
# [114] case Command.Command of
	lds	r19,(U_sPsEMAKEFUNMOTOR_ss_COMMAND+1)
	cpi	r19,7
	brlo	.Lj27
	mov	r18,r19
	subi	r19,7
	cpi	r18,7
	brne	.Lj36
# [142] end.
	rjmp	.Lj35
.Lj36:
	mov	r18,r19
	subi	r19,2
	cpi	r18,2
	brne	.Lj37
	rjmp	.Lj34
.Lj37:
	mov	r18,r19
	subi	r19,12
	cpi	r18,12
	breq	.Lj31
	mov	r18,r19
	subi	r19,4
	cpi	r18,4
	brne	.Lj38
	rjmp	.Lj33
.Lj38:
	mov	r18,r19
	subi	r19,39
	cpi	r18,39
	breq	.Lj32
	rjmp	.Lj27
.Lj31:
# [117] UARTConsole.WriteLnString('Stop');
	ldi	r22,lo8(_sEMAKEFUNMOTORs_Ld2)
	ldi	r23,hi8(_sEMAKEFUNMOTORs_Ld2)
	ldi	r24,lo8(U_sUART_ss_UARTCONSOLE)
	ldi	r25,hi8(U_sUART_ss_UARTCONSOLE)
	call	UARTs_sTUART_s__ss_WRITELNSTRINGsPCHAR
# [118] Bot.Stop;
	ldi	r24,lo8(U_sPsEMAKEFUNMOTOR_ss_BOT)
	ldi	r25,hi8(U_sPsEMAKEFUNMOTOR_ss_BOT)
	call	PsEMAKEFUNMOTORs_sTBOT_s__ss_STOP
	rjmp	.Lj27
.Lj32:
# [122] UARTConsole.WriteLnString('Up');
	ldi	r22,lo8(_sEMAKEFUNMOTORs_Ld3)
	ldi	r23,hi8(_sEMAKEFUNMOTORs_Ld3)
	ldi	r24,lo8(U_sUART_ss_UARTCONSOLE)
	ldi	r25,hi8(U_sUART_ss_UARTCONSOLE)
	call	UARTs_sTUART_s__ss_WRITELNSTRINGsPCHAR
# [123] Bot.Up;
	ldi	r24,lo8(U_sPsEMAKEFUNMOTOR_ss_BOT)
	ldi	r25,hi8(U_sPsEMAKEFUNMOTOR_ss_BOT)
	call	PsEMAKEFUNMOTORs_sTBOT_s__ss_UP
	rjmp	.Lj27
.Lj33:
# [127] UARTConsole.WriteLnString('Down');
	ldi	r22,lo8(_sEMAKEFUNMOTORs_Ld4)
	ldi	r23,hi8(_sEMAKEFUNMOTORs_Ld4)
	ldi	r24,lo8(U_sUART_ss_UARTCONSOLE)
	ldi	r25,hi8(U_sUART_ss_UARTCONSOLE)
	call	UARTs_sTUART_s__ss_WRITELNSTRINGsPCHAR
# [128] Bot.Down;
	ldi	r24,lo8(U_sPsEMAKEFUNMOTOR_ss_BOT)
	ldi	r25,hi8(U_sPsEMAKEFUNMOTOR_ss_BOT)
	call	PsEMAKEFUNMOTORs_sTBOT_s__ss_DOWN
	rjmp	.Lj27
.Lj34:
# [132] UARTConsole.WriteLnString('Right');
	ldi	r22,lo8(_sEMAKEFUNMOTORs_Ld5)
	ldi	r23,hi8(_sEMAKEFUNMOTORs_Ld5)
	ldi	r24,lo8(U_sUART_ss_UARTCONSOLE)
	ldi	r25,hi8(U_sUART_ss_UARTCONSOLE)
	call	UARTs_sTUART_s__ss_WRITELNSTRINGsPCHAR
# [133] Bot.Right;
	ldi	r24,lo8(U_sPsEMAKEFUNMOTOR_ss_BOT)
	ldi	r25,hi8(U_sPsEMAKEFUNMOTOR_ss_BOT)
	call	PsEMAKEFUNMOTORs_sTBOT_s__ss_RIGHT
	rjmp	.Lj27
.Lj35:
# [137] UARTConsole.WriteLnString('Left');
	ldi	r22,lo8(_sEMAKEFUNMOTORs_Ld6)
	ldi	r23,hi8(_sEMAKEFUNMOTORs_Ld6)
	ldi	r24,lo8(U_sUART_ss_UARTCONSOLE)
	ldi	r25,hi8(U_sUART_ss_UARTCONSOLE)
	call	UARTs_sTUART_s__ss_WRITELNSTRINGsPCHAR
# [138] Bot.Left;
	ldi	r24,lo8(U_sPsEMAKEFUNMOTOR_ss_BOT)
	ldi	r25,hi8(U_sPsEMAKEFUNMOTOR_ss_BOT)
	call	PsEMAKEFUNMOTORs_sTBOT_s__ss_LEFT
# [141] until False;
	rjmp	.Lj27
.Le6:
	.size	main, .Le6 - main

.section .text.n_FPC_INIT_FUNC_TABLE,"ax"
.globl	FPC_INIT_FUNC_TABLE
FPC_INIT_FUNC_TABLE:
# [143] 
	call	INITs_sTIMERS
	call	INITs_sPWM
	ret

.section .text.n_FPC_FINALIZE_FUNC_TABLE,"ax"
.globl	FPC_FINALIZE_FUNC_TABLE
FPC_FINALIZE_FUNC_TABLE:
	ret
# End asmlist al_procedures
# Begin asmlist al_globals

.section .bss.n_u_spsemakefunmotor_ss_ir,"aw",%nobits
# [99] IR: TIRReceiver;
	.size U_sPsEMAKEFUNMOTOR_ss_IR,6
U_sPsEMAKEFUNMOTOR_ss_IR:
	.zero 6

.section .bss.n_u_spsemakefunmotor_ss_command,"aw",%nobits
# [100] Command: TIRValue;
	.size U_sPsEMAKEFUNMOTOR_ss_COMMAND,2
U_sPsEMAKEFUNMOTOR_ss_COMMAND:
	.zero 2

.section .bss.n_u_spsemakefunmotor_ss_bot,"aw",%nobits
# [101] Bot: TBot;
	.size U_sPsEMAKEFUNMOTOR_ss_BOT,2
U_sPsEMAKEFUNMOTOR_ss_BOT:
	.zero 2

.section .data.n_VMT_sPsEMAKEFUNMOTOR_ss_TBOT
	.balign 2
.globl	VMT_sPsEMAKEFUNMOTOR_ss_TBOT
VMT_sPsEMAKEFUNMOTOR_ss_TBOT:
	.short	2,65534,0
	.short	gs(0)
.Le7:
	.size	VMT_sPsEMAKEFUNMOTOR_ss_TBOT, .Le7 - VMT_sPsEMAKEFUNMOTOR_ss_TBOT

.section .data.n_INITFINAL
.globl	INITFINAL
INITFINAL:
	.byte	2,0
	.short	gs(INITs_sTIMERS)
	.short	gs(0)
	.short	gs(INITs_sPWM)
	.short	gs(0)
.Le8:
	.size	INITFINAL, .Le8 - INITFINAL

.section .data.n_FPC_THREADVARTABLES
.globl	FPC_THREADVARTABLES
FPC_THREADVARTABLES:
	.long	0
.Le9:
	.size	FPC_THREADVARTABLES, .Le9 - FPC_THREADVARTABLES

.section .data.n_FPC_RESOURCESTRINGTABLES
.globl	FPC_RESOURCESTRINGTABLES
FPC_RESOURCESTRINGTABLES:
	.short	0
.Le10:
	.size	FPC_RESOURCESTRINGTABLES, .Le10 - FPC_RESOURCESTRINGTABLES

.section .data.n_FPC_WIDEINITTABLES
.globl	FPC_WIDEINITTABLES
FPC_WIDEINITTABLES:
	.short	0
.Le11:
	.size	FPC_WIDEINITTABLES, .Le11 - FPC_WIDEINITTABLES

.section .data.n_FPC_RESSTRINITTABLES
.globl	FPC_RESSTRINITTABLES
FPC_RESSTRINITTABLES:
	.short	0
.Le12:
	.size	FPC_RESSTRINITTABLES, .Le12 - FPC_RESSTRINITTABLES

.section .fpc.n_version,"aw"
__fpc_ident:
	.ascii	"FPC 3.3.1 [2022/01/30] for avr - embedded"
.Le13:
	.size	__fpc_ident, .Le13 - __fpc_ident

.section .data.n___stklen
.globl	__stklen
__stklen:
	.short	1024
.Le14:
	.size	__stklen, .Le14 - __stklen

.section .data.n___heapsize
.globl	__heapsize
__heapsize:
	.short	128
.Le15:
	.size	__heapsize, .Le15 - __heapsize

.section .bss.n___fpc_initialheap,"aw",%nobits
	.globl __fpc_initialheap
	.size __fpc_initialheap,128
__fpc_initialheap:
	.zero 128

.section .data.n___fpc_valgrind
.globl	__fpc_valgrind
__fpc_valgrind:
	.byte	0
.Le16:
	.size	__fpc_valgrind, .Le16 - __fpc_valgrind
# End asmlist al_globals
# Begin asmlist al_typedconsts

.section .rodata.n__sEMAKEFUNMOTORs_Ld1
.globl	_sEMAKEFUNMOTORs_Ld1
_sEMAKEFUNMOTORs_Ld1:
	.ascii	"start\000"
.Le17:
	.size	_sEMAKEFUNMOTORs_Ld1, .Le17 - _sEMAKEFUNMOTORs_Ld1

.section .rodata.n__sEMAKEFUNMOTORs_Ld2
.globl	_sEMAKEFUNMOTORs_Ld2
_sEMAKEFUNMOTORs_Ld2:
	.ascii	"Stop\000"
.Le18:
	.size	_sEMAKEFUNMOTORs_Ld2, .Le18 - _sEMAKEFUNMOTORs_Ld2

.section .rodata.n__sEMAKEFUNMOTORs_Ld3
.globl	_sEMAKEFUNMOTORs_Ld3
_sEMAKEFUNMOTORs_Ld3:
	.ascii	"Up\000"
.Le19:
	.size	_sEMAKEFUNMOTORs_Ld3, .Le19 - _sEMAKEFUNMOTORs_Ld3

.section .rodata.n__sEMAKEFUNMOTORs_Ld4
.globl	_sEMAKEFUNMOTORs_Ld4
_sEMAKEFUNMOTORs_Ld4:
	.ascii	"Down\000"
.Le20:
	.size	_sEMAKEFUNMOTORs_Ld4, .Le20 - _sEMAKEFUNMOTORs_Ld4

.section .rodata.n__sEMAKEFUNMOTORs_Ld5
.globl	_sEMAKEFUNMOTORs_Ld5
_sEMAKEFUNMOTORs_Ld5:
	.ascii	"Right\000"
.Le21:
	.size	_sEMAKEFUNMOTORs_Ld5, .Le21 - _sEMAKEFUNMOTORs_Ld5

.section .rodata.n__sEMAKEFUNMOTORs_Ld6
.globl	_sEMAKEFUNMOTORs_Ld6
_sEMAKEFUNMOTORs_Ld6:
	.ascii	"Left\000"
.Le22:
	.size	_sEMAKEFUNMOTORs_Ld6, .Le22 - _sEMAKEFUNMOTORs_Ld6
# End asmlist al_typedconsts
# Begin asmlist al_indirectglobals

.section .data.n_VMT_sPsEMAKEFUNMOTOR_ss_TBOT
	.balign 2
.globl	VMT_sPsEMAKEFUNMOTOR_ss_TBOTsindirect
VMT_sPsEMAKEFUNMOTOR_ss_TBOTsindirect:
	.short	VMT_sPsEMAKEFUNMOTOR_ss_TBOT
.Le23:
	.size	VMT_sPsEMAKEFUNMOTOR_ss_TBOTsindirect, .Le23 - VMT_sPsEMAKEFUNMOTOR_ss_TBOTsindirect
# End asmlist al_indirectglobals

