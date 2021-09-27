unit HandledComponent;

{$mode ObjFPC}{$H+}

interface

uses
  glib2,
  //Gtk2WSControls,
  Classes,
  SysUtils,
  Controls,
  LCLType,
  LCLClasses,
  LMessages,
  WSControls;

const
  HCM_SENDMESSAGE = LM_USER + 5345;

type
  { THandledComponent }

  THandledComponent = class(TLCLComponent)
  private
    FHandle: THandle;
    function GetHandle: THandle;
    procedure HCMSendMessage(var AMsg: TLMessage); message HCM_SENDMESSAGE;
  protected
    procedure Dispatch(var message); override;
    procedure CreateWnd; virtual;
    procedure CreateHandle; virtual;
  public
    function HandleAllocated: Boolean;
    procedure HandleNeeded;
    property Handle: THandle read GetHandle;
  end;

function SendMessage(HandleWnd: HWND; Msg: Cardinal; WParam: WParam; LParam: LParam): LResult;

implementation

uses
  Gtk2WSControls,
  LCLIntf,
  WSLCLClasses,
  syncobjs;

function SendMessage(HandleWnd: HWND; Msg: Cardinal; WParam: WParam; LParam: LParam): LResult;
var
  VContextMessage: TLMessage;
  VEvent: TEvent;
begin
  if MainThreadID = GetCurrentThreadId then
    LCLIntf.SendMessage(HandleWnd, Msg, WParam, LParam)
  else
  begin
    VContextMessage.Msg := Msg;
    VContextMessage.WParam := WParam;
    VContextMessage.LParam := LParam;
    VEvent := TSimpleEvent.Create;
    try
      PostMessage(HandleWnd, HCM_SENDMESSAGE, PtrInt(VEvent), PtrInt(@VContextMessage));
      VEvent.WaitFor(INFINITE);
    finally
      VEvent.Free;
    end;
  end;
end;

{ THandledComponent }

function THandledComponent.GetHandle: THandle;
begin
  HandleNeeded;
  Result := FHandle;
end;

procedure THandledComponent.HCMSendMessage(var AMsg: TLMessage);
begin
  Dispatch(PLMessage(AMsg.LParam)^);
  TEvent(AMsg.WParam).SetEvent;
end;

procedure THandledComponent.Dispatch(var message);
begin
  inherited Dispatch(message);
end;

procedure THandledComponent.CreateWnd;
var
  VParams: TCreateParams;
begin
  VParams := Default(TCreateParams);
  FHandle := TWSWinControlClass(WidgetSetClass).CreateHandle(TWinControl(Self), VParams);
end;

procedure THandledComponent.CreateHandle;
begin
  if not HandleAllocated then
    CreateWnd;
end;

function THandledComponent.HandleAllocated: Boolean;
begin
  Result := FHandle <> 0;
end;

procedure THandledComponent.HandleNeeded;
begin
  if not HandleAllocated and not (csDestroying in ComponentState) then
    CreateHandle;
end;

initialization
  RegisterWSComponent(THandledComponent, TGtk2WSWinControl);

end.
