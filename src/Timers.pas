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
  TTimer2CLKMode = (t2clkmOff, t2clkm1, t2clkm8, t2clkm32, t2clkm64, t2clkm128, t2clkm256, t2clkm1024);

  TTimerSubscribeEventType = (tsetCompareA, tsetCompareB, tsetOverflow);
  TTimerSubscribeEventTypes = set of TTimerSubscribeEventType;

  PCustomTimer = ^TSyncTimer;

  TTimerInterruptEvent = procedure(const ATimer: PCustomTimer; const AType: TTimerSubscribeEventType) of object;
  TTimerInterruptProc = procedure(const ATimer: PCustomTimer; const AType: TTimerSubscribeEventType);

  TTimerSubscriber = packed record
    Event: TMethod;
    EventTypes: TTimerSubscribeEventTypes;
  end;

  TTimerSubscribers = array[1..MAX_INERRUPT_EVENT_SUBSCRIBES] of TTimerSubscriber;

  { TAbstractTimer }

  TAbstractTimer = object
  private
    FSubscribers: TTimerSubscribers;
    procedure DoEvent(const AEventType: TTimerSubscribeEventType);
  public
    constructor Init;
    function Bits: Byte; virtual; abstract;
    function Subscribe(const AEvent: TTimerInterruptEvent; const AEventTypes: TTimerSubscribeEventTypes): Shortint;
      overload;
    function Subscribe(const AEvent: TTimerInterruptProc; const AEventTypes: TTimerSubscribeEventTypes): Shortint;
      overload;
    //procedure Unsubscribe(const AEvent: TTimerInterruptEvent); overload;
    procedure Unsubscribe(const AEvent: TTimerInterruptProc); overload;
  end;

  { TSyncTimer }

  TSyncTimer = object(TAbstractTimer)
  private
  protected
    function GetCTCMode: Boolean; virtual; abstract;
    procedure SetCTCMode(const AValue: Boolean); virtual; abstract;
    function GetCLKMode: TTimerCLKMode; virtual; abstract;
    function GetCounterModes: TTimerCounterModes; virtual; abstract;
    function GetOutputModes: TTimerOutputModes; virtual; abstract;
    procedure SetCLKMode(const AValue: TTimerCLKMode); virtual; abstract;
    procedure SetCounterModes(const AValue: TTimerCounterModes); virtual; abstract;
    procedure SetOutputModes(const AValue: TTimerOutputModes); virtual; abstract;
  public
    property CounterModes: TTimerCounterModes read GetCounterModes write SetCounterModes;
    property OutputModes: TTimerOutputModes read GetOutputModes write SetOutputModes;
    property CLKMode: TTimerCLKMode read GetCLKMode write SetCLKMode;
    property CTCMode: Boolean read GetCTCMode write SetCTCMode;
  end;

  { TTimer0 }

  TTimer0 = object(TSyncTimer)
  private
    function GetCounter: Byte;
    function GetValueA: Byte;
    function GetValueB: Byte;
    procedure SetCounter(const AValue: Byte);
    procedure SetValueA(const AValue: Byte);
    procedure SetValueB(const AValue: Byte);
  protected
    function GetCTCMode: Boolean; virtual;
    procedure SetCTCMode(const AValue: Boolean); virtual;
    function GetCLKMode: TTimerCLKMode; virtual;
    function GetCounterModes: TTimerCounterModes; virtual;
    function GetOutputModes: TTimerOutputModes; virtual;
    procedure SetCLKMode(const AValue: TTimerCLKMode); virtual;
    procedure SetCounterModes(const AValue: TTimerCounterModes); virtual;
    procedure SetOutputModes(const AValue: TTimerOutputModes); virtual;
  public
    function Bits: Byte; virtual;
    //
    property ValueA: Byte read GetValueA write SetValueA;
    property ValueB: Byte read GetValueB write SetValueB;
    property Counter: Byte read GetCounter write SetCounter;
  end;

  { TTimer1 }

  TTimer1 = object(TSyncTimer)
  private
    function GetCounter: Word;
    function GetNoiseCanceler: Boolean;
    function GetValueA: Word;
    function GetValueB: Word;
    procedure SetCounter(const AValue: Word);
    procedure SetNoiseCanceler(const AValue: Boolean);
    procedure SetValueA(const AValue: Word);
    procedure SetValueB(const AValue: Word);
  protected
    function GetCTCMode: Boolean; virtual;
    procedure SetCTCMode(const AValue: Boolean); virtual;
    function GetCLKMode: TTimerCLKMode; virtual;
    function GetCounterModes: TTimerCounterModes; virtual;
    function GetOutputModes: TTimerOutputModes; virtual;
    procedure SetCLKMode(const AValue: TTimerCLKMode); virtual;
    procedure SetCounterModes(const AValue: TTimerCounterModes); virtual;
    procedure SetOutputModes(const AValue: TTimerOutputModes); virtual;
  public
    function Bits: Byte; virtual;
    //
    property ValueA: Word read GetValueA write SetValueA;
    property ValueB: Word read GetValueB write SetValueB;
    property Counter: Word read GetCounter write SetCounter;
    property NoiseCanceler: Boolean read GetNoiseCanceler write SetNoiseCanceler;
  end;

  { TTimer2 }

  TTimer2 = object(TAbstractTimer)
  private
    function GetAsyncMode: Boolean;
    function GetCLKMode: TTimer2CLKMode;
    function GetCounter: Byte;
    function GetCounterModes: TTimerCounterModes;
    function GetCTCMode: Boolean;
    function GetExternalMode: Boolean;
    function GetOutputModes: TTimerOutputModes;
    function GetValueA: Byte;
    function GetValueB: Byte;
    procedure SetAsyncMode(const AValue: Boolean);
    procedure SetCLKMode(const AValue: TTimer2CLKMode);
    procedure SetCounter(const AValue: Byte);
    procedure SetCounterModes(AValue: TTimerCounterModes);
    procedure SetCTCMode(AValue: Boolean);
    procedure SetExternalMode(const AValue: Boolean);
    procedure SetOutputModes(AValue: TTimerOutputModes);
    procedure SetValueA(const AValue: Byte);
    procedure SetValueB(const AValue: Byte);
  public
    function Bits: Byte; virtual;
    //
    property ValueA: Byte read GetValueA write SetValueA;
    property ValueB: Byte read GetValueB write SetValueB;
    property Counter: Byte read GetCounter write SetCounter;
    property ExternalMode: Boolean read GetExternalMode write SetExternalMode;
    property AsyncMode: Boolean read GetAsyncMode write SetAsyncMode;
    property CLKMode: TTimer2CLKMode read GetCLKMode write SetCLKMode;   
    property CTCMode: Boolean read GetCTCMode write SetCTCMode;    
    property OutputModes: TTimerOutputModes read GetOutputModes write SetOutputModes;      
    property CounterModes: TTimerCounterModes read GetCounterModes write SetCounterModes;
  end;

