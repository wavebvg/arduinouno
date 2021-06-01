program IRTest;

{$mode objfpc}{$H-}
{$goto on}

uses
  ArduinoTools,
  UInterrupts,
  Servo,
  KeyMap,
  IR,
  UARTI;

const
  IR_PIN_PORT = 11;

var
  IRData: TIRReceiver;
  Value: TIRValue;

begin
  UARTIConsole.Init(9600);
  IRData.Init(IR_PIN_PORT);
  UARTIConsole.WriteLnString('start');
  repeat
    Value := IRData.Read;
    UARTIConsole.WriteLnString('Key: ' + GetKeyName(Value.Command));
  until False;
end.
