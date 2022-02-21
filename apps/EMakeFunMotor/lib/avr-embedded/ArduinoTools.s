	.file "ArduinoTools.pas"
# Begin asmlist al_pure_assembler

.section .text.n_arduinotools_ss_ienable,"ax"
.globl	ARDUINOTOOLS_ss_IENABLE
ARDUINOTOOLS_ss_IENABLE:
# [ArduinoTools.pas]
# [287] asm
#  CPU AVR5
# [291] SEI
	sei
#  CPU AVR5
# [293] end;
	ret
.Le0:
	.size	ARDUINOTOOLS_ss_IENABLE, .Le0 - ARDUINOTOOLS_ss_IENABLE

.section .text.n_arduinotools_ss_idisable,"ax"
.globl	ARDUINOTOOLS_ss_IDISABLE
ARDUINOTOOLS_ss_IDISABLE:
# [296] asm
#  CPU AVR5
# [297] CLI
	cli
#  CPU AVR5
# [298] end;
	ret
.Le1:
	.size	ARDUINOTOOLS_ss_IDISABLE, .Le1 - ARDUINOTOOLS_ss_IDISABLE

.section .text.n_arduinotools_ss_hasienabledssboolean,"ax"
.globl	ARDUINOTOOLS_ss_HASIENABLEDssBOOLEAN
ARDUINOTOOLS_ss_HASIENABLEDssBOOLEAN:
# [301] asm
	push	r29
	push	r28
	in	r28,61
	in	r29,62
	subi	r28,3
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var $result located at r28+2, size=OS_8
#  CPU AVR5
# [304] LDS   R24, 95 {SREG}
	lds	r24,95
# [305] ANDI.R24, 128
	andi	r24,128
# [306] CPSE  R24, R1
	cpse	r24,r1
# [307] LDI   R24, 1
	ldi	r24,1
#  CPU AVR5
# [309] end;
	subi	r28,-3
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
	.size	ARDUINOTOOLS_ss_HASIENABLEDssBOOLEAN, .Le2 - ARDUINOTOOLS_ss_HASIENABLEDssBOOLEAN

.section .text.n_arduinotools_ss_ipause,"ax"
.globl	ARDUINOTOOLS_ss_IPAUSE
ARDUINOTOOLS_ss_IPAUSE:
# [314] asm
#  CPU AVR5
# [317] PUSH.R18     {VIPauseIndex}
	push	r18
# [319] LDS.  R18, VIPauseIndex
	lds	r18,(U_sARDUINOTOOLS_ss_VIPAUSEINDEX)
# [320] CPI.  R18, 0
	cpi	r18,0
# [321] BRNE  goend
	brne	.Lj11
# [323] PUSH.R24     {VIPauseState}
	push	r24
# [324] LDS   R24, 95 {SREG}
	lds	r24,95
# [325] CLI
	cli
# [326] ANDI.R24, 128
	andi	r24,128
# [327] CPSE  R24, R1
	cpse	r24,r1
# [328] LDI   R24, 1
	ldi	r24,1
# [329] STS.  VIPauseState, R24
	sts	(U_sARDUINOTOOLS_ss_VIPAUSESTATE),r24
# [330] POP   R24
	pop	r24
.Lj11:
# [333] INC.  R18
	inc	r18
# [334] STS.  VIPauseIndex, R18
	sts	(U_sARDUINOTOOLS_ss_VIPAUSEINDEX),r18
# [336] POP   R18
	pop	r18
#  CPU AVR5
# [338] end;
	ret
.Le3:
	.size	ARDUINOTOOLS_ss_IPAUSE, .Le3 - ARDUINOTOOLS_ss_IPAUSE

.section .text.n_arduinotools_ss_iresume,"ax"
.globl	ARDUINOTOOLS_ss_IRESUME
ARDUINOTOOLS_ss_IRESUME:
# [343] asm
#  CPU AVR5
# [346] PUSH.R18 {VIPauseIndex}
	push	r18
# [347] LDS.R18, VIPauseIndex
	lds	r18,(U_sARDUINOTOOLS_ss_VIPAUSEINDEX)
# [348] DEC.R18
	dec	r18
# [349] CP  R18, R1
	cp	r18,r1
# [350] BRNE goend
	brne	.Lj14
# [351] PUSH.R24 {VIPauseState}
	push	r24
# [352] LDS.R24, VIPauseIndex
	lds	r24,(U_sARDUINOTOOLS_ss_VIPAUSEINDEX)
# [353] CPSE  R24, R1
	cpse	r24,r1
# [354] SEI
	sei
# [355] POP R24
	pop	r24
.Lj14:
# [357] STS.VIPauseIndex,R18
	sts	(U_sARDUINOTOOLS_ss_VIPAUSEINDEX),r18
# [358] POP R18
	pop	r18
#  CPU AVR5
# [360] end;
	ret
.Le4:
	.size	ARDUINOTOOLS_ss_IRESUME, .Le4 - ARDUINOTOOLS_ss_IRESUME

.section .text.n_arduinotools_ss_nopwait,"ax"
.globl	ARDUINOTOOLS_ss_NOPWAIT
ARDUINOTOOLS_ss_NOPWAIT:
# [381] asm
#  CPU AVR5
# [382] nop
	nop
# [383] nop
	nop
# [384] nop
	nop
# [385] nop
	nop
#  CPU AVR5
# [386] end;
	ret
.Le5:
	.size	ARDUINOTOOLS_ss_NOPWAIT, .Le5 - ARDUINOTOOLS_ss_NOPWAIT

.section .text.n_arduinotools_ss_sbispbytesbyte,"ax"
.globl	ARDUINOTOOLS_ss_SBIsPBYTEsBYTE
ARDUINOTOOLS_ss_SBIsPBYTEsBYTE:
# [524] asm
#  CPU AVR5
# [526] PUSH    R18  {Addr value}                 {1}
	push	r18
# [527] PUSH    R19  {Flag value}                 {1}
	push	r19
# [528] PUSH    R26  {X} {FAST_BIT_TABLE} {AAddr} {1}
	push	r26
# [529] PUSH    R27  {X} {FAST_BIT_TABLE} {AAddr} {1}
	push	r27
# [531] LDI.   R26, LO8(FAST_BIT_TABLE)          {1}
	ldi	r26,lo8(TC_sARDUINOTOOLS_ss_FAST_BIT_TABLE)
# [532] LDI.   R27, HI8(FAST_BIT_TABLE)          {1}
	ldi	r27,hi8(TC_sARDUINOTOOLS_ss_FAST_BIT_TABLE)
# [533] ADD     R26, R22                          {1}
	add	r26,r22
# [534] ADC     R27, R1                           {1}
	adc	r27,r1
# [535] LD      R19, X                            {2}
	ld	r19,x
# [536] MOVW    R26, R24                          {1}
	movw	r26,r24
# [537] LD      R18, X                            {2}
	ld	r18,x
# [538] OR.     R18, R19                          {1}
	or	r18,r19
# [539] ST      X, R18                            {2}
	st	x,r18
# [541] POP     R27                               {1}
	pop	r27
# [542] POP     R26                               {1}
	pop	r26
# [543] POP     R19                               {1}
	pop	r19
# [544] POP     R18                               {1}
	pop	r18
#  CPU AVR5
# [546] end;
	ret
.Le6:
	.size	ARDUINOTOOLS_ss_SBIsPBYTEsBYTE, .Le6 - ARDUINOTOOLS_ss_SBIsPBYTEsBYTE

.section .text.n_arduinotools_ss_cbispbytesbyte,"ax"
.globl	ARDUINOTOOLS_ss_CBIsPBYTEsBYTE
ARDUINOTOOLS_ss_CBIsPBYTEsBYTE:
# [557] asm
#  CPU AVR5
# [559] PUSH    R18  {Addr value}                 {1}
	push	r18
# [560] PUSH    R19  {Flag value}                 {1}
	push	r19
# [561] PUSH    R26  {X} {FAST_BIT_TABLE} {AAddr} {1}
	push	r26
# [562] PUSH    R27  {X} {FAST_BIT_TABLE} {AAddr} {1}
	push	r27
# [564] LDI.   R26, LO8(FAST_BIT_TABLE)          {1}
	ldi	r26,lo8(TC_sARDUINOTOOLS_ss_FAST_BIT_TABLE)
# [565] LDI.   R27, HI8(FAST_BIT_TABLE)          {1}
	ldi	r27,hi8(TC_sARDUINOTOOLS_ss_FAST_BIT_TABLE)
# [566] ADD     R26, R22                          {1}
	add	r26,r22
# [567] ADC     R27, R1                           {1}
	adc	r27,r1
# [568] LD      R19, X                            {2}
	ld	r19,x
# [569] COM     R19                               {1}
	com	r19
# [570] MOVW    R26, R24                          {1}
	movw	r26,r24
# [571] LD      R18, X                            {2}
	ld	r18,x
# [572] AND.   R18, R19                          {1}
	and	r18,r19
# [573] ST      X, R18                            {2}
	st	x,r18
# [575] POP     R27                               {1}
	pop	r27
# [576] POP     R26                               {1}
	pop	r26
# [577] POP     R19                               {1}
	pop	r19
# [578] POP     R18                               {1}
	pop	r18
#  CPU AVR5
# [580] end;
	ret
.Le7:
	.size	ARDUINOTOOLS_ss_CBIsPBYTEsBYTE, .Le7 - ARDUINOTOOLS_ss_CBIsPBYTEsBYTE

.section .text.n_arduinotools_ss_digitalreadsbytessboolean,"ax"
.globl	ARDUINOTOOLS_ss_DIGITALREADsBYTEssBOOLEAN
ARDUINOTOOLS_ss_DIGITALREADsBYTEssBOOLEAN:
# [597] asm
	push	r29
	push	r28
	in	r28,61
	in	r29,62
	subi	r28,3
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var $result located at r28+2, size=OS_8
#  CPU AVR5
# [599] PUSH    R18  {VBitMask}                       {1}
	push	r18
# [600] PUSH    R26  {X}                              {1}
	push	r26
# [601] PUSH    R27  {X}                              {1}
	push	r27
# [602] PUSH    R28  {Y}                              {1}
	push	r28
# [603] PUSH    R29  {Y}                              {1}
	push	r29
# [605] LDI.   R26, LO8(DigitalPinToBitMask)         {1}
	ldi	r26,lo8(TC_sARDUINOTOOLS_ss_DIGITALPINTOBITMASK)
# [606] LDI.   R27, HI8(DigitalPinToBitMask)         {1}
	ldi	r27,hi8(TC_sARDUINOTOOLS_ss_DIGITALPINTOBITMASK)
# [607] ADD     R26, R24                              {1}
	add	r26,r24
# [608] ADC     R27, R1                               {1}
	adc	r27,r1
# [609] LD      R18, X                                {2}
	ld	r18,x
# [611] LDI.   R26, LO8(DigitalPinToPort)            {1}
	ldi	r26,lo8(TC_sARDUINOTOOLS_ss_DIGITALPINTOPORT)
# [612] LDI.   R27, HI8(DigitalPinToPort)            {1}
	ldi	r27,hi8(TC_sARDUINOTOOLS_ss_DIGITALPINTOPORT)
# [613] ADD     R26, R24                              {1}
	add	r26,r24
# [614] ADC     R27, R1                               {1}
	adc	r27,r1
# [615] LD      R24, X                                {2}
	ld	r24,x
# [616] LSL     R24                                   {1}
	lsl	r24
# [618] LDI.   R26, LO8(PortToInput)                 {1}
	ldi	r26,lo8(TC_sARDUINOTOOLS_ss_PORTTOINPUT)
# [619] LDI     R27, HI8(PortToInput)                 {1}
	ldi	r27,hi8(TC_sARDUINOTOOLS_ss_PORTTOINPUT)
# [620] ADD     R26, R24                              {1}
	add	r26,r24
# [621] ADC     R27, R1                               {1}
	adc	r27,r1
# [622] LD      R28, X+                               {2}
	ld	r28,x+
# [623] LD      R29, X                                {2}
	ld	r29,x
# [624] LD      R24, Y                                {2}
	ld	r24,y
# [625] AND     R24, R18                              {1}
	and	r24,r18
# [627] POP     R29                                   {1}
	pop	r29
# [628] POP     R28                                   {1}
	pop	r28
# [629] POP     R27                                   {1}
	pop	r27
# [630] POP     R26                                   {1}
	pop	r26
# [631] POP     R18                                   {1}
	pop	r18
#  CPU AVR5
# [633] end;
	subi	r28,-3
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
	.size	ARDUINOTOOLS_ss_DIGITALREADsBYTEssBOOLEAN, .Le8 - ARDUINOTOOLS_ss_DIGITALREADsBYTEssBOOLEAN

