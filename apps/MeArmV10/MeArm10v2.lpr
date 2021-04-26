program MeArm10v2;

{$mode objfpc}{$H-}
{$goto on}

uses
  UInterrupts,
  ArduinoTools,
  TimedServo;

const
  SERVO_COUNT = 4;
  MIN_PIN_PORT: SmallInt = 9;
  SERVO_ANGE_DEF: array[1..SERVO_COUNT] of Byte = (0, 0, 0, 0);
  SERVO_ANGE_MIN: array[1..SERVO_COUNT] of Byte = (0, 0, 0, 0);
  SERVO_ANGE_MAX: array[1..SERVO_COUNT] of Byte = (180, 180, 180, 100);

var
  VServos: array[1..SERVO_COUNT] of TTimedServo;
  VServoNo: SmallInt;
  c: Char;
  i: Byte;
  VMin, VMax: Byte;

begin
  UARTInit;     
  InterruptsEnable;
  for i := 1 to SERVO_COUNT do
    VServos[i].Init(MIN_PIN_PORT + i - 1, SERVO_ANGE_DEF[i]);
  VServoNo := 1;
  repeat
    c := UARTReadChar;
    VMin := SERVO_ANGE_MIN[VServoNo];
    VMax := SERVO_ANGE_MAX[VServoNo];
    case c of
      '1':
        if VMax >= VServos[VServoNo].Angle + 10 then
          VServos[VServoNo].Angle := VServos[VServoNo].Angle + 10;
      '2':
        if VMin <= VServos[VServoNo].Angle - 10 then
          VServos[VServoNo].Angle := VServos[VServoNo].Angle - 10;
      'p':
      begin
        UARTWrite('Active ');
        UARTWrite(IntToStr(VServoNo));
        for i := 1 to SERVO_COUNT do
        begin
          UARTWrite(' ');
          UARTWrite(IntToStr(VServos[i].Angle));
        end;
      end;
      'a':
        VServoNo := 1;
      's':
        VServoNo := 2;
      'd':
        VServoNo := 3;
      'f':
        VServoNo := 4;
    end;
  until False;
end.
