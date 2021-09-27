program MotorTest;

{$mode objfpc}{$H-}{$Z1}

uses
  UART;

begin
  UARTConsole.Init(9600);
  UARTConsole.WriteLnString('start');
  repeat
  until False;
end.