.section .text.n_arduinotools_ss_digitalwritesbytesboolean,"ax"
.globl	ARDUINOTOOLS_ss_DIGITALWRITEsBYTEsBOOLEAN
ARDUINOTOOLS_ss_DIGITALWRITEsBYTEsBOOLEAN:
# [647] asm
#  CPU AVR5
# [649] PUSH    R18  {VBitMask}                       {1}
	push	r18
# [650] PUSH    R26  {X}                              {1}
	push	r26
# [651] PUSH    R27  {X}                              {1}
	push	r27
# [652] PUSH    R28  {Y}                              {1}
	push	r28
# [653] PUSH    R29  {Y}                              {1}
	push	r29
# [655] LDI.   R26, LO8(DigitalPinToBitMask)         {1}
	ldi	r26,lo8(TC_sARDUINOTOOLS_ss_DIGITALPINTOBITMASK)
# [656] LDI.   R27, HI8(DigitalPinToBitMask)         {1}
	ldi	r27,hi8(TC_sARDUINOTOOLS_ss_DIGITALPINTOBITMASK)
# [657] ADD     R26, R24                              {1}
	add	r26,r24
# [658] ADC     R27, R1                               {1}
	adc	r27,r1
# [659] LD      R18, X                                {2}  {VBitMask => R18}
	ld	r18,x
# [661] LDI.   R26, LO8(DigitalPinToPort)            {1}
	ldi	r26,lo8(TC_sARDUINOTOOLS_ss_DIGITALPINTOPORT)
# [662] LDI.   R27, HI8(DigitalPinToPort)            {1}
	ldi	r27,hi8(TC_sARDUINOTOOLS_ss_DIGITALPINTOPORT)
# [663] ADD     R26, R24                              {1}
	add	r26,r24
# [664] ADC     R27, R1                               {1}
	adc	r27,r1
# [665] LD      R24, X                                {2}
	ld	r24,x
# [666] LSL     R24                                   {1}  {VPort => R24}
	lsl	r24
# [668] LDI.   R26, LO8(PortToOutput)                {1}
	ldi	r26,lo8(TC_sARDUINOTOOLS_ss_PORTTOOUTPUT)
# [669] LDI     R27, HI8(PortToOutput)                {1}
	ldi	r27,hi8(TC_sARDUINOTOOLS_ss_PORTTOOUTPUT)
# [670] ADD     R26, R24                              {1}
	add	r26,r24
# [671] ADC     R27, R1                               {1}
	adc	r27,r1
# [672] LD      R28, X+                               {2}
	ld	r28,x+
# [673] LD      R29, X                                {2}  {VPortAddr => R28,R29}
	ld	r29,x
# [674] LD      R24, Y                                {2}  {VPortAddr^ => R24}
	ld	r24,y
# [676] SBRS    r22, 0                                {1|2}
	sbrs	r22,0
# [677] JMP     vfalse                                {4}
	jmp	.Lj94
# [679] OR      R24, R18                              {1}
	or	r24,r18
# [680] JMP     exit                                  {4}
	jmp	.Lj95
.Lj94:
# [684] COM     R18                                   {1}
	com	r18
# [685] AND     R24, R18                              {1}
	and	r24,r18
.Lj95:
# [688] ST      Y, R24                                {2}
	st	y,r24
# [690] POP     R29                                   {1}
	pop	r29
# [691] POP     R28                                   {1}
	pop	r28
# [692] POP     R27                                   {1}
	pop	r27
# [693] POP     R26                                   {1}
	pop	r26
# [694] POP     R18                                   {1}
	pop	r18
#  CPU AVR5
# [696] end;
	ret
.Le9:
	.size	ARDUINOTOOLS_ss_DIGITALWRITEsBYTEsBOOLEAN, .Le9 - ARDUINOTOOLS_ss_DIGITALWRITEsBYTEsBOOLEAN

.section .text.n_arduinotools_ss_sleepmicrosecsslongword,"ax"
.globl	ARDUINOTOOLS_ss_SLEEPMICROSECSsLONGWORD
ARDUINOTOOLS_ss_SLEEPMICROSECSsLONGWORD:
# [720] asm
#  CPU AVR5
# [723] NOP                           // 1
	nop
# [724] NOP                           // 1
	nop
# [725] NOP                           // 1
	nop
# [726] NOP                           // 1
	nop
# [727] NOP                           // 1
	nop
# [728] CPC    R25, R1                // 1
	cpc	r25,r1
# [729] CPC    R24, R1                // 1
	cpc	r24,r1
# [730] CPC    R23, R1                // 1
	cpc	r23,r1
# [731] PUSH   R18                    // 2
	push	r18
# [732] LDI    R18, 3                 // 1
	ldi	r18,3
# [733] CPC    R22, R18               // 1
	cpc	r22,r18
# [734] POP    R18                    // 2
	pop	r18
# [735] BRLO   compl                  // 1|2
	brlo	.Lj100
# [736] SUBI    r22, 2                // 1
	subi	r22,2
# [737] SBCI    r23, 0                // 1
	sbci	r23,0
# [738] SBCI    r24, 0                // 1
	sbci	r24,0
# [739] SBCI    r25, 0                // 1
	sbci	r25,0
.Lj101:
# [743] SUBI    r22, 1                // 1
	subi	r22,1
# [744] SBCI    r23, 0                // 1
	sbci	r23,0
# [745] SBCI    r24, 0                // 1
	sbci	r24,0
# [746] SBCI    r25, 0                // 1
	sbci	r25,0
# [747] CP      R1, R22               // 1
	cp	r1,r22
# [748] CPC     R1, R23               // 1
	cpc	r1,r23
# [749] CPC     R1, R24               // 1
	cpc	r1,r24
# [750] CPC     R1, R25               // 1
	cpc	r1,r25
# [751] BREQ    compl                 // 1|2
	breq	.Lj100
# [752] NOP                           // 1
	nop
# [753] NOP                           // 1
	nop
# [754] NOP                           // 1
	nop
# [755] NOP                           // 1
	nop
# [756] NOP                           // 1
	nop
# [757] RJMP    loop                  // 2
	rjmp	.Lj101
.Lj100:
#  CPU AVR5
# [760] end;
	ret
.Le10:
	.size	ARDUINOTOOLS_ss_SLEEPMICROSECSsLONGWORD, .Le10 - ARDUINOTOOLS_ss_SLEEPMICROSECSsLONGWORD
# End asmlist al_pure_assembler
# Begin asmlist al_procedures

.section .text.n_arduinotools_ss_setpbyteregspbytespbyte,"ax"
.globl	ARDUINOTOOLS_ss_SETPBYTEREGsPBYTEsPBYTE
ARDUINOTOOLS_ss_SETPBYTEREGsPBYTEsPBYTE:
# [363] begin
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
# Var ADest located at r28+2, size=OS_16
# Var ASrc located at r28+4, size=OS_16
	std	Y+2,r24
	std	Y+3,r25
	std	Y+4,r22
	std	Y+5,r23
# [365] ADest := Pbyte(Word(ASrc) and $00FF);
	ldd	r18,Y+4
	ldd	r21,Y+5
	mov	r19,r18
	mov	r21,r1
	ldd	r18,Y+2
	ldd	r20,Y+3
	mov	r30,r18
	mov	r31,r20
	st	Z,r19
	std	Z+1,r21
# [367] end;
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
.Le11:
	.size	ARDUINOTOOLS_ss_SETPBYTEREGsPBYTEsPBYTE, .Le11 - ARDUINOTOOLS_ss_SETPBYTEREGsPBYTEsPBYTE

.section .text.n_arduinotools_ss_settempwordswordsword,"ax"
.globl	ARDUINOTOOLS_ss_SETTEMPWORDsWORDsWORD
ARDUINOTOOLS_ss_SETTEMPWORDsWORDsWORD:
# [375] begin
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
# Var ADest located at r28+2, size=OS_16
# Var ASrc located at r28+4, size=OS_16
	std	Y+2,r24
	std	Y+3,r25
	std	Y+4,r22
	std	Y+5,r23
# [376] TWord(ADest).High := TWord(ASrc).High;
	ldd	r18,Y+2
	ldd	r19,Y+3
	movw	r30,r18
	adiw	r30,1
	ldd	r0,Y+5
	st	Z,r0
# [377] TWord(ADest).Low := TWord(ASrc).Low;
	ldd	r18,Y+2
	ldd	r19,Y+3
	movw	r30,r18
	ldd	r0,Y+4
	st	Z,r0
# [378] end;
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
.Le12:
	.size	ARDUINOTOOLS_ss_SETTEMPWORDsWORDsWORD, .Le12 - ARDUINOTOOLS_ss_SETTEMPWORDsWORDsWORD

.section .text.n_arduinotools_ss_bytemapsarray_of_bytessbyte,"ax"
.globl	ARDUINOTOOLS_ss_BYTEMAPsarray_of_BYTEssBYTE
ARDUINOTOOLS_ss_BYTEMAPsarray_of_BYTEssBYTE:
# [391] begin
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
# Var ABytes located at r28+2, size=OS_16
# Var $highABYTES located at r28+4, size=OS_S16
# Var $result located at r28+6, size=OS_8
# Var i located at r28+7, size=OS_8
	std	Y+2,r24
	std	Y+3,r25
	std	Y+4,r22
	std	Y+5,r23
# [392] Result := 0;
	std	Y+6,r1
# [393] for i := 0 to Length(ABytes) - 1 do
	ldd	r21,Y+4
	ldd	r18,Y+5
	ldi	r19,1
	add	r21,r19
	adc	r18,r1
	subi	r21,1
	sbc	r18,r1
	ldi	r18,-1
	std	Y+7,r18
.Lj23:
	ldd	r18,Y+7
	inc	r18
	std	Y+7,r18
# [394] Result := Result or Byte((1 shl ABytes[i]));
	ldd	r18,Y+2
	ldd	r20,Y+3
	ldd	r23,Y+7
	mov	r19,r1
	ldi	r22,1
	mov	r30,r18
	mov	r31,r20
	add	r30,r23
	adc	r31,r19
	ld	r18,Z
	tst	r18
	breq	.Lj27
.Lj26:
	lsl	r22
	dec	r18
	brne	.Lj26
.Lj27:
	ldd	r18,Y+6
	or	r18,r22
	std	Y+6,r18
	ldd	r18,Y+7
	cp	r18,r21
	brlo	.Lj23
# [395] end;
	ldd	r24,Y+6
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
.Le13:
	.size	ARDUINOTOOLS_ss_BYTEMAPsarray_of_BYTEssBYTE, .Le13 - ARDUINOTOOLS_ss_BYTEMAPsarray_of_BYTEssBYTE

.section .text.n_arduinotools_ss_sassignsshortstringsstintstr,"ax"
.globl	ARDUINOTOOLS_ss_sassignsSHORTSTRINGssTINTSTR
ARDUINOTOOLS_ss_sassignsSHORTSTRINGssTINTSTR:
# [398] begin
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
# Var $result located at r28+4, size=OS_16
	std	Y+4,r24
	std	Y+5,r25
	std	Y+2,r22
	std	Y+3,r23
# [399] Result.Length := Length(AValue);
	ldd	r18,Y+2
	ldd	r19,Y+3
	movw	r30,r18
	ld	r21,Z
	mov	r18,r1
	ldd	r19,Y+4
	ldd	r20,Y+5
	mov	r30,r19
	mov	r31,r20
	std	Z+11,r21
	std	Z+12,r18
# [400] Move(AValue[1], Result.Str[1], Result.Length);
	ldd	r22,Y+4
	ldd	r23,Y+5
	ldd	r19,Y+2
	ldd	r18,Y+3
	ldi	r24,lo8(1)
	ldi	r25,hi8(1)
	add	r24,r19
	adc	r25,r18
	ldd	r18,Y+4
	ldd	r19,Y+5
	movw	r30,r18
	ldd	r20,Z+11
	movw	r30,r18
	ldd	r21,Z+12
	call	SYSTEM_ss_MOVEsformalsformalsSMALLINT
# [401] Result.Str[Result.Length+1] := #0;
	ldd	r20,Y+4
	ldd	r21,Y+5
	ldd	r18,Y+4
	ldd	r19,Y+5
	movw	r30,r18
	ldd	r22,Z+11
	ldd	r19,Z+12
	mov	r18,r1
	movw	r30,r20
	add	r30,r22
	adc	r31,r19
	st	Z,r18
# [402] end;
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
.Le14:
	.size	ARDUINOTOOLS_ss_sassignsSHORTSTRINGssTINTSTR, .Le14 - ARDUINOTOOLS_ss_sassignsSHORTSTRINGssTINTSTR

