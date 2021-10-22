unit ArduinoTools;

{$mode objfpc}{$H-}{$Z1}

interface      

{$IFDEF PCTEST}
var
    DDRB, DDRC, DDRD,PORTB, PORTC, PORTD , PINB, PINC,PIND, UCSR0A, UCSR0B, UCSR0C, UDR0: Byte;

var
  ASSR, TCNT2, TCNT0, OCR0A, OCR0B, TCCR0B, OCR2A, OCR2B: Byte;
  TIMSK0, TCCR0A, TIMSK1, TCCR1A, TIMSK2, TCCR2B, TCCR2A: Cardinal;
  TCNT1, TCCR1B, OCR1A, OCR1B, UBRR0: Word;


const
  WGM02 = 0;
  ICNC1 = 0;
  AS2 = 0;
  EXCLK = 0;
  OCR2BUB = 0;
  TCR2BUB = 0;
  OCR2AUB = 0;
  TCN2UB = 0;
  TXEN0 = 0;
  RXEN0 = 0;
  UCSZ0 = 0;
  UDRE0 = 0;
  RXC0 = 0;
{$ENDIF}

const
  F_CPU = 16000000;      // Arduino clock frequency, default 16MHz.
  BaudRate = 9600;       // baud rate
  ClockCyclesPerMicrosecond = F_CPU div 1000000;

const
  HexChars: array[0..15] of Char = '0123456789ABCDEF';

const
  WGM10 = 0;
  WGM11 = 1;
  COM1B0 = 4;
  COM1B1 = 5;
  COM1A0 = 6;
  COM1A1 = 7;

  CS10 = 0;
  CS11 = 1;
  CS12 = 2;
  WGM12 = 3;
  WGM13 = 4;

  WGM20 = 0;
  WGM21 = 1;
  COM2B0 = 4;
  COM2B1 = 5;
  COM2A0 = 6;
  COM2A1 = 7;

  CS20 = 0;
  CS21 = 1;
  CS22 = 2;
  WGM22 = 3;
  FOC2B = 6;
  FOC2A = 7;

const
  TIMER_1B_VALUE_COUNT = High(Byte) + 1;
  TIMER_2B_VALUE_COUNT = High(Word) + 1;

type
  TAVRPort = (avrpUndefined, avrpA, avrpB, avrpC, avrpD, avrpE, avrpF, avrpG, avrpH,
    avrpNone, avrpJ, avrpK, avrpL);
  TAVRPinMode = (avrmOutput, avrmInput);

