program servo;

{$mode objfpc}{$H-}
{$goto on}

uses
  UInterrupts,
  ArduinoTools, Servo;

const
  SERVO_PIN = 14;
  MIN_PULSE_WIDTH: longint = 450;
  MAX_PULSE_WIDTH: longint = 2400;

  procedure Rotate(const AAngle: byte);
  var
    i: byte;
    VTime: longint;
  begin
    UARTWriteLn('Rotate to angle ' + IntToStr(AAngle));
    VTime := (MAX_PULSE_WIDTH - MIN_PULSE_WIDTH) * AAngle div 180 + MIN_PULSE_WIDTH;
    for i := 1 to 50 do
    begin
      InterruptsEnable;
      DigitalWrite(SERVO_PIN, True);
      SleepMillisecs(VTime);
      DigitalWrite(SERVO_PIN, False);
      InterruptsDisable;
      SleepMillisecs(200);
    end;
  end;

var
  c: char;
begin
  UARTInit;
  Rotate(0);
  while True do
  begin
    c := UARTReadChar;
    if c in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'] then
      Rotate((Ord(c) - 48) * 20);
  end;
end.