program TimersTest;

{$mode objfpc}{$H-}{$Z1}

uses
  ArduinoTools,
  UART,
  Timers;

begin
  UARTConsole.Init(9600);
  //
  InterruptsEnable;
  //
  UARTConsole.WriteLnString('start');
  repeat
  until False;
end.
