unit UISRTimers;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TTimer0 }

  TTimer0 = class(TThread)
  private
    FOnCompareA, FOnCompareB, FOnOverFlow: TNotifyEvent;
    FValueA, FValueB, FCounter: Byte;
    procedure DoOverFlow;
    procedure DoCompareA;
    procedure DoCompareB;
  protected
    procedure Execute; override;
  public
    property Counter: Byte read FCounter write FCounter;
    property ValueA: Byte read FValueA write FValueA;
    property ValueB: Byte read FValueB write FValueB;
    //
    property OnOverFlow: TNotifyEvent read FOnOverFlow write FOnOverFlow;
    property OnCompareA: TNotifyEvent read FOnCompareA write FOnCompareA;
    property OnCompareB: TNotifyEvent read FOnCompareB write FOnCompareB;
  end;

var
  Timer0: TTimer0;

implementation

uses
  BaseUnix;


{ TTimer0 }

procedure TTimer0.DoOverFlow;
begin
  if Assigned(OnOverFlow) then
    OnOverFlow(Self);
end;

procedure TTimer0.DoCompareA;
begin
  if Assigned(OnCompareA) then
    OnCompareA(Self);
end;

procedure TTimer0.DoCompareB;
begin
  if Assigned(OnCompareB) then
    OnCompareB(Self);
end;

procedure TTimer0.Execute;
var
  timeout, timeoutresult: TTimespec;
  res: cint;
begin
  timeout.tv_sec := 0;
  timeout.tv_nsec := 0;
  repeat
    Inc(FCounter);
    if FCounter = 0 then
      DoOverFlow;
    if FCounter = FValueA then
      DoCompareA;
    if FCounter = FValueB then
      DoCompareB;
    fpnanosleep(@timeout, @timeoutresult);
  until Terminated;
end;

initialization
  Timer0 := TTimer0.Create(True);

finalization
  Timer0.Free;
end.
