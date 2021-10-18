program IRTest;

{$mode objfpc}{$H-}{$Z1}

uses
  ArduinoTools,
  KeyMap,
  IRReceiver,
  Timers,
  UART;

const
  IR_PIN_PORT = 11;

var
  IRData: TIRReceiver;
  Value: TIRValue;

  procedure TestValues(const ADataTime, ASpaceTime: Word);
  begin
    UARTConsole.WriteLnFormat('Normal: %d, asm: %d', [Ord(CalcEvent(ADataTime, ASpaceTime)), Ord(CalcEvent(ADataTime, ASpaceTime))]);
  end;

begin
  UARTConsole.Init(9600);

  TestValues(0, 0);
  TestValues(IR_META_DATA_TIME, IR_META_DATA_TIME div 2);
  TestValues(IR_META_DATA_TIME div 16, IR_META_DATA_TIME div 16);
  TestValues(IR_META_DATA_TIME div 16, IR_META_DATA_TIME * 3 div 16);    
  TestValues(IR_META_DATA_TIME, IR_META_DATA_TIME div 4);
  //IRData.Init(IR_PIN_PORT);

  //Timer0.OutputModes := [];
  //Timer0.CLKMode := tclkm64;
  //
  //IEnable;
  //UARTConsole.WriteLnString('start');
  repeat
  //  Value := IRData.Read;
  //  UARTConsole.WriteLnFormat('Key: %s', [GetKeyName(Value.Command)]);
  until False;
end.