.section .text.n_arduinotools_ss_sassignstintstrsspchar,"ax"
.globl	ARDUINOTOOLS_ss_sassignsTINTSTRssPCHAR
ARDUINOTOOLS_ss_sassignsTINTSTRssPCHAR:
# [405] begin
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
# Var $result located at r28+4, size=OS_16
	std	Y+2,r24
	std	Y+3,r25
# [406] Result := @AValue.Str[1];
	ldd	r18,Y+2
	ldd	r19,Y+3
	std	Y+4,r18
	std	Y+5,r19
# [407] end;
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
.Le15:
	.size	ARDUINOTOOLS_ss_sassignsTINTSTRssPCHAR, .Le15 - ARDUINOTOOLS_ss_sassignsTINTSTRssPCHAR

.section .text.n_arduinotools_ss_sassignstintstrssshortstring,"ax"
.globl	ARDUINOTOOLS_ss_sassignsTINTSTRssSHORTSTRING
ARDUINOTOOLS_ss_sassignsTINTSTRssSHORTSTRING:
# [410] begin
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
# Var $result located at r28+4, size=OS_16
	std	Y+4,r24
	std	Y+5,r25
	std	Y+2,r22
	std	Y+3,r23
# [411] Result := '';
	ldd	r18,Y+4
	ldd	r19,Y+5
	mov	r20,r1
	movw	r30,r18
	st	Z,r20
# [412] Move(AValue.Str[1], Result[1], AValue.Length + 1);
	ldd	r18,Y+2
	ldd	r19,Y+3
	movw	r30,r18
	ldd	r20,Z+11
	ldd	r21,Z+12
	ldi	r18,1
	add	r20,r18
	adc	r21,r1
	ldd	r18,Y+4
	ldd	r19,Y+5
	ldi	r22,lo8(1)
	ldi	r23,hi8(1)
	add	r22,r18
	adc	r23,r19
	ldd	r24,Y+2
	ldd	r25,Y+3
	call	SYSTEM_ss_MOVEsformalsformalsSMALLINT
# [413] SetLength(Result, AValue.Length)    ;
	ldd	r18,Y+2
	ldd	r19,Y+3
	movw	r30,r18
	ldd	r20,Z+11
	mov	r21,r1
	sbrc	r20,7
	com	r21
	ldd	r24,Y+4
	ldd	r25,Y+5
	ldi	r22,-1
	mov	r23,r1
	call	fpc_shortstr_setlength
# [414] end;
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
.Le16:
	.size	ARDUINOTOOLS_ss_sassignsTINTSTRssSHORTSTRING, .Le16 - ARDUINOTOOLS_ss_sassignsTINTSTRssSHORTSTRING

.section .text.n_arduinotools_ss_setlengthstintstrsbyte,"ax"
ARDUINOTOOLS_ss_SETLENGTHsTINTSTRsBYTE:
# [417] begin
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
# Var AStr located at r28+2, size=OS_16
# Var AValue located at r28+4, size=OS_8
	std	Y+2,r24
	std	Y+3,r25
	std	Y+4,r22
# [418] AStr.Length:=AValue;
	ldd	r18,Y+2
	ldd	r19,Y+3
	ldd	r21,Y+4
	mov	r20,r1
	movw	r30,r18
	std	Z+11,r21
	std	Z+12,r20
# [419] AStr.Str[AStr.Length+1] := #0;
	ldd	r20,Y+2
	ldd	r21,Y+3
	ldd	r19,Y+2
	ldd	r18,Y+3
	mov	r30,r19
	mov	r31,r18
	ldd	r22,Z+11
	ldd	r19,Z+12
	mov	r18,r1
	movw	r30,r20
	add	r30,r22
	adc	r31,r19
	st	Z,r18
# [420] end;
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
.Le17:
	.size	ARDUINOTOOLS_ss_SETLENGTHsTINTSTRsBYTE, .Le17 - ARDUINOTOOLS_ss_SETLENGTHsTINTSTRsBYTE

.section .text.n_arduinotools_ss_inttostrslongintsstintstr,"ax"
.globl	ARDUINOTOOLS_ss_INTTOSTRsLONGINTssTINTSTR
ARDUINOTOOLS_ss_INTTOSTRsLONGINTssTINTSTR:
# Temps allocated between r28+18 and r28+31
# [432] begin
	push	r29
	push	r28
	in	r28,61
	in	r29,62
	subi	r28,31
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var AValue located at r28+2, size=OS_S32
# Var $result located at r28+6, size=OS_16
# Var VHasMinus located at r28+8, size=OS_8
# Var VPow located at r28+9, size=OS_16
# Var n located at r28+11, size=OS_8
# Var p located at r28+12, size=OS_8
# Var c located at r28+13, size=OS_8
# Var VValue located at r28+14, size=OS_S32
	std	Y+6,r24
	std	Y+7,r25
	std	Y+2,r20
	std	Y+3,r21
	std	Y+4,r22
	std	Y+5,r23
# [433] if AValue = 0 then
	ldd	r20,Y+2
	ldd	r21,Y+3
	ldd	r18,Y+4
	ldd	r19,Y+5
	cp	r20,r1
	cpc	r21,r1
	cpc	r18,r1
	cpc	r19,r1
	breq	.Lj65
# [477] end;
	rjmp	.Lj39
.Lj65:
# [434] Result := '0'
	ldi	r19,1
	mov	r18,r1
	std	Y+29,r19
	std	Y+30,r18
	ldi	r22,lo8(18)
	ldi	r23,hi8(18)
	add	r22,r28
	adc	r23,r29
	ldi	r24,lo8(_sARDUINOTOOLSs_Ld3+1)
	ldi	r25,hi8(_sARDUINOTOOLSs_Ld3+1)
	ldd	r20,Y+29
	ldd	r21,Y+30
	call	SYSTEM_ss_MOVEsformalsformalsSMALLINT
	ldd	r19,Y+29
	ldd	r20,Y+30
	mov	r18,r1
	movw	r30,r28
	add	r30,r19
	adc	r31,r20
	adiw	r30,18
	st	Z,r18
	ldd	r18,Y+6
	ldd	r19,Y+7
	movw	r30,r18
	ldd	r0,Y+18
	st	Z+,r0
	ldd	r0,Y+19
	st	Z+,r0
	ldd	r0,Y+20
	st	Z+,r0
	ldd	r0,Y+21
	st	Z+,r0
	ldd	r0,Y+22
	st	Z+,r0
	ldd	r0,Y+23
	st	Z+,r0
	ldd	r0,Y+24
	st	Z+,r0
	ldd	r0,Y+25
	st	Z+,r0
	ldd	r0,Y+26
	st	Z+,r0
	ldd	r0,Y+27
	st	Z+,r0
	ldd	r0,Y+28
	st	Z+,r0
	ldd	r0,Y+29
	st	Z+,r0
	ldd	r0,Y+30
	st	Z,r0
	rjmp	.Lj41
.Lj39:
# [436] if AValue = Low(Longint) then
	ldd	r21,Y+2
	ldd	r20,Y+3
	ldd	r18,Y+4
	ldd	r19,Y+5
	cp	r21,r1
	cpc	r20,r1
	cpc	r18,r1
	ldi	r18,-128
	cpc	r19,r18
	brne	.Lj43
# [438] Result.Length:= 11;
	ldd	r20,Y+6
	ldd	r21,Y+7
	ldi	r19,11
	mov	r18,r1
	movw	r30,r20
	std	Z+11,r19
	std	Z+12,r18
# [439] Move(LOWINTSTR^, Result.Str[1], Result.Length);
	ldd	r22,Y+6
	ldd	r23,Y+7
	lds	r24,(TC_sARDUINOTOOLS_ss_LOWINTSTR)
	lds	r25,(TC_sARDUINOTOOLS_ss_LOWINTSTR+1)
	ldd	r18,Y+6
	ldd	r19,Y+7
	movw	r30,r18
	ldd	r20,Z+11
	movw	r30,r18
	ldd	r21,Z+12
	call	SYSTEM_ss_MOVEsformalsformalsSMALLINT
	rjmp	.Lj41
.Lj43:
# [443] VHasMinus := AValue < 0;
	ldd	r18,Y+2
	ldd	r18,Y+3
	ldd	r18,Y+4
	ldd	r18,Y+5
	cp	r18,r1
	ldi	r18,1
	brlt	.Lj45
	mov	r18,r1
.Lj45:
	std	Y+8,r18
# [444] if VHasMinus then
	ldd	r18,Y+8
	cp	r18,r1
	breq	.Lj47
# [445] VValue := -AValue
	ldd	r18,Y+2
	ldd	r19,Y+3
	ldd	r21,Y+4
	ldd	r20,Y+5
	com	r19
	com	r21
	com	r20
	neg	r18
	sbci	r19,-1
	sbci	r21,-1
	sbci	r20,-1
	std	Y+14,r18
	std	Y+15,r19
	std	Y+16,r21
	std	Y+17,r20
	rjmp	.Lj48
.Lj47:
# [447] VValue := AValue;
	ldd	r0,Y+2
	std	Y+14,r0
	ldd	r0,Y+3
	std	Y+15,r0
	ldd	r0,Y+4
	std	Y+16,r0
	ldd	r0,Y+5
	std	Y+17,r0
.Lj48:
# [448] n := 1;
	ldi	r18,1
	std	Y+11,r18
# [449] VPow := @POWS;
	ldi	r19,lo8(TC_sARDUINOTOOLSs_sINTTOSTRsLONGINTssTINTSTR_ss_POWS)
	ldi	r18,hi8(TC_sARDUINOTOOLSs_sINTTOSTRsLONGINTssTINTSTR_ss_POWS)
	std	Y+9,r19
	std	Y+10,r18
# [450] while (n <= MAX_POW_INDEX) and (VValue >= VPow^) do
	rjmp	.Lj50
.Lj49:
# [452] Inc(VPow);
	ldd	r19,Y+9
	ldd	r20,Y+10
	ldi	r18,4
	add	r19,r18
	adc	r20,r1
	std	Y+9,r19
	std	Y+10,r20
# [453] Inc(n);
	ldd	r18,Y+11
	inc	r18
	std	Y+11,r18
.Lj50:
	ldd	r19,Y+11
	ldi	r18,9
	cp	r18,r19
	brlo	.Lj53
	ldd	r18,Y+9
	ldd	r19,Y+10
	movw	r30,r18
	ld	r22,Z
	ldd	r23,Z+1
	ldd	r24,Z+2
	ldd	r25,Z+3
	ldd	r18,Y+14
	ldd	r19,Y+15
	ldd	r20,Y+16
	ldd	r21,Y+17
	cp	r18,r22
	cpc	r19,r23
	cpc	r20,r24
	cpc	r21,r25
	brge	.Lj49
.Lj53:
# [455] if n <= MAX_POW_INDEX then
	ldd	r19,Y+11
	ldi	r18,9
	cp	r18,r19
	brlo	.Lj56
# [457] Dec(VPow);
	ldd	r19,Y+9
	ldd	r18,Y+10
	subi	r19,4
	sbc	r18,r1
	std	Y+9,r19
	std	Y+10,r18
# [458] Dec(n);
	ldd	r18,Y+11
	dec	r18
	std	Y+11,r18
.Lj56:
# [460] n := n + Byte(VHasMinus);
	ldd	r19,Y+11
	ldd	r18,Y+8
	add	r18,r19
	std	Y+11,r18
# [461] SetLength(Result, n);
	ldd	r24,Y+6
	ldd	r25,Y+7
	ldd	r22,Y+11
	call	ARDUINOTOOLS_ss_SETLENGTHsTINTSTRsBYTE
# [462] p := 1 + Byte(VHasMinus);
	ldd	r18,Y+8
	inc	r18
	std	Y+12,r18
# [463] if VHasMinus then
	ldd	r18,Y+8
	cp	r18,r1
	breq	.Lj59
# [464] Result.Str[1] := '-';
	ldd	r19,Y+6
	ldd	r20,Y+7
	ldi	r18,45
	mov	r30,r19
	mov	r31,r20
	st	Z,r18
.Lj59:
# [466] c := 0;
	std	Y+13,r1
# [467] while VValue >= VPow^ do
	rjmp	.Lj63
.Lj62:
# [469] Inc(c);
	ldd	r18,Y+13
	inc	r18
	std	Y+13,r18
# [470] Dec(VValue, VPow^);
	ldd	r18,Y+9
	ldd	r19,Y+10
	movw	r30,r18
	ld	r18,Z
	ldd	r19,Z+1
	ldd	r20,Z+2
	ldd	r25,Z+3
	ldd	r21,Y+14
	ldd	r22,Y+15
	ldd	r23,Y+16
	ldd	r24,Y+17
	sub	r21,r18
	sbc	r22,r19
	sbc	r23,r20
	sbc	r24,r25
	std	Y+14,r21
	std	Y+15,r22
	std	Y+16,r23
	std	Y+17,r24
