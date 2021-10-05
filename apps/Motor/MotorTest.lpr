program MotorTest;

{$mode objfpc}{$H-}{$Z1}

uses
  ArduinoTools,
  UART,
  Timers,
  PWM;

var
  i: SmallInt;

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
  AnalogWrite(1, 1);
  AnalogWrite(2, 2);
  AnalogWrite(3, 3);
  AnalogWrite(4, 4);
  AnalogWrite(5, 5);
  AnalogWrite(6, 6);
  AnalogWrite(7, 7);
  AnalogWrite(8, 128);
  UARTConsole.WriteLnFormat('PWMChanged: %d', [Ord(PWMChanged)]);
  UARTConsole.WriteLnFormat('PWMCount: %d', [PWMCount]);
  for i := 0 to PWMCount - 1 do
    UARTConsole.WriteLnFormat('  PWM[%d]: %d', [PWMPins[i].Pin, PWMPins[i].Counter]);
  //
  UARTConsole.WriteLnString('Start');
  //
  IEnable;
  SleepMicroSecs(1000000);
  repeat
    IPause;
    UARTConsole.WriteLnFormat('PWMChanged: %d', [Ord(PWMChanged)]);
    UARTConsole.WriteLnFormat('PWMCount: %d', [PWMCount]);
    if PWMCount > 0 then
      for i := 0 to PWMCount - 1 do
        UARTConsole.WriteLnFormat('  PWM[%d]: %d', [PWMPins[i].Pin, PWMPins[i].Counter]);
    UARTConsole.WriteLnFormat('SortedPWMCount: %d', [SortedPWMCount]);
    if SortedPWMCount > 0 then
      for i := 0 to SortedPWMCount - 1 do
        UARTConsole.WriteLnFormat('  PWM[%d]: {counter: %d, value: %d}',
          [i, SortedPWMs[i].Counter, PWMCounter[i]]);
    IResume;
    UARTConsole.ReadChar;
  until False;
end.
