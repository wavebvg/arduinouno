program servo;

{$mode objfpc}{$H-}{$Z1}

uses
  ArduinoTools,
  UART,
  Timers,
  ServoI;

var
  Servo0, Servo1, Servo2, Servo3: TServoI;
  c: Char;
  i: Byte;

begin       
  IDisable;
  UARTConsole.Init(9600);
  //
  Timer0.OutputModes := [];
  Timer0.CounterModes := [];
  Timer0.CLKMode := tclkm64;
  //
  Timer1.OutputModes := [];
  Timer1.CounterModes := [];
  Timer1.CLKMode := tclkm64;
  //                 
  Servo0.Init(10, 0);
  Servo1.Init(11, 0);
  Servo2.Init(12, 0);
  Servo3.Init(13, 0);
  //
  UARTConsole.WriteLnString('Start');
  //
  IEnable;
  repeat
    SleepMicroSecs(100000);
    //while SortedServoIndex >= ServoCount do
    //;
    //while SortedServoIndex < ServoCount do
    //;
    IPause;
    for i := 0 to ServoCount - 1 do
    begin
      UARTConsole.WriteLnFormat('Servo[%d]: {angle: %d, value: %d}', [i, Servos[i]^.Angle,
        Servos[i]^.FCounter]);
    end;
    for i := 0 to SortedServoCount - 1 do
    begin
      UARTConsole.WriteLnFormat('Counter[%d]: {begin: %d, count: %d, diff: %d, tmp: %d}',
        [i, ServoBeginCounter, ServoCounter[i], SortedServos[i].Counter, TmpCounter]);
    end;
    IResume;
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
