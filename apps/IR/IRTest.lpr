program IRTest;

{$mode objfpc}{$H-}
{$goto on}

uses
  ArduinoTools,
  UInterrupts,
  IRRemote,
  IRRemoteISR;

const
  IR_PIN_PORT: SmallInt = 11;

type
  TIRState = (irsIdle, irsWait);

var
  VValue: Boolean;
  VState: TIRState;
  VTimer: Integer;
  VCounter: Integer;

begin
  UARTInit;
  VCounter := 0;
  VTimer := 0;
  VState := irsIdle;
  repeat
    Inc(VCounter);
    VValue := DigitalRead(IR_PIN_PORT);
    if VValue then
    begin
      Inc(VTimer);
      case VState of
        irsIdle:
          VState := irsIdle;
        irsWait: ;
      end;
    end
    else
    begin
      case VState of
        irsIdle: ;
        irsWait:
        begin
          VState := irsIdle;
          UARTWrite('Key pressed timer: ');
          UARTWriteLn(IntToStr(VTimer));
          VTimer := 0;
        end;
      end;
    end;
    if VCounter div 100000 = 0 then
      UARTWriteLn(IntToStr(Ord(VValue)));
  until False;
end.
