program servoapp;

{$mode objfpc}{$H-}
{$goto on}

uses
  UInterrupts,
  ArduinoTools,
  Servo,
  UARTI;

const
  SERVO_PIN = 14;

var
  Servo1: TServo;
  c: char;
begin
  SleepMicroSecs(100000);
  UARTIConsole.Init(9600);
  Servo1.Init(SERVO_PIN);
  while True do
  begin
    c := UARTReadChar;
    UARTWriteLn('Char ' + c);
    if c in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'] then
      Servo1.Angle := (Ord(c) - 48) * 20;
  end;
end.