.Lj63:
	ldd	r18,Y+9
	ldd	r19,Y+10
	movw	r30,r18
	ld	r21,Z
	ldd	r22,Z+1
	ldd	r23,Z+2
	ldd	r25,Z+3
	ldd	r24,Y+14
	ldd	r19,Y+15
	ldd	r18,Y+16
	ldd	r20,Y+17
	cp	r24,r21
	cpc	r19,r22
	cpc	r18,r23
	cpc	r20,r25
	brlt	.Lj66
	rjmp	.Lj62
.Lj66:
# [472] Dec(VPow);
	ldd	r18,Y+9
	ldd	r19,Y+10
	subi	r18,4
	sbc	r19,r1
	std	Y+9,r18
	std	Y+10,r19
# [473] Result.Str[p] := Char(c + 48);
	ldd	r21,Y+6
	ldd	r22,Y+7
	ldd	r23,Y+12
	mov	r18,r1
	ldd	r19,Y+13
	ldi	r20,48
	add	r19,r20
	mov	r30,r21
	mov	r31,r22
	add	r30,r23
	adc	r31,r18
	sbiw	r30,1
	st	Z,r19
# [474] Inc(p);
	ldd	r18,Y+12
	inc	r18
	std	Y+12,r18
# [475] until p > n;
	ldd	r18,Y+12
	ldd	r19,Y+11
	cp	r19,r18
	brlo	.Lj67
	rjmp	.Lj59
.Lj67:
.Lj41:
	subi	r28,-31
	sbci	r29,-1
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
	pop	r28
	pop	r29
	ret
.Le18:
	.size	ARDUINOTOOLS_ss_INTTOSTRsLONGINTssTINTSTR, .Le18 - ARDUINOTOOLS_ss_INTTOSTRsLONGINTssTINTSTR

.section .text.n_arduinotools_ss_inttohexslongintsbytesstintstr,"ax"
.globl	ARDUINOTOOLS_ss_INTTOHEXsLONGINTsBYTEssTINTSTR
ARDUINOTOOLS_ss_INTTOHEXsLONGINTsBYTEssTINTSTR:
# Temps allocated between r28+23 and r28+25
# [482] begin
	push	r29
	push	r28
	in	r28,61
	in	r29,62
	subi	r28,25
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var AValue located at r28+2, size=OS_S32
# Var ADigits located at r28+6, size=OS_8
# Var $result located at r28+7, size=OS_16
# Var i located at r28+9, size=OS_8
# Var $_zero_$ARDUINOTOOLS_$$_TINTSTR located at r28+10, size=OS_NO
	std	Y+7,r24
	std	Y+8,r25
	std	Y+2,r20
	std	Y+3,r21
	std	Y+4,r22
	std	Y+5,r23
	std	Y+6,r18
# [480] var
	ldi	r18,lo8(10)
	ldi	r19,hi8(10)
	add	r18,r28
	adc	r19,r29
	std	Y+23,r18
	std	Y+24,r19
	ldd	r24,Y+23
	ldd	r25,Y+24
	mov	r20,r1
	ldi	r22,13
	mov	r23,r1
	call	SYSTEM_ss_FILLCHARsformalsSMALLINTsBYTE
# [483] Result := Default(TIntStr);
	ldd	r18,Y+7
	ldd	r19,Y+8
	movw	r30,r18
	ldd	r0,Y+10
	st	Z+,r0
	ldd	r0,Y+11
	st	Z+,r0
	ldd	r0,Y+12
	st	Z+,r0
	ldd	r0,Y+13
	st	Z+,r0
	ldd	r0,Y+14
	st	Z+,r0
	ldd	r0,Y+15
	st	Z+,r0
	ldd	r0,Y+16
	st	Z+,r0
	ldd	r0,Y+17
	st	Z+,r0
	ldd	r0,Y+18
	st	Z+,r0
	ldd	r0,Y+19
	st	Z+,r0
	ldd	r0,Y+20
	st	Z+,r0
	ldd	r0,Y+21
	st	Z+,r0
	ldd	r0,Y+22
	st	Z,r0
# [484] SetLength(Result, ADigits);
	ldd	r24,Y+7
	ldd	r25,Y+8
	ldd	r22,Y+6
	call	ARDUINOTOOLS_ss_SETLENGTHsTINTSTRsBYTE
# [485] for i := 1 to ADigits do
	ldd	r18,Y+6
	cpi	r18,1
	brsh	.Lj76
# [490] end;
	rjmp	.Lj71
.Lj76:
	std	Y+9,r1
.Lj72:
	ldd	r18,Y+9
	inc	r18
	std	Y+9,r18
# [487] Result.Str[ADigits - i + 1] := HexChars[Byte(AValue and $0000000F)];
	ldd	r22,Y+7
	ldd	r23,Y+8
	ldd	r20,Y+6
	mov	r19,r1
	ldd	r21,Y+9
	mov	r18,r1
	sub	r20,r21
	sbc	r19,r18
	ldd	r21,Y+2
	andi	r21,15
	mov	r18,r1
	ldi	r30,lo8(TC_sARDUINOTOOLS_ss_HEXCHARS)
	ldi	r31,hi8(TC_sARDUINOTOOLS_ss_HEXCHARS)
	add	r30,r21
	adc	r31,r18
	add	r22,r20
	adc	r23,r19
	movw	r26,r22
	ld	r0,Z
	st	X,r0
# [488] AValue := AValue shr 4;
	ldd	r18,Y+2
	ldd	r19,Y+3
	ldd	r20,Y+4
	ldd	r21,Y+5
	ldi	r22,4
.Lj75:
	lsr	r21
	ror	r20
	ror	r19
	ror	r18
	dec	r22
	brne	.Lj75
	std	Y+2,r18
	std	Y+3,r19
	std	Y+4,r20
	std	Y+5,r21
	ldd	r18,Y+9
	ldd	r19,Y+6
	cp	r18,r19
	brsh	.Lj77
	rjmp	.Lj72
.Lj77:
.Lj71:
	subi	r28,-25
	sbci	r29,-1
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
	pop	r28
	pop	r29
	ret
.Le19:
	.size	ARDUINOTOOLS_ss_INTTOHEXsLONGINTsBYTEssTINTSTR, .Le19 - ARDUINOTOOLS_ss_INTTOHEXsLONGINTsBYTEssTINTSTR

.section .text.n_arduinotools_ss_inttohexspointersstintstr,"ax"
.globl	ARDUINOTOOLS_ss_INTTOHEXsPOINTERssTINTSTR
ARDUINOTOOLS_ss_INTTOHEXsPOINTERssTINTSTR:
# [493] begin
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
# Var $result located at r28+4, size=OS_16
	std	Y+4,r24
	std	Y+5,r25
	std	Y+2,r22
	std	Y+3,r23
# [494] Result := IntToHex(UIntPtr(AValue), 4);
	ldd	r18,Y+2
	ldd	r21,Y+3
	mov	r22,r1
	mov	r23,r1
	mov	r20,r18
	ldd	r24,Y+4
	ldd	r25,Y+5
	ldi	r26,4
	mov	r18,r26
	call	ARDUINOTOOLS_ss_INTTOHEXsLONGINTsBYTEssTINTSTR
# [495] end;
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
.Le20:
	.size	ARDUINOTOOLS_ss_INTTOHEXsPOINTERssTINTSTR, .Le20 - ARDUINOTOOLS_ss_INTTOHEXsPOINTERssTINTSTR

.section .text.n_arduinotools_ss_pinmodesbytestavrpinmode,"ax"
.globl	ARDUINOTOOLS_ss_PINMODEsBYTEsTAVRPINMODE
ARDUINOTOOLS_ss_PINMODEsBYTEsTAVRPINMODE:
# [501] begin
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
# Var APin located at r28+2, size=OS_8
# Var AMode located at r28+3, size=OS_8
# Var VPort located at r28+4, size=OS_8
# Var VBitMask located at r28+5, size=OS_8
	std	Y+2,r24
	std	Y+3,r22
# [502] VPort := DigitalPinToPort[APin];
	ldd	r19,Y+2
	mov	r18,r1
	ldi	r30,lo8(TC_sARDUINOTOOLS_ss_DIGITALPINTOPORT)
	ldi	r31,hi8(TC_sARDUINOTOOLS_ss_DIGITALPINTOPORT)
	add	r30,r19
	adc	r31,r18
	ld	r0,Z
	std	Y+4,r0
# [503] VBitMask := DigitalPinToBitMask[APin];
	ldd	r19,Y+2
	mov	r18,r1
	ldi	r30,lo8(TC_sARDUINOTOOLS_ss_DIGITALPINTOBITMASK)
	ldi	r31,hi8(TC_sARDUINOTOOLS_ss_DIGITALPINTOBITMASK)
	add	r30,r19
	adc	r31,r18
	ld	r0,Z
	std	Y+5,r0
# [504] case AMode of
	ldd	r18,Y+3
	cp	r18,r1
	breq	.Lj83
	mov	r19,r18
	dec	r18
	cpi	r19,1
	brne	.Lj85
# [513] end;
	rjmp	.Lj84
.Lj85:
	rjmp	.Lj82
.Lj83:
# [506] PortToMode[VPort]^ := PortToMode[VPort]^ or VBitMask;
	ldd	r19,Y+4
	mov	r18,r1
	lsl	r19
	rol	r18
	ldi	r30,lo8(TC_sARDUINOTOOLS_ss_PORTTOMODE)
	ldi	r31,hi8(TC_sARDUINOTOOLS_ss_PORTTOMODE)
	add	r30,r19
	adc	r31,r18
	ld	r18,Z+
	ld	r19,Z
	movw	r30,r18
	ld	r18,Z
	ldd	r19,Y+5
	or	r19,r18
	ldd	r20,Y+4
	mov	r18,r1
	lsl	r20
	rol	r18
	ldi	r30,lo8(TC_sARDUINOTOOLS_ss_PORTTOMODE)
	ldi	r31,hi8(TC_sARDUINOTOOLS_ss_PORTTOMODE)
	add	r30,r20
	adc	r31,r18
	ld	r18,Z+
	ld	r20,Z
	mov	r30,r18
	mov	r31,r20
	st	Z,r19
	rjmp	.Lj82
.Lj84:
# [509] PortToMode[VPort]^ := PortToMode[VPort]^ and not VBitMask;
	ldd	r19,Y+4
	mov	r18,r1
	lsl	r19
	rol	r18
	ldi	r30,lo8(TC_sARDUINOTOOLS_ss_PORTTOMODE)
	ldi	r31,hi8(TC_sARDUINOTOOLS_ss_PORTTOMODE)
	add	r30,r19
	adc	r31,r18
	ld	r18,Z+
	ld	r20,Z
	ldd	r19,Y+5
	com	r19
	mov	r30,r18
	mov	r31,r20
	ld	r18,Z
	and	r19,r18
	ldd	r20,Y+4
	mov	r18,r1
	lsl	r20
	rol	r18
	ldi	r30,lo8(TC_sARDUINOTOOLS_ss_PORTTOMODE)
	ldi	r31,hi8(TC_sARDUINOTOOLS_ss_PORTTOMODE)
	add	r30,r20
	adc	r31,r18
	ld	r18,Z+
	ld	r20,Z
	mov	r30,r18
	mov	r31,r20
	st	Z,r19
# [510] PortToOutput[VPort]^ := PortToOutput[VPort]^ and not VBitMask;
	ldd	r19,Y+4
	mov	r18,r1
	lsl	r19
	rol	r18
	ldi	r30,lo8(TC_sARDUINOTOOLS_ss_PORTTOOUTPUT)
	ldi	r31,hi8(TC_sARDUINOTOOLS_ss_PORTTOOUTPUT)
	add	r30,r19
	adc	r31,r18
	ld	r18,Z+
	ld	r20,Z
	ldd	r19,Y+5
	com	r19
	mov	r30,r18
	mov	r31,r20
	ld	r18,Z
	and	r19,r18
	ldd	r20,Y+4
	mov	r18,r1
	lsl	r20
	rol	r18
	ldi	r30,lo8(TC_sARDUINOTOOLS_ss_PORTTOOUTPUT)
	ldi	r31,hi8(TC_sARDUINOTOOLS_ss_PORTTOOUTPUT)
	add	r30,r20
	adc	r31,r18
	ld	r18,Z+
	ld	r20,Z
	mov	r30,r18
	mov	r31,r20
	st	Z,r19
.Lj82:
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
.Le21:
	.size	ARDUINOTOOLS_ss_PINMODEsBYTEsTAVRPINMODE, .Le21 - ARDUINOTOOLS_ss_PINMODEsBYTEsTAVRPINMODE

