program MeArm10v2;

{$mode objfpc}{$H-}
{$goto on}

uses
  UInterrupts,
  IRRemoteISR,
  TimedServoISR,
  ArduinoTools,
  Servo,
  TimedServo,
  IRRemote;

const
  PIN_PORT1 = 9;
  PIN_PORT2 = 10;
  PIN_PORT3 = 11;
  PIN_PORT4 = 12;
  SERVO_ANGE_MIN: array[1..4] of Byte = (0, 0, 0, 0);
  SERVO_ANGE_MAX: array[1..4] of Byte = (180, 180, 180, 100);

var
  VServo1, VServo2, VServo3, VServo4: TTimedServo;
  VServoNo: byte;
  ActiveServo: PCustomServo;
  c: char;
  VMin, VMax: Byte;

begin
  UARTInit;
  VServo1.Init(PIN_PORT1);
  VServo1.Angle := 90;//SERVO_ANGE_MIN[1];
  VServo2.Init(PIN_PORT2);
  VServo2.Angle := 50;//SERVO_ANGE_MIN[2];
  VServo3.Init(PIN_PORT3);
  VServo3.Angle := 120;//SERVO_ANGE_MIN[3];
  VServo4.Init(PIN_PORT4);
  VServo4.Angle := 0;//SERVO_ANGE_MIN[4];
  ActiveServo := @VServo1;
  VServoNo := 1;
  InterruptsEnable;
  repeat
    c := UARTReadChar;
    VMin := SERVO_ANGE_MIN[VServoNo];
    VMax := SERVO_ANGE_MAX[VServoNo];
    case c of
      '1':
      begin
        if VMax >= ActiveServo^.Angle + 10 then
          ActiveServo^.Angle := ActiveServo^.Angle + 10;
      end;
      '2':
      begin                                   
        if VMin <= ActiveServo^.Angle - 10 then
          ActiveServo^.Angle := ActiveServo^.Angle - 10;
      end;
      'p':
      begin
        UARTWrite('Active ');              
        UARTWrite(IntToStr(VServoNo));
        UARTWrite(' ');
        UARTWrite(IntToStr(VServo1.Angle));
        UARTWrite(' ');
        UARTWrite(IntToStr(VServo2.Angle));
        UARTWrite(' ');
        UARTWrite(IntToStr(VServo3.Angle));
        UARTWrite(' ');
        UARTWriteLn(IntToStr(VServo4.Angle));
      end;
      'a':
      begin
        ActiveServo := @VServo1;
        VServoNo := 1;
      end;
      's':
      begin
        ActiveServo := @VServo2;
        VServoNo := 2;
      end;
      'd':
      begin
        ActiveServo := @VServo3;
        VServoNo := 3;
      end;
      'f':
      begin
        ActiveServo := @VServo4;
        VServoNo := 4;
      end;
    end;
  until False;
end.
