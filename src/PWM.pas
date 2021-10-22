unit PWM;

{$mode objfpc}{$H-}{$Z1}
{$i TimersMacro.inc}
{.$DEFINE USE_DEBUG_COUNTER}

interface

uses
  ArduinoTools;

const
  MAX_PWM_PIN_COUNT = 8;
  MAX_VALUE = 255;
  CICLE_STEP_COUNT = 2;
  CICLE_FULL_COUNT = MAX_VALUE * CICLE_STEP_COUNT;

procedure AnalogWrite(const APin: Byte; const AValue: Byte);

type
  TPWMPin = packed record
    Pin: Byte;
    Counter: Word;
  end;

  PSortedPWMPin = ^TSortedPWMPin;
  TSortedPWMPin = packed record 
    Counter: Byte;
    NotMaskB: Byte;
    NotMaskC: Byte;
    NotMaskD: Byte;
  end;

  TSortedPWMPins = array[0..MAX_PWM_PIN_COUNT - 1 + 5] of TSortedPWMPin;
  TPWMPins = array[0..MAX_PWM_PIN_COUNT - 1] of TPWMPin;

var
  PWMCount: Byte;
  PWMPins: TPWMPins;
  PWMChanged: Boolean;       
  PWMAllMaskB, PWMAllMaskC, PWMAllMaskD: Byte;
  SortedPWMs: TSortedPWMPins;
  SortedPWMCount: Byte;
  SortedPWMIndex: Byte;
  CurrentSortedPWM: PByte;

{$IfDef USE_DEBUG_COUNTER}
var
  PWMBeginCounter: Word;
  PWMCounter: array[0..MAX_PWM_PIN_COUNT - 1 + 5] of Word;
{$EndIf USE_DEBUG_COUNTER}

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
  Inc(j); 
  SortedPWMs[j].Counter := 0;
  SortedPWMCount := j;
  PWMAllMaskB := VAllMaskB;
  PWMAllMaskC := VAllMaskC;
  PWMAllMaskD := VAllMaskD;
end;

{$IFDEF PCTEST}
procedure DoTimer0ServoCompareB; {assembler;}
begin
  if CurrentSortedPWM^ = 0 then
  begin               
    Inc(CicleNo);
    // Restart cicle
    if PWMChanged then
    begin
      PWMChanged := False;
      SortPWMs;
    end;
    CurrentSortedPWM := @SortedPWMs;
{$IfDef USE_DEBUG_COUNTER}
    SortedPWMIndex := 0;
    PWMBeginCounter := Timer1_Counter;
{$EndIf USE_DEBUG_COUNTER}
    PORTB := PORTB or PWMAllMaskB;
    PORTC := PORTC or PWMAllMaskC;
    PORTD := PORTD or PWMAllMaskD;
    Timer0_ValueB := Timer0_Counter + CurrentSortedPWM^ - 2;
  end
  else
  begin
    // Next step of cicle
    Inc(CurrentSortedPWM);
{$IfDef USE_DEBUG_COUNTER}
    PWMCounter[SortedPWMIndex] := Timer1_Counter - PWMBeginCounter;
    Inc(SortedPWMIndex);
{$EndIf USE_DEBUG_COUNTER}
    PORTB := PORTB and CurrentSortedPWM^;
    Inc(CurrentSortedPWM);
    PORTC := PORTC and CurrentSortedPWM^;
    Inc(CurrentSortedPWM);
    PORTD := PORTD and CurrentSortedPWM^;
    Inc(CurrentSortedPWM);
    Timer0_ValueB := Timer0_ValueB + CurrentSortedPWM^;
  end;
end;

{$ELSE}
procedure DoTimer0ServoCompareB; assembler;
label
  inits, nexts, exit, nochanged;
