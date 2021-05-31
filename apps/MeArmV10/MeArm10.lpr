program MeArm10;

{$mode objfpc}{$H-}
{$goto on}

uses
  UInterrupts,
  ArduinoTools,
  TimedServo,
  IR,
  KeyMap,
  UART;

const
  IR_PIN_PORT: SmallInt = 11;
  SERVO_COUNT = 4;
  MIN_PIN_PORT: SmallInt = 6;
  SERVO_ANGE_DEF: array[1..SERVO_COUNT] of Byte = (0, 0, 0, 0);
  SERVO_ANGE_MIN: array[1..SERVO_COUNT] of Byte = (0, 0, 0, 0);
  SERVO_ANGE_MAX: array[1..SERVO_COUNT] of Byte = (180, 180, 180, 100);

var
  VIR: TIRReceiver;
  VServos: array[1..SERVO_COUNT] of TTimedServo;
  VServoNo: SmallInt;    
  Value: TIRValue;
  i: Byte;
  VMin, VMax: Byte;
  VUART: TUART;

begin     
  VUART.Init;
  VIR.Init(IR_PIN_PORT);
  InterruptsEnable;
  for i := 1 to SERVO_COUNT do
    VServos[i].Init(MIN_PIN_PORT + i - 1, SERVO_ANGE_DEF[i]);
  VUART.WriteLnString('started2');
  VServoNo := 1;
  repeat
    Value := VIR.Read;
    VUART.WriteLnString(GetKeyName(Value.Command));
    VMin := SERVO_ANGE_MIN[VServoNo];
    VMax := SERVO_ANGE_MAX[VServoNo];
    case Value.Command of
      KeyPLUS:
        if VMax >= VServos[VServoNo].Angle + 10 then
          VServos[VServoNo].Angle := VServos[VServoNo].Angle + 5;
      KeyMINUS:
        if VMin <= VServos[VServoNo].Angle - 10 then
          VServos[VServoNo].Angle := VServos[VServoNo].Angle - 5;
      KeyOK:
      begin
        VUART.WriteString('Active ');
        VUART.WriteString(IntToStr(VServoNo));
        for i := 1 to SERVO_COUNT do
        begin
          VUART.WriteString(' ');
          VUART.WriteLnString(IntToStr(VServos[i].Angle));
        end;
      end;
      KeyA:
        VServoNo := 1;
      KeyB:
        VServoNo := 2;
      KeyC:
        VServoNo := 3;
      KeyD:
        VServoNo := 4;
    end;
  until False;
end.
