program IRTest;

{$mode objfpc}{$H-}{$Z1}

uses
  ArduinoTools,
  UInterrupts,
  KeyMap,
  IR,
  UART;

const
  IR_PIN_PORT = 11;

var
  IRData: TIRReceiver;
  Value: TIRValue;
begin
  UARTConsole.Init(9600);
  IRData.Init(IR_PIN_PORT);
  //
  InterruptsEnable;
  UARTConsole.WriteLnString('start');
  repeat
    Value := IRData.Read;
    UARTConsole.WriteLnString('Key: ' + GetKeyName(Value.Command));
  until False;
end.
