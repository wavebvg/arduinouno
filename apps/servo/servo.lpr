program servo;

{$mode objfpc}{$H-}{$Z1}
//{$MACRO ON}

uses
  ArduinoTools,
  UART,
  Timers,
  ServoI2;

var
  Servo1: TServoI;

begin
  UARTConsole.Init(9600);
  //                    
  Servo1.Init(11, 0);
  //
  Timer0.OutputModes := [];
  Timer0.CounterModes := [tcmOverflow];
  Timer0.CLKMode := tclkm256;
  //                 
  UARTConsole.WriteLnString('Start');
  //
  InterruptsEnable;
  repeat
    UARTConsole.WriteLnFormat('Index: %d', [TestIndex]);
    UARTConsole.WriteLnFormat('Servo value: %d', [Servo1.FValue]);
    UARTConsole.WriteLnFormat('Servo state: %d', [Byte(Servo1.FState)]);
    SleepMicroSecs(1000000);
  until False;
end.
