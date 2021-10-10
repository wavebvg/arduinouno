program IRSensorTest;

{$mode objfpc}{$H-}{$Z1}

uses
  ArduinoTools,
  Timers,
  UART;

const
  //IR_PIN = 12;
  IR_PIN = 19; //A5

  procedure PrintDigitalValue(const ANewValue: Boolean);
  begin
    if DigitalRead(13) then
      UARTConsole.WriteLnString('before true')
    else
      UARTConsole.WriteLnString('before false');
    if ANewValue then
      UARTConsole.WriteLnString('set true')
    else
      UARTConsole.WriteLnString('set false');
    DigitalWrite2(13, ANewValue);
    if DigitalRead(13) then
      UARTConsole.WriteLnString('after true')
    else
      UARTConsole.WriteLnString('after false');
    UARTConsole.WriteLnString('----');
  end;

begin
  UARTConsole.Init(BaudRate);
  PinMode(IR_PIN, avrmInput);
  PinMode(13, avrmOutput);
  PrintDigitalValue(True);
  PrintDigitalValue(False);
  PrintDigitalValue(True);
  PrintDigitalValue(False);
  repeat
    if DigitalRead(IR_PIN) then
      UARTConsole.WriteLnString('NO BARIER')
    else
      UARTConsole.WriteLnString('BARIER');
    SleepMicroSecs(1000000);
  until False;
end.
