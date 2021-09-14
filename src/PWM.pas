unit PWM;

{$mode objfpc}{$H-}{$Z1}

interface

uses
  ArduinoTools;

const
  MAX_PWM_PIN_COUNT = 8;

procedure AnalogWrite(const APin: Byte; const AValue: Byte);
procedure AnalogRead(const APin: Byte; const AValue: Byte);

type
  TPWMPin = packed record
    Pin: Byte;
    Counter: Byte;
  end;       

  TSortedPWMPin = packed record
    NotMaskB: Byte;
    NotMaskC: Byte;
    NotMaskD: Byte;
    Counter: Byte;
  end;

  TSortedPWMPins = array[0..MAX_PWM_PIN_COUNT - 1 + 5] of TSortedPWMPin;

var
  PWMPinCount: Byte;
  SortedPWMPinCount: Byte;
  PWMPins: array[0..MAX_PWM_PIN_COUNT - 1] of TPWMPin;
  PWMChanged: Boolean;
  SortedPWMPins: TSortedPWMPins;
  PWMPinAllMaskB, PWMPinAllMaskC, PWMPinAllMaskD: Byte;

implementation

uses
  Timers;    

procedure SortPWMPorts;
var
  i, j, VMask, VAllMaskB, VAllMaskC, VAllMaskD: Byte;
  VPort: TAVRPort;
  VBuffer: TPWMPin;
  VComplete: Boolean;
  VOldCounter, d: Word;
begin
  //UARTConsole.WriteLnFormat('Sorted!', []);
  // Сортируем пузырьком
  if PWMPinCount > 1 then
    for i := 1 to PWMPinCount - 1 do
    begin
      VComplete := True;
      for j := i to PWMPinCount - 1 do
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
  while i < PWMPinCount do
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
      SortedPWMPins[j].NotMaskB := $FF;
      SortedPWMPins[j].NotMaskC := $FF;
      SortedPWMPins[j].NotMaskD := $FF;
      if d > 255 then
      begin
        SortedPWMPins[j].Counter := 128;
        Inc(VOldCounter, 128);
      end
      else
      begin
        Inc(VOldCounter, d);
        SortedPWMPins[j].Counter := d;
        case VPort of
          avrpB:
            SortedPWMPins[j].NotMaskB := SortedPWMPins[j].NotMaskB and not VMask;
          avrpC:
            SortedPWMPins[j].NotMaskC := SortedPWMPins[j].NotMaskC and not VMask;
          avrpD:
            SortedPWMPins[j].NotMaskD := SortedPWMPins[j].NotMaskD and not VMask;
        end;
        Inc(i);
      end;
    end
    else
    begin
      case VPort of
        avrpB:
          SortedPWMPins[j].NotMaskB := SortedPWMPins[j].NotMaskB and not VMask;
        avrpC:
          SortedPWMPins[j].NotMaskC := SortedPWMPins[j].NotMaskC and not VMask;
        avrpD:
          SortedPWMPins[j].NotMaskD := SortedPWMPins[j].NotMaskD and not VMask;
      end;
      Inc(i);
    end;
  end;
  SortedPWMPinCount := j + 1;
  PWMPinAllMaskB := VAllMaskB;
  PWMPinAllMaskC := VAllMaskC;
  PWMPinAllMaskD := VAllMaskD;
end;

procedure DoTimer0ServoCompareB; {assembler;}
begin

end;

procedure PWMPortDelete(const AIndex: Byte);
var
  i: Byte;
begin
  for i := AIndex + 1 to PWMPinCount - 1 do
    PWMPins[i - 1] := PWMPins[i];
  Dec(PWMPinCount);
  PWMChanged := PWMPinCount > 0;
end;

procedure PWMPortChange(const AIndex: Byte; const AValue: Byte);
begin
  PWMPins[AIndex].Counter := 2000 * AValue div 255 div 4;
  PWMChanged := PWMPinCount > 0;
end;

procedure PWMPortAdd(const APin: Byte; const AValue: Byte);
begin
  PWMPins[PWMPinCount].Pin := APin;
  PWMPins[PWMPinCount].Counter := AValue;
  Inc(PWMPinCount);
  PWMChanged := PWMPinCount > 0;
end;

procedure AnalogWrite(const APin: Byte; const AValue: Byte);
var
  i: SmallInt;
  NeedInit: Boolean;
begin
  NeedInit := PWMPinCount = 0;
  i := PWMPinCount - 1;
  while (i >= 0) and (PWMPins[i].Pin <> APin) do
    Inc(i);
  case AValue of
    0:
    begin
      if i >= 0 then
        PWMPortDelete(i);
      DigitalWrite(APin, False);
    end;
    255:
    begin
      if i >= 0 then
        PWMPortDelete(i);
      DigitalWrite(APin, True);
    end;
    else
    begin
      if i >= 0 then
        PWMPortChange(i, AValue)
      else
        PWMPortAdd(APin, AValue);
    end;
  end;
  if NeedInit then
  begin
    if PWMChanged then
    begin
      Timer0.ValueB := 0;
      Timer0.SetCompareAProc(@DoTimer0ServoCompareB);
      Timer0.CounterModes := Timer0.CounterModes + [tcmCompareB];
    end;
  end
  else
  begin
    if PWMPinCount = 0 then
    begin

    end;
  end;
end;

procedure AnalogRead(const APin: Byte; const AValue: Byte);
begin

end;

end.
