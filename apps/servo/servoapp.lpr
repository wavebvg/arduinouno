program servoapp;

{$mode objfpc}{$H-}{$Z1}

uses
  ArduinoTools,
  Servo,
  Timers,
  UART,
  ServoI2;

const
  SERVO_PIN = 14;

var
  Servo1: TServoI;
  c: Char;
begin
  Timer0.CLKMode := tclkm64;
  Timer0.CounterModes := [tcmOverflow];
  UARTConsole.Init(9600);
  Servo1.Init(SERVO_PIN, 0);
  SleepMicroSecs(100000);
  while True do
  begin
    c := UARTConsole.ReadChar;
    UARTConsole.WriteLnString('Char ' + c);
    if c in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'] then
      Servo1.Angle := (Ord(c) - 48) * 20;
  end;
end.
