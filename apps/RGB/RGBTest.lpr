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
  c: Char;
  Color: TRGBColor;

begin
  UARTConsole.Init(9600);  
  //
  UARTConsole.WriteLnString('start');
  //
  Led.Init(RGB_PIN, 6);
  //Color := Led.Color;
  Color := Default(TRGBColor);
  repeat
    c := UARTConsole.ReadChar;
    case c of
      'r':
        Color.R := Color.R + 10;
      'g':
        Color.G := Color.G + 10;
      'b':
        Color.B := Color.B + 10;
    end;
    UARTConsole.WriteLnFormat('RGB (%d:%d:%d)', [Color.R, Color.G, Color.B]);
    //Led.Color := Color;
  until False;
end.
