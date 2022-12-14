unit Timers;

{$mode objfpc}{$H-}{$Z1}
{$i TimersMacro.inc}

interface

const
  MAX_INTERRUPT_EVENT_SUBSCRIBES = 8;

type
  TTimerCounterMode = (tcmOverflow, tcmCompareA, tcmCompareB, tcmUndefined3, tcmUndefined4, tcmCapture);
  TTimerCounterModes = set of TTimerCounterMode;

  TTimerOutputMode = (tomWaveForm, tomUndefined1, tomUndefined2, tomUndefined3, tomFastPWM,
    tomUndefined5, tomPhaseCorrectPWM, tomUndefined7);
  TTimerOutputModes = set of TTimerOutputMode;

  TTimerCLKMode = (tclkmOff, tclkm1, tclkm8, tclkm64, tclkm256, tclkm1024, tclkmT1Up, tclkmT1Down);
  TTimer2CLKMode = (t2clkmOff, t2clkm1, t2clkm8, t2clkm32, t2clkm64, t2clkm128, t2clkm256, t2clkm1024);

  TTimerSubscribeEventType = (tsetCompareA, tsetCompareB, tsetOverflow);
  TTimerSubscribeEventTypes = set of TTimerSubscribeEventType;

  PTimer = ^TAbstractTimer;

  TTimerInterruptEvent = procedure of object;
  TTimerInterruptProc = procedure;

  TTimerSubscriberOFs = array[0..MAX_INTERRUPT_EVENT_SUBSCRIBES - 1] of TMethod;

  { TAbstractTimer }

  TAbstractTimer = object
  private
    FSubscriberOVFs: TTimerSubscriberOFs;
    FSubscriberOFIndex: Byte;
    FCompareAEvent, FCompareBEvent: TTimerInterruptEvent;
    function IndexOfOVFEvent(const AEvent: TTimerInterruptEvent): Shortint;
  protected
    function GetCounterModes: TTimerCounterModes; virtual; abstract;
    procedure SetCounterModes(const AValue: TTimerCounterModes); virtual; abstract;
    function GetOutputModes: TTimerOutputModes; virtual; abstract;
    procedure SetOutputModes(const AValue: TTimerOutputModes); virtual; abstract;
    function GetCTCMode: Boolean; virtual; abstract;
    procedure SetCTCMode(const AValue: Boolean); virtual; abstract;
    procedure DoOVFEvents;
  public
    constructor Init;
    function Bits: Byte; virtual; abstract;
    function SubscribeOVFEvent(const AEvent: TTimerInterruptEvent): Shortint;
    function SubscribeOVFProc(const AProc: TTimerInterruptProc): Shortint;
    procedure UnsubscribeOVFEvent(const AEvent: TTimerInterruptEvent);
    procedure UnsubscribeOVFProc(const AProc: TTimerInterruptProc);
    procedure SetCompareAEvent(const AEvent: TTimerInterruptEvent);
    procedure SetCompareAProc(const AProc: TTimerInterruptProc);
    procedure ClearCompareAEvent;
    procedure SetCompareBEvent(const AEvent: TTimerInterruptEvent);
    procedure SetCompareBProc(const AProc: TTimerInterruptProc);
    procedure ClearCompareBEvent;
    property CounterModes: TTimerCounterModes read GetCounterModes write SetCounterModes;
    property OutputModes: TTimerOutputModes read GetOutputModes write SetOutputModes;
    property CTCMode: Boolean read GetCTCMode write SetCTCMode;
  end;

  { TSyncTimer }

  TSyncTimer = object(TAbstractTimer)
  private
  protected
    function GetCLKMode: TTimerCLKMode; virtual; abstract;
    procedure SetCLKMode(const AValue: TTimerCLKMode); virtual; abstract;
  public
    property CLKMode: TTimerCLKMode read GetCLKMode write SetCLKMode;
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
    procedure SetCLKMode(const AValue: TTimerCLKMode); virtual;
    procedure SetCounterModes(const AValue: TTimerCounterModes); virtual;
    function GetOutputModes: TTimerOutputModes; virtual;
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
    function GetExternalMode: Boolean;
    function GetValueA: Byte;
    function GetValueB: Byte;
    procedure SetAsyncMode(const AValue: Boolean);
    procedure SetCLKMode(const AValue: TTimer2CLKMode);
    procedure SetCounter(const AValue: Byte);
    procedure SetExternalMode(const AValue: Boolean);
    procedure SetValueA(const AValue: Byte);
    procedure SetValueB(const AValue: Byte);
  protected
    function GetCounterModes: TTimerCounterModes; virtual;
    procedure SetCounterModes(const AValue: TTimerCounterModes); virtual;
    function GetOutputModes: TTimerOutputModes; virtual;
    procedure SetOutputModes(const AValue: TTimerOutputModes); virtual;
    function GetCTCMode: Boolean; virtual;
    procedure SetCTCMode(const AValue: Boolean); virtual;
  public
    function Bits: Byte; virtual;
    //
    property ValueA: Byte read GetValueA write SetValueA;
    property ValueB: Byte read GetValueB write SetValueB;
    property Counter: Byte read GetCounter write SetCounter;
    property ExternalMode: Boolean read GetExternalMode write SetExternalMode;
    property AsyncMode: Boolean read GetAsyncMode write SetAsyncMode;
    property CLKMode: TTimer2CLKMode read GetCLKMode write SetCLKMode;
  end;