const
  { PortToMode }
  PortToMode: array[TAVRPort] of Pbyte = (
    {avrpUndefined} nil,
    {        avrpA} nil,
    {        avrpB} @DDRB,
    {        avrpC} @DDRC,
    {        avrpD} @DDRD,
    {        avrpE} nil,
    {        avrpF} nil,
    {        avrpG} nil,
    {        avrpH} nil,
    {     avrpNone} nil,
    {        avrpJ} nil,
    {        avrpK} nil,
    {        avrpL} nil
    );

  { PortToOutput }
  PortToOutput: array[TAVRPort] of Pbyte = (
    {avrpUndefined} nil,
    {        avrpA} nil,
    {        avrpB} @PORTB,
    {        avrpC} @PORTC,
    {        avrpD} @PORTD,
    {        avrpE} nil,
    {        avrpF} nil,
    {        avrpG} nil,
    {        avrpH} nil,
    {     avrpNone} nil,
    {        avrpJ} nil,
    {        avrpK} nil,
    {        avrpL} nil
    );

  { PortToInput }
  PortToInput: array[TAVRPort] of Pbyte = (
    {avrpUndefined} nil,
    {        avrpA} nil,
    {        avrpB} @PINB,
    {        avrpC} @PINC,
    {        avrpD} @PIND,
    {        avrpE} nil,
    {        avrpF} nil,
    {        avrpG} nil,
    {        avrpH} nil,
    {     avrpNone} nil,
    {        avrpJ} nil,
    {        avrpK} nil,
    {        avrpL} nil
    );

  { DigitalPinToPort }
  DigitalPinToPort: array[0..19] of TAVRPort = (
    avrpD, (* 0 - port D *)
    avrpD,
    avrpD,
    avrpD,
    avrpD,
    avrpD,
    avrpD,
    avrpD,
    avrpB, (* 8 - port B *)
    avrpB,
    avrpB,
    avrpB,
    avrpB,
    avrpB,
    avrpC, (* 14 - port C *)
    avrpC,
    avrpC,
    avrpC,
    avrpC,
    avrpC
    );

  DigitalPinToBitMask: array[0..19] of Byte = (
    1 shl 0, (* 0 - port D *)
    1 shl 1,
    1 shl 2,
    1 shl 3,
    1 shl 4,
    1 shl 5,
    1 shl 6,
    1 shl 7,
    1 shl 0, (* 8 - port B *)
    1 shl 1,
    1 shl 2,
    1 shl 3,
    1 shl 4,
    1 shl 5,
    1 shl 0, (* 14 - port C *)
    1 shl 1,
    1 shl 2,
    1 shl 3,
    1 shl 4,
    1 shl 5
    );

  DigitalPinToPortIndex: array[0..19] of Byte = (
    0, (* 0 - port D *)
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    0, (* 8 - port B *)
    1,
    2,
    3,
    4,
    5,
    0, (* 14 - port C *)
    1,
    2,
    3,
    4,
    5
    );

type
  TIntStr = packed record 
    Str: array[1..11] of Char;
    Length: Byte;
  end;

procedure sbi(const AAddr: Pbyte; const ABit: Byte);
procedure cbi(const AAddr: Pbyte; const ABit: Byte);
//
procedure ADCInit;
procedure PinMode(const APin: Byte; const AMode: TAVRPinMode);
function DigitalRead(const APin: Byte): Boolean;
procedure DigitalWrite(const APin: Byte; const AValue: Boolean);
procedure SleepMicroSecs(const ATime: Longword);
function IntToStr(const AValue: Longint): TIntStr;
function IntToHex(AValue: LongInt; const ADigits: Byte = 8): TIntStr; overload;
function IntToHex(AValue: Pointer): TIntStr; overload;
procedure IEnable;
procedure IDisable;
function HasIEnabled: Boolean;
procedure IPause;
procedure IResume;
procedure SetPByteReg(var ADest: Pbyte; const ASrc: Pbyte);
procedure SetTEMPWord(var ADest: Word; const ASrc: Word);
procedure NopWait;

type

  { TCustomPinOutput }

  PCustomPined = ^TCustomPined;

  { TCustomPined }

  TCustomPined = object
  private
    FPin: byte;
    function GetDigitalValue: Boolean;
    procedure SetDigitalValue(const AValue: Boolean);
  public
    constructor Init(const APin: byte);
    destructor Deinit; virtual;
    //
    property Pin: byte read FPin;
    //
    property DigitalValue: Boolean read GetDigitalValue write SetDigitalValue;
  end;

  { TCustomPinOutput }

  PCustomPinOutput = ^TCustomPinOutput;

  TCustomPinOutput = object(TCustomPined)
  public
    constructor Init(const APin: byte);
  end;

  { TCustomPinInput }

  PCustomPinInput = ^TCustomPinInput;

  TCustomPinInput = object(TCustomPined)
  public
    constructor Init(const APin: byte);
  end;

function ByteMap(const ABytes: array of Byte): Byte;     

operator := (const AValue: shortstring): TIntStr; inline;

operator := (const AValue: TIntStr): PChar; inline;

operator := (const AValue: TIntStr): shortstring; inline;

var
  VIPauseIndex: Byte;
  VIPauseState: Boolean;

const
  FAST_BIT_TABLE: array[0..7] of Byte = (1, 2, 4, 8, 16, 32, 64, 128);

implementation

const
  LOWINTSTR: PChar = '-2147483648';

