program servotest;

{$mode objfpc}{$H-}{$Z1}

uses
  ArduinoTools,
  UART,
  Timers,
  Servo;

var
  c: Char;
  VServo: TServo;

begin
  UARTConsole.Init(9600);
  //
  Timer0.OutputModes := [];
  Timer0.CounterModes := [];
  Timer0.CLKMode := tclkm64;
  //             
  VServo.Init(10, 0);
  //
  UARTConsole.WriteLnString('Start');
  //
  IEnable;
  repeat
    SleepMicroSecs(100000);
    //IPause;
    UARTConsole.WriteLnFormat('Servo.angle: %d', [VServo.Angle]);
    //IResume;
    c := UARTConsole.ReadChar;
    case c of
      '-':
        if VServo.Angle > 0 then
          VServo.Angle := VServo.Angle - 1;
      '+':
        if VServo.Angle < 180 then
          VServo.Angle := VServo.Angle + 1;
    end;
  until False;
end.
