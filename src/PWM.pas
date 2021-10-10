unit PWM;

{$mode objfpc}{$H-}{$Z1}
{$i TimersMacro.inc}
{$DEFINE USE_DEBUG_COUNTER}

interface

uses
  ArduinoTools;

const
  MAX_PWM_PIN_COUNT = 8;
  MAX_VALUE = 255;
  CICLE_STEP_COUNT = 4;
  CICLE_FULL_COUNT = MAX_VALUE * CICLE_STEP_COUNT;

procedure AnalogWrite(const APin: Byte; const AValue: Byte);
procedure AnalogRead(const APin: Byte; const AValue: Byte);

type
  TPWMPin = packed record
    Pin: Byte;
    Counter: Word;
  end;

  TSortedPWMPin = packed record
    NotMaskB: Byte;
    NotMaskC: Byte;
    NotMaskD: Byte;
    Counter: Byte;
  end;

  TSortedPWMPins = array[0..MAX_PWM_PIN_COUNT - 1 + 5] of TSortedPWMPin;
  TPWMPins = array[0..MAX_PWM_PIN_COUNT - 1] of TPWMPin;

var
  PWMCount: Byte;
  SortedPWMCount: Byte;
  SortedPWMIndex: Byte;
  PWMPins: TPWMPins;
  PWMChanged: Boolean;
  SortedPWMs: TSortedPWMPins;
  PWMAllMaskB, PWMAllMaskC, PWMAllMaskD: Byte;

var
  PWMBeginCounter: Word;
  PWMCounter: array[0..MAX_PWM_PIN_COUNT - 1 + 5] of Word;
  DebugCounter: array[0..MAX_PWM_PIN_COUNT - 1 + 5] of Byte;

{$IFDEF PCTEST}
procedure DoTimer0ServoCompareB;
{$ENDIF}

implementation

uses
  Timers;

procedure SortPWMs;
var
  i, j, VMask, VAllMaskB, VAllMaskC, VAllMaskD: Byte;
  VPort: TAVRPort;
  VBuffer: TPWMPin;
  VComplete: Boolean;
  VOldCounter, d: Word;
begin
  //UARTConsole.WriteLnFormat('Sorted!', []);
  // Сортируем пузырьком
  if PWMCount > 1 then
    for i := 1 to PWMCount - 1 do
    begin
      VComplete := True;
      for j := 1 to PWMCount - i do
        if PWMPins[j - 1].Counter > PWMPins[j].Counter then
        begin
          VBuffer := PWMPins[j - 1];
          PWMPins[j - 1] := PWMPins[j];
          PWMPins[j] := VBuffer;
          VComplete := False;
        end;
      if VComplete then
        Break;
    end;
  // Загружаем сортированные значения в буфер с масками
  j := 255;
  VAllMaskB := 0;
  VAllMaskC := 0;
  VAllMaskD := 0;
  VOldCounter := 0;
  i := 0;
  while i < PWMCount do
  begin
    VMask := DigitalPinToBitMask[PWMPins[i].Pin];
    VPort := DigitalPinToPort[PWMPins[i].Pin];
    case VPort of
      avrpB:
        VAllMaskB := VAllMaskB or VMask;
      avrpC:
        VAllMaskC := VAllMaskC or VMask;
      avrpD:
        VAllMaskD := VAllMaskD or VMask;
    end;
    d := PWMPins[i].Counter - VOldCounter;
    if (i = 0) or (d > 0) then
    begin
      Inc(j);
      SortedPWMs[j].NotMaskB := $FF;
      SortedPWMs[j].NotMaskC := $FF;
      SortedPWMs[j].NotMaskD := $FF;
      if d > 285 then
      begin
        SortedPWMs[j].Counter := 255;
        Inc(VOldCounter, 255);
      end
      else
      if d > 255 then
      begin
        SortedPWMs[j].Counter := 128;
        Inc(VOldCounter, 128);
      end
      else
      begin
        Inc(VOldCounter, d);
        SortedPWMs[j].Counter := d;
        case VPort of
          avrpB:
            SortedPWMs[j].NotMaskB := SortedPWMs[j].NotMaskB and not VMask;
          avrpC:
            SortedPWMs[j].NotMaskC := SortedPWMs[j].NotMaskC and not VMask;
          avrpD:
            SortedPWMs[j].NotMaskD := SortedPWMs[j].NotMaskD and not VMask;
        end;
        Inc(i);
      end;
    end
    else
    begin
      case VPort of
        avrpB:
          SortedPWMs[j].NotMaskB := SortedPWMs[j].NotMaskB and not VMask;
        avrpC:
          SortedPWMs[j].NotMaskC := SortedPWMs[j].NotMaskC and not VMask;
        avrpD:
          SortedPWMs[j].NotMaskD := SortedPWMs[j].NotMaskD and not VMask;
      end;
      Inc(i);
    end;
  end;
  while VOldCounter < CICLE_FULL_COUNT do
  begin
    Inc(j);
    SortedPWMs[j].NotMaskB := $FF;
    SortedPWMs[j].NotMaskC := $FF;
    SortedPWMs[j].NotMaskD := $FF;
    d := CICLE_FULL_COUNT - VOldCounter;
    if d > 285 then
    begin
      SortedPWMs[j].Counter := 255;
      Inc(VOldCounter, 255);
    end
    else
    if d > 255 then
    begin
      SortedPWMs[j].Counter := 128;
      Inc(VOldCounter, 128);
    end
    else
    begin
      Inc(VOldCounter, d);
      SortedPWMs[j].Counter := d;
    end;
  end;
  SortedPWMCount := j + 1;
  PWMAllMaskB := VAllMaskB;
  PWMAllMaskC := VAllMaskC;
  PWMAllMaskD := VAllMaskD;