procedure IEnable; assembler;
asm           
{$IFDEF PCTEST}
         STI
{$ELSE}
         SEI
{$ENDIF}
end;

procedure IDisable; assembler;
asm
         CLI
end;

function HasIEnabled: Boolean; assembler;
asm        
{$IFDEF PCTEST}
{$ELSE}
  LDS   R24, 95 {SREG}
  ANDI	R24, 128
  CPSE  R24, R1
  LDI   R24, 1
{$ENDIF}
end;

procedure IPause; assembler;
label
  goend;
asm
{$IFDEF PCTEST}
{$ELSE}
	PUSH	R18     {VIPauseIndex}

  LDS	  R18, VIPauseIndex
  CPI	  R18, 0
  BRNE  goend
              
	PUSH	R24     {VIPauseState}
  LDS   R24, 95 {SREG}  
  CLI
  ANDI	R24, 128
  CPSE  R24, R1
  LDI   R24, 1
  STS	  VIPauseState, R24
  POP   R24

  goend:
  INC	  R18
  STS	  VIPauseIndex, R18

  POP   R18    
{$ENDIF}
end;

procedure IResume; assembler;
label
  goend;
asm     
{$IFDEF PCTEST}
{$ELSE}
	PUSH	R18 {VIPauseIndex}
  LDS	R18, VIPauseIndex 
  DEC	R18
  CP  R18, R1
  BRNE goend        
	PUSH	R24 {VIPauseState}
  LDS	R24, VIPauseIndex
  CPSE  R24, R1
  SEI   
  POP R24
  goend:
  STS	VIPauseIndex,R18
  POP R18    
{$ENDIF}
end;

procedure SetPByteReg(var ADest: Pbyte; const ASrc: Pbyte);
begin
{$HINTS OFF}
  ADest := Pbyte(Word(ASrc) and $00FF);
{$HINTS ON}
end;

procedure SetTEMPWord(var ADest: Word; const ASrc: Word);
type
  TWord = packed record
    Low, High: Byte;
  end;

begin
  TWord(ADest).High := TWord(ASrc).High;
  TWord(ADest).Low := TWord(ASrc).Low;
end;

procedure NopWait; assembler;
asm
  nop
  nop
  nop
  nop
end;

function ByteMap(const ABytes: array of Byte): Byte;
var
  i: Byte;
begin
  Result := 0;
  for i := 0 to Length(ABytes) - 1 do
    Result := Result or Byte((1 shl ABytes[i]));
end;

operator := (const AValue: shortstring): TIntStr; inline;
begin
  Result.Length := Length(AValue);
  Move(AValue[1], Result.Str[1], Result.Length);
  Result.Str[Result.Length+1] := #0;
end;

operator := (const AValue: TIntStr): PChar; inline;
begin
  Result := @AValue.Str[1];
end;

operator := (const AValue: TIntStr): shortstring; inline;
begin                
  Move(AValue.Str[1], Result[1], AValue.Length + 1);
  SetLength(Result, AValue.Length)    ;
end;

procedure SetLength(var AStr: TIntStr; const AValue: Byte);
begin
  AStr.Length:=AValue;    
  AStr.Str[AStr.Length+1] := #0;
end;

function IntToStr(const AValue: Longint): TIntStr;
const
  MAX_POW_INDEX = 9;
  POWS: array[0..MAX_POW_INDEX] of Longint =
    (1, 10, 100, 1000, 10000, 100000, 1000000, 10000000, 100000000, 1000000000);
var
  VHasMinus: Boolean;
  VPow: PLongInt;
  n, p, c: Byte;
  VValue: LongInt;
