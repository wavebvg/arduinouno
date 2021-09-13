program IRTest;

{$mode objfpc}{$H-}{$Z1}

uses
  ArduinoTools,
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
  IEnable;
  UARTConsole.WriteLnString('start');
  repeat
    Value := IRData.Read;
    UARTConsole.WriteLnFormat('Key: %s', [GetKeyName(Value.Command)]);
  until False;
end.
