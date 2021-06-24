unit Timers;

{$mode objfpc}{$H-}{$Z1}

interface

type
  TTimerCounterMode = (tcmOverflow, tcmCompareA, tcmCompareB, tcmUndefined3, tcmUndefined4, tcmCapture);
  TTimerCounterModes = set of TTimerCounterMode;
  TTimerOutputMode = (tomWaveForm, tomUndefined1, tomUndefined2, tomUndefined3, tomA, tomUndefined5, tomB);
  TTimerOutputModes = set of TTimerOutputMode;
  TTimerCLKMode = (tclkmOff, tclkm1, tclkm8, tclkm64, tclkm256, tclkm1024, tclkmT1Up, tclkmT1Down);

  TInterruptEvent = procedure of object;

  { TCustomTimer }

  TCustomTimer = object
  private
    FTCCRXA: Pbyte;
    FTCCRXB: Pbyte;
    FTCCRXC: Pbyte;
    FTIMSKX: Pbyte;
    FOCRXA: PByte;
    FOCRXB: PByte;
    function GetCLKMode: TTimerCLKMode;
    function GetCounterModes: TTimerCounterModes;
    function GetOutputModes: TTimerOutputModes;
    procedure SetCLKMode(AValue: TTimerCLKMode);
    procedure SetCounterModes(const AValue: TTimerCounterModes);
    procedure SetOutputModes(AValue: TTimerOutputModes);
    procedure DoCompareA;
    procedure DoCompareB;
    procedure DoOverflow;
  public
    constructor Init(const ATCCRXA, ATCCRXB, ATCCRXC, ATIMSKX, AOCRXA, AOCRXB: Pbyte);
    property CounterModes: TTimerCounterModes read GetCounterModes write SetCounterModes;
    property OutputModes: TTimerOutputModes read GetOutputModes write SetOutputModes;
    property CLKMode: TTimerCLKMode read GetCLKMode write SetCLKMode;
    //
    procedure SubscribeCompareA(const AEvent: TInterruptEvent);
    procedure UnsubscribeCompareA(const AEvent: TInterruptEvent);
    procedure SubscribeCompareB(const AEvent: TInterruptEvent);
    procedure UnsubscribeCompareB(const AEvent: TInterruptEvent);
    procedure SubscribeOverflow(const AEvent: TInterruptEvent);
    procedure UnsubscribeOverflow(const AEvent: TInterruptEvent);
  end;

  { TTimer16 }

  TTimer16 = object(TCustomTimer)
  private
    function GetNoiseCanceler: Boolean;
    function GetValueA: Word;
    function GetValueB: Word;
    procedure SetNoiseCanceler(AValue: Boolean);
    procedure SetValueA(AValue: Word);
    procedure SetValueB(AValue: Word);
  public
    property NoiseCanceler: Boolean read GetNoiseCanceler write SetNoiseCanceler;
    property ValueA: Word read GetValueA write SetValueA;
    property ValueB: Word read GetValueB write SetValueB;
  end;

var
  Timer1: TTimer16;

implementation

{ TTimer16 }

function TTimer16.GetNoiseCanceler: Boolean;
begin
  Result := FTCCRXB^ and %10000000 > 0;
end;

function TTimer16.GetValueA: Word;
begin
  Result := PWord(FOCRXA)^;
end;

function TTimer16.GetValueB: Word;
begin
  Result := PWord(FOCRXB)^;
end;

procedure TTimer16.SetNoiseCanceler(AValue: Boolean);
begin
  FTCCRXB^ := FTCCRXB^ and %01111111 or (Byte(AValue) shr ICNC1);
end;

procedure TTimer16.SetValueA(AValue: Word);
begin
  PWord(FOCRXA)^ := AValue;
end;

procedure TTimer16.SetValueB(AValue: Word);
begin
  PWord(FOCRXB)^ := AValue;
end;

{ TCustomTimer }

constructor TCustomTimer.Init(const ATCCRXA, ATCCRXB, ATCCRXC, ATIMSKX, AOCRXA,
  AOCRXB: Pbyte);
begin
  FTCCRXA := ATCCRXA;
  FTCCRXB := ATCCRXB;
  FTCCRXC := ATCCRXC;
  FTIMSKX := ATIMSKX;
  FOCRXA := AOCRXA;
  FOCRXB := AOCRXB;
end;

function TCustomTimer.GetCounterModes: TTimerCounterModes;
begin
  Result := TTimerCounterModes(FTIMSKX^);
end;

function TCustomTimer.GetCLKMode: TTimerCLKMode;
begin
  Result := TTimerCLKMode(FTCCRXB^ and %00000111);
end;

function TCustomTimer.GetOutputModes: TTimerOutputModes;
begin
  Result := TTimerOutputModes(FTCCRXA^);
end;

procedure TCustomTimer.SetCLKMode(AValue: TTimerCLKMode);
begin
  FTCCRXB^ := FTCCRXB^ and %11111000 or Byte(AValue);
end;

procedure TCustomTimer.SetCounterModes(const AValue: TTimerCounterModes);
begin
  TTimerCounterModes(FTIMSKX^) := AValue;
end;

procedure TCustomTimer.SetOutputModes(AValue: TTimerOutputModes);
begin
  TTimerOutputModes(FTCCRXA^) := AValue;
end;

procedure TCustomTimer.DoCompareA;
begin

end;

procedure TCustomTimer.DoCompareB;
begin

end;

procedure TCustomTimer.DoOverflow;
begin

end;

procedure TIMER1_COMPA_ISR; public Name 'TIMER1_COMPA_ISR'; interrupt;
begin
  Timer1.DoCompareA;
end;

procedure TIMER1_COMPB_ISR; public Name 'TIMER1_COMPB_ISR'; interrupt;
begin
  Timer1.DoCompareB;
end;

procedure TIMER1_OVF_ISR; public Name 'TIMER1_OVF_ISR'; interrupt;
begin
  Timer1.DoOverflow;
end;

initialization

  Timer1.Init(@TCCR1A, @TCCR1B, @TCCR1C, @TIMSK1, @OCR1A, @OCR1B);

end.