begin
  if AValue = 0 then
    Result := '0'
  else
  if AValue = Low(Longint) then
  begin
    Result.Length:= 11;
    Move(LOWINTSTR^, Result.Str[1], Result.Length);
  end
  else
  begin
    VHasMinus := AValue < 0;
    if VHasMinus then
      VValue := -AValue
    else
      VValue := AValue;
    n := 1;
    VPow := @POWS;
    while (n <= MAX_POW_INDEX) and (VValue >= VPow^) do
    begin
      Inc(VPow);
      Inc(n);
    end;
    if n <= MAX_POW_INDEX then
    begin
      Dec(VPow);
      Dec(n);
    end;
    n := n + Byte(VHasMinus);
    SetLength(Result, n);
    p := 1 + Byte(VHasMinus);
    if VHasMinus then
      Result.Str[1] := '-';
    repeat
      c := 0;
      while VValue >= VPow^ do
      begin
        Inc(c);
        Dec(VValue, VPow^);
      end;
      Dec(VPow);
      Result.Str[p] := Char(c + 48);
      Inc(p);
    until p > n;
  end;
end;

function IntToHex(AValue: LongInt; const ADigits: Byte): TIntStr;
var
  i: Byte;
begin
  SetLength(Result, ADigits);
  for i := 1 to ADigits do
  begin
    Result.Str[ADigits - i + 1] := HexChars[Byte(AValue and $0000000F)];
    AValue := AValue shr 4;
  end;
end;

function IntToHex(AValue: Pointer): TIntStr; overload;
begin
  Result := IntToHex(Word(AValue), 4);
end;

procedure PinMode(const APin: Byte; const AMode: TAVRPinMode);
var
  VPort: TAVRPort;
  VBitMask: Byte;
begin
  VPort := DigitalPinToPort[APin];
  VBitMask := DigitalPinToBitMask[APin];
  case AMode of
    avrmOutput:
      PortToMode[VPort]^ := PortToMode[VPort]^ or VBitMask;
    avrmInput:
    begin
      PortToMode[VPort]^ := PortToMode[VPort]^ and not VBitMask;
      PortToOutput[VPort]^ := PortToOutput[VPort]^ and not VBitMask;
    end;
  end;
end;

{$IFDEF PCTEST}           
procedure sbi(const AAddr: Pbyte{R24;R25}; const ABit: Byte{R22;R23});
begin
  AAddr^ := AAddr^ or FAST_BIT_TABLE[ABit];
end;

{$ELSE}
procedure sbi(const AAddr: Pbyte{R24;R25}; const ABit: Byte{R22;R23});  assembler;
{Total: 28}
asm
         // CALL                                   {4}
         PUSH    R18  {Addr value}                 {1}
         PUSH    R19  {Flag value}                 {1}
         PUSH    R26  {X} {FAST_BIT_TABLE} {AAddr} {1}
         PUSH    R27  {X} {FAST_BIT_TABLE} {AAddr} {1}
         //
	       LDI	   R26, LO8(FAST_BIT_TABLE)          {1}
	       LDI	   R27, HI8(FAST_BIT_TABLE)          {1}
         ADD     R26, R22                          {1}
         ADC     R27, R1                           {1}
         LD      R19, X                            {2}
         MOVW    R26, R24                          {1}
         LD      R18, X                            {2}
         OR	     R18, R19                          {1}
         ST      X, R18                            {2}
         //
         POP     R27                               {1}
         POP     R26                               {1}
         POP     R19                               {1}
         POP     R18                               {1}
         // RET                                    {4} 
end;
{$ENDIF}
        
{$IFDEF PCTEST}
procedure cbi(const AAddr: Pbyte{R24;R25}; const ABit: Byte{R22;R23});
begin
  AAddr^ := AAddr^ and not FAST_BIT_TABLE[ABit];
