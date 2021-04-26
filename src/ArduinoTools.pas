unit ArduinoTools;

{$mode objfpc}{$H-}

interface

const
  F_CPU = 16000000;      // Arduino clock frequency, default 16MHz.
  Baud = 9600;           // baud rate
  Divider = F_CPU div (16 * Baud) - 1;
  ClockCyclesPerMicrosecond = F_CPU div 1000000;

const
  WGM10  =  0;
  WGM11  =  1;
  COM1B0 =  4;
  COM1B1 =  5;
  COM1A0 =  6;
  COM1A1 =  7;

  CS10   = 0;
  CS11   = 1;
  CS12   = 2;
  WGM12  = 3;
  WGM13  = 4;

  WGM20  = 0;
  WGM21  = 1;
  COM2B0 = 4;
  COM2B1 = 5;
  COM2A0 = 6;
  COM2A1 = 7;

  CS20   = 0;
  CS21   = 1;
  CS22   = 2;
  WGM22  = 3;
  FOC2B  = 6;
  FOC2A  = 7;

const
  LOW = 0;
  HIGH = 1;

type                                                                  
  TAVRPort = (avrpUndefined, avrpA, avrpB, avrpC, avrpD, avrpE, avrpF, avrpG, avrpH,
    avrpNone, avrpJ, avrpK, avrpL);
  TAVRTimer = (avrtNo, avrt0A, avrt0B, avrt1A, avrt1B, avrt2A, avrt2B);
  TAVRPinMode = (avrmOutput, avrmInput);

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

  TimerCounterControlRegister: array[TAVRTimer] of PByte = (
    {avrtNo}nil,
    {avrt0A}@TCCR0A,
    {avrt0B}@TCCR0A,
    {avrt1A}@TCCR1A,
    {avrt1B}@TCCR1A,
    {avrt2A}@TCCR2A,
    {avrt2B}@TCCR2A
    );

  TimerClockControlRegister: array[TAVRTimer] of PByte = (
    {avrtNo}nil,
    {avrt0A}@TCCR0B,
    {avrt0B}@TCCR0B,
    {avrt1A}@TCCR1B,
    {avrt1B}@TCCR1B,
    {avrt2A}@TCCR2B,
    {avrt2B}@TCCR2B
    );

  TimerOutputCompareRegister: array[TAVRTimer] of PByte = (
    {avrtNo}nil,
    {avrt0A}@OCR0A,
    {avrt0B}@OCR0B,
    {avrt1A}@OCR1A,
    {avrt1B}@OCR1B,
    {avrt2A}@OCR2A,
    {avrt2B}@OCR2B
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

             
procedure sbi(const AAddr: PByte; const ABit: Byte);
procedure cbi(const AAddr: PByte; const ABit: Byte);
procedure UARTInit;
procedure UARTWrite(s: String); overload;
procedure UARTWriteLn(s: String);
procedure UARTWrite(c: Char);overload;
function UARTReadChar: Char;
//
procedure ArduinoInit;
procedure ADCInit;
procedure PinMode(const APin: Byte; const AMode: TAVRPinMode);
function DigitalRead(const APin: Byte): Boolean;
procedure DigitalWrite(const APin: Byte; const AValue: Boolean);
function AnalogRead(const APin: Byte): Word;
procedure AnalogWrite(const APin: Byte; const AValue: Integer);
procedure Sleep10ms(Time: Byte);
procedure Wait(Time: Byte);
procedure SleepMicroSecs(Time: LongInt);
function PulseIn(const APin: Byte; const AState: Boolean; const ATimeOut: Cardinal): Cardinal;
function IntToStr(AValue: longint): string;


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

implementation

function IntToStr(AValue: longint): string;
begin
  Str(AValue, Result);
end;

function IntToStr1(AValue: longint): string;
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

procedure PinMode(const APin: Byte; const AMode: TAVRPinMode);
begin
  if AMode = avrmOutput then
    sbi(PortToModePGM[DigitalPinToPortPGM[APin]], DigitalPinToPortMask[APin])
  else
    cbi(PortToModePGM[DigitalPinToPortPGM[APin]], DigitalPinToPortMask[APin]);
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

procedure sbi(const AAddr: PByte; const ABit: Byte);
begin
  AAddr^ := AAddr^ or (Byte(1) shl ABit);
end;

procedure cbi(const AAddr: PByte; const ABit: Byte);
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

procedure ArduinoInit1;
begin
  //InterruptsEnable;
  sbi(@TCCR0A, WGM0);
  sbi(@TCCR2B, CS2);
  sbi(@TCCR2A, WGM2);
end;

procedure ArduinoInit2;
begin
  //InterruptsDisable;  //stop interrupts

//set timer0 interrupt at 2kHz
  TCCR0A := 0;// set entire TCCR0A register to 0
  TCCR0B := 0;// same for TCCR0B
  TCNT0  := 0;//initialize counter value to 0
  // set compare match register for 2khz increments
  OCR0A := 124;// = (16*10^6) / (2000*64) - 1 (must be <256)
  // turn on CTC mode
  TCCR0A := TCCR0A or (1 shl 1);
  // Set CS01 and CS00 bits for 64 prescaler
  TCCR0B :=  TCCR0B or (1 shl 1) or (1 shl 0);
  // enable timer compare interrupt
  TIMSK0 := TIMSK0 or (1 shl OCIE0A);

//set timer1 interrupt at 1Hz
  TCCR1A := 0;// set entire TCCR1A register to 0
  TCCR1B := 0;// same for TCCR1B
  TCNT1  := 0;//initialize counter value to 0
  // set compare match register for 1hz increments
  OCR1A := 15624;// = (16*10^6) / (1*1024) - 1 (must be <65536)
  // turn on CTC mode
  TCCR1B := TCCR1B or (1 shl 3);
  // Set CS10 and CS12 bits for 1024 prescaler
  TCCR1B := TCCR1B or (1 shl 2) or (1 shl 0);
  // enable timer compare interrupt
  TIMSK1 := TIMSK1 or (1 shl OCIE1A);

//set timer2 interrupt at 8kHz
  TCCR2A := 0;// set entire TCCR2A register to 0
  TCCR2B := 0;// same for TCCR2B
  TCNT2  := 0;//initialize counter value to 0
  // set compare match register for 8khz increments
  OCR2A := 249;// = (16*10^6) / (8000*8) - 1 (must be <256)
  // turn on CTC mode
  TCCR2A := TCCR2A or (1 shl 1);
  // Set CS21 bit for 8 prescaler
  TCCR2B := TCCR2B or (1 shl 1);
  // enable timer compare interrupt
  TIMSK2 := TIMSK2 or (1 shl OCIE2A);

  //InterruptsEnable;  //allow interrupts
end;

procedure ArduinoInit;assembler;
asm
  sei
  in	r24, 0x24	  // 36
  ori	r24, 0x02	  // 2
  out	0x24, r24	  // 36
  in	r24, 0x24	  // 36
  ori	r24, 0x01	  // 1
  out	0x24, r24	  // 36
  in	r24, 0x25  	// 37
  ori	r24, 0x02  	// 2
  out	0x25, r24	  // 37
  in	r24, 0x25	  // 37
  ori	r24, 0x01	  // 1
  out	0x25, r24	  // 37
  lds	r24, 0x006E	// 0x80006e <__DATA_REGION_ORIGIN__+0xe>
  ori	r24, 0x01  	// 1
  sts	0x006E, r24	// 0x80006e <__DATA_REGION_ORIGIN__+0xe>
  sts	0x0081, r1	// 0x800081 <__DATA_REGION_ORIGIN__+0x21>
  lds	r24, 0x0081	// 0x800081 <__DATA_REGION_ORIGIN__+0x21>
  ori	r24, 0x02	  // 2
  sts	0x0081, r24	// 0x800081 <__DATA_REGION_ORIGIN__+0x21>
  lds	r24, 0x0081	// 0x800081 <__DATA_REGION_ORIGIN__+0x21>
  ori	r24, 0x01	  // 1
  sts	0x0081, r24	// 0x800081 <__DATA_REGION_ORIGIN__+0x21>
  lds	r24, 0x0080	// 0x800080 <__DATA_REGION_ORIGIN__+0x20>
  ori	r24, 0x01  	// 1
  sts	0x0080, r24	// 0x800080 <__DATA_REGION_ORIGIN__+0x20>
  lds	r24, 0x00B1	// 0x8000b1 <__DATA_REGION_ORIGIN__+0x51>
  ori	r24, 0x04	  // 4
  sts	0x00B1, r24	// 0x8000b1 <__DATA_REGION_ORIGIN__+0x51>
  lds	r24, 0x00B0	// 0x8000b0 <__DATA_REGION_ORIGIN__+0x50>
  ori	r24, 0x01	  // 1
  sts	0x00B0, r24	// 0x8000b0 <__DATA_REGION_ORIGIN__+0x50>
  lds	r24, 0x007A	// 0x80007a <__DATA_REGION_ORIGIN__+0x1a>
  ori	r24, 0x04	  // 4
  sts	0x007A, r24	// 0x80007a <__DATA_REGION_ORIGIN__+0x1a>
  lds	r24, 0x007A	// 0x80007a <__DATA_REGION_ORIGIN__+0x1a>
  ori	r24, 0x02	  // 2
  sts	0x007A, r24	// 0x80007a <__DATA_REGION_ORIGIN__+0x1a>
  lds	r24, 0x007A	// 0x80007a <__DATA_REGION_ORIGIN__+0x1a>
  ori	r24, 0x01	  // 1
  sts	0x007A, r24	// 0x80007a <__DATA_REGION_ORIGIN__+0x1a>
  lds	r24, 0x007A	// 0x80007a <__DATA_REGION_ORIGIN__+0x1a>
  ori	r24, 0x80	  // 128
  sts	0x007A, r24	// 0x80007a <__DATA_REGION_ORIGIN__+0x1a>
  sts	0x00C1, r1	// 0x8000c1 <__DATA_REGION_ORIGIN__+0x61>
  ldi	r28, 0x00	  // 0
  ldi	r29, 0x00	  // 0
  sbiw	r28, 0x00 // 0
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

procedure UARTInit;
begin
  UBRR0 := Divider;

  UCSR0A := (0 shl U2X0);
  UCSR0B := (1 shl TXEN0) or (1 shl RXEN0);
  UCSR0C := %011 shl UCSZ0;              // 8-bit word, 1 stop bit
end;

function UARTReadChar: Char;
begin
  while UCSR0A and (1 shl RXC0) = 0 do
  asm
  nop;                                        // Wait for a character to arrive
  end;
  Result := Char(UDR0);                    // Read character
end;

procedure UARTWrite(c: Char);
begin
  while UCSR0A and (1 shl UDRE0) = 0 do
  asm
    nop;                                        // Wait for the last character to be sent
  end;
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

procedure SleepMicroSecs(Time: LongInt);
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
  FPin:=APin;
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

