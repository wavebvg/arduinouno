program IRTest;

{$mode objfpc}{$H-}
{$goto on}

uses
  ArduinoTools,
  UInterrupts;

const
  IR_PIN_PORT: SmallInt = 11;
  INTERVAL = 200;

type
  TIRState = (irsIdle, irsWait);

begin
  //UARTInit;
  //UARTWriteLn('start');
  SleepMicroSecs(3000000);
  //UARTWriteLn('SleepMicroSecs 3000000');
  //Sleep10ms(200);
  //UARTWriteLn('Sleep10ms 2000000');
  repeat
    Sleep10ms(200);
  until False;
end.
