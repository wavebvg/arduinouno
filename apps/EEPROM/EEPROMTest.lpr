program EEPROMTest;

{$mode objfpc}{$H-}{$Z1}

uses
  ArduinoTools,
  UARTI,
  EEPROM;

var
  VValue: Word;

begin
  UARTConsole.Init(BaudRate);
  IEnable;
  //
  UARTConsole.WriteLnString('Start');  
  SleepMicroSecs(100000);
  //
  VValue := 10400;
  UARTConsole.WriteLnFormat('Write value %d', [VValue]);
  ROM.WriteBuffer(0, @VValue, SizeOf(VValue));
  VValue := 0;
  UARTConsole.WriteLnFormat('Reset value to %d', [VValue]);
  ROM.ReadBuffer(2, @VValue, SizeOf(VValue));
  UARTConsole.WriteLnFormat('Read value %d', [VValue]);
  //
  repeat
  until False;
end.