.section .text.n_arduinotools_ss_adcinit,"ax"
.globl	ARDUINOTOOLS_ss_ADCINIT
ARDUINOTOOLS_ss_ADCINIT:
# [702] begin
# [705] ADMUX := (1 shl REFS) or (Port and $0F);
	ldi	r18,64
	sts	(124),r18
# [706] ADCSRA := %111 or (1 shl ADEN) or (1 shl ADSC) or (1 shl ADIE);
	ldi	r18,-49
	sts	(122),r18
# [708] end;
	ret
.Le22:
	.size	ARDUINOTOOLS_ss_ADCINIT, .Le22 - ARDUINOTOOLS_ss_ADCINIT

.section .text.n_arduinotoolss_stcustompininput_s__ss_initsbytesslongbool,"ax"
.globl	ARDUINOTOOLSs_sTCUSTOMPININPUT_s__ss_INITsBYTEssLONGBOOL
ARDUINOTOOLSs_sTCUSTOMPININPUT_s__ss_INITsBYTEssLONGBOOL:
# Temps allocated between r28+7 and r28+67
# [766] begin
	push	r29
	push	r28
	push	r2
	in	r28,61
	in	r29,62
	subi	r28,67
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var APin located at r28+2, size=OS_8
# Var $vmt located at r28+3, size=OS_16
# Var $self located at r28+5, size=OS_16
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
	brne	.Lj115
# [769] end;
	rjmp	.Lj102
.Lj115:
	ldi	r20,lo8(7)
	ldi	r21,hi8(7)
	add	r20,r28
	adc	r21,r29
	ldi	r22,lo8(13)
	ldi	r23,hi8(13)
	add	r22,r28
	adc	r23,r29
	ldi	r24,1
	mov	r25,r1
	call	fpc_pushexceptaddr
	call	fpc_setjmp
	std	Y+36,r24
	cp	r24,r1
	brne	.Lj110
# [767] inherited;
	ldd	r24,Y+5
	ldd	r25,Y+6
	ldd	r20,Y+2
	mov	r22,r1
	mov	r23,r1
	call	ARDUINOTOOLSs_sTCUSTOMPINED_s__ss_INITsBYTEssLONGBOOL
# [768] PinMode(Pin, avrmInput);
	ldd	r18,Y+5
	ldd	r19,Y+6
	movw	r30,r18
	ld	r24,Z
	ldi	r26,1
	mov	r22,r26
	call	ARDUINOTOOLS_ss_PINMODEsBYTEsTAVRPINMODE
.Lj110:
	call	fpc_popaddrstack
	ldd	r18,Y+36
	cp	r18,r1
	brne	.Lj116
	rjmp	.Lj108
.Lj116:
	ldi	r20,lo8(37)
	ldi	r21,hi8(37)
	add	r20,r28
	adc	r21,r29
	ldi	r22,lo8(43)
	ldi	r23,hi8(43)
	add	r22,r28
	adc	r23,r29
	ldi	r24,1
	mov	r25,r1
	call	fpc_pushexceptaddr
	call	fpc_setjmp
	ldi	r30,lo8(66)
	ldi	r31,hi8(66)
	add	r30,r28
	adc	r31,r29
	st	Z,r24
	cp	r24,r1
	brne	.Lj111
	ldd	r19,Y+3
	ldd	r18,Y+4
	cp	r19,r1
	cpc	r18,r1
	breq	.Lj113
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
.Lj113:
	call	fpc_popaddrstack
	call	fpc_reraise
.Lj111:
	call	fpc_popaddrstack
	ldi	r30,lo8(66)
	ldi	r31,hi8(66)
	add	r30,r28
	adc	r31,r29
	ld	r18,Z
	cp	r18,r1
	breq	.Lj114
	call	fpc_raise_nested
.Lj114:
	call	fpc_doneexception
.Lj108:
.Lj102:
	ldd	r24,Y+5
	ldd	r25,Y+6
	subi	r28,-67
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
.Le23:
	.size	ARDUINOTOOLSs_sTCUSTOMPININPUT_s__ss_INITsBYTEssLONGBOOL, .Le23 - ARDUINOTOOLSs_sTCUSTOMPININPUT_s__ss_INITsBYTEssLONGBOOL

.section .text.n_arduinotoolss_stcustompined_s__ss_getdigitalvaluessboolean,"ax"
.globl	ARDUINOTOOLSs_sTCUSTOMPINED_s__ss_GETDIGITALVALUEssBOOLEAN
ARDUINOTOOLSs_sTCUSTOMPINED_s__ss_GETDIGITALVALUEssBOOLEAN:
# [774] begin
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
# [775] Result := DigitalRead(Pin);
	ldd	r18,Y+2
	ldd	r19,Y+3
	movw	r30,r18
	ld	r24,Z
	call	ARDUINOTOOLS_ss_DIGITALREADsBYTEssBOOLEAN
	std	Y+4,r24
# [776] end;
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
	.size	ARDUINOTOOLSs_sTCUSTOMPINED_s__ss_GETDIGITALVALUEssBOOLEAN, .Le24 - ARDUINOTOOLSs_sTCUSTOMPINED_s__ss_GETDIGITALVALUEssBOOLEAN

.section .text.n_arduinotoolss_stcustompined_s__ss_setdigitalvaluesboolean,"ax"
.globl	ARDUINOTOOLSs_sTCUSTOMPINED_s__ss_SETDIGITALVALUEsBOOLEAN
ARDUINOTOOLSs_sTCUSTOMPINED_s__ss_SETDIGITALVALUEsBOOLEAN:
# [779] begin
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
# [780] DigitalWrite(Pin, AValue);
	ldd	r18,Y+3
	ldd	r19,Y+4
	movw	r30,r18
	ld	r24,Z
	ldd	r22,Y+2
	call	ARDUINOTOOLS_ss_DIGITALWRITEsBYTEsBOOLEAN
# [781] end;
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
	.size	ARDUINOTOOLSs_sTCUSTOMPINED_s__ss_SETDIGITALVALUEsBOOLEAN, .Le25 - ARDUINOTOOLSs_sTCUSTOMPINED_s__ss_SETDIGITALVALUEsBOOLEAN

.section .text.n_arduinotoolss_stcustompined_s__ss_initsbytesslongbool,"ax"
.globl	ARDUINOTOOLSs_sTCUSTOMPINED_s__ss_INITsBYTEssLONGBOOL
ARDUINOTOOLSs_sTCUSTOMPINED_s__ss_INITsBYTEssLONGBOOL:
# Temps allocated between r28+7 and r28+67
# [784] begin
	push	r29
	push	r28
	push	r2
	in	r28,61
	in	r29,62
	subi	r28,67
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var APin located at r28+2, size=OS_8
# Var $vmt located at r28+3, size=OS_16
# Var $self located at r28+5, size=OS_16
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
	brne	.Lj134
# [786] end;
	rjmp	.Lj121
.Lj134:
	ldi	r20,lo8(7)
	ldi	r21,hi8(7)
	add	r20,r28
	adc	r21,r29
	ldi	r22,lo8(13)
	ldi	r23,hi8(13)
	add	r22,r28
	adc	r23,r29
	ldi	r24,1
	mov	r25,r1
	call	fpc_pushexceptaddr
	call	fpc_setjmp
	std	Y+36,r24
	cp	r24,r1
	brne	.Lj129
# [785] FPin := APin;
	ldd	r18,Y+5
	ldd	r19,Y+6
	movw	r30,r18
	ldd	r0,Y+2
	st	Z,r0
.Lj129:
	call	fpc_popaddrstack
	ldd	r18,Y+36
	cp	r18,r1
	brne	.Lj135
	rjmp	.Lj127
.Lj135:
	ldi	r20,lo8(37)
	ldi	r21,hi8(37)
	add	r20,r28
	adc	r21,r29
	ldi	r22,lo8(43)
	ldi	r23,hi8(43)
	add	r22,r28
	adc	r23,r29
	ldi	r24,1
	mov	r25,r1
	call	fpc_pushexceptaddr
	call	fpc_setjmp
	ldi	r30,lo8(66)
	ldi	r31,hi8(66)
	add	r30,r28
	adc	r31,r29
	st	Z,r24
	cp	r24,r1
	brne	.Lj130
	ldd	r19,Y+3
	ldd	r18,Y+4
	cp	r19,r1
	cpc	r18,r1
	breq	.Lj132
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
.Lj132:
	call	fpc_popaddrstack
	call	fpc_reraise
.Lj130:
	call	fpc_popaddrstack
	ldi	r30,lo8(66)
	ldi	r31,hi8(66)
	add	r30,r28
	adc	r31,r29
	ld	r18,Z
	cp	r18,r1
	breq	.Lj133
	call	fpc_raise_nested
.Lj133:
	call	fpc_doneexception
.Lj127:
.Lj121:
	ldd	r24,Y+5
	ldd	r25,Y+6
	subi	r28,-67
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
.Le26:
	.size	ARDUINOTOOLSs_sTCUSTOMPINED_s__ss_INITsBYTEssLONGBOOL, .Le26 - ARDUINOTOOLSs_sTCUSTOMPINED_s__ss_INITsBYTEssLONGBOOL

.section .text.n_arduinotoolss_stcustompined_s__ss_deinit,"ax"
.globl	ARDUINOTOOLSs_sTCUSTOMPINED_s__ss_DEINIT
ARDUINOTOOLSs_sTCUSTOMPINED_s__ss_DEINIT:
# [789] begin
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
# Var $vmt located at r28+2, size=OS_16
# Var $self located at r28+4, size=OS_16
	std	Y+4,r24
	std	Y+5,r25
	std	Y+2,r22
	std	Y+3,r23
# [790] FPin := 0;
	ldd	r18,Y+4
	ldd	r19,Y+5
	mov	r20,r1
	movw	r30,r18
	st	Z,r20
# [791] end;
	ldd	r24,Y+4
	ldd	r25,Y+5
	ldi	r18,2
	mov	r19,r1
	mov	r20,r1
	mov	r21,r1
	ldd	r22,Y+2
	ldd	r23,Y+3
	call	fpc_help_destructor
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
.Le27:
	.size	ARDUINOTOOLSs_sTCUSTOMPINED_s__ss_DEINIT, .Le27 - ARDUINOTOOLSs_sTCUSTOMPINED_s__ss_DEINIT

.section .text.n_arduinotoolss_stcustompinoutput_s__ss_initsbytesslongbool,"ax"
.globl	ARDUINOTOOLSs_sTCUSTOMPINOUTPUT_s__ss_INITsBYTEssLONGBOOL
ARDUINOTOOLSs_sTCUSTOMPINOUTPUT_s__ss_INITsBYTEssLONGBOOL:
# Temps allocated between r28+7 and r28+67
# [796] begin
	push	r29
	push	r28
	push	r2
	in	r28,61
	in	r29,62
	subi	r28,67
	sbci	r29,0
	in	r0,63
	cli
	out	62,r29
	out	63,r0
	out	61,r28
# Var APin located at r28+2, size=OS_8
# Var $vmt located at r28+3, size=OS_16
# Var $self located at r28+5, size=OS_16
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
	brne	.Lj151
# [799] end;
	rjmp	.Lj138
.Lj151:
	ldi	r20,lo8(7)
	ldi	r21,hi8(7)
	add	r20,r28
	adc	r21,r29
	ldi	r22,lo8(13)
	ldi	r23,hi8(13)
	add	r22,r28
	adc	r23,r29
	ldi	r24,1
	mov	r25,r1
	call	fpc_pushexceptaddr
	call	fpc_setjmp
	std	Y+36,r24
	cp	r24,r1
	brne	.Lj146
# [797] inherited;
	ldd	r24,Y+5
	ldd	r25,Y+6
	ldd	r20,Y+2
	mov	r22,r1
	mov	r23,r1
	call	ARDUINOTOOLSs_sTCUSTOMPINED_s__ss_INITsBYTEssLONGBOOL
# [798] PinMode(Pin, avrmOutput);
	ldd	r18,Y+5
	ldd	r19,Y+6
	movw	r30,r18
	ld	r24,Z
	mov	r22,r1
	call	ARDUINOTOOLS_ss_PINMODEsBYTEsTAVRPINMODE
.Lj146:
	call	fpc_popaddrstack
	ldd	r18,Y+36
	cp	r18,r1
	brne	.Lj152
	rjmp	.Lj144
.Lj152:
	ldi	r20,lo8(37)
	ldi	r21,hi8(37)
	add	r20,r28
	adc	r21,r29
	ldi	r22,lo8(43)
	ldi	r23,hi8(43)
	add	r22,r28
	adc	r23,r29
	ldi	r24,1
	mov	r25,r1
	call	fpc_pushexceptaddr
	call	fpc_setjmp
	ldi	r30,lo8(66)
	ldi	r31,hi8(66)
	add	r30,r28
	adc	r31,r29
	st	Z,r24
	cp	r24,r1
	brne	.Lj147
	ldd	r19,Y+3
	ldd	r18,Y+4
	cp	r19,r1
	cpc	r18,r1
	breq	.Lj149
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
.Lj149:
	call	fpc_popaddrstack
	call	fpc_reraise
