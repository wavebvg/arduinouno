program servo;

{$mode objfpc}{$H-}{$Z1}

uses
  ArduinoTools,
  UART,
  Timers,
  ServoI2;

var
  Servo1: TServoI;
  c: Char;

begin
  UARTConsole.Init(9600);
  //                    
  Servo1.Init(11, 0);
  //
  Timer0.OutputModes := [];
  Timer0.CounterModes := [tcmCompareA, tcmOverflow];
  Timer0.CLKMode := tclkm64;
  //
  Timer1.OutputModes := [];
  Timer1.CounterModes := [];
  Timer1.CLKMode := tclkm64;
  //
  InterruptsEnable;
  //                 
  UARTConsole.WriteLnString('Start');
  UARTConsole.WriteLnFormat('SERVO_COUNT_A %d', [SERVO_COUNT_A]);
  UARTConsole.WriteLnFormat('SERVO_COUNT_B %d', [SERVO_COUNT_B]);
  UARTConsole.WriteLnFormat('SERVO_COUNT_D %d', [SERVO_COUNT_D]);
  repeat
    //c := UARTConsole.ReadChar;
    //case c of
    //  '-':
    //    if Servo1.Angle > 0 then
    //      Servo1.Angle := Servo1.Angle - 5;
    //  '+':
    //    if Servo1.Angle < 180 then
    //      Servo1.Angle := Servo1.Angle + 5;
    //end;
    UARTConsole.WriteLnFormat('Angle %d (index: %d, counter: %d, timer: %d)',
      [Servo1.Angle, Servo1.FIndex, Servo1.FCounter, Timer0.ValueA]);
    UARTConsole.WriteLnFormat('Counter %d (%d..%d)', [Counter, BeginCounter, EndCounter]);
    //UARTConsole.WriteLnFormat('ServoInfoCounter %d (index: %d)', [ServoInfoCounter, ServoInfoIndex]);
    SleepMicroSecs(1000000);
  until False;
end.
