program RGBTest;

{$mode objfpc}{$H-}{$Z1}
{.$DEFINE EMIL}

uses
  ArduinoTools,
  UART,
  RGBLed;

const
  RGB_PIN = 2;

var
  Led: TRGBLeds;
  Color: TRGBColor;

begin
{$IFNDEF EMIL}
  UARTConsole.Init(9600);
  UARTConsole.WriteLnString('Start');
  Led.Init(RGB_PIN, 12);
{$ENDIF EMIL}
  repeat
    Color.R := 255;
    Color.G := 1;
    Color.B := 1;
{$IFNDEF EMIL}
    UARTConsole.WriteLnString('Red');
{$ENDIF EMIL}
    Led.BeginUpdate;
    Led.AllColors := Color;
    Led.EndUpdate;
{$IFNDEF EMIL}
    SleepMicroSecs(1000000);
    Color.R := 0;
    Color.G := 255;
    Color.B := 0;
    UARTConsole.WriteLnString('Green');
    Led.AllColors := Color;
    SleepMicroSecs(1000000);
    Color.R := 0;
    Color.G := 0;
    Color.B := 255;
    UARTConsole.WriteLnString('Blue');
    Led.AllColors := Color;
    SleepMicroSecs(1000000); 
{$ENDIF EMIL}
  until False;
end.