var
  Timer0: TTimer0;
  Timer1: TTimer1;
  Timer2: TTimer2;

function CalcWordTime(const AOldTime: PWord): Word;    
function PulseIn(const APin: Byte; const AState: Boolean; ATimeOut: Cardinal = 1000000): Cardinal;

implementation

uses
  ArduinoTools;

function PulseIn(const APin: Byte; const AState: Boolean; ATimeOut: Cardinal): Cardinal;
var
  VBitMask, VStateMask: Byte;
  VPort: Pbyte;
  VCounter, VLastCounter: Byte;
begin
  Result := $FFFFFFFF;
  VLastCounter := Timer0_Counter;
  ATimeOut := ATimeOut div 4;
  VBitMask := DigitalPinToBitMask[APin];
  VPort := PortToInput[DigitalPinToPort[APin]];
  //
  if AState then
    VStateMask := VBitMask
  else
    VStateMask := 0;
  //
  while VPort^ and VBitMask = VStateMask do
  begin
    VCounter := Timer0_Counter;
    VLastCounter := VCounter - VLastCounter;
    if ATimeOut <= VLastCounter then
      Exit;
    ATimeOut := ATimeOut - VLastCounter;
    VLastCounter := VCounter;
  end;
  //
  while VPort^ and VBitMask <> VStateMask do
  begin
    VCounter := Timer0_Counter;
    VLastCounter := VCounter - VLastCounter;
    if ATimeOut <= VLastCounter then
      Exit;
    ATimeOut := ATimeOut - VLastCounter;
    VLastCounter := VCounter;
  end;
  //      
  Result := 0;
  while VPort^ and VBitMask = VStateMask do
  begin
    VCounter := Timer0_Counter;
    VLastCounter := VCounter - VLastCounter;
    Result := Result + VLastCounter;
    VLastCounter := VCounter;
    if ATimeOut <= Result then
    begin
      Result := $FFFFFFFF;
      Exit;
    end;
  end;
  //
  if Result <> $FFFFFFFF then
    Result := Result * 4;
end;
         
{$IFDEF PCTEST}    
function CalcWordTime(const AOldTime{R24;R25}: PWord): Word;
begin

end;

{$ELSE}
function CalcWordTime(const AOldTime{R24;R25}: PWord): Word; assembler;
// {Total: 29}
asm
         // CALL                                  {4}
         PUSH    R18  {OldTime}                   {1}
         PUSH    R19  {OldTime}                   {1}
         PUSH    R26  {X} {AOldTime}              {1}
         PUSH    R27  {X} {AOldTime}              {1}
         //
         MOVW    R26, R24                         {1}
         LD      R18, X+                          {2}
         LD      R19, X                           {2}
         //VCounter := Timer1_Counter;
         LDS     R25, TCNT1H {VCounter}           {3}
         LDS     R24, TCNT1L {VCounter}           {3}
         //  Result := VCounter - AOldTime^
         SUB     R24, R18                         {1}
         SBC     R25, R19                         {1}
         //
         POP     R27                              {1}
         POP     R26                              {1}
         POP     R19                              {1}
         POP     R18                              {1}
         // RET                                   {4}
