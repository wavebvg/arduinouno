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
  repeat
    while not UARTConsole.ReadBufferEmpty do
    begin
      c := UARTConsole.ReadByte;
      UARTConsole.WriteString(Char(c));
    end;
    UARTConsole.WriteLnString('');
    UARTConsole.WriteLnString('Read wait');
    SleepMicroSecs(10000000);
    UARTConsole.WriteLnString('Read start');
    c := UARTConsole.ReadByte;
    UARTConsole.WriteString(Char(c));
  until False;
end.