.Lj147:
	call	fpc_popaddrstack
	ldi	r30,lo8(66)
	ldi	r31,hi8(66)
	add	r30,r28
	adc	r31,r29
	ld	r18,Z
	cp	r18,r1
	breq	.Lj150
	call	fpc_raise_nested
.Lj150:
	call	fpc_doneexception
.Lj144:
.Lj138:
	ldd	r24,Y+5
	ldd	r25,Y+6
	subi	r28,-67
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
.Le28:
	.size	ARDUINOTOOLSs_sTCUSTOMPINOUTPUT_s__ss_INITsBYTEssLONGBOOL, .Le28 - ARDUINOTOOLSs_sTCUSTOMPINOUTPUT_s__ss_INITsBYTEssLONGBOOL
# End asmlist al_procedures
# Begin asmlist al_globals

.section .bss.n_u_sarduinotools_ss_vipauseindex,"aw",%nobits
# [275] VIPauseIndex: Byte;
	.globl U_sARDUINOTOOLS_ss_VIPAUSEINDEX
	.size U_sARDUINOTOOLS_ss_VIPAUSEINDEX,1
U_sARDUINOTOOLS_ss_VIPAUSEINDEX:
	.zero 1

.section .bss.n_u_sarduinotools_ss_vipausestate,"aw",%nobits
# [276] VIPauseState: Boolean;
	.globl U_sARDUINOTOOLS_ss_VIPAUSESTATE
	.size U_sARDUINOTOOLS_ss_VIPAUSESTATE,1
U_sARDUINOTOOLS_ss_VIPAUSESTATE:
	.zero 1

.section .data.n_VMT_sARDUINOTOOLS_ss_TCUSTOMPINED
	.balign 2
.globl	VMT_sARDUINOTOOLS_ss_TCUSTOMPINED
VMT_sARDUINOTOOLS_ss_TCUSTOMPINED:
	.short	4,65532,0
	.short	gs(ARDUINOTOOLSs_sTCUSTOMPINED_s__ss_DEINIT)
	.short	gs(0)
# [801] end.
.Le29:
	.size	VMT_sARDUINOTOOLS_ss_TCUSTOMPINED, .Le29 - VMT_sARDUINOTOOLS_ss_TCUSTOMPINED

.section .data.n_VMT_sARDUINOTOOLS_ss_TCUSTOMPINOUTPUT
	.balign 2
.globl	VMT_sARDUINOTOOLS_ss_TCUSTOMPINOUTPUT
VMT_sARDUINOTOOLS_ss_TCUSTOMPINOUTPUT:
	.short	4,65532
	.short	VMT_sARDUINOTOOLS_ss_TCUSTOMPINEDsindirect
	.short	gs(ARDUINOTOOLSs_sTCUSTOMPINED_s__ss_DEINIT)
	.short	gs(0)
.Le30:
	.size	VMT_sARDUINOTOOLS_ss_TCUSTOMPINOUTPUT, .Le30 - VMT_sARDUINOTOOLS_ss_TCUSTOMPINOUTPUT

.section .data.n_VMT_sARDUINOTOOLS_ss_TCUSTOMPININPUT
	.balign 2
.globl	VMT_sARDUINOTOOLS_ss_TCUSTOMPININPUT
VMT_sARDUINOTOOLS_ss_TCUSTOMPININPUT:
	.short	4,65532
	.short	VMT_sARDUINOTOOLS_ss_TCUSTOMPINEDsindirect
	.short	gs(ARDUINOTOOLSs_sTCUSTOMPINED_s__ss_DEINIT)
	.short	gs(0)
.Le31:
	.size	VMT_sARDUINOTOOLS_ss_TCUSTOMPININPUT, .Le31 - VMT_sARDUINOTOOLS_ss_TCUSTOMPININPUT
# End asmlist al_globals
# Begin asmlist al_const

.section .rodata.n_.Ld1
.Ld1:
# [284] LOWINTSTR: PChar = '-2147483648';
	.ascii	"-2147483648\000"
.Le32:
	.size	.Ld1, .Le32 - .Ld1
# End asmlist al_const
# Begin asmlist al_typedconsts

.section .data.n_TC_sARDUINOTOOLS_ss_HEXCHARS
.globl	TC_sARDUINOTOOLS_ss_HEXCHARS
TC_sARDUINOTOOLS_ss_HEXCHARS:
	.byte	48,49,50,51,52,53,54,55,56,57,65,66,67,68,69,70
# [41] const
.Le33:
	.size	TC_sARDUINOTOOLS_ss_HEXCHARS, .Le33 - TC_sARDUINOTOOLS_ss_HEXCHARS

.section .data.n_TC_sARDUINOTOOLS_ss_PORTTOMODE
.globl	TC_sARDUINOTOOLS_ss_PORTTOMODE
TC_sARDUINOTOOLS_ss_PORTTOMODE:
	.short	0,0,36,39,42,0,0,0,0,0,0,0,0
# [97] PortToOutput: array[TAVRPort] of Pbyte = (
.Le34:
	.size	TC_sARDUINOTOOLS_ss_PORTTOMODE, .Le34 - TC_sARDUINOTOOLS_ss_PORTTOMODE

.section .data.n_TC_sARDUINOTOOLS_ss_PORTTOOUTPUT
.globl	TC_sARDUINOTOOLS_ss_PORTTOOUTPUT
TC_sARDUINOTOOLS_ss_PORTTOOUTPUT:
	.short	0,0,37,40,43,0,0,0,0,0,0,0,0
# [114] PortToInput: array[TAVRPort] of Pbyte = (
.Le35:
	.size	TC_sARDUINOTOOLS_ss_PORTTOOUTPUT, .Le35 - TC_sARDUINOTOOLS_ss_PORTTOOUTPUT

.section .data.n_TC_sARDUINOTOOLS_ss_PORTTOINPUT
.globl	TC_sARDUINOTOOLS_ss_PORTTOINPUT
TC_sARDUINOTOOLS_ss_PORTTOINPUT:
	.short	0,0,35,38,41,0,0,0,0,0,0,0,0
# [131] DigitalPinToPort: array[0..19] of TAVRPort = (
.Le36:
	.size	TC_sARDUINOTOOLS_ss_PORTTOINPUT, .Le36 - TC_sARDUINOTOOLS_ss_PORTTOINPUT

.section .data.n_TC_sARDUINOTOOLS_ss_DIGITALPINTOPORT
.globl	TC_sARDUINOTOOLS_ss_DIGITALPINTOPORT
TC_sARDUINOTOOLS_ss_DIGITALPINTOPORT:
	.byte	4,4,4,4,4,4,4,4,2,2,2,2,2,2,3,3,3,3,3,3
# [154] DigitalPinToBitMask: array[0..19] of Byte = (
.Le37:
	.size	TC_sARDUINOTOOLS_ss_DIGITALPINTOPORT, .Le37 - TC_sARDUINOTOOLS_ss_DIGITALPINTOPORT

.section .data.n_TC_sARDUINOTOOLS_ss_DIGITALPINTOBITMASK
.globl	TC_sARDUINOTOOLS_ss_DIGITALPINTOBITMASK
TC_sARDUINOTOOLS_ss_DIGITALPINTOBITMASK:
	.byte	1,2,4,8,16,32,64,128,1,2,4,8,16,32,1,2,4,8,16,32
# [177] DigitalPinToPortIndex: array[0..19] of Byte = (
.Le38:
	.size	TC_sARDUINOTOOLS_ss_DIGITALPINTOBITMASK, .Le38 - TC_sARDUINOTOOLS_ss_DIGITALPINTOBITMASK

.section .data.n_TC_sARDUINOTOOLS_ss_DIGITALPINTOPORTINDEX
.globl	TC_sARDUINOTOOLS_ss_DIGITALPINTOPORTINDEX
TC_sARDUINOTOOLS_ss_DIGITALPINTOPORTINDEX:
	.byte	0,1,2,3,4,5,6,7,0,1,2,3,4,5,0,1,2,3,4,5
# [200] type
.Le39:
	.size	TC_sARDUINOTOOLS_ss_DIGITALPINTOPORTINDEX, .Le39 - TC_sARDUINOTOOLS_ss_DIGITALPINTOPORTINDEX

.section .data.n_TC_sARDUINOTOOLS_ss_FAST_BIT_TABLE
.globl	TC_sARDUINOTOOLS_ss_FAST_BIT_TABLE
TC_sARDUINOTOOLS_ss_FAST_BIT_TABLE:
	.byte	1,2,4,8,16,32,64,128
# [281] implementation
.Le40:
	.size	TC_sARDUINOTOOLS_ss_FAST_BIT_TABLE, .Le40 - TC_sARDUINOTOOLS_ss_FAST_BIT_TABLE

.section .data.n_TC_sARDUINOTOOLS_ss_LOWINTSTR
TC_sARDUINOTOOLS_ss_LOWINTSTR:
	.short	.Ld1
# [286] procedure IEnable; assembler;
.Le41:
	.size	TC_sARDUINOTOOLS_ss_LOWINTSTR, .Le41 - TC_sARDUINOTOOLS_ss_LOWINTSTR

.section .rodata.n__sARDUINOTOOLSs_Ld2
.globl	_sARDUINOTOOLSs_Ld2
_sARDUINOTOOLSs_Ld2:
	.ascii	"\000\000"
.Le42:
	.size	_sARDUINOTOOLSs_Ld2, .Le42 - _sARDUINOTOOLSs_Ld2

.section .data.n_TC_sARDUINOTOOLSs_sINTTOSTRsLONGINTssTINTSTR_ss_POWS
TC_sARDUINOTOOLSs_sINTTOSTRsLONGINTssTINTSTR_ss_POWS:
	.long	1,10,100,1000,10000,100000,1000000,10000000,100000000,1000000000
# [427] var
.Le43:
	.size	TC_sARDUINOTOOLSs_sINTTOSTRsLONGINTssTINTSTR_ss_POWS, .Le43 - TC_sARDUINOTOOLSs_sINTTOSTRsLONGINTssTINTSTR_ss_POWS

.section .rodata.n__sARDUINOTOOLSs_Ld3
.globl	_sARDUINOTOOLSs_Ld3
_sARDUINOTOOLSs_Ld3:
	.ascii	"\0010\000"
.Le44:
	.size	_sARDUINOTOOLSs_Ld3, .Le44 - _sARDUINOTOOLSs_Ld3
# End asmlist al_typedconsts
# Begin asmlist al_rtti

.section .data.n_RTTI_sARDUINOTOOLS_ss_TAVRPORT
.globl	RTTI_sARDUINOTOOLS_ss_TAVRPORT
RTTI_sARDUINOTOOLS_ss_TAVRPORT:
	.byte	3,8
# [802] 
	.ascii	"TAVRPort"
	.short	0
	.byte	1
	.long	0,12
	.short	0
	.byte	13
	.ascii	"avrpUndefined"
	.byte	5
	.ascii	"avrpA"
	.byte	5
	.ascii	"avrpB"
	.byte	5
	.ascii	"avrpC"
	.byte	5
	.ascii	"avrpD"
	.byte	5
	.ascii	"avrpE"
	.byte	5
	.ascii	"avrpF"
	.byte	5
	.ascii	"avrpG"
	.byte	5
	.ascii	"avrpH"
	.byte	8
	.ascii	"avrpNone"
	.byte	5
	.ascii	"avrpJ"
	.byte	5
	.ascii	"avrpK"
	.byte	5
	.ascii	"avrpL"
	.byte	12
	.ascii	"ArduinoTools"
	.byte	0
.Le45:
	.size	RTTI_sARDUINOTOOLS_ss_TAVRPORT, .Le45 - RTTI_sARDUINOTOOLS_ss_TAVRPORT

.section .data.n_RTTI_sARDUINOTOOLS_ss_TAVRPORT_s2o
	.balign 2