asm
         //if CurrentSortedPWM^ = 0 then
         LDS     R26, CurrentSortedPWM
         LDS     R27, CurrentSortedPWM + 1
         LD      R19, X
         CP      R19, R1
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
         //  CurrentSortedPWM := @SortedPWMs;
         LDI     R26, LO8(SortedPWMs)
         LDI     R27, HI8(SortedPWMs)
         STS     CurrentSortedPWM, R26
         STS     CurrentSortedPWM + 1, R27
{$IfDef USE_DEBUG_COUNTER}
         //    Запоминаем текущее значение счетчика для отладки
         //    PWMBeginCounter := Timer1_Counter;
         LDS     R20, 132
         LDS     R21, 133
         STS     PWMBeginCounter, R20
         STS     PWMBeginCounter + 1, R21
{$EndIf USE_DEBUG_COUNTER}
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
         //  Timer0_ValueB := Timer0_Counter + SortedPWMs[0].Counter - 2;
         LD      R18, X
         SBCI    R18, 2
         IN      R19, 38
         ADD     R19, R18
         OUT     40,  R19
         //end
         RJMP    exit
         nexts:
         //else
         //begin
         //Inc(CurrentSortedPWM);
         ADIW    R26, 1
{$IfDef USE_DEBUG_COUNTER}
         //      ServoCounter[SortedServoIndex] := Timer1_Counter - PWMBeginCounter;   
         LDS     R18, SortedPWMIndex           {3}
         LDS     R20, PWMBeginCounter          {3}
         LDS     R21, PWMBeginCounter + 1      {3}
         LDI     R28, LO8(PWMCounter)          {1}
         LDI     R29, HI8(PWMCounter)          {1}
         ADD     R28, R18                      {1}
         ADC     R29, R1                       {1}
         ADD     R28, R18                      {1}
         ADC     R29, R1                       {1}
         LDS     R22, 132                      {3}
         LDS     R23, 133                      {3}
         SUB     R22, R20                      {1}
         SBC     R23, R21                      {1}
         ST      Y+,  R22                      {2}
         ST      Y,   R23                      {2}  
         INC     R18                           {1}
         STS     SortedPWMIndex, R18           {3}
{$EndIf USE_DEBUG_COUNTER}
         //  PORTB := PORTB and SortedPWMs[SortedPWMIndex].NotMaskB; {PORTB := PORTB and CurrentSortedPWM^; Inc(CurrentSortedPWM);}
         LD      R19, X+
         IN      R20, 5
         AND     R20, R19
         OUT     5,   R20
         //  PORTC := PORTC and SortedPWMs[SortedPWMIndex].NotMaskC; {PORTC := PORTC and CurrentSortedPWM^; Inc(CurrentSortedPWM);}
         LD      R19, X+
         IN      R20, 8
         AND     R20, R19
         OUT     8,   R20
         //  PORTD := PORTD and SortedPWMs[SortedPWMIndex].NotMaskD; {PORTD := PORTD and CurrentSortedPWM^; Inc(CurrentSortedPWM);}
         LD      R19, X+
         IN      R20, 11
         AND     R20, R19
         OUT     11,   R20
         //  Timer0_ValueB := Timer0_ValueB + SortedPWMs[SortedPWMIndex].Counter; {Timer0_ValueB := Timer0_ValueB + CurrentSortedPWM^;}
         LD      R19, X
         IN      R20, 40
         ADD     R20, R19
         OUT     40,  R20
         STS     CurrentSortedPWM, R26
         STS     CurrentSortedPWM + 1, R27
         //end;
         exit:
         NOP
end;

procedure DoTimer0ServoCompareBOld; assembler;
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
         LDS     R18, SortedPWMs
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
         LDI     R26, LO8(SortedPWMs + 1)
         LDI     R27, HI8(SortedPWMs + 1)
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
  end
  else
  if PWMCount = 0 then
  begin
    Timer0.ClearCompareBEvent;
  end;
end;

initialization
    FillByte(SortedPWMs, SizeOf(SortedPWMs), 0);
    CurrentSortedPWM := @SortedPWMs[Length(SortedPWMs) - 1];

end.
