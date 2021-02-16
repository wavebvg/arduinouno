unit ServoTimerISR;

{$mode objfpc}{$H-}
{$goto on}

interface    

const
  MAX_SERVO_COUNT = 2;

type
  PServoInfo = ^TServoInfo;
  TServoInfo = packed record
    Pin: byte;
    Angle: Word;
    OCR1A: Word;
    Active: boolean;
  end;         

var
  // Переменная номер шага для прерывния TIMER1_COMPA_vect.
  ServoTakt: byte = 0;

var
  // Угол поворота сервы (1 тик таймера 0,004ms, нетральное положение 0,6ms).
  ServoInfos: array[0..MAX_SERVO_COUNT - 1] of TServoInfo;

implementation

uses
  ArduinoTools;

const
  // 4-верть сигнала в 50Hz, импульсы идут один за другим.
  SERVO_CYCLE: word = 1250;

procedure TIMER1_COMPA_ISR; Alias: 'TIMER1_COMPA_ISR'; interrupt; public;

  procedure SetValue(const AValue: word);
  begin
    OCR1A := AValue;
    OCR1A := AValue;
    OCR1A := AValue;
  end;

var
  VInfo: TServoInfo;
begin
  VInfo := ServoInfos[ServoTakt div 2];
  if VInfo.Active then
  begin
    DigitalWrite(VInfo.Pin, VInfo.Active and (ServoTakt mod 2 = 0));
    if ServoTakt mod 2 = 0 then
      SetValue(VInfo.Angle)
    else
      SetValue(SERVO_CYCLE - VInfo.Angle);
  end
  else
    SetValue(0);
  VInfo.OCR1A := OCR1A;
  // Увеличиваем шаг.
  Inc(ServoTakt);

  // Обнуляем шаг.
  if ServoTakt = MAX_SERVO_COUNT * 2 then
    ServoTakt := 0;
end;

initialization
  ServoInfos[0].Active := False;
  FillChar(ServoInfos, SizeOf(TServoInfo) * Length(ServoInfos), 0);

end.