end;   
{$ENDIF}

{ TAbstractTimer }

procedure TAbstractTimer.DoOVFEvents;
var
  i: Byte;
  VSubscriber: TMethod;
begin
  for i := 0 to FSubscriberOFIndex - 1 do
  begin
    VSubscriber := Self.FSubscriberOVFs[i];
    if VSubscriber.Data = nil then
      TTimerInterruptProc(VSubscriber.Code)()
    else
      TTimerInterruptEvent(VSubscriber)();
  end;
end;
              
{$IFDEF PCTEST}                
procedure AbstractTimerDoCompareEvent(const Self: TMethod);
begin

end;

{$ELSE}
procedure AbstractTimerDoCompareEvent(const VMethod: TMethod); assembler;
label
  exit;
asm
         PUSH    R26
         PUSH    R27
         PUSH    R30
         PUSH    R31
         //         
         MOVW    R26, R24
         LD      R30, X+
         LD      R31, X+
         //if VMethod.Code <> nil then
         CP      R30, R1
         CPC     R31, R1
         BREQ    exit
         //TTimerInterruptProc(VMethod.Code)()
         PUSH    R18
         PUSH    R19
         PUSH    R20
         PUSH    R21
         PUSH    R22
         PUSH    R23   
         PUSH    R28
         PUSH    R29  
         LD      R24, X+
         LD      R25, X
         ICALL      
         POP     R29
         POP     R28
         POP     R23
         POP     R22
         POP     R21
         POP     R20
         POP     R19
         POP     R18
         //
         exit:  
         POP     R31
         POP     R30
         POP     R27
         POP     R26
end;    
{$ENDIF}

constructor TAbstractTimer.Init;
begin
  FSubscriberOVFs := Default(TTimerSubscriberOFs);
end;

function TAbstractTimer.IndexOfOVFEvent(const AEvent: TTimerInterruptEvent): Shortint;
var
  i: Byte;
begin
  Result := -1;
  for i := 1 to FSubscriberOFIndex do
    if (FSubscriberOVFs[i].Data = TMethod(AEvent).Data) and (FSubscriberOVFs[i].Code = TMethod(AEvent).Code) then
    begin
      Result := i;
      Exit;
    end;
end;

function TAbstractTimer.SubscribeOVFEvent(const AEvent: TTimerInterruptEvent): Shortint;
begin
  Result := -1;
  if FSubscriberOFIndex = MAX_INTERRUPT_EVENT_SUBSCRIBES then
    Exit;
  Result := IndexOfOVFEvent(AEvent);
  if Result = -1 then
  begin
    FSubscriberOVFs[FSubscriberOFIndex] := TMethod(AEvent);
    Result := FSubscriberOFIndex;
    Inc(FSubscriberOFIndex);       
    if FSubscriberOFIndex = 1 then
      SetCounterModes(CounterModes + [tcmOverflow]);
  end;
end;

function TAbstractTimer.SubscribeOVFProc(const AProc: TTimerInterruptProc): Shortint;
var
  VMethod: TMethod;
begin
  VMethod.Data := nil;
  VMethod.Code := AProc;
  Result := SubscribeOVFEvent(TTimerInterruptEvent(VMethod));
end;

procedure TAbstractTimer.UnsubscribeOVFEvent(const AEvent: TTimerInterruptEvent);
var
  i: Byte;
begin
  if FSubscriberOFIndex = 0 then
    Exit;
  for i := 1 to MAX_INTERRUPT_EVENT_SUBSCRIBES do
    if (FSubscriberOVFs[i].Data = TMethod(AEvent).Data) and (FSubscriberOVFs[i].Code = TMethod(AEvent).Code) then
    begin
      Move(FSubscriberOVFs[i + 1], FSubscriberOVFs[i], (FSubscriberOFIndex - i - 1));
      Dec(FSubscriberOFIndex);
      if FSubscriberOFIndex = 0 then
        SetCounterModes(CounterModes - [tcmOverflow]);
      Exit;
    end;
