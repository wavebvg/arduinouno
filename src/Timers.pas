unit Timers;

{$mode objfpc}{$H-}{$Z1}

interface

const
  MAX_INERRUPT_EVENT_SUBSCRIBES = 8;

type
  TTimerCounterMode = (tcmOverflow, tcmCompareA, tcmCompareB, tcmUndefined3, tcmUndefined4, tcmCapture);
  TTimerCounterModes = set of TTimerCounterMode;

  TTimerOutputMode = (tomWaveForm, tomUndefined1, tomUndefined2, tomUndefined3, tomA, tomUndefined5, tomB);
  TTimerOutputModes = set of TTimerOutputMode;

  TTimerCLKMode = (tclkmOff, tclkm1, tclkm8, tclkm64, tclkm256, tclkm1024, tclkmT1Up, tclkmT1Down);

  TTimerSubscribeEventType = (tsetCompareA, tsetCompareB, tsetOverflow);
  TTimerSubscribeEventTypes = set of TTimerSubscribeEventType;

  PCustomTimer = ^TCustomTimer;

  TTimerInterruptEvent = procedure(const ATimer: PCustomTimer; const AType: TTimerSubscribeEventType) of object;
  TTimerInterruptProc = procedure(const ATimer: PCustomTimer; const AType: TTimerSubscribeEventType);

  TTimerSubscriber = packed record
    Event: TMethod;
    HasProc: Boolean;
    EventTypes: TTimerSubscribeEventTypes;
  end;

  TTimerSubscribers = array[1..MAX_INERRUPT_EVENT_SUBSCRIBES] of TTimerSubscriber;

  { TCustomTimer }

  TCustomTimer = object
  private
    FTCCRXA: Pbyte;
    FTCCRXB: Pbyte;
    FTCCRXC: Pbyte;
    FTIMSKX: Pbyte;
    FOCRXA: Pbyte;
    FOCRXB: Pbyte;
    FSubscribers: TTimerSubscribers;
    procedure DoEvent(const AEventType: TTimerSubscribeEventType);
    procedure DoCompareA;
    procedure DoCompareB;
    procedure DoOverflow;
  protected
    function GetCLKMode: TTimerCLKMode;
    function GetCounterModes: TTimerCounterModes;
    function GetOutputModes: TTimerOutputModes;
    procedure SetCLKMode(AValue: TTimerCLKMode);
    procedure SetCounterModes(const AValue: TTimerCounterModes);
    procedure SetOutputModes(AValue: TTimerOutputModes);
  public
    constructor Init(const ATCCRXA, ATCCRXB, ATCCRXC, ATIMSKX, AOCRXA, AOCRXB: Pbyte);
    property CounterModes: TTimerCounterModes read GetCounterModes write SetCounterModes;
    property OutputModes: TTimerOutputModes read GetOutputModes write SetOutputModes;
    property CLKMode: TTimerCLKMode read GetCLKMode write SetCLKMode;
    //
    function Subscribe(const AEvent: TTimerInterruptEvent; const AEventTypes: TTimerSubscribeEventTypes): Shortint;
      overload;
    function Subscribe(const AEvent: TTimerInterruptProc; const AEventTypes: TTimerSubscribeEventTypes): Shortint;
      overload;
    procedure Unsubscribe(const AEvent: TTimerInterruptEvent); overload;
    procedure Unsubscribe(const AEvent: TTimerInterruptProc); overload;
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

constructor TCustomTimer.Init(const ATCCRXA, ATCCRXB, ATCCRXC, ATIMSKX, AOCRXA, AOCRXB: Pbyte);
begin
  FTCCRXA := ATCCRXA;
  FTCCRXB := ATCCRXB;
  FTCCRXC := ATCCRXC;
  FTIMSKX := ATIMSKX;
  FOCRXA := AOCRXA;
  FOCRXB := AOCRXB;
end;

function TCustomTimer.Subscribe(const AEvent: TTimerInterruptEvent;
  const AEventTypes: TTimerSubscribeEventTypes): Shortint;
var
  i: Byte;
  VExist: Boolean;
begin
  VExist := False;
  for i := 1 to MAX_INERRUPT_EVENT_SUBSCRIBES do
    if (FSubscribers[i].Event.Data = TMethod(AEvent).Data) and (FSubscribers[i].Event.Code = TMethod(AEvent).Code) then
    begin
      FSubscribers[i].EventTypes := AEventTypes;
      VExist := True;
      Result := i;
    end;
  if AEventTypes = [] then
  begin
    Result := -1;
  end
  else
  if not VExist then
  begin
    for i := 1 to MAX_INERRUPT_EVENT_SUBSCRIBES do
      if FSubscribers[i].EventTypes = [] then
      begin
        FSubscribers[i].Event := TMethod(AEvent);
        FSubscribers[i].EventTypes := AEventTypes;
        FSubscribers[i].HasProc := False;
        VExist := True;
        Result := i;
      end;
    if not VExist then
      Result := -1;
  end;
end;

function TCustomTimer.Subscribe(const AEvent: TTimerInterruptProc;
  const AEventTypes: TTimerSubscribeEventTypes): Shortint;
var
  VMethod: TMethod;
begin
  VMethod.Data := nil;
  VMethod.Code := AEvent;
  Result := Subscribe(TTimerInterruptEvent(VMethod), AEventTypes);
end;

procedure TCustomTimer.Unsubscribe(const AEvent: TTimerInterruptEvent);
begin
  Subscribe(AEvent, []);
end;

procedure TCustomTimer.Unsubscribe(const AEvent: TTimerInterruptProc);
begin
  Subscribe(AEvent, []);
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

procedure TCustomTimer.DoEvent(const AEventType: TTimerSubscribeEventType);
var
  i: Byte;
  VSubscriber: TTimerSubscriber;
begin
  for i := 0 to MAX_INERRUPT_EVENT_SUBSCRIBES do
    if AEventType in FSubscribers[i].EventTypes then
    begin
      VSubscriber := FSubscribers[i];
      if VSubscriber.HasProc then
        TTimerInterruptProc(VSubscriber.Event.Code)(@Self, AEventType)
      else
        TTimerInterruptEvent(VSubscriber.Event)(@Self, AEventType);
    end;
end;

procedure TCustomTimer.DoCompareA;
begin
  DoEvent(tsetCompareA);
end;

procedure TCustomTimer.DoCompareB;
begin
  DoEvent(tsetCompareB);
end;

procedure TCustomTimer.DoOverflow;
begin
  DoEvent(tsetOverflow);
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
