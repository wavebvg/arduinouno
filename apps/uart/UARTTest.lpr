program UARTTest;

{$mode objfpc}{$H-}{$Z1}
{$goto on}

uses
  ArduinoTools,
  UART,
  UARTI;

var
  c: Byte;

begin
  UARTConsole.Init(BaudRate);
  UARTConsole.WriteLnString('Start');
  InterruptsEnable;
  SleepMicroSecs(8000000);
  repeat
    UARTConsole.WriteLnString('Read');
    c := UARTConsole.ReadByte;
    UARTConsole.WriteLnString(Char(c));
  until False;
end.
