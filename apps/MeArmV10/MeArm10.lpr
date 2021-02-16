program MeArm10;

{$mode objfpc}{$H-}
{$goto on}

uses
  UInterrupts,
  ArduinoTools,
  Servo;

const
  SERVO1_PIN = 5;
  SERVO2_PIN = 6;

var
  i: byte;
  Servo1: TServo;
  Servo2: TServo;
  ActiveServo: PServo;
  c: char;

begin
  Sleep10ms(200);
  UARTInit;
  Servo1.Init(SERVO1_PIN);
  Servo2.Init(SERVO2_PIN);
  ActiveServo := @Servo1;
  while True do
  begin
    c := UARTReadChar;
    case c of
      '1': ActiveServo^.Angle := 0;
      '2': ActiveServo^.Angle := 10;
      '3': ActiveServo^.Angle := 20;
      '4': ActiveServo^.Angle := 30;
      '5': ActiveServo^.Angle := 40;
      '6': ActiveServo^.Angle := 50;
      '7': ActiveServo^.Angle := 60;
      '8': ActiveServo^.Angle := 70;
      '9': ActiveServo^.Angle := 80;
      '0': ActiveServo^.Angle := 90;
      'q': ActiveServo^.Angle := 100;
      'w': ActiveServo^.Angle := 110;
      'e': ActiveServo^.Angle := 120;
      'r': ActiveServo^.Angle := 130;
      't': ActiveServo^.Angle := 140;
      'y': ActiveServo^.Angle := 150;
      'u': ActiveServo^.Angle := 160;
      'i': ActiveServo^.Angle := 170;
      'o': ActiveServo^.Angle := 180;
      'a': ActiveServo := @Servo1;
      's': ActiveServo := @Servo2;
    end;
  end;
end.
