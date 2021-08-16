unit ArduinoTools;

{$mode objfpc}{$H-}{$Z1}
{.$DEFINE DIV1024}

interface

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

type
  TAVRPort = (avrpUndefined, avrpA, avrpB, avrpC, avrpD, avrpE, avrpF, avrpG, avrpH,
    avrpNone, avrpJ, avrpK, avrpL);
  TAVRTimer = (avrtNo, avrt0A, avrt0B, avrt1A, avrt1B, avrt2A, avrt2B);
  TAVRPinMode = (avrmOutput, avrmInput);

{ begin pins_arduino.h }
const
  { port_to_mode_PGM }
  PortToModePGM: array[TAVRPort] of Pbyte = (
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

  { port_to_output_PGM }
  PortToOutputPGM: array[TAVRPort] of Pbyte = (
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

  { port_to_input_PGM }
  PortToInputPGM: array[TAVRPort] of Pbyte = (
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

  { digital_pin_to_timer_PGM }
  DigitalPinTimerPGM: array[0..19] of TAVRTimer = (
    avrtNo, (* 0 - port D *)
    avrtNo,
    avrtNo,
    avrt2B, (* 3 *)
    avrtNo,
    avrt0B, (* 5 *)
    avrt0A, (* 6 *)
    avrtNo,
    avrtNo, (* 8 - port B *)
    avrt1A, (* 9 *)
    avrt1B, (* 10 *)
    avrt2A, (* 11 *)
    avrtNo,
    avrtNo,
    avrtNo, (* 14 - port C *)
    avrtNo,
    avrtNo,
    avrtNo,
    avrtNo,
    avrtNo
    );

  { digital_pin_to_port_PGM }
  DigitalPinToPortPGM: array[0..19] of TAVRPort = (
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

  { digital_pin_to_bit_mask_PGM }
  DigitalPinToBitMaskPGM: array[0..19] of Byte = (
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

  TimerCounterControlRegister: array[TAVRTimer] of Pbyte = (
    {avrtNo}nil,
    {avrt0A} @TCCR0A,
    {avrt0B} @TCCR0A,
    {avrt1A} @TCCR1A,
    {avrt1B} @TCCR1A,
    {avrt2A} @TCCR2A,
    {avrt2B} @TCCR2A
    );

  TimerClockControlRegister: array[TAVRTimer] of Pbyte = (
    {avrtNo}nil,
    {avrt0A} @TCCR0B,
    {avrt0B} @TCCR0B,
    {avrt1A} @TCCR1B,
    {avrt1B} @TCCR1B,
    {avrt2A} @TCCR2B,
    {avrt2B} @TCCR2B
    );

  TimerOutputCompareRegister: array[TAVRTimer] of Pbyte = (
    {avrtNo}nil,
    {avrt0A} @OCR0A,
    {avrt0B} @OCR0B,
    {avrt1A} @OCR1A,
    {avrt1B} @OCR1B,
    {avrt2A} @OCR2A,
    {avrt2B} @OCR2B
    );

  TimerRegisterOutputMode: array[TAVRTimer] of Byte = (
    {avrtNo} 0,
    {avrt0A} COM0A,
    {avrt0B} COM0B,
    {avrt1A} COM1A,
    {avrt1B} COM1B,
    {avrt2A} COM2A,
    {avrt2B} COM2B
    );

  { end pins_arduino.h }

  DigitalPinToPortMask: array[0..19] of Byte = (
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
//
//TimerOutputCompareRegister_PGM: array[TAVRTimer] of PByte = (
//  {avrtNo}nil,
//  {avrt0A}@OCR0A,
//  {avrt0B}@OCR0A,
//  {avrt1A}@OCR1A,
//  {avrt1B}@OCR1B,
//  {avrt2A}@OCR2A,
//  {avrt2B}@OCR2B
//  );
//
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
function AnalogRead(const APin: Byte): Word;
procedure AnalogWrite(const APin: Byte; const AValue: Integer);
procedure SleepMicroSecs(const ATime: Longword);
procedure Sleep10ms(const ATime: Byte);
function PulseIn(const APin: Byte; const AState: Boolean; const ATimeOut: Cardinal): Cardinal;
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


type

  { TCustomPinOutput }

  PCustomPined = ^TCustomPined;

  { TCustomPined }

  TCustomPined = object
  private
    FPin: byte;
  public
    constructor Init(const APin: byte);
    destructor Deinit; virtual;
    //
    property Pin: byte read FPin;
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

implementation

const
  LOWINTSTR: PChar = '-2147483648';

procedure IEnable; assembler;
asm
         SEI
end;

procedure IDisable; assembler;
asm
         CLI
end;

function HasIEnabled: Boolean; assembler;
asm
  LDS   R24, 95 {SREG}
  ANDI	R24, 128
  CPSE  R24, R1
  LDI   R24, 1
end;

procedure IPause; assembler;
label
  goend;
asm
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
end;

procedure IResume; assembler;
label
  goend;
asm
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

function ByteMap(const ABytes: array of Byte): Byte;
var
  i: Byte;
begin
  Result := 0;
  for i := 0 to Length(ABytes) - 1 do
    Result := Result or Byte((1 shl ABytes[i]));
end;

function IntToStr1(const AValue: Longint): String;
begin
  //Str(AValue, Result);
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
  begin
    Result := '0';
  end
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
begin
  if AMode = avrmOutput then
    sbi(PortToModePGM[DigitalPinToPortPGM[APin]], DigitalPinToPortMask[APin])
  else
    cbi(PortToModePGM[DigitalPinToPortPGM[APin]], DigitalPinToPortMask[APin]);
end;

function DigitalRead(const APin: Byte): Boolean;
var
  VBit: Byte;
  VPort: TAVRPort;
begin
  VBit := DigitalPinToBitMaskPGM[APin];
  VPort := DigitalPinToPortPGM[APin];
  Result := PortToInputPGM[VPort]^ and VBit <> 0;
end;

procedure sbi(const AAddr: Pbyte; const ABit: Byte);
begin
  AAddr^ := AAddr^ or (Byte(1) shl ABit);
end;

procedure cbi(const AAddr: Pbyte; const ABit: Byte);
begin
  AAddr^ := AAddr^ and not (1 shl ABit);
end;

procedure DigitalWrite(const APin: Byte; const AValue: Boolean);
begin
  if AValue then
    sbi(PortToOutputPGM[DigitalPinToPortPGM[APin]], DigitalPinToPortMask[APin])
  else
    cbi(PortToOutputPGM[DigitalPinToPortPGM[APin]], DigitalPinToPortMask[APin]);
end;

function pgm_read_byte(const AFlash: Word): Byte;
begin
  Result := AFlash and $00FF;
end;

procedure ADCInit;
const
  Port = 0;
begin
  ADMUX := (1 shl REFS) or (Port and $0F);
  ADCSRA := %111 or (1 shl ADEN) or (1 shl ADSC) or (1 shl ADIE);
end;

procedure AnalogWrite(const APin: Byte; const AValue: Integer);
var
  VTimer: TAVRTimer;
begin
  PinMode(APin, avrmOutput);
  if AValue = System.Low(AValue) then
    DigitalWrite(APin, False)
  else if AValue = System.High(AValue) then
    DigitalWrite(APin, True)
  else
  begin
    VTimer := DigitalPinTimerPGM[APin];
    if VTimer = avrtNo then
      if AValue < 128 then
        DigitalWrite(APin, False)
      else
        DigitalWrite(APin, True)
    else
    begin
      sbi(TimerCounterControlRegister[VTimer], TimerRegisterOutputMode[VTimer]);
      TimerOutputCompareRegister[VTimer]^ := AValue;
    end;
  end;
end;

function AnalogRead(const APin: Byte): Word;
begin
  ADMUX := (1 shl REFS) or (APin and $0F);   // Specify port
  sbi(@ADCSRA, ADSC);                        // Start measuring
  while (ADCSRA and (1 shl ADSC)) <> 0 do    // Wait until measured
  begin
  end;
  Result := ADC;  // Read out the measured value
end;

// Waiting time = Time * 10 Milliseconds
procedure Sleep10ms(const ATime: Byte);
const
  Faktor = 10 * ClockCyclesPerMicrosecond;
label                 // Labels, here for the loop, has to be declared explicitly
  outer, inner1, inner2;
var
  tmpByte: byte;
  // In Inline assembler local variables are accesed by the instructions LDD and STD, global variables are accessed by LDS and STS.
begin
  asm                              // asm states inline assembly block until the next END statement
           LDD     r20, ATime      // Variables can be accessed, here a local variable
           outer:
           LDI     r21, Faktor    // 1 cycle
           inner1:                // 1000*Faktor = 160000/16 = 10000 cycles/1MHz
           LDI     r22,250        // 1 cycle
           inner2:                // 4*250 = 1000 cycles
           NOP                    // 1 cycle
           DEC     r22            // 1 cycle
           BRNE    inner2         // 2 cycles
           DEC     r21            // 1 cycle
           BRNE    inner1         // 2 cycles
           DEC     r20
           BRNE    outer
  end; // Used registers to be published to compiler
end;  // procedure


procedure SleepMicroSecs(const ATime: Longword); assembler;
label
  loop, compl;
  (* ~ 32/16 мкс возможный минимум запуска sleep *)
asm
         // CALL                       // 4 + 4
{$IFDEF DIV1024}
         // DEC ATime DIV 1024               // 29...33
         // PUSH
         PUSH    R18                   // 2
         PUSH    R19                   // 2  
         PUSH    R17                   // 2
         // BYTE 0
         MOV     R17, R23              // 1
         LSR     R17                   // 1
         LSR     R17                   // 1
         // BYTE 1
         MOV     R18, R24              // 1
         SBRC    R18, 0                // 1|2
         ORI     R17, 64               // 1
         LSR     R18                   // 1
         SBRC    R18, 0                // 1|2
         ORI     R17, 128              // 1
         LSR     R18                   // 1
         // BYTE 2
         MOV     R19, R25              // 1
         SBRC    R19, 0                // 1|2
         ORI     R18, 64               // 1
         LSR     R19                   // 1
         SBRC    R19, 0                // 1|2
         ORI     R18, 128              // 1
         LSR     R19                   // 1
         // MINUS
         SBC     R22, R17              // 1
         SBC     R23, R18              // 1
         SBC     R24, R19              // 1
         SBCI    R25, 0                // 1
         // POP                          
         POP     R19                   // 2
         POP     R18                   // 2
         POP     R17                   // 2
{$ENDIF}
         // Wait start                       
         CP      R1, R22               // 1
         CPC     R1, R23               // 1
         CPC     R1, R24               // 1
         CPC     R1, R25               // 1
         BREQ    compl                 // 1|2    
{$IFDEF DIV1024}
         SUBI    r22, 4                // 1
{$ELSE}
         SUBI    r22, 2                // 1
{$ENDIF}
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

function CountPulse(const APort: Pbyte; const ABit, AStateMask: Byte; AMaxLoops: Word): Cardinal;
begin
  Result := 0;
  while APort^ and ABit = AStateMask do
  begin
    Dec(AMaxLoops);
    if AMaxLoops = 0 then
      Exit;
  end;

  // wait for the pulse to start
  while APort^ and ABit <> AStateMask do
  begin
    Dec(AMaxLoops);
    if AMaxLoops = 0 then
      Exit;
  end;

  // wait for the pulse to stop
  while APort^ and ABit = AStateMask do
  begin
    Inc(Result);
    if Result = AMaxLoops then
    begin
      Result := 0;
      Exit;
    end;
  end;
end;

function PulseIn(const APin: Byte; const AState: Boolean; const ATimeOut: Cardinal): Cardinal;
var
  VBit, VStateMask: Byte;
  VPort: TAVRPort;
  VMaxLoops: Word;
  VWidth: Word;
begin
  // cache the port and bit of the pin in order to speed up the
  // pulse width measuring loop and achieve finer resolution.  calling
  // digitalRead() instead yields much coarser resolution.
  VBit := DigitalPinToBitMaskPGM[APin];
  VPort := DigitalPinToPortPGM[APin];
  if AState then
    VStateMask := VBit
  else
    VStateMask := 0;
  // convert the timeout from microseconds to a number of times through
  // the initial loop; it takes approximately 16 clock cycles per iteration
  VMaxLoops := ATimeOut * ClockCyclesPerMicrosecond div 16;

  VWidth := CountPulse(PortToInputPGM[VPort], VBit, VStateMask, VMaxLoops);

  // prevent clockCyclesToMicroseconds to return bogus values if countPulseASM timed out
  if VWidth > 0 then
    Result := (VWidth * 16 + 16) div ClockCyclesPerMicrosecond
  else
    Result := 0;
end;

{ TCustomPinInput }

constructor TCustomPinInput.Init(const APin: byte);
begin
  inherited;
  PinMode(Pin, avrmInput);
end;

{ TCustomPined }

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