.globl	RTTI_sARDUINOTOOLS_ss_TAVRPORT_s2o
RTTI_sARDUINOTOOLS_ss_TAVRPORT_s2o:
	.long	13,1
	.short	RTTI_sARDUINOTOOLS_ss_TAVRPORT+37
	.long	2
	.short	RTTI_sARDUINOTOOLS_ss_TAVRPORT+43
	.long	3
	.short	RTTI_sARDUINOTOOLS_ss_TAVRPORT+49
	.long	4
	.short	RTTI_sARDUINOTOOLS_ss_TAVRPORT+55
	.long	5
	.short	RTTI_sARDUINOTOOLS_ss_TAVRPORT+61
	.long	6
	.short	RTTI_sARDUINOTOOLS_ss_TAVRPORT+67
	.long	7
	.short	RTTI_sARDUINOTOOLS_ss_TAVRPORT+73
	.long	8
	.short	RTTI_sARDUINOTOOLS_ss_TAVRPORT+79
	.long	10
	.short	RTTI_sARDUINOTOOLS_ss_TAVRPORT+94
	.long	11
	.short	RTTI_sARDUINOTOOLS_ss_TAVRPORT+100
	.long	12
	.short	RTTI_sARDUINOTOOLS_ss_TAVRPORT+106
	.long	9
	.short	RTTI_sARDUINOTOOLS_ss_TAVRPORT+85
	.long	0
	.short	RTTI_sARDUINOTOOLS_ss_TAVRPORT+23
.Le46:
	.size	RTTI_sARDUINOTOOLS_ss_TAVRPORT_s2o, .Le46 - RTTI_sARDUINOTOOLS_ss_TAVRPORT_s2o

.section .data.n_RTTI_sARDUINOTOOLS_ss_TAVRPORT_o2s
	.balign 2
.globl	RTTI_sARDUINOTOOLS_ss_TAVRPORT_o2s
RTTI_sARDUINOTOOLS_ss_TAVRPORT_o2s:
	.long	0
	.short	RTTI_sARDUINOTOOLS_ss_TAVRPORT+23
	.short	RTTI_sARDUINOTOOLS_ss_TAVRPORT+37
	.short	RTTI_sARDUINOTOOLS_ss_TAVRPORT+43
	.short	RTTI_sARDUINOTOOLS_ss_TAVRPORT+49
	.short	RTTI_sARDUINOTOOLS_ss_TAVRPORT+55
	.short	RTTI_sARDUINOTOOLS_ss_TAVRPORT+61
	.short	RTTI_sARDUINOTOOLS_ss_TAVRPORT+67
	.short	RTTI_sARDUINOTOOLS_ss_TAVRPORT+73
	.short	RTTI_sARDUINOTOOLS_ss_TAVRPORT+79
	.short	RTTI_sARDUINOTOOLS_ss_TAVRPORT+85
	.short	RTTI_sARDUINOTOOLS_ss_TAVRPORT+94
	.short	RTTI_sARDUINOTOOLS_ss_TAVRPORT+100
	.short	RTTI_sARDUINOTOOLS_ss_TAVRPORT+106
.Le47:
	.size	RTTI_sARDUINOTOOLS_ss_TAVRPORT_o2s, .Le47 - RTTI_sARDUINOTOOLS_ss_TAVRPORT_o2s

.section .data.n_RTTI_sARDUINOTOOLS_ss_TAVRPINMODE
.globl	RTTI_sARDUINOTOOLS_ss_TAVRPINMODE
RTTI_sARDUINOTOOLS_ss_TAVRPINMODE:
	.byte	3,11
	.ascii	"TAVRPinMode"
	.short	0
	.byte	1
	.long	0,1
	.short	0
	.byte	10
	.ascii	"avrmOutput"
	.byte	9
	.ascii	"avrmInput"
	.byte	12
	.ascii	"ArduinoTools"
	.byte	0
.Le48:
	.size	RTTI_sARDUINOTOOLS_ss_TAVRPINMODE, .Le48 - RTTI_sARDUINOTOOLS_ss_TAVRPINMODE

.section .data.n_RTTI_sARDUINOTOOLS_ss_TAVRPINMODE_s2o
	.balign 2
.globl	RTTI_sARDUINOTOOLS_ss_TAVRPINMODE_s2o
RTTI_sARDUINOTOOLS_ss_TAVRPINMODE_s2o:
	.long	2,1
	.short	RTTI_sARDUINOTOOLS_ss_TAVRPINMODE+37
	.long	0
	.short	RTTI_sARDUINOTOOLS_ss_TAVRPINMODE+26
.Le49:
	.size	RTTI_sARDUINOTOOLS_ss_TAVRPINMODE_s2o, .Le49 - RTTI_sARDUINOTOOLS_ss_TAVRPINMODE_s2o

.section .data.n_RTTI_sARDUINOTOOLS_ss_TAVRPINMODE_o2s
	.balign 2
.globl	RTTI_sARDUINOTOOLS_ss_TAVRPINMODE_o2s
RTTI_sARDUINOTOOLS_ss_TAVRPINMODE_o2s:
	.long	0
	.short	RTTI_sARDUINOTOOLS_ss_TAVRPINMODE+26
	.short	RTTI_sARDUINOTOOLS_ss_TAVRPINMODE+37
.Le50:
	.size	RTTI_sARDUINOTOOLS_ss_TAVRPINMODE_o2s, .Le50 - RTTI_sARDUINOTOOLS_ss_TAVRPINMODE_o2s

.section .data.n_INIT_sARDUINOTOOLS_ss_TINTSTR
.globl	INIT_sARDUINOTOOLS_ss_TINTSTR
INIT_sARDUINOTOOLS_ss_TINTSTR:
	.byte	13,7
	.ascii	"TIntStr"
	.short	0,0
	.long	13
	.short	0,0
	.long	0
.Le51:
	.size	INIT_sARDUINOTOOLS_ss_TINTSTR, .Le51 - INIT_sARDUINOTOOLS_ss_TINTSTR

.section .data.n_RTTI_sARDUINOTOOLS_ss_def0000000B
.globl	RTTI_sARDUINOTOOLS_ss_def0000000B
RTTI_sARDUINOTOOLS_ss_def0000000B:
	.byte	12,0
	.short	0,11,11
	.short	RTTI_sSYSTEM_ss_CHARsindirect
	.byte	1
	.short	RTTI_sSYSTEM_ss_SHORTINTsindirect
.Le52:
	.size	RTTI_sARDUINOTOOLS_ss_def0000000B, .Le52 - RTTI_sARDUINOTOOLS_ss_def0000000B

.section .data.n_RTTI_sARDUINOTOOLS_ss_TINTSTR
.globl	RTTI_sARDUINOTOOLS_ss_TINTSTR
RTTI_sARDUINOTOOLS_ss_TINTSTR:
	.byte	13,7
	.ascii	"TIntStr"
	.short	0
	.short	INIT_sARDUINOTOOLS_ss_TINTSTR
	.long	13,2
	.short	RTTI_sARDUINOTOOLS_ss_def0000000Bsindirect
	.short	0
	.short	RTTI_sSYSTEM_ss_SMALLINTsindirect
	.short	11
.Le53:
	.size	RTTI_sARDUINOTOOLS_ss_TINTSTR, .Le53 - RTTI_sARDUINOTOOLS_ss_TINTSTR

.section .data.n_INIT_sARDUINOTOOLS_ss_TCUSTOMPINED
.globl	INIT_sARDUINOTOOLS_ss_TCUSTOMPINED
INIT_sARDUINOTOOLS_ss_TCUSTOMPINED:
	.byte	16,12
	.ascii	"TCustomPined"
	.short	0,0
	.long	4
	.short	0,0
	.long	0
.Le54:
	.size	INIT_sARDUINOTOOLS_ss_TCUSTOMPINED, .Le54 - INIT_sARDUINOTOOLS_ss_TCUSTOMPINED

.section .data.n_RTTI_sARDUINOTOOLS_ss_TCUSTOMPINED
.globl	RTTI_sARDUINOTOOLS_ss_TCUSTOMPINED
RTTI_sARDUINOTOOLS_ss_TCUSTOMPINED:
	.byte	16,12
	.ascii	"TCustomPined"
	.short	0
	.short	INIT_sARDUINOTOOLS_ss_TCUSTOMPINED
	.long	4,2
	.short	RTTI_sSYSTEM_ss_BYTEsindirect
	.short	0
	.short	RTTI_sSYSTEM_ss_POINTERsindirect
	.short	2
.Le55:
	.size	RTTI_sARDUINOTOOLS_ss_TCUSTOMPINED, .Le55 - RTTI_sARDUINOTOOLS_ss_TCUSTOMPINED

.section .data.n_RTTI_sARDUINOTOOLS_ss_PCUSTOMPINED
.globl	RTTI_sARDUINOTOOLS_ss_PCUSTOMPINED
RTTI_sARDUINOTOOLS_ss_PCUSTOMPINED:
	.byte	29,12
	.ascii	"PCustomPined"
	.short	0
	.short	RTTI_sARDUINOTOOLS_ss_TCUSTOMPINEDsindirect
.Le56:
	.size	RTTI_sARDUINOTOOLS_ss_PCUSTOMPINED, .Le56 - RTTI_sARDUINOTOOLS_ss_PCUSTOMPINED

.section .data.n_INIT_sARDUINOTOOLS_ss_TCUSTOMPINOUTPUT
.globl	INIT_sARDUINOTOOLS_ss_TCUSTOMPINOUTPUT
INIT_sARDUINOTOOLS_ss_TCUSTOMPINOUTPUT:
	.byte	16,16
	.ascii	"TCustomPinOutput"
	.short	0,0
	.long	4
	.short	0,0
	.long	0
.Le57:
	.size	INIT_sARDUINOTOOLS_ss_TCUSTOMPINOUTPUT, .Le57 - INIT_sARDUINOTOOLS_ss_TCUSTOMPINOUTPUT

.section .data.n_RTTI_sARDUINOTOOLS_ss_TCUSTOMPINOUTPUT
.globl	RTTI_sARDUINOTOOLS_ss_TCUSTOMPINOUTPUT
RTTI_sARDUINOTOOLS_ss_TCUSTOMPINOUTPUT:
	.byte	16,16
	.ascii	"TCustomPinOutput"
	.short	0
	.short	INIT_sARDUINOTOOLS_ss_TCUSTOMPINOUTPUT
	.long	4,1
	.short	RTTI_sARDUINOTOOLS_ss_TCUSTOMPINEDsindirect
	.short	0
.Le58:
	.size	RTTI_sARDUINOTOOLS_ss_TCUSTOMPINOUTPUT, .Le58 - RTTI_sARDUINOTOOLS_ss_TCUSTOMPINOUTPUT

.section .data.n_RTTI_sARDUINOTOOLS_ss_PCUSTOMPINOUTPUT
.globl	RTTI_sARDUINOTOOLS_ss_PCUSTOMPINOUTPUT
RTTI_sARDUINOTOOLS_ss_PCUSTOMPINOUTPUT:
	.byte	29,16
	.ascii	"PCustomPinOutput"
	.short	0
	.short	RTTI_sARDUINOTOOLS_ss_TCUSTOMPINOUTPUTsindirect
.Le59:
	.size	RTTI_sARDUINOTOOLS_ss_PCUSTOMPINOUTPUT, .Le59 - RTTI_sARDUINOTOOLS_ss_PCUSTOMPINOUTPUT

.section .data.n_INIT_sARDUINOTOOLS_ss_TCUSTOMPININPUT
.globl	INIT_sARDUINOTOOLS_ss_TCUSTOMPININPUT
INIT_sARDUINOTOOLS_ss_TCUSTOMPININPUT:
	.byte	16,15
	.ascii	"TCustomPinInput"
	.short	0,0
	.long	4
	.short	0,0
	.long	0
.Le60:
	.size	INIT_sARDUINOTOOLS_ss_TCUSTOMPININPUT, .Le60 - INIT_sARDUINOTOOLS_ss_TCUSTOMPININPUT

.section .data.n_RTTI_sARDUINOTOOLS_ss_TCUSTOMPININPUT
.globl	RTTI_sARDUINOTOOLS_ss_TCUSTOMPININPUT
RTTI_sARDUINOTOOLS_ss_TCUSTOMPININPUT:
	.byte	16,15
	.ascii	"TCustomPinInput"
	.short	0
	.short	INIT_sARDUINOTOOLS_ss_TCUSTOMPININPUT
	.long	4,1
	.short	RTTI_sARDUINOTOOLS_ss_TCUSTOMPINEDsindirect
	.short	0
.Le61:
	.size	RTTI_sARDUINOTOOLS_ss_TCUSTOMPININPUT, .Le61 - RTTI_sARDUINOTOOLS_ss_TCUSTOMPININPUT

.section .data.n_RTTI_sARDUINOTOOLS_ss_PCUSTOMPININPUT
.globl	RTTI_sARDUINOTOOLS_ss_PCUSTOMPININPUT
RTTI_sARDUINOTOOLS_ss_PCUSTOMPININPUT:
	.byte	29,15
	.ascii	"PCustomPinInput"
	.short	0
	.short	RTTI_sARDUINOTOOLS_ss_TCUSTOMPININPUTsindirect
.Le62:
	.size	RTTI_sARDUINOTOOLS_ss_PCUSTOMPININPUT, .Le62 - RTTI_sARDUINOTOOLS_ss_PCUSTOMPININPUT