end;
{$ELSE}   
procedure cbi(const AAddr: Pbyte{R24;R25}; const ABit: Byte{R22;R23}); assembler;
{Total: 29}
asm
         // CALL                                   {4}
         PUSH    R18  {Addr value}                 {1}
         PUSH    R19  {Flag value}                 {1}
         PUSH    R26  {X} {FAST_BIT_TABLE} {AAddr} {1}
         PUSH    R27  {X} {FAST_BIT_TABLE} {AAddr} {1}
         //
	       LDI	   R26, LO8(FAST_BIT_TABLE)          {1}
	       LDI	   R27, HI8(FAST_BIT_TABLE)          {1}
         ADD     R26, R22                          {1}
         ADC     R27, R1                           {1}
         LD      R19, X                            {2}
         COM     R19                               {1}
         MOVW    R26, R24                          {1}
         LD      R18, X                            {2}
         AND	   R18, R19                          {1}
         ST      X, R18                            {2}
         //
         POP     R27                               {1}
         POP     R26                               {1}
         POP     R19                               {1}
         POP     R18                               {1}
         // RET                                    {4}   
end;
{$ENDIF}  

{$IFDEF PCTEST}
function DigitalRead(const APin: Byte): Boolean;
//var
//  VBitMask: Byte;
//  VPort: TAVRPort;
begin
  //VBitMask := DigitalPinToBitMask[APin];
  //VPort := DigitalPinToPort[APin];
  //Result := PortToInput[VPort]^ and VBitMask <> 0;
end;

{$ELSE}
function DigitalRead(const APin: Byte): Boolean; assembler;
{Total: 42}
asm
  // CALL                                              {4}
         PUSH    R18  {VBitMask}                       {1}
         PUSH    R26  {X}                              {1}
         PUSH    R27  {X}                              {1}
         PUSH    R28  {Y}                              {1}
         PUSH    R29  {Y}                              {1}
  // VBitMask := DigitalPinToBitMask[APin];
         LDI	   R26, LO8(DigitalPinToBitMask)         {1}
         LDI	   R27, HI8(DigitalPinToBitMask)         {1}
         ADD     R26, R24                              {1}
         ADC     R27, R1                               {1}
         LD      R18, X                                {2}
  // VPort := DigitalPinToPort[APin];
         LDI	   R26, LO8(DigitalPinToPort)            {1}
         LDI	   R27, HI8(DigitalPinToPort)            {1}
         ADD     R26, R24                              {1}
         ADC     R27, R1                               {1}
         LD      R24, X                                {2}
         LSL     R24                                   {1}
  // Result := PortToInput[VPort]^ and VBitMask <> 0;
         LDI	   R26, LO8(PortToInput)                 {1}
         LDI     R27, HI8(PortToInput)                 {1}
         ADD     R26, R24                              {1}
         ADC     R27, R1                               {1}
         LD      R28, X+                               {2}
         LD      R29, X                                {2}
         LD      R24, Y                                {2}
         AND     R24, R18                              {1}
         //
         POP     R29                                   {1}
         POP     R28                                   {1}
         POP     R27                                   {1}
         POP     R26                                   {1}
         POP     R18                                   {1}
         // RET                                        {4}
end;
{$ENDIF}
                    
{$IFDEF PCTEST}        
procedure DigitalWrite(const APin: Byte; const AValue: Boolean);
begin

end;

{$ELSE}
procedure DigitalWrite(const APin{R24}: Byte; const AValue{R22}: Boolean); assembler;
{Total: 41}
label
  exit, vfalse;
