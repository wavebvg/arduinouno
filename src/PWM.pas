unit PWM;

{$mode objfpc}{$H-}{$Z1}
{$i TimersMacro.inc}

interface

uses
  ArduinoTools;

const
  MAX_PWM_PIN_COUNT = 8;
  CICLE_FULL_TIME = 4080;
  CICLE_STEP_TIME = CICLE_FULL_TIME div 255;
  CICLE_STEP_COUNT = CICLE_STEP_TIME div 4;
  CICLE_FULL_COUNT = CICLE_FULL_TIME div 4;

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
  PWMCicles: LongInt;

var
  PWMBeginCounter: Word;
  PWMCounter: array[0..MAX_PWM_PIN_COUNT - 1 + 5] of Word;

{$IFDEF PCTEST}
procedure DoTimer0ServoCompareB;
{$ENDIF}

implementation

uses
  Timers,
  UART;

procedure SortPWMs;
var
  i, j, VMask, VAllMaskB, VAllMaskC, VAllMaskD: Byte;
  VPort: TAVRPort;
  VBuffer: TPWMPin;
  VComplete: Boolean;
  VOldCounter, d: Word;
begin
  PWMChanged := False;
  //UARTConsole.WriteLnFormat('Sorted!', []);
  // Сортируем пузырьком
  if PWMCount > 1 then
  begin
    for i := 1 to PWMCount - 1 do
    begin
      VComplete := True;
      for j := i to PWMCount - 1 do
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

procedure DoTimer0ServoCompareB; {assembler;}
begin
  if SortedPWMIndex = SortedPWMCount then
  begin
    // Restart cicle
    if PWMChanged then
      SortPWMs;
    SortedPWMIndex := 0;
    PORTB := PORTB or PWMAllMaskB;
    PORTC := PORTC or PWMAllMaskC;
    PORTD := PORTD or PWMAllMaskD;
    PWMBeginCounter := Timer1_Counter;
    Timer0_ValueB := Timer0_Counter + SortedPWMs[0].Counter;
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
