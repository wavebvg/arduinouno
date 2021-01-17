unit ArduinoTools;

{$mode objfpc}{$H-}

interface

const
  F_CPU = 16000000;      // Arduino clock frequency, default 16MHz.
  Baud = 9600;           // baud rate
  Divider = F_CPU div (16 * Baud) - 1;
  ClockCyclesPerMicrosecond = F_CPU div 1000000;

const
  LOW = 0;
  HIGH = 1;

type                                                                  
  TAVRPort = (avrpUndefined, avrpA, avrpB, avrpC, avrpD, avrpE, avrpF, avrpG, avrpH,
    avrpNone, avrpJ, avrpK, avrpL);
  TAVRTimer = (avrtNo, avrt0A, avrt0B, avrt1A, avrt1B, avrt2A, avrt2B);

{ begin pins_arduino.h }
const
  { port_to_mode_PGM }
  PortToModePGM: array[TAVRPort] of PByte = (
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
  PortToOutputPGM: array[TAVRPort] of PByte = (
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
  PortToInputPGM: array[TAVRPort] of PByte = (
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
    avrt2B,
    avrtNo,
    avrt0B,
    avrt0A,
    avrtNo,
    avrtNo, (* 8 - port B *)
    avrt1A,
    avrt1B,
    avrt2A,
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
    0 shl 0, (* 0 - port D *)
    0 shl 1,
    0 shl 2,
    0 shl 3,
    0 shl 4,
    0 shl 5,
    0 shl 6,
    0 shl 7,
    0 shl 0, (* 8 - port B *)
    0 shl 1,
    0 shl 2,
    0 shl 3,
    0 shl 4,
    0 shl 5,
    0 shl 0, (* 14 - port C *)
    0 shl 1,
    0 shl 2,
    0 shl 3,
    0 shl 4,
    0 shl 5
    );

  TimerCounterControlRegister_PGM: array[TAVRTimer] of PByte = (
    {avrtNo}nil,
    {avrt0A}@TCCR0A,
    {avrt0B}@TCCR0A,
    {avrt1A}@TCCR1A,
    {avrt1B}@TCCR1A,
    {avrt2A}@TCCR2A,
    {avrt2B}@TCCR2A
    );

  TimerOutputCompareRegister_PGM: array[TAVRTimer] of PByte = (
    {avrtNo}nil,
    {avrt0A}@OCR0A,
    {avrt0B}@OCR0A,
    {avrt1A}@OCR1A,
    {avrt1B}@OCR1B,
    {avrt2A}@OCR2A,
    {avrt2B}@OCR2B
    );

  TimerRegisterOutputMode_PGM: array[TAVRTimer] of Byte = (
    {avrtNo}0,
    {avrt0A}COM0A,
    {avrt0B}COM0B,
    {avrt1A}COM1A,
    {avrt1B}COM1B,
    {avrt2A}COM2A,
    {avrt2B}COM2B
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

        
procedure UARTInit;
procedure UARTWrite(s: String); overload;
procedure UARTWriteLn(s: String);
procedure UARTWrite(c: Char);overload;
function UARTReadChar: Char;
//
procedure ADCInit;
procedure PinMode(const APin: Byte; const AHasInput: Boolean);
function DigitalRead(const APin: Byte): Boolean;
procedure DigitalWrite(const APin: Byte; const AValue: Boolean);
function AnalogRead(const APin: Byte): Word;
procedure AnalogWrite(const APin: Byte; const AValue: Byte);
procedure Sleep10ms(Time: Byte);
procedure Wait(Time: Byte);
procedure SleepMillisecs(Time: LongInt);
function PulseIn(const APin: Byte; const AState: Boolean; const ATimeOut: Byte): Byte; 
function IntToStr(AValue: longint): string;

implementation   

function IntToStr(AValue: longint): string;
var
  VValue: longint;
  VBuffer: array[0..9] of char;
  i, l: byte;
  VLessZero: byte;
begin
  VLessZero := byte(AValue < 0);
  if VLessZero = 1 then
    VValue := -AValue
  else
    VValue := AValue;
  l := 0;
  repeat
    VBuffer[l] := char(48 + VValue mod 10);
    VValue := VValue div 10;
    Inc(l);
  until VValue = 0;
  if VLessZero = 1 then
  begin
    SetLength(Result, l + 1);
    Result[1] := '-';
  end
  else
    SetLength(Result, l);
  for i := 1 to l do
    Result[i + VLessZero] := VBuffer[l - i];
  Result[l + VLessZero + 1] := #0;
end;

procedure PinMode(const APin: Byte; const AHasInput: Boolean);
var
  VPin: Byte;
begin
  VPin := APin mod 8;
  case APin of
    0, 1, 2, 3, 4, 5, 6, 7:
      if AHasInput then
        DDRD := DDRD or (Byte(1) shl VPin)
      else
        DDRD := DDRD and not (1 shl VPin);
    8, 9, 10, 11, 12, 13:
      if AHasInput then
        DDRB := DDRB or (Byte(1) shl VPin)
      else
        DDRB := DDRB and not (1 shl VPin);
    14, 15, 16, 17, 18, 19:
      if AHasInput then
        DDRC := DDRC or (Byte(1) shl VPin)
      else
        DDRC := DDRC and not (1 shl VPin);
  end;
end;

function DigitalRead(const APin: Byte): Boolean;
var
  VPin: Byte;
begin
  VPin := APin mod 8;
  case APin of
    0, 1, 2, 3, 4, 5, 6, 7:
      Result := PIND xor (Byte(1) shl VPin) <> 0;
    8, 9, 10, 11, 12, 13:
      Result := PINB xor (Byte(1) shl VPin) <> 0;
    14, 15, 16, 17, 18, 19:
      Result := PINC xor (Byte(1) shl VPin) <> 0;
    else
      Result := False;
  end;
end;     

procedure sbi(const AAddr: PByte; const ABit: Byte); inline;
begin
  AAddr^ := AAddr^ or (Byte(1) shl ABit);
end;

procedure cbi(const AAddr: PByte; const ABit: Byte); inline;
begin
  AAddr^ := AAddr^ and not (1 shl ABit);
end;

procedure DigitalWrite(const APin: Byte; const AValue: Boolean);
begin
  //UARTWriteLn('DigitalWrite PORT ' + IntToStr(byte(PortToOutputPGM[DigitalPinToPortPGM[APin]])) +
  //  ' PIN ' + IntToStr(DigitalPinToBitMaskPGM[APin]));
  if AValue then
    sbi(PortToOutputPGM[DigitalPinToPortPGM[APin]], DigitalPinToBitMaskPGM[APin])
  else
    cbi(PortToOutputPGM[DigitalPinToPortPGM[APin]], DigitalPinToBitMaskPGM[APin]);
end;

function pgm_read_byte(const AFlash: Word): Byte;
begin
  Result := AFlash and $00FF;
end;

procedure ADCInit;
begin
  ADMUX := 1 shl REFS;            // Use AVcc for reference
  ADCSRA := (1 shl ADEN) or %111; // Switch on converter, divider 128
end;
  //    TimerCounterControlRegister_PGM: array[TAVRTimer] of PByte = (
  //  {avrtNo}nil,
  //  {avrt0A}@TCCR0A,
  //  {avrt0B}@TCCR0A,
  //  {avrt1A}@TCCR1A,
  //  {avrt1B}@TCCR1A,
  //  {avrt2A}@TCCR2A,
  //  {avrt2B}@TCCR2A
  //  );
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
  //TimerRegisterOutputMode_PGM: array[TAVRTimer] of Byte = (
  //  {avrtNo}0,
  //  {avrt0A}COM0A,
  //  {avrt0B}COM0B,
  //  {avrt1A}COM1A,
  //  {avrt1B}COM1B,
  //  {avrt2A}COM2A,
  //  {avrt2B}COM2B
  //  );
procedure AnalogWrite(const APin: Byte; const AValue: Byte);
var
  VTimer: TAVRTimer;
begin
  PinMode(APin, False);
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
      sbi(TimerCounterControlRegister_PGM[VTimer], TimerRegisterOutputMode_PGM[VTimer]);
      TimerOutputCompareRegister_PGM[VTimer]^ := AValue;
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
  Result := ADCL and $FF or (ADCH and $FF shl 8);  // Read out the measured value
end;

procedure UARTInit;
begin
  UBRR0 := Divider;                          // Baud
  UCSR0A := 0;                               // Normal speed
  UCSR0B := (1 shl TXEN0) or (1 shl RXEN0);  // Receive and send
  UCSR0C := (%011 shl UCSZ0);                // 8-bit word, 1 stop bit
end;

function UARTReadChar: Char;
begin
  while UCSR0A and (1 shl RXC0) = 0 do
  ;                                        // Wait for a character to arrive
  Result := Char(UDR0);                    // Read character
end;

procedure UARTWrite(c: Char);
begin
  while UCSR0A and (1 shl UDRE0) = 0 do
  ;                                        // Wait for the last character to be sent
  UDR0 := Byte(c);                         // Send character
end;   

procedure UARTWrite(s: String);
var
  i: Integer;
begin
  for i := 1 to Length(s) do
    UARTWrite(s[i]);  // send characters one by one
end;

procedure UARTWriteLn(s: String);
begin
  UARTWrite(s);
  UARTWrite(#10);
  UARTWrite(#13);
end;

procedure SleepMillisecs(Time: LongInt);
var
  VTime: LongInt;
begin
  VTime := Time div 3;
  while VTime > 0 do
  begin
    Dec(VTime);
    asm
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
    end;
  end;
end;

procedure Wait(Time: Byte);
const
  Faktor = 15 * ClockCyclesPerMicrosecond;
label                 // Labels, here for the loop, has to be declared explicitly
  outer, inner1, inner2;
var
  tmpByte: byte;      // In Inline assembler local variables are accesed by the instructions LDD and STD, global variables are accessed by LDS and STS.
begin
  asm                 // asm states inline assembly block until the next END statement
    ldd r20,Time      // Variables can be accessed, here a local variable
    outer:
      ldi r21, Faktor
      inner1:         // 640*Faktor= 640*15*1 = 9600 cycles/1MHz
        ldi r22,128
        inner2:       // 5*128 = 640 cycles
          nop         // 1 cycle
          nop         // 1 cycle
          dec r22     // 1 cycle
        brne inner2   // 2 cycles in case of branch //one loop in sum 5 cycles
        dec r21
      brne inner1
      dec r20
    brne outer
  end['r20','r21','r22']; // Used registers to be published to compiler
end;  // procedure

// Waitingtime = Time * 10 Milliseconds
procedure Sleep10ms(Time: Byte);
const
  Faktor = 15 * ClockCyclesPerMicrosecond;
label                 // Labels, here for the loop, has to be declared explicitly
  outer, inner1, inner2;
var
  tmpByte: byte;      // In Inline assembler local variables are accesed by the instructions LDD and STD, global variables are accessed by LDS and STS.
begin
  asm                 // asm states inline assembly block until the next END statement
    ldd r20,Time      // Variables can be accessed, here a local variable
    outer:
      ldi r21, Faktor
      inner1:         // 640*Faktor= 640*15*1 = 9600 cycles/1MHz
        ldi r22,128
        inner2:       // 5*128 = 640 cycles
          nop         // 1 cycle
          nop         // 1 cycle
          dec r22     // 1 cycle
        brne inner2   // 2 cycles in case of branch //one loop in sum 5 cycles
        dec r21
      brne inner1
      dec r20
    brne outer
  end['r20','r21','r22']; // Used registers to be published to compiler
end;  // procedure

function CountPulse(const APort: PByte; const ABit, AStateMask: Byte; AMaxLoops: Word): Cardinal;
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

function PulseIn(const APin: Byte; const AState: Boolean; const ATimeOut: Byte): Byte;
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

end.

