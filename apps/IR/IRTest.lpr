program IRTest;

{$mode objfpc}{$H-}
{$goto on}

uses
  ArduinoTools,
  UInterrupts,
  Servo,
  KeyMap,
  IR;

const
  IR_PIN_PORT = 11;

var
  Context: TIRReceiver;
  Value: TIRValue;

begin
  UARTInit;
  Context.Init(IR_PIN_PORT);
  UARTWriteLn('start');
  repeat
    Value := Context.Read;
    UARTWriteLn('Key: ' + GetKeyName(Value.Command));
  until False;
end.