end;

{$IFDEF PCTEST}
procedure DoTimer0ServoCompareB; {assembler;}
begin
  if SortedPWMIndex = SortedPWMCount then
  begin
    // Restart cicle
    if PWMChanged then
    begin
      PWMChanged := False;
      SortPWMs;
    end;
    SortedPWMIndex := 0;
    PORTB := PORTB or PWMAllMaskB;
    PORTC := PORTC or PWMAllMaskC;
    PORTD := PORTD or PWMAllMaskD;
    PWMBeginCounter := Timer1_Counter;
    Timer0_ValueB := Timer0_Counter + SortedPWMs[0].Counter - 2;
    Inc(PWMCicles);
  end
  else
  begin
    // Next step of cicle    
    PORTB := PORTB and SortedPWMs[SortedPWMIndex].NotMaskB;
    PORTC := PORTC and SortedPWMs[SortedPWMIndex].NotMaskC;
    PORTD := PORTD and SortedPWMs[SortedPWMIndex].NotMaskD;
    PWMCounter[SortedPWMIndex] := Timer1_Counter - PWMBeginCounter;
    Inc(SortedPWMIndex);
    Timer0_ValueB := Timer0_ValueB + SortedPWMs[SortedPWMIndex].Counter;
  end;
end;

{$ELSE}
procedure DoTimer0ServoCompareB; assembler;
label
  inits, nexts, exit, nochanged;
