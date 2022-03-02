	.file "UltrasonicFW.lpr"
# Begin asmlist al_procedures

.section .text.n_main
.globl	PASCALMAIN
PASCALMAIN:
.globl	main
main:
# [UltrasonicFW.lpr]
# [19] begin
	call	FPC_INIT_FUNC_TABLE
# [20] UARTConsole.Init(9600);
	ldi	r18,lo8(U_sUART_ss_UARTCONSOLE)
	ldi	r25,hi8(U_sUART_ss_UARTCONSOLE)
	ldi	r20,-128
	ldi	r21,37
	ldi	r22,lo8(VMT_sUART_ss_TUART)
	ldi	r23,hi8(VMT_sUART_ss_TUART)
	mov	r24,r18
	call	UARTs_sTUART_s__ss_INITsWORDssLONGBOOL
# [22] Timer0.OutputModes := [];
	ldi	r24,lo8(U_sTIMERS_ss_TIMER0)
	ldi	r25,hi8(U_sTIMERS_ss_TIMER0)
	mov	r22,r1
	lds	r18,(U_sTIMERS_ss_TIMER0+42)
	lds	r19,(U_sTIMERS_ss_TIMER0+43)
	movw	r30,r18
	ldd	r18,Z+12
	ldd	r2,Z+13
	mov	r30,r18
	mov	r31,r2
	icall
# [23] Timer0.CLKMode := tclkm64;
	ldi	r24,lo8(U_sTIMERS_ss_TIMER0)
	ldi	r25,hi8(U_sTIMERS_ss_TIMER0)
	ldi	r22,3
	lds	r19,(U_sTIMERS_ss_TIMER0+42)
	lds	r18,(U_sTIMERS_ss_TIMER0+43)
	mov	r30,r19
	mov	r31,r18
	ldd	r18,Z+22
	ldd	r2,Z+23
	mov	r30,r18
	mov	r31,r2
	icall
# [25] IEnable;
	call	ARDUINOTOOLS_ss_IENABLE
.Lj3:
# [28] PinMode(ULTRASOUND_PIN, avrmOutput);
	mov	r22,r1
	ldi	r26,3
	mov	r24,r26
	call	ARDUINOTOOLS_ss_PINMODEsBYTEsTAVRPINMODE
# [29] DigitalWrite(ULTRASOUND_PIN, False);
	mov	r22,r1
	ldi	r26,3
	mov	r24,r26
	call	ARDUINOTOOLS_ss_DIGITALWRITEsBYTEsBOOLEAN
# [30] SleepMicroSecs(2);
	ldi	r22,2
	mov	r23,r1
	mov	r24,r1
	mov	r25,r1
	call	ARDUINOTOOLS_ss_SLEEPMICROSECSsLONGWORD
# [31] DigitalWrite(ULTRASOUND_PIN, True);
	ldi	r22,1
	ldi	r26,3
	mov	r24,r26
	call	ARDUINOTOOLS_ss_DIGITALWRITEsBYTEsBOOLEAN
# [32] SleepMicroSecs(10);
	ldi	r22,10
	mov	r23,r1
	mov	r24,r1
	mov	r25,r1
	call	ARDUINOTOOLS_ss_SLEEPMICROSECSsLONGWORD
# [33] DigitalWrite(ULTRASOUND_PIN, False);
	mov	r22,r1
	ldi	r26,3
	mov	r24,r26
	call	ARDUINOTOOLS_ss_DIGITALWRITEsBYTEsBOOLEAN
# [34] PinMode(ULTRASOUND_PIN, avrmInput);
	ldi	r22,1
	ldi	r26,3
	mov	r24,r26
	call	ARDUINOTOOLS_ss_PINMODEsBYTEsTAVRPINMODE
# [35] VDuration := PulseIn(ULTRASOUND_PIN, True);
	ldi	r18,64
	ldi	r19,66
	ldi	r20,15
	mov	r21,r1
	ldi	r22,1
	ldi	r26,3
	mov	r24,r26
	call	TIMERS_ss_PULSEINsBYTEsBOOLEANsLONGWORDssLONGWORD
	sts	(U_sPsULTRASONICFW_ss_VDURATION),r22
	sts	(U_sPsULTRASONICFW_ss_VDURATION+1),r23
	sts	(U_sPsULTRASONICFW_ss_VDURATION+2),r24
	sts	(U_sPsULTRASONICFW_ss_VDURATION+3),r25
# [36] if VDuration = $FFFFFFFF then
	lds	r18,(U_sPsULTRASONICFW_ss_VDURATION)
	lds	r19,(U_sPsULTRASONICFW_ss_VDURATION+1)
	lds	r20,(U_sPsULTRASONICFW_ss_VDURATION+2)
	lds	r21,(U_sPsULTRASONICFW_ss_VDURATION+3)
	cpi	r18,-1
	ldi	r18,-1
	cpc	r19,r18
	ldi	r18,-1
	cpc	r20,r18
	ldi	r18,-1
	cpc	r21,r18
	brne	.Lj9
# [47] end.
	rjmp	.Lj8