var
  Timer0: TTimer0;
  Timer1: TTimer1;
  Timer2: TTimer2;

var
  CounterCompareA, CounterCompareB, CounterOverflow: LongWord;

implementation

uses
  ArduinoTools;

{ TAbstractTimer }

constructor TAbstractTimer.Init;
begin
  FSubscribers := Default(TTimerSubscribers);
end;

procedure TAbstractTimer.DoEvent(const AEventType: TTimerSubscribeEventType);
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

function TAbstractTimer.Subscribe(const AEvent: TTimerInterruptEvent;
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

function TAbstractTimer.Subscribe(const AEvent: TTimerInterruptProc;
  const AEventTypes: TTimerSubscribeEventTypes): Shortint;
var
  VMethod: TMethod;
begin
  VMethod.Data := nil;
  VMethod.Code := AEvent;
  Result := Subscribe(TTimerInterruptEvent(VMethod), AEventTypes);
end;

//procedure TAbstractTimer.Unsubscribe(const AEvent: TTimerInterruptEvent);
//begin
//  Subscribe(AEvent, []);
//end;

procedure TAbstractTimer.Unsubscribe(const AEvent: TTimerInterruptProc);
begin
  Subscribe(AEvent, []);
end;

{ TTimer0 }

function TTimer0.GetCounter: Byte;
begin
  Result := TCNT0;
end;

function TTimer0.GetValueA: Byte;
begin
  Result := OCR0A;
end;

function TTimer0.GetValueB: Byte;
begin
  Result := OCR0B;
end;

procedure TTimer0.SetCounter(const AValue: Byte);
begin
  TCNT0 := AValue;
end;

procedure TTimer0.SetValueA(const AValue: Byte);
begin
  OCR0A := AValue;
end;

procedure TTimer0.SetValueB(const AValue: Byte);
begin
  OCR0B := AValue;
end;

function TTimer0.GetCTCMode: Boolean;
begin
  Result := TCCR0B and (1 shr WGM02) > 0;
end;

procedure TTimer0.SetCTCMode(const AValue: Boolean);
begin
  TCCR0B := TCCR0B and not (1 shr WGM02) or (Byte(AValue) shr WGM02);
end;

function TTimer0.GetCLKMode: TTimerCLKMode;
begin
  Result := TTimerCLKMode(TCCR0B and %00000111);
end;

function TTimer0.GetCounterModes: TTimerCounterModes;
begin
  Result := TTimerCounterModes(TIMSK0);
end;

function TTimer0.GetOutputModes: TTimerOutputModes;
begin
  Result := TTimerOutputModes(TCCR0A);
end;

procedure TTimer0.SetCLKMode(const AValue: TTimerCLKMode);
begin
  TCCR0B := TCCR0B and %11111000 or Byte(AValue);
end;

procedure TTimer0.SetCounterModes(const AValue: TTimerCounterModes);
begin
  TTimerCounterModes(TIMSK0) := AValue;
end;

procedure TTimer0.SetOutputModes(const AValue: TTimerOutputModes);
begin
  TTimerOutputModes(TCCR0A) := AValue;
end;

function TTimer0.Bits: Byte;
begin
  Result := 8;
end;

{ TTimer1 }

function TTimer1.GetCounter: Word;
begin
  Result := TCNT1;
end;

function TTimer1.GetNoiseCanceler: Boolean;
begin
  Result := TCCR1B and (1 shr ICNC1) > 0;
end;

function TTimer1.GetValueA: Word;
begin
  Result := OCR1A;
end;

function TTimer1.GetValueB: Word;
begin
  Result := OCR1B;
end;

procedure TTimer1.SetCounter(const AValue: Word);
begin
  SetTEMPWord(TCNT1, AValue);
end;

procedure TTimer1.SetNoiseCanceler(const AValue: Boolean);
begin
  TCCR1B := TCCR1B and not (1 shr ICNC1) or (Byte(AValue) shr ICNC1);
end;

procedure TTimer1.SetValueA(const AValue: Word);
begin
  SetTEMPWord(OCR1A, AValue);
end;

procedure TTimer1.SetValueB(const AValue: Word);
begin
  SetTEMPWord(OCR1B, AValue);
end;

function TTimer1.GetCTCMode: Boolean;
begin
  Result := TCCR1B and (1 shr WGM12) > 0;
end;

procedure TTimer1.SetCTCMode(const AValue: Boolean);
begin
  TCCR1B := TCCR1B and not (1 shr WGM12) or (Byte(AValue) shr WGM12){ or (Byte(AValue) shr WGM13)};
end;

function TTimer1.GetCLKMode: TTimerCLKMode;
begin
  Result := TTimerCLKMode(TCCR1B and %00000111);
end;

function TTimer1.GetCounterModes: TTimerCounterModes;
begin
  Result := TTimerCounterModes(TIMSK1);
end;

function TTimer1.GetOutputModes: TTimerOutputModes;
begin
  Result := TTimerOutputModes(TCCR1A);
end;

procedure TTimer1.SetCLKMode(const AValue: TTimerCLKMode);
begin
  TCCR1B := TCCR1B and %11111000 or Byte(AValue);
end;

procedure TTimer1.SetCounterModes(const AValue: TTimerCounterModes);
begin
  TTimerCounterModes(TIMSK1) := AValue;
end;

procedure TTimer1.SetOutputModes(const AValue: TTimerOutputModes);
begin
  TTimerOutputModes(TCCR1A) := AValue;
end;

function TTimer1.Bits: Byte;
begin
  Result := 16;
end;     

{ TTimer2 }

function TTimer2.GetAsyncMode: Boolean;
begin
  Result := ASSR and (1 shr AS2) > 0;
end;

function TTimer2.GetCLKMode: TTimer2CLKMode;
begin
  Result := TTimer2CLKMode(TCCR2B and %00000111);
end;

function TTimer2.GetCounter: Byte;
begin
  Result := TCNT2;
end;

function TTimer2.GetCounterModes: TTimerCounterModes;
begin
  Result := TTimerCounterModes(TIMSK2);
end;

function TTimer2.GetCTCMode: Boolean;
begin
  Result := TCCR2B and (1 shr WGM22) > 0;
end;

function TTimer2.GetExternalMode: Boolean;
begin
  Result := ASSR and (1 shr EXCLK) > 0;
end;

function TTimer2.GetOutputModes: TTimerOutputModes;
begin
  Result := TTimerOutputModes(TCCR0A);
end;

function TTimer2.GetValueA: Byte;
begin
  Result := OCR2A;
end;

function TTimer2.GetValueB: Byte;
begin
  Result := OCR2B;
end;

procedure TTimer2.SetAsyncMode(const AValue: Boolean);
begin
  ASSR := ASSR and not (1 shr AS2) or (Byte(AValue) shr AS2);
end;

procedure TTimer2.SetCLKMode(const AValue: TTimer2CLKMode);
begin
  while ASSR and (1 shr TCR2BUB) > 0 do
  ;
  TCCR2B := TCCR2B and %11111000 or Byte(AValue);
end;

procedure TTimer2.SetCounter(const AValue: Byte);
begin
  while ASSR and (1 shr TCN2UB) > 0 do
  ;
  TCNT2 := AValue;
end;

procedure TTimer2.SetCounterModes(AValue: TTimerCounterModes);
begin
  TTimerCounterModes(TIMSK2) := AValue;
end;

procedure TTimer2.SetCTCMode(AValue: Boolean);
begin
  TCCR2B := TCCR2B and not (1 shr WGM22) or (Byte(AValue) shr WGM22);
end;

procedure TTimer2.SetExternalMode(const AValue: Boolean);
begin
  ASSR := ASSR and not (1 shr EXCLK) or (Byte(AValue) shr EXCLK);
end;

procedure TTimer2.SetOutputModes(AValue: TTimerOutputModes);
begin
  TTimerOutputModes(TCCR2A) := AValue;
end;

procedure TTimer2.SetValueA(const AValue: Byte);
begin
  while ASSR and (1 shr OCR2AUB) > 0 do
  ;
  OCR2A := AValue;
end;

procedure TTimer2.SetValueB(const AValue: Byte);
begin
  while ASSR and (1 shr OCR2BUB) > 0 do
  ;
  OCR2B := AValue;
end;

function TTimer2.Bits: Byte;
begin
  Result := 8;
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

  Timer0.Init;
  Timer1.Init;
  Timer2.Init;

end.