asm
         //if SortedPWMIndex = SortedPWMCount then
         LDS     R18, SortedPWMIndex
         LDS     R19, SortedPWMCount
         CP      R18, R19
         BREQ    inits
         RJMP    nexts
         inits:
         //begin
         //  if PWMChanged then
         LDS     R19, PWMChanged
         CP      R19, R1
         BREQ    nochanged
         //  begin
         //    PWMChanged := False;
         STS     PWMChanged, R1
         //    SortPWMs;
         CALL    SortPWMs
         //  end;
         nochanged:
         //  SortedPWMIndex := 0;
         STS     SortedPWMIndex,  R1
         //  PORTB := PORTB or PWMAllMaskB;
         IN      R18, 5
         LDS     R19, PWMAllMaskB
         OR      R18, R19
         OUT     5, R18
         //  PORTC := PORTC or PWMAllMaskC;
         IN      R18, 8
         LDS     R19, PWMAllMaskC
         OR      R18, R19
         OUT     8, R18
         //  PORTD := PORTD or PWMAllMaskD;
         IN      R18, 11
         LDS     R19, PWMAllMaskD
         OR      R18, R19
         OUT     11, R18
{$IfDef USE_DEBUG_COUNTER}
         //  PWMBeginCounter := Timer1_Counter;
         LDS     R20, 132
         LDS     R21, 133
         STS     PWMBeginCounter, R20
         STS     PWMBeginCounter + 1, R21
{$EndIf USE_DEBUG_COUNTER}
         //  Timer0_ValueB := Timer0_Counter + SortedPWMs[0].Counter - 2;
         //LDI     R26, LO8(SortedPWMs)
         //LDI     R27, HI8(SortedPWMs)
         //ADIW    R26, 3
         //LD      R18, X
         LDS     R18, SortedPWMs + 3
         SBCI    R18, 2
         IN      R19, 38
         ADD     R19, R18
         OUT     40,  R19
         //end
         RJMP    exit
         nexts:
         //else
         //begin
         //  PORTB := PORTB and SortedPWMs[SortedPWMIndex].NotMaskB;
         MOV     R19, R18
         LSL     R19
         LSL     R19
         LDI     R26, LO8(SortedPWMs)
         LDI     R27, HI8(SortedPWMs)
         ADD     R26, R19
         ADC     R27, R1
         LD      R19, X+
         IN      R20, 5
         AND     R20, R19
         OUT     5,   R20
         //  PORTC := PORTC and SortedPWMs[SortedPWMIndex].NotMaskC;
         LD      R19, X+
         IN      R20, 8
         AND     R20, R19
         OUT     8,   R20
         //  PORTD := PORTD and SortedPWMs[SortedPWMIndex].NotMaskD;
         LD      R19, X+
         IN      R20, 11
         AND     R20, R19
         OUT     11,   R20
{$IfDef USE_DEBUG_COUNTER}
         //  PWMCounter[SortedPWMIndex] := Timer1_Counter - PWMBeginCounter;
         LDS     R22, 132
         LDS     R23, 133
         LDS     R20, PWMBeginCounter
         LDS     R21, PWMBeginCounter + 1
         LDI     R28, LO8(PWMCounter)
         LDI     R29, HI8(PWMCounter)
         MOV     R19, R18
         LSL     R19
         ADD     R28, R19
         ADC     R29, R1
         SUB     R22, R20
         SBC     R23, R21
         ST      Y+,  R22
         ST      Y,   R23
{$EndIf USE_DEBUG_COUNTER}
         //  Inc(SortedPWMIndex);
         INC     R18
         STS     SortedPWMIndex, R18
         //  Timer0_ValueB := Timer0_ValueB + SortedPWMs[SortedPWMIndex].Counter;
         ADIW    R26, 4
         LD      R19, X
         IN      R20, 40
         ADD     R20, R19
         OUT     40,  R20
         //end;
         exit:
         //NOP
end;

{$ENDIF}

procedure PWMPortDelete(const AIndex: Byte);
var
  i: Byte;
begin
  IPause;
  Dec(PWMCount);
  for i := AIndex + 1 to PWMCount do
    PWMPins[i - 1] := PWMPins[i];
  IResume;
end;

procedure PWMPortChange(const AIndex: Byte; const AValue: Byte);
begin
  PWMPins[AIndex].Counter := Word(AValue) * CICLE_STEP_COUNT;
end;

procedure PWMPortAdd(const APin: Byte; const AValue: Byte);
begin
  PWMPins[PWMCount].Pin := APin;
  PWMPins[PWMCount].Counter := Word(AValue) * CICLE_STEP_COUNT;
  Inc(PWMCount);
end;

procedure AnalogWrite(const APin: Byte; const AValue: Byte);
var
  i: SmallInt;
  NeedInit: Boolean;
begin
  i := PWMCount - 1;
  while (i >= 0) and (PWMPins[i].Pin <> APin) do
    Dec(i);
  if AValue in [0, 255] then
  begin
    NeedInit := False;
    if i >= 0 then
      PWMPortDelete(i);
    DigitalWrite(APin, AValue = 255);
  end
  else
  begin
    NeedInit := PWMCount = 0;
    if i >= 0 then
      PWMPortChange(i, AValue)
    else
      PWMPortAdd(APin, AValue);
  end;
  PWMChanged := True;
  if NeedInit then
  begin
    Timer0_ValueB := Timer0_Counter + 5;
    Timer0.SetCompareBProc(@DoTimer0ServoCompareB);
    Timer0.CounterModes := Timer0.CounterModes + [tcmCompareB];
  end
  else
  if PWMCount = 0 then
  begin
    Timer0.CounterModes := Timer0.CounterModes - [tcmCompareB];
    Timer0.ClearCompareBEvent;
  end;
end;

procedure AnalogRead(const APin: Byte; const AValue: Byte);
begin

end;

end.
