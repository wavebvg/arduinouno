program UARTTest;

{$mode objfpc}{$H-}{$Z1}
{$goto on}

uses
  ArduinoTools,
  UART;

begin
  UARTConsole.Init(BaudRate);
  UARTConsole.WriteLnString('Start');
  UARTConsole.WriteFormat('1: %d, 2: %d', [100000, 2147483647]);
  repeat
  until False;
end.