end;

procedure TAbstractTimer.UnsubscribeOVFProc(const AProc: TTimerInterruptProc);
var
  VMethod: TMethod;
begin
  VMethod.Code := AProc;
  VMethod.Data := nil;
  UnsubscribeOVFEvent(TTimerInterruptEvent(VMethod));
end;

procedure TAbstractTimer.SetCompareAEvent(const AEvent: TTimerInterruptEvent);
begin
  if (AEvent <> nil) and (TMethod(AEvent).Code <> nil) then
  begin
    FCompareAEvent := AEvent;
    SetCounterModes(CounterModes + [tcmCompareA]);
  end else
    ClearCompareAEvent;
end;

procedure TAbstractTimer.SetCompareAProc(const AProc: TTimerInterruptProc);
begin
  if AProc <> nil then
  begin
    TMethod(FCompareAEvent).Code := AProc;
    TMethod(FCompareAEvent).Data := nil;
    SetCounterModes(CounterModes + [tcmCompareA]);
  end else
    ClearCompareAEvent;
end;

procedure TAbstractTimer.ClearCompareAEvent;
begin
  FCompareAEvent := Default(TTimerInterruptEvent); 
  SetCounterModes(CounterModes - [tcmCompareA]);
end;

procedure TAbstractTimer.SetCompareBEvent(const AEvent: TTimerInterruptEvent);
begin
  if (AEvent <> nil) and (TMethod(AEvent).Code <> nil) then
  begin
    FCompareBEvent := AEvent;
    SetCounterModes(CounterModes + [tcmCompareB]);
  end else
    ClearCompareBEvent;
end;

procedure TAbstractTimer.SetCompareBProc(const AProc: TTimerInterruptProc);
begin                      
  if AProc <> nil then
  begin
    TMethod(FCompareBEvent).Code := AProc;
    TMethod(FCompareBEvent).Data := nil;
    SetCounterModes(CounterModes + [tcmCompareB]);
  end else
    ClearCompareBEvent;
end;

procedure TAbstractTimer.ClearCompareBEvent;
begin
  FCompareBEvent := Default(TTimerInterruptEvent);  
  SetCounterModes(CounterModes - [tcmCompareB]);
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
  Result := TCCR0B and (1 shl WGM02) > 0;
end;

procedure TTimer0.SetCTCMode(const AValue: Boolean);
begin
  TCCR0B := TCCR0B and not (1 shl WGM02) or (Byte(AValue) shr WGM02);
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
  Result := TCCR1B and (1 shl ICNC1) > 0;
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
  TCCR1B := TCCR1B and not Byte(Byte(not AValue) shl ICNC1);
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
  Result := TCCR1B and (1 shl WGM12) > 0;
end;

procedure TTimer1.SetCTCMode(const AValue: Boolean);
begin
  TCCR1B := TCCR1B and not Byte(Byte(not AValue) shl WGM12){ or (Byte(AValue) shr WGM13)};
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
  Result := ASSR and (1 shl AS2) > 0;
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
  Result := TCCR2B and (1 shl WGM22) > 0;
end;

function TTimer2.GetExternalMode: Boolean;
begin
  Result := ASSR and (1 shl EXCLK) > 0;
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
  ASSR := ASSR and not Byte(Byte(not AValue) shl AS2);
end;

procedure TTimer2.SetCLKMode(const AValue: TTimer2CLKMode);
begin
  while ASSR and (1 shl TCR2BUB) > 0 do
  ;
  TCCR2B := TCCR2B and %11111000 or Byte(AValue);
end;

procedure TTimer2.SetCounter(const AValue: Byte);
begin
  while ASSR and (1 shl TCN2UB) > 0 do
  ;
  TCNT2 := AValue;
end;

procedure TTimer2.SetCounterModes(const AValue: TTimerCounterModes);
begin
  TTimerCounterModes(TIMSK2) := AValue;