.Lj9:
# [42] VDistance := VDuration div 58;
	lds	r18,(U_sPsULTRASONICFW_ss_VDURATION)
	lds	r19,(U_sPsULTRASONICFW_ss_VDURATION+1)
	lds	r20,(U_sPsULTRASONICFW_ss_VDURATION+2)
	lds	r21,(U_sPsULTRASONICFW_ss_VDURATION+3)
	ldi	r22,58
	mov	r23,r1
	mov	r24,r1
	mov	r25,r1
	call	fpc_div_dword
	sts	(U_sPsULTRASONICFW_ss_VDISTANCE),r22
	sts	(U_sPsULTRASONICFW_ss_VDISTANCE+1),r23
# [43] UARTConsole.WriteBuffer(@VDistance, SizeOf(VDistance));
	ldi	r22,lo8(U_sPsULTRASONICFW_ss_VDISTANCE)
	ldi	r23,hi8(U_sPsULTRASONICFW_ss_VDISTANCE)
	ldi	r24,lo8(U_sUART_ss_UARTCONSOLE)
	ldi	r25,hi8(U_sUART_ss_UARTCONSOLE)
	ldi	r20,2
	lds	r18,(U_sUART_ss_UARTCONSOLE+2)
	lds	r19,(U_sUART_ss_UARTCONSOLE+3)
	movw	r30,r18
	ldd	r18,Z+8
	ldd	r2,Z+9
	mov	r30,r18
	mov	r31,r2
	icall
.Lj8:
# [45] SleepMicroSecs(1000000);
	ldi	r22,64
	ldi	r23,66
	ldi	r24,15
	mov	r25,r1
	call	ARDUINOTOOLS_ss_SLEEPMICROSECSsLONGWORD
# [46] until False;
	rjmp	.Lj3
.Le0:
	.size	main, .Le0 - main

.section .text.n_FPC_INIT_FUNC_TABLE
.globl	FPC_INIT_FUNC_TABLE
FPC_INIT_FUNC_TABLE:
# [48] 
	call	INITs_sTIMERS
	ret

.section .text.n_FPC_FINALIZE_FUNC_TABLE
.globl	FPC_FINALIZE_FUNC_TABLE
FPC_FINALIZE_FUNC_TABLE:
	ret
# End asmlist al_procedures
# Begin asmlist al_globals

.section .bss.n_u_spsultrasonicfw_ss_vduration
# [16] VDuration: Cardinal;
	.size U_sPsULTRASONICFW_ss_VDURATION,4
U_sPsULTRASONICFW_ss_VDURATION:
	.zero 4

.section .bss.n_u_spsultrasonicfw_ss_vdistance
# [17] VDistance: Word;
	.size U_sPsULTRASONICFW_ss_VDISTANCE,2
U_sPsULTRASONICFW_ss_VDISTANCE:
	.zero 2

.section .data.n_INITFINAL
	.balign 2
.globl	INITFINAL
INITFINAL:
	.byte	1,0
	.short	gs(INITs_sTIMERS)
	.short	gs(0)
.Le1:
	.size	INITFINAL, .Le1 - INITFINAL

.section .data.n_FPC_THREADVARTABLES
	.balign 2
.globl	FPC_THREADVARTABLES
FPC_THREADVARTABLES:
	.long	0
.Le2:
	.size	FPC_THREADVARTABLES, .Le2 - FPC_THREADVARTABLES

.section .data.n_FPC_RESOURCESTRINGTABLES
	.balign 2
.globl	FPC_RESOURCESTRINGTABLES
FPC_RESOURCESTRINGTABLES:
	.short	0
.Le3:
	.size	FPC_RESOURCESTRINGTABLES, .Le3 - FPC_RESOURCESTRINGTABLES

.section .data.n_FPC_WIDEINITTABLES
	.balign 2
.globl	FPC_WIDEINITTABLES
FPC_WIDEINITTABLES:
	.short	0
.Le4:
	.size	FPC_WIDEINITTABLES, .Le4 - FPC_WIDEINITTABLES

.section .data.n_FPC_RESSTRINITTABLES
	.balign 2
.globl	FPC_RESSTRINITTABLES
FPC_RESSTRINITTABLES:
	.short	0
.Le5:
	.size	FPC_RESSTRINITTABLES, .Le5 - FPC_RESSTRINITTABLES

.section .fpc.n_version
__fpc_ident:
	.ascii	"FPC 3.2.2 [2022/02/18] for avr - embedded"
.Le6:
	.size	__fpc_ident, .Le6 - __fpc_ident

.section .data.n___stklen
	.balign 2
.globl	__stklen
__stklen:
	.short	1024
.Le7:
	.size	__stklen, .Le7 - __stklen

.section .data.n___heapsize
	.balign 2
.globl	__heapsize
__heapsize:
	.short	128
.Le8:
	.size	__heapsize, .Le8 - __heapsize

.section .bss.n___fpc_initialheap
	.globl __fpc_initialheap
	.size __fpc_initialheap,128
__fpc_initialheap:
	.zero 128

.section .data.n___fpc_valgrind
	.balign 2
.globl	__fpc_valgrind
__fpc_valgrind:
	.byte	0
.Le9:
	.size	__fpc_valgrind, .Le9 - __fpc_valgrind
# End asmlist al_globals

