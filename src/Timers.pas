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
    EventTypes: TTimerSubscribeEventTypes;
  end;

  TTimerSubscribers = array[1..MAX_INERRUPT_EVENT_SUBSCRIBES] of TTimerSubscriber;

  { TCustomTimer }

  TCustomTimer = object
  private
    FTCCRXA: Pbyte;
    FTCCRXB: Pbyte;
    FTIMSKX: Pbyte;
    FOCRXA: Pbyte;
    FOCRXB: Pbyte;
    FTCNTX: Pbyte;
    FSubscribers: TTimerSubscribers;
    procedure DoEvent(const AEventType: TTimerSubscribeEventType);
    function GetCTCMode: Boolean;
    procedure SetCTCMode(const AValue: Boolean);
  protected
    function GetCLKMode: TTimerCLKMode;
    function GetCounterModes: TTimerCounterModes;
    function GetOutputModes: TTimerOutputModes;
    procedure SetCLKMode(const AValue: TTimerCLKMode);
    procedure SetCounterModes(const AValue: TTimerCounterModes);
    procedure SetOutputModes(const AValue: TTimerOutputModes);
  public
    constructor Init(const ATCCRXA, ATCCRXB, ATIMSKX, AOCRXA, AOCRXB, ATCNTX: Pbyte);
    property CounterModes: TTimerCounterModes read GetCounterModes write SetCounterModes;
    property OutputModes: TTimerOutputModes read GetOutputModes write SetOutputModes;
    property CLKMode: TTimerCLKMode read GetCLKMode write SetCLKMode;
    property CTCMode: Boolean read GetCTCMode write SetCTCMode;
    //
    function Bits: Byte; virtual; abstract;
    function Subscribe(const AEvent: TTimerInterruptEvent; const AEventTypes: TTimerSubscribeEventTypes): Shortint;
      overload;
    function Subscribe(const AEvent: TTimerInterruptProc; const AEventTypes: TTimerSubscribeEventTypes): Shortint;
      overload;
    procedure Unsubscribe(const AEvent: TTimerInterruptEvent); overload;
    procedure Unsubscribe(const AEvent: TTimerInterruptProc); overload;
  end;

  PTimer16 = ^TTimer16;

  { TTimer16 }

  TTimer16 = object(TCustomTimer)
  private
    function GetCounter: Word;
    function GetNoiseCanceler: Boolean;
    function GetValueA: Word;
    function GetValueB: Word;
    procedure SetCounter(const AValue: Word);
    procedure SetNoiseCanceler(const AValue: Boolean);
    procedure SetValueA(const AValue: Word);
    procedure SetValueB(const AValue: Word);
  public
    property ValueA: Word read GetValueA write SetValueA;
    property ValueB: Word read GetValueB write SetValueB;
    //                            
    function Bits: Byte; virtual;
    property Counter: Word read GetCounter write SetCounter;
    property NoiseCanceler: Boolean read GetNoiseCanceler write SetNoiseCanceler;
  end;

  PTimer8 = ^TTimer8;

  { TTimer8 }

  TTimer8 = object(TCustomTimer)
  private
    function GetCounter: Byte;
    function GetValueA: Byte;
    function GetValueB: Byte;
    procedure SetCounter(const AValue: Byte);
    procedure SetValueA(const AValue: Byte);
    procedure SetValueB(const AValue: Byte);
  public
    property ValueA: Byte read GetValueA write SetValueA;
    property ValueB: Byte read GetValueB write SetValueB;
    //           
    function Bits: Byte; virtual;
    property Counter: Byte read GetCounter write SetCounter;
  end;

var
  Timer0: TTimer8;
  Timer1: TTimer16;
  Timer2: TTimer8;

var
  CounterCompareA, CounterCompareB, CounterOverflow: Byte;

implementation

uses
  ArduinoTools;

{ TTimer8 }

function TTimer8.GetCounter: Byte;
begin
  Result := FTCNTX^;
end;

function TTimer8.GetValueA: Byte;
begin
  Result := FOCRXA^;
end;

function TTimer8.GetValueB: Byte;
begin
  Result := FOCRXB^;
end;

procedure TTimer8.SetCounter(const AValue: Byte);
begin
  FTCNTX^ := AValue;
end;

procedure TTimer8.SetValueA(const AValue: Byte);
begin
  FOCRXA^ := AValue;
end;

procedure TTimer8.SetValueB(const AValue: Byte);
begin
  FOCRXB^ := AValue;
end;

function TTimer8.Bits: Byte;
begin
  Result := 8;
end;

{ TTimer16 }

function TTimer16.GetCounter: Word;
begin
  Result := PWord(FTCNTX)^;
end;

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

procedure TTimer16.SetCounter(const AValue: Word);
begin
  PWord(FTCNTX)^ := AValue;
end;

procedure TTimer16.SetNoiseCanceler(const AValue: Boolean);
begin
  FTCCRXB^ := FTCCRXB^ and %01111111 or (Byte(AValue) shr ICNC1);
