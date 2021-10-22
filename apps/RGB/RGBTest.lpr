program RGBTest;

{$mode objfpc}{$H-}{$Z1}
{$i ../../src/TimersMacro.inc}

uses
  ArduinoTools,
  UART,
  RGBLed;

const
  RGB_PIN = 2;

var
  Led: TRGBLed;

begin
  //UARTConsole.Init(9600);
  //
  Led.Init(RGB_PIN, 6);
  InternalUpdate(@Led);
  //
  //UARTConsole.WriteLnString('start');
  repeat
  until False;
end.