end;

procedure TTimer2.SetCTCMode(const AValue: Boolean);
begin
  TCCR2B := TCCR2B and not Byte(Byte(not AValue) shl WGM22);
end;

procedure TTimer2.SetExternalMode(const AValue: Boolean);
begin
  ASSR := ASSR and not Byte(Byte(not AValue) shl EXCLK);
end;

procedure TTimer2.SetOutputModes(const AValue: TTimerOutputModes);
begin
  TTimerOutputModes(TCCR2A) := AValue;
end;

procedure TTimer2.SetValueA(const AValue: Byte);
begin
  while ASSR and (1 shl OCR2AUB) > 0 do
  ;
  OCR2A := AValue;
end;

procedure TTimer2.SetValueB(const AValue: Byte);
begin
  while ASSR and (1 shl OCR2BUB) > 0 do
  ;
  OCR2B := AValue;
end;

function TTimer2.Bits: Byte;
begin
  Result := 8;
end;

{$IFNDEF PCTEST}
procedure TIMER0_COMPA_ISR; public Name 'TIMER0_COMPA_ISR'; interrupt; assembler;
asm
         PUSH    R24
         PUSH    R25
         //
         LDI     R24,LO8(Timer0.FCompareAEvent)
         LDI     R25,HI8(Timer0.FCompareAEvent)
         RCALL   AbstractTimerDoCompareEvent
         //        
         POP     R25
         POP     R24
end;

procedure TIMER0_COMPB_ISR; public Name 'TIMER0_COMPB_ISR'; interrupt; assembler;
asm
         PUSH    R24
         PUSH    R25
         //                  
         LDI     R24,LO8(Timer0.FCompareBEvent)
         LDI     R25,HI8(Timer0.FCompareBEvent)
         RCALL   AbstractTimerDoCompareEvent
         //
         POP     R25
         POP     R24
end;

procedure TIMER0_OVF_ISR; public Name 'TIMER0_OVF_ISR'; interrupt;
begin
  Timer0.DoOVFEvents;
end;

procedure TIMER1_COMPA_ISR; public Name 'TIMER1_COMPA_ISR'; interrupt; assembler;
asm
         PUSH    R24
         PUSH    R25           
         LDI     R24,LO8(Timer1.FCompareAEvent)
         LDI     R25,HI8(Timer1.FCompareAEvent)
         RCALL   AbstractTimerDoCompareEvent
         POP     R25
         POP     R24
end;

procedure TIMER1_COMPB_ISR; public Name 'TIMER1_COMPB_ISR'; interrupt; assembler;
asm
         PUSH    R24
         PUSH    R25         
         LDI     R24,LO8(Timer1.FCompareBEvent)
         LDI     R25,HI8(Timer1.FCompareBEvent)
         RCALL   AbstractTimerDoCompareEvent
         POP     R25
         POP     R24
end;

procedure TIMER1_OVF_ISR; public Name 'TIMER1_OVF_ISR'; interrupt;
begin
  Timer1.DoOVFEvents;
end;

procedure TIMER2_COMPA_ISR; public Name 'TIMER2_COMPA_ISR'; interrupt; assembler;
asm
         PUSH    R24
         PUSH    R25       
         LDI     R24,LO8(Timer2.FCompareAEvent)
         LDI     R25,HI8(Timer2.FCompareAEvent)
         RCALL   AbstractTimerDoCompareEvent
         POP     R25
         POP     R24
end;

procedure TIMER2_COMPB_ISR; public Name 'TIMER2_COMPB_ISR'; interrupt; assembler;
asm
         PUSH    R24
         PUSH    R25         
         LDI     R24,LO8(Timer2.FCompareBEvent)
         LDI     R25,HI8(Timer2.FCompareBEvent)
         RCALL   AbstractTimerDoCompareEvent
         POP     R25
         POP     R24
end;

procedure TIMER2_OVF_ISR; public Name 'TIMER2_OVF_ISR'; interrupt;
begin
  Timer2.DoOVFEvents;
end;
{$ENDIF}

initialization
  Timer0.Init;
  Timer1.Init;
  Timer2.Init;

end.
