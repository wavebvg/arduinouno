program UARTTest;

{$mode objfpc}{$H-}
{$goto on}

uses
  ArduinoTools,
  UInterrupts,
  UART,
  UARTI;

var
  c: Byte;

begin
  UARTIConsole.Init(BaudRate);
  UARTIConsole.WriteLnString('Start');
  InterruptsEnable;
  SleepMicroSecs(8000000);
  repeat
    UARTIConsole.WriteLnString('Read');
    c := UARTIConsole.ReadByte;
    UARTIConsole.WriteLnString(Char(c));
  until False;
end.