end;

procedure TTimer16.SetValueA(const AValue: Word);
begin
  SetTEMPWord(FOCRXA, AValue);
end;

procedure TTimer16.SetValueB(const AValue: Word);
begin
  SetTEMPWord(FOCRXB, AValue);
end;

function TTimer16.Bits: Byte;
begin
  Result := 16;
end;

{ TCustomTimer }

constructor TCustomTimer.Init(const ATCCRXA, ATCCRXB, ATIMSKX, AOCRXA, AOCRXB, ATCNTX: Pbyte);
begin
  FSubscribers := Default(TTimerSubscribers);
  SetPByteReg(FTCCRXA, ATCCRXA);
  SetPByteReg(FTCCRXB, ATCCRXB);
  SetPByteReg(FTIMSKX, ATIMSKX);
  SetPByteReg(FOCRXA, AOCRXA);
  SetPByteReg(FOCRXB, AOCRXB);
  SetPByteReg(FTCNTX, ATCNTX);
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
      Break;
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
        VExist := True;
        Result := i;
        Break;
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

function TCustomTimer.GetCTCMode: Boolean;
begin
  Result := FTCCRXB^ and (1 shr WGM12) > 0;
end;

function TCustomTimer.GetOutputModes: TTimerOutputModes;
begin
  Result := TTimerOutputModes(FTCCRXA^);
end;

procedure TCustomTimer.SetCLKMode(const AValue: TTimerCLKMode);
begin
  FTCCRXB^ := FTCCRXB^ and %11111000 or Byte(AValue);
end;

procedure TCustomTimer.SetCTCMode(const AValue: Boolean);
begin
  FTCCRXB^ := FTCCRXB^ and not (1 shr WGM12) or (Byte(AValue) shr WGM12){ or (Byte(AValue) shr WGM13)};
end;

procedure TCustomTimer.SetCounterModes(const AValue: TTimerCounterModes);
begin
  TTimerCounterModes(FTIMSKX^) := AValue;
end;

procedure TCustomTimer.SetOutputModes(const AValue: TTimerOutputModes);
begin
  TTimerOutputModes(FTCCRXA^) := AValue;
end;

procedure TCustomTimer.DoEvent(const AEventType: TTimerSubscribeEventType);
var
  i: Byte;
  VSubscriber: TTimerSubscriber;
begin
  //UARTConsole.WriteLnString('DoEvent');
  for i := 1 to MAX_INERRUPT_EVENT_SUBSCRIBES do
    if AEventType in FSubscribers[i].EventTypes then
    begin
      VSubscriber := FSubscribers[i];
      if VSubscriber.Event.Data = nil then
      begin
        TTimerInterruptProc(VSubscriber.Event.Code)(@Self, AEventType);
      end
      else
      begin
        TTimerInterruptEvent(VSubscriber.Event)(@Self, AEventType);
      end;
    end;
end;

procedure TIMER0_COMPA_ISR; public Name 'TIMER0_COMPA_ISR'; interrupt;
begin
  Timer0.DoEvent(tsetCompareA);
end;

procedure TIMER0_COMPB_ISR; public Name 'TIMER0_COMPB_ISR'; interrupt;
begin
  Timer0.DoEvent(tsetCompareB);
end;

procedure TIMER0_OVF_ISR; public Name 'TIMER0_OVF_ISR'; interrupt;
begin
  Timer0.DoEvent(tsetOverflow);
end;

procedure TIMER1_COMPA_ISR; public Name 'TIMER1_COMPA_ISR'; interrupt;
begin
  Timer1.DoEvent(tsetCompareA);
end;

procedure TIMER1_COMPB_ISR; public Name 'TIMER1_COMPB_ISR'; interrupt;
begin
  Timer1.DoEvent(tsetCompareB);
end;

procedure TIMER1_OVF_ISR; public Name 'TIMER1_OVF_ISR'; interrupt;
begin
  Timer1.DoEvent(tsetOverflow);
end;    

procedure TIMER2_COMPA_ISR; public Name 'TIMER2_COMPA_ISR'; interrupt;
begin
  Timer2.DoEvent(tsetCompareA);
end;

procedure TIMER2_COMPB_ISR; public Name 'TIMER2_COMPB_ISR'; interrupt;
begin
  Timer2.DoEvent(tsetCompareB);
end;

procedure TIMER2_OVF_ISR; public Name 'TIMER2_OVF_ISR'; interrupt;
begin
  Timer2.DoEvent(tsetOverflow);
end;

initialization

  Timer0.Init(@TCCR0A, @TCCR0B, @TIMSK0, @OCR0A, @OCR0B, @TCNT0);
  Timer1.Init(@TCCR1A, @TCCR1B, @TIMSK1, @OCR1A, @OCR1B, @TCNT1);
  Timer2.Init(@TCCR2A, @TCCR2B, @TIMSK2, @OCR2A, @OCR2B, @TCNT2);

end.
