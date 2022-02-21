program RGBTest;

{$mode objfpc}{$H-}{$Z1}

uses
  ArduinoTools,
  RGBLed;

const
  RGB_PIN = 2;

var
  Led: TRGBLeds;
  Color: TRGBColor;

begin
  //Led.Init(RGB_PIN, 6);
  Color.R := 255;
  Color.G := 0;
  Color.B := 0;
  Led.AllColors := Color;
  Color.R := 0;
  Color.G := 255;
  Color.B := 0;
  Led.AllColors := Color;
  Color.R := 0;
  Color.G := 0;
  Color.B := 255;
  Led.AllColors := Color;
end.
