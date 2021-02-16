unit UIRRemote;

{$mode objfpc}{$H-}
{$goto on}

interface

implementation

uses
  ArduinoTools;

const
  RAWBUF = 80;                   
  USECPERTICK = 50;  // microseconds per clock interrupt tick
  _GAP = 5000; // Minimum map between transmissions
  GAP_TICKS =_GAP div USECPERTICK;

type
  TReceiverState = (rsUndefined0, rsUndefined1, rsIdle, rsMark, rsSpace, rsStop);
  TReceiverData = (rdMark, rdSpace);

  TRawBuffer = array[1..RAWBUF] of Byte;
  TIRParams = record
    RecvPin: Byte;
    RecvState: TReceiverState;
    LastTime: Cardinal;
    Timer: Integer;
    RawBuf: TRawBuffer;
    RawLen: Byte;
  end;

var
  _Params: TIRParams;
  Params: TIRParams absolute _Params;


procedure TIMER_INTR_NAME_;{ Alias: TIMER_INTR_NAME; interrupt; public;}
var
  VData: TReceiverData;
begin    
  // Serial.println("ISR");
  // Serial.println(millis());
  VData := TReceiverData(DigitalRead(Params.recvpin));
  // uint32_t new_time = micros();
  // uint8_t timer = (new_time - irparams.lastTime)>>6;
  Inc(Params.timer); // One more 50us tick
  if Params.rawlen >= RAWBUF then
  begin
    // Buffer overflow
    Params.RecvState := rsStop;
  end;
  case Params.RecvState of
  rsIdle:
    if VData = rdMark then
    begin
      Params.RawLen:=  0;
      Params.Timer:=  0;
      Params.RecvState:=  rsMark;
    end;
  rsMark:
    if VData = rdSpace then
    begin
      Params.RawBuf[Params.RawLen]:=  Params.Timer;
      Inc(Params.RawLen);
      Params.Timer:=  0;
      Params.RecvState:=  rsSpace;
    end;
  rsSpace:
    if VData = rdMark then
    begin
      Params.RawBuf[Params.RawLen]:=  Params.Timer; 
      Inc(Params.RawLen);
      Params.Timer:=  0;
      Params.RecvState:=  rsMark;
    end else
    begin
        if Params.timer > GAP_TICKS then begin
          // big SPACE, indicates gap between codes
          // Mark current code as ready for processing
          // Switch to STOP
          // Don't reset timer; keep counting space width
          Params.RecvState := rsStop;
          (*Params.LastTime := millis();*)
          // TODO : реализовать millis в ArduinoTools
        end;
    end;
  rsStop:
      (*if(millis() - Params.lastTime > 120) then*)
      begin
        Params.RawLen := 0;
        Params.Timer := 0;
        Params.RecvState := rsIdle;
      end
      (*else if VData = rdMark then
      begin
        // reset gap timer
        Params.timer := 0;
      end*);
  end;
end;


end.

