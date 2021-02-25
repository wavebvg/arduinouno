unit IRRemoteISR;

{$mode objfpc}{$H-}
{$goto on}

interface    

uses
  ArduinoTools;

const
  RAWBUF = 80;
  USECPERTICK = 50;  // microseconds per clock interrupt tick
  _GAP = 5000; // Minimum map between transmissions
  GAP_TICKS = _GAP div USECPERTICK;
  TIMER_COUNT_TOP = F_CPU div 1000000 * USECPERTICK;

type
  TReceiverState = (rsUndefined0, rsUndefined1, rsIdle, rsMark, rsSpace, rsStop);
  TReceiverData = (rdMark, rdSpace);

  TRawBuffer = array[1..RAWBUF] of byte;

  TIRParams = record
    RecvPin: byte;
    RecvState: TReceiverState;
    LastTime: cardinal;
    Timer: integer;
    RawBuf: TRawBuffer;
    RawLen: byte;
  end;

var
  Params: TIRParams;

implementation


procedure TIMER_INTR_NAME; Alias: 'TIMER_INTR_NAME'; interrupt; public;
var
  VData: TReceiverData;
begin
  VData := TReceiverData(DigitalRead(Params.recvpin));
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
        Params.RawLen := 0;
        Params.Timer := 0;
        Params.RecvState := rsMark;
      end;
    rsMark:
      if VData = rdSpace then
      begin
        Params.RawBuf[Params.RawLen] := Params.Timer;
        Inc(Params.RawLen);
        Params.Timer := 0;
        Params.RecvState := rsSpace;
      end;
    rsSpace:
      if VData = rdMark then
      begin
        Params.RawBuf[Params.RawLen] := Params.Timer;
        Inc(Params.RawLen);
        Params.Timer := 0;
        Params.RecvState := rsMark;
      end
      else
      begin
        if Params.timer > GAP_TICKS then
        begin
          // big SPACE, indicates gap between codes
          // Mark current code as ready for processing
          // Switch to STOP
          // Don't reset timer; keep counting space width
          Params.RecvState := rsStop;
          Params.LastTime := Params.timer;
        end;
      end;
    rsStop:
      if (Params.timer - Params.lastTime > 120) then
      begin
        Params.RawLen := 0;
        Params.Timer := 0;
        Params.RecvState := rsIdle;
      end
      else if VData = rdMark then
      begin
        // reset gap timer
        Params.timer := 0;
      end;
    else
    begin
      // reset gap timer
      Params.timer := 0;
    end;
  end;
end;    

procedure CheckTimer;
begin
  // TCCR2A - регистр управления A.
  TCCR2A := 0;

  // TCCR2B - регистр управления B.
  TCCR2B := 0;

  TCCR2A := TCCR2A or (1 shl WGM0) or (0 shl WGM20);

  TCCR2B := TCCR2B or (0 shl CS22) or (1 shl CS21) or (0 shl CS20);

  OCR2A := TIMER_COUNT_TOP div 8;

  TCNT2 := 0;

  TIMSK2 := TIMSK2 or (1 shl OCIE2A);
end;


end.
