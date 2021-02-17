program MeArm10v2;

{$mode objfpc}{$H-}
{$goto on}

uses
  UInterrupts,
  UIRRemote,
  TimedServoISR,
  ArduinoTools,
  Servo,
  TimedServo;

const
  PIN_PORT1 = 11;
  PIN_PORT2 = 12;

var
  VServo1, VServo2: TServo;
  ActiveServo: PCustomServo;
  c: char;

begin
  UARTInit;
  VServo1.Init(PIN_PORT1);
  VServo1.Angle := 0;
  VServo2.Init(PIN_PORT2);
  VServo2.Angle := 0;
  ActiveServo := @VServo1;
  InterruptsEnable;
  repeat
    c := UARTReadChar;
    case c of
      '1': ActiveServo^.Angle := ActiveServo^.Angle + 10;
      '2': ActiveServo^.Angle := ActiveServo^.Angle - 10;
      //'3': ActiveServo^.Angle := FULL_CIRCLE * 20 div 180;
      //'4': ActiveServo^.Angle := FULL_CIRCLE * 30 div 180;
      //'5': ActiveServo^.Angle := FULL_CIRCLE * 40 div 180;
      //'6': ActiveServo^.Angle := FULL_CIRCLE * 50 div 180;
      //'7': ActiveServo^.Angle := FULL_CIRCLE * 60 div 180;
      //'8': ActiveServo^.Angle := FULL_CIRCLE * 70 div 180;
      //'9': ActiveServo^.Angle := FULL_CIRCLE * 80 div 180;
      //'0': ActiveServo^.Angle := FULL_CIRCLE * 90 div 180;
      //'q': ActiveServo^.Angle := FULL_CIRCLE * 100 div 180;
      //'w': ActiveServo^.Angle := FULL_CIRCLE * 110 div 180;
      //'e': ActiveServo^.Angle := FULL_CIRCLE * 120 div 180;
      //'r': ActiveServo^.Angle := FULL_CIRCLE * 130 div 180;
      //'t': ActiveServo^.Angle := FULL_CIRCLE * 140 div 180;
      //'y': ActiveServo^.Angle := FULL_CIRCLE * 150 div 180;
      //'u': ActiveServo^.Angle := FULL_CIRCLE * 160 div 180;
      //'i': ActiveServo^.Angle := FULL_CIRCLE * 170 div 180;
      //'o': ActiveServo^.Angle := 600;
      'a': ActiveServo := @VServo1;
      's': ActiveServo := @VServo2;
    end;
    UARTWriteLn(IntToStr(ActiveServo^.Angle));
    //UARTWriteLn(IntToStr(ServoInfos[0].Position));
  until False;
end.