asm
  // CALL                                              {4}
         PUSH    R18  {VBitMask}                       {1}
         PUSH    R26  {X}                              {1}
         PUSH    R27  {X}                              {1}
         PUSH    R28  {Y}                              {1}
         PUSH    R29  {Y}                              {1}
         //  VBitMask := DigitalPinToBitMask[APin];
         LDI	   R26, LO8(DigitalPinToBitMask)         {1}
         LDI	   R27, HI8(DigitalPinToBitMask)         {1}
         ADD     R26, R24                              {1}
         ADC     R27, R1                               {1}
         LD      R18, X                                {2}  {VBitMask => R18}
         //  VPort := DigitalPinToPort[APin];
         LDI	   R26, LO8(DigitalPinToPort)            {1}
         LDI	   R27, HI8(DigitalPinToPort)            {1}
         ADD     R26, R24                              {1}
         ADC     R27, R1                               {1}
         LD      R24, X                                {2}
         LSL     R24                                   {1}  {VPort => R24}
         //  VPortValue := PortToOutput[VPort]^;
         LDI	   R26, LO8(PortToOutput)                {1}
         LDI     R27, HI8(PortToOutput)                {1}
         ADD     R26, R24                              {1}
         ADC     R27, R1                               {1}
         LD      R28, X+                               {2}
         LD      R29, X                                {2}  {VPortAddr => R28,R29} 
         LD      R24, Y                                {2}  {VPortAddr^ => R24}
         //  if AValue then
         SBRS    r22, 0                                {1|2}
         JMP     vfalse                                {4}
         //  VPortAddr^ := VPortAddr^ or VBitMask;
         OR      R24, R18                              {1}
         JMP     exit                                  {4}
         //  else           
         vfalse:
         //    VPortAddr^ := VPortAddr^ and not VBitMask;
         COM     R18                                   {1}  
         AND     R24, R18                              {1}
         //
         exit:         
         ST      Y, R24                                {2}
         //
         POP     R29                                   {1}
         POP     R28                                   {1}
         POP     R27                                   {1}
         POP     R26                                   {1}
         POP     R18                                   {1}
         // RET                                        {4}
end;
{$ENDIF}

procedure ADCInit;
const
  Port = 0;
begin
{$IFDEF PCTEST}
{$ELSE}
  ADMUX := (1 shl REFS) or (Port and $0F);
  ADCSRA := %111 or (1 shl ADEN) or (1 shl ADSC) or (1 shl ADIE);   
{$ENDIF}
end;

          
{$IFDEF PCTEST}          
procedure SleepMicroSecs(const ATime: Longword);
begin
end;
{$ELSE}
procedure SleepMicroSecs(const ATime: Longword); assembler;
label
  loop, compl;
  (* ~ 32/16 мкс возможный минимум запуска sleep *)
asm
         // CALL                       // 4 + 4
         // Wait start                        
         NOP                           // 1
         NOP                           // 1
         NOP                           // 1
         NOP                           // 1
         NOP                           // 1
         CPC    R25, R1                // 1   
         CPC    R24, R1                // 1
         CPC    R23, R1                // 1
         PUSH   R18                    // 2
         LDI    R18, 3                 // 1
         CPC    R22, R18               // 1
         POP    R18                    // 2
         BRLO   compl                  // 1|2
         SUBI    r22, 2                // 1
         SBCI    r23, 0                // 1
         SBCI    r24, 0                // 1
         SBCI    r25, 0                // 1
         // Loop
         loop:
         // Decrement
         SUBI    r22, 1                // 1
         SBCI    r23, 0                // 1
         SBCI    r24, 0                // 1
         SBCI    r25, 0                // 1
         CP      R1, R22               // 1
         CPC     R1, R23               // 1
         CPC     R1, R24               // 1
         CPC     R1, R25               // 1
         BREQ    compl                 // 1|2
         NOP                           // 1
         NOP                           // 1
         NOP                           // 1
         NOP                           // 1
         NOP                           // 1
         RJMP    loop                  // 2
         compl:
         // RET                        // 4
end;
{$ENDIF}

{ TCustomPinInput }

constructor TCustomPinInput.Init(const APin: byte);
begin
  inherited;
  PinMode(Pin, avrmInput);
end;

{ TCustomPined }

function TCustomPined.GetDigitalValue: Boolean;
begin
  Result := DigitalRead(Pin);
end;

procedure TCustomPined.SetDigitalValue(const AValue: Boolean);
begin
  DigitalWrite(Pin, AValue);
end;

constructor TCustomPined.Init(const APin: byte);
begin
  FPin := APin;
end;

destructor TCustomPined.Deinit;
begin
  FPin := 0;
end;

{ TCustomPinOutput }

constructor TCustomPinOutput.Init(const APin: byte);
begin
  inherited;
  PinMode(Pin, avrmOutput);
end;

end.
