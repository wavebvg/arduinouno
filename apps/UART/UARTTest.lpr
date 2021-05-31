program UARTTest;

{$mode objfpc}{$H-}
{$goto on}

uses
  ArduinoTools,
  UInterrupts,
  UART,
  UARTI;

var
  VUART: TUARTI;
  c: Byte;

begin
  VUART.Init(BaudRate);
  VUART.WriteLnString('Start');
  repeat
    c := VUART.ReadByte;
    VUART.WriteLnString(Char(c));
  until False;
end.
