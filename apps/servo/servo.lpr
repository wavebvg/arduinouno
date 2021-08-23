program servo;

{$mode objfpc}{$H-}{$Z1}

uses
  ArduinoTools,
  UART,
  Timers,
  ServoI;

var
  Servo1, Servo2, Servo3: TServoI;
  c: Char;
  i: Byte;

begin
  UARTConsole.Init(9600);
  //
  Servo1.Init(11, 0);
  Servo2.Init(12, 0);
  Servo3.Init(13, 0);
  //
  Timer0.OutputModes := [];
  Timer0.CounterModes := [tcmCompareA];
  Timer0.CLKMode := tclkm64;
  //
  Timer1.OutputModes := [];
  Timer1.CounterModes := [];
  Timer1.CLKMode := tclkm64;
  //
  IEnable;
  //
  UARTConsole.WriteLnString('Start');
  repeat
    SleepMicroSecs(500000);
    for i := 0 to ServoCount - 1 do
    begin
      UARTConsole.WriteLnFormat('Servo[%d]: {angle: %d, counter: %d, value: %d, timer: %d}',
        [i, Servos[i].Servo^.Angle, ServoCounter[i], Servos[i].Counter, Timer0Value[i]]);
    end;
    c := UARTConsole.ReadChar;
    case c of
      '-':
        if Servo1.Angle > 0 then
          Servo1.Angle := Servo1.Angle - 1;
      '+':
        if Servo1.Angle < 180 then
          Servo1.Angle := Servo1.Angle + 1;
      '9':
        if Servo2.Angle > 0 then
          Servo2.Angle := Servo2.Angle - 1;
      '6':
        if Servo2.Angle < 180 then
          Servo2.Angle := Servo2.Angle + 1;
    end;
  until False;
end.