# End asmlist al_rtti
# Begin asmlist al_indirectglobals

.section .data.n_VMT_sARDUINOTOOLS_ss_TCUSTOMPINED
	.balign 2
.globl	VMT_sARDUINOTOOLS_ss_TCUSTOMPINEDsindirect
VMT_sARDUINOTOOLS_ss_TCUSTOMPINEDsindirect:
	.short	VMT_sARDUINOTOOLS_ss_TCUSTOMPINED
.Le63:
	.size	VMT_sARDUINOTOOLS_ss_TCUSTOMPINEDsindirect, .Le63 - VMT_sARDUINOTOOLS_ss_TCUSTOMPINEDsindirect

.section .data.n_VMT_sARDUINOTOOLS_ss_TCUSTOMPINOUTPUT
	.balign 2
.globl	VMT_sARDUINOTOOLS_ss_TCUSTOMPINOUTPUTsindirect
VMT_sARDUINOTOOLS_ss_TCUSTOMPINOUTPUTsindirect:
	.short	VMT_sARDUINOTOOLS_ss_TCUSTOMPINOUTPUT
.Le64:
	.size	VMT_sARDUINOTOOLS_ss_TCUSTOMPINOUTPUTsindirect, .Le64 - VMT_sARDUINOTOOLS_ss_TCUSTOMPINOUTPUTsindirect

.section .data.n_VMT_sARDUINOTOOLS_ss_TCUSTOMPININPUT
	.balign 2
.globl	VMT_sARDUINOTOOLS_ss_TCUSTOMPININPUTsindirect
VMT_sARDUINOTOOLS_ss_TCUSTOMPININPUTsindirect:
	.short	VMT_sARDUINOTOOLS_ss_TCUSTOMPININPUT
.Le65:
	.size	VMT_sARDUINOTOOLS_ss_TCUSTOMPININPUTsindirect, .Le65 - VMT_sARDUINOTOOLS_ss_TCUSTOMPININPUTsindirect

.section .data.n_RTTI_sARDUINOTOOLS_ss_TAVRPORT
	.balign 2
.globl	RTTI_sARDUINOTOOLS_ss_TAVRPORTsindirect
RTTI_sARDUINOTOOLS_ss_TAVRPORTsindirect:
	.short	RTTI_sARDUINOTOOLS_ss_TAVRPORT
.Le66:
	.size	RTTI_sARDUINOTOOLS_ss_TAVRPORTsindirect, .Le66 - RTTI_sARDUINOTOOLS_ss_TAVRPORTsindirect

.section .data.n_RTTI_sARDUINOTOOLS_ss_TAVRPORT_s2o
	.balign 2
.globl	RTTI_sARDUINOTOOLS_ss_TAVRPORT_s2osindirect
RTTI_sARDUINOTOOLS_ss_TAVRPORT_s2osindirect:
	.short	RTTI_sARDUINOTOOLS_ss_TAVRPORT_s2o
.Le67:
	.size	RTTI_sARDUINOTOOLS_ss_TAVRPORT_s2osindirect, .Le67 - RTTI_sARDUINOTOOLS_ss_TAVRPORT_s2osindirect

.section .data.n_RTTI_sARDUINOTOOLS_ss_TAVRPORT_o2s
	.balign 2
.globl	RTTI_sARDUINOTOOLS_ss_TAVRPORT_o2ssindirect
RTTI_sARDUINOTOOLS_ss_TAVRPORT_o2ssindirect:
	.short	RTTI_sARDUINOTOOLS_ss_TAVRPORT_o2s
.Le68:
	.size	RTTI_sARDUINOTOOLS_ss_TAVRPORT_o2ssindirect, .Le68 - RTTI_sARDUINOTOOLS_ss_TAVRPORT_o2ssindirect

.section .data.n_RTTI_sARDUINOTOOLS_ss_TAVRPINMODE
	.balign 2
.globl	RTTI_sARDUINOTOOLS_ss_TAVRPINMODEsindirect
RTTI_sARDUINOTOOLS_ss_TAVRPINMODEsindirect:
	.short	RTTI_sARDUINOTOOLS_ss_TAVRPINMODE
.Le69:
	.size	RTTI_sARDUINOTOOLS_ss_TAVRPINMODEsindirect, .Le69 - RTTI_sARDUINOTOOLS_ss_TAVRPINMODEsindirect

.section .data.n_RTTI_sARDUINOTOOLS_ss_TAVRPINMODE_s2o
	.balign 2
.globl	RTTI_sARDUINOTOOLS_ss_TAVRPINMODE_s2osindirect
RTTI_sARDUINOTOOLS_ss_TAVRPINMODE_s2osindirect:
	.short	RTTI_sARDUINOTOOLS_ss_TAVRPINMODE_s2o
.Le70:
	.size	RTTI_sARDUINOTOOLS_ss_TAVRPINMODE_s2osindirect, .Le70 - RTTI_sARDUINOTOOLS_ss_TAVRPINMODE_s2osindirect

.section .data.n_RTTI_sARDUINOTOOLS_ss_TAVRPINMODE_o2s
	.balign 2
.globl	RTTI_sARDUINOTOOLS_ss_TAVRPINMODE_o2ssindirect
RTTI_sARDUINOTOOLS_ss_TAVRPINMODE_o2ssindirect:
	.short	RTTI_sARDUINOTOOLS_ss_TAVRPINMODE_o2s
.Le71:
	.size	RTTI_sARDUINOTOOLS_ss_TAVRPINMODE_o2ssindirect, .Le71 - RTTI_sARDUINOTOOLS_ss_TAVRPINMODE_o2ssindirect

.section .data.n_INIT_sARDUINOTOOLS_ss_TINTSTR
	.balign 2
.globl	INIT_sARDUINOTOOLS_ss_TINTSTRsindirect
INIT_sARDUINOTOOLS_ss_TINTSTRsindirect:
	.short	INIT_sARDUINOTOOLS_ss_TINTSTR
.Le72:
	.size	INIT_sARDUINOTOOLS_ss_TINTSTRsindirect, .Le72 - INIT_sARDUINOTOOLS_ss_TINTSTRsindirect

.section .data.n_RTTI_sARDUINOTOOLS_ss_def0000000B
	.balign 2
.globl	RTTI_sARDUINOTOOLS_ss_def0000000Bsindirect
RTTI_sARDUINOTOOLS_ss_def0000000Bsindirect:
	.short	RTTI_sARDUINOTOOLS_ss_def0000000B
.Le73:
	.size	RTTI_sARDUINOTOOLS_ss_def0000000Bsindirect, .Le73 - RTTI_sARDUINOTOOLS_ss_def0000000Bsindirect

.section .data.n_RTTI_sARDUINOTOOLS_ss_TINTSTR
	.balign 2
.globl	RTTI_sARDUINOTOOLS_ss_TINTSTRsindirect
RTTI_sARDUINOTOOLS_ss_TINTSTRsindirect:
	.short	RTTI_sARDUINOTOOLS_ss_TINTSTR
.Le74:
	.size	RTTI_sARDUINOTOOLS_ss_TINTSTRsindirect, .Le74 - RTTI_sARDUINOTOOLS_ss_TINTSTRsindirect

.section .data.n_INIT_sARDUINOTOOLS_ss_TCUSTOMPINED
	.balign 2
.globl	INIT_sARDUINOTOOLS_ss_TCUSTOMPINEDsindirect
INIT_sARDUINOTOOLS_ss_TCUSTOMPINEDsindirect:
	.short	INIT_sARDUINOTOOLS_ss_TCUSTOMPINED
.Le75:
	.size	INIT_sARDUINOTOOLS_ss_TCUSTOMPINEDsindirect, .Le75 - INIT_sARDUINOTOOLS_ss_TCUSTOMPINEDsindirect

.section .data.n_RTTI_sARDUINOTOOLS_ss_TCUSTOMPINED
	.balign 2
.globl	RTTI_sARDUINOTOOLS_ss_TCUSTOMPINEDsindirect
RTTI_sARDUINOTOOLS_ss_TCUSTOMPINEDsindirect:
	.short	RTTI_sARDUINOTOOLS_ss_TCUSTOMPINED
.Le76:
	.size	RTTI_sARDUINOTOOLS_ss_TCUSTOMPINEDsindirect, .Le76 - RTTI_sARDUINOTOOLS_ss_TCUSTOMPINEDsindirect

.section .data.n_RTTI_sARDUINOTOOLS_ss_PCUSTOMPINED
	.balign 2
.globl	RTTI_sARDUINOTOOLS_ss_PCUSTOMPINEDsindirect
RTTI_sARDUINOTOOLS_ss_PCUSTOMPINEDsindirect:
	.short	RTTI_sARDUINOTOOLS_ss_PCUSTOMPINED
.Le77:
	.size	RTTI_sARDUINOTOOLS_ss_PCUSTOMPINEDsindirect, .Le77 - RTTI_sARDUINOTOOLS_ss_PCUSTOMPINEDsindirect

.section .data.n_INIT_sARDUINOTOOLS_ss_TCUSTOMPINOUTPUT
	.balign 2
.globl	INIT_sARDUINOTOOLS_ss_TCUSTOMPINOUTPUTsindirect
INIT_sARDUINOTOOLS_ss_TCUSTOMPINOUTPUTsindirect:
	.short	INIT_sARDUINOTOOLS_ss_TCUSTOMPINOUTPUT
.Le78:
	.size	INIT_sARDUINOTOOLS_ss_TCUSTOMPINOUTPUTsindirect, .Le78 - INIT_sARDUINOTOOLS_ss_TCUSTOMPINOUTPUTsindirect

.section .data.n_RTTI_sARDUINOTOOLS_ss_TCUSTOMPINOUTPUT
	.balign 2
.globl	RTTI_sARDUINOTOOLS_ss_TCUSTOMPINOUTPUTsindirect
RTTI_sARDUINOTOOLS_ss_TCUSTOMPINOUTPUTsindirect:
	.short	RTTI_sARDUINOTOOLS_ss_TCUSTOMPINOUTPUT
.Le79:
	.size	RTTI_sARDUINOTOOLS_ss_TCUSTOMPINOUTPUTsindirect, .Le79 - RTTI_sARDUINOTOOLS_ss_TCUSTOMPINOUTPUTsindirect

.section .data.n_RTTI_sARDUINOTOOLS_ss_PCUSTOMPINOUTPUT
	.balign 2
.globl	RTTI_sARDUINOTOOLS_ss_PCUSTOMPINOUTPUTsindirect
RTTI_sARDUINOTOOLS_ss_PCUSTOMPINOUTPUTsindirect:
	.short	RTTI_sARDUINOTOOLS_ss_PCUSTOMPINOUTPUT
.Le80:
	.size	RTTI_sARDUINOTOOLS_ss_PCUSTOMPINOUTPUTsindirect, .Le80 - RTTI_sARDUINOTOOLS_ss_PCUSTOMPINOUTPUTsindirect

.section .data.n_INIT_sARDUINOTOOLS_ss_TCUSTOMPININPUT
	.balign 2
.globl	INIT_sARDUINOTOOLS_ss_TCUSTOMPININPUTsindirect
INIT_sARDUINOTOOLS_ss_TCUSTOMPININPUTsindirect:
	.short	INIT_sARDUINOTOOLS_ss_TCUSTOMPININPUT
.Le81:
	.size	INIT_sARDUINOTOOLS_ss_TCUSTOMPININPUTsindirect, .Le81 - INIT_sARDUINOTOOLS_ss_TCUSTOMPININPUTsindirect

.section .data.n_RTTI_sARDUINOTOOLS_ss_TCUSTOMPININPUT
	.balign 2
.globl	RTTI_sARDUINOTOOLS_ss_TCUSTOMPININPUTsindirect
RTTI_sARDUINOTOOLS_ss_TCUSTOMPININPUTsindirect:
	.short	RTTI_sARDUINOTOOLS_ss_TCUSTOMPININPUT
.Le82:
	.size	RTTI_sARDUINOTOOLS_ss_TCUSTOMPININPUTsindirect, .Le82 - RTTI_sARDUINOTOOLS_ss_TCUSTOMPININPUTsindirect

.section .data.n_RTTI_sARDUINOTOOLS_ss_PCUSTOMPININPUT
	.balign 2
.globl	RTTI_sARDUINOTOOLS_ss_PCUSTOMPININPUTsindirect
RTTI_sARDUINOTOOLS_ss_PCUSTOMPININPUTsindirect:
	.short	RTTI_sARDUINOTOOLS_ss_PCUSTOMPININPUT
.Le83:
	.size	RTTI_sARDUINOTOOLS_ss_PCUSTOMPININPUTsindirect, .Le83 - RTTI_sARDUINOTOOLS_ss_PCUSTOMPININPUTsindirect
# End asmlist al_indirectglobals

