program servotest;

{$mode objfpc}{$H-}{$Z1}

uses
  ArduinoTools,
  UART,
  Timers,
  ServoI;

const
  SERVO_COUNT = 4;

var
  c: Char;
  i: Integer;
  VServos: array[1..SERVO_COUNT] of TServoI;

begin
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
  VServos[1] := Default(TServoI);
  VServos[1].Init(10, 1);
  for i := 2 to SERVO_COUNT do
  begin
    VServos[i] := Default(TServoI);
    VServos[i].Init(10, 0);
  end;
  //
  UARTConsole.WriteLnString('Start');
  //
  IEnable;
  repeat
    SleepMicroSecs(100000);
    IPause;
    for i := 1 to SERVO_COUNT do
      UARTConsole.WriteLnFormat('Servo[%d]: %d', [i, VServos[i].Angle]);
    UARTConsole.WriteLnFormat('SortedServoCount: %d', [SortedServoCount]);
    for i := 0 to SortedServoCount - 1 do
      UARTConsole.WriteLnFormat('Servo[%d]: {counter: %d, value: %d}',
        [i, SortedServos[i].Counter, ServoCounter[i]]);
    IResume;
    c := UARTConsole.ReadChar;
    case c of
      '-':
        if VServos[1].Angle > 0 then
          VServos[1].Angle := VServos[1].Angle - 1;
      '+':
        if VServos[1].Angle < 180 then
          VServos[1].Angle := VServos[1].Angle + 1;
    end;
  until False;
end.
