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

var
  MSecs: Longint;

  procedure PrintTime;
  begin
    UARTWriteLn(IntToStr(MSecs));
  end;

begin
  UARTInit;
  UARTWriteLn('start');
  MSecs := 0;
  //repeat
  //  Sleep10ms(INTERVAL);
  //  Inc(MSecs, INTERVAL * 10);
  //  if MSecs mod 2000 = 0 then
  //    PrintTime;
  //until False;   
  SleepMicroSecs(3000000);
  UARTWriteLn('SleepMicroSecs 3000000');
  Sleep10ms(200);
  UARTWriteLn('Sleep10ms 2000000');
  repeat
    Sleep10ms(200);
  until False;
end.
