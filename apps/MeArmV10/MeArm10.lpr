program MeArm10;

{$mode objfpc}{$H-}
{$goto on}

uses
  UInterrupts,
  ArduinoTools,
  Servo;

const
  SERVO_PIN = 6;

var
  i: byte;
  Servo1: TServo;
  c: char;

begin
  Sleep10ms(200);
  UARTInit;
  Servo1.Init(SERVO_PIN);
  while True do
  begin
    c := UARTReadChar;
    case c of
      '0': Servo1.Angle := 0;
      '1': Servo1.Angle := 10;
      '2': Servo1.Angle := 20;
      '3': Servo1.Angle := 30;
      '4': Servo1.Angle := 40;
      '5': Servo1.Angle := 50;
      '6': Servo1.Angle := 60;
      '7': Servo1.Angle := 70;
      '8': Servo1.Angle := 80;
      '9': Servo1.Angle := 90;
      'q': Servo1.Angle := 100;
      'w': Servo1.Angle := 110;
      'e': Servo1.Angle := 110;
      'r': Servo1.Angle := 120;
      't': Servo1.Angle := 130;
      'y': Servo1.Angle := 140;
      'u': Servo1.Angle := 150;
      'i': Servo1.Angle := 160;
      'o': Servo1.Angle := 170;
      'p': Servo1.Angle := 180;
    end;
  end;
end.
