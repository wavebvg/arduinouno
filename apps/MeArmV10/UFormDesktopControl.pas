unit UFormDesktopControl;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  UServoCommands, LazSerial, LMessages, Messages,
  LCLIntf;

const
  WM_SERVO_POSITION = WM_USER + 435;

type

  { TFormDesktopControl }

  TFormDesktopControl = class(TForm)
    ButtonRefresh: TButton;
    ButtonSave: TButton;
    Serial: TLazSerial;
    ToggleBoxConnect: TToggleBox;
    TrackBarServo1: TTrackBar;
    TrackBarServo2: TTrackBar;
    TrackBarServo3: TTrackBar;
    TrackBarServo4: TTrackBar;
    procedure ButtonRefreshClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure SerialRxData(Sender: TObject);
    procedure ToggleBoxConnectChange(Sender: TObject);
    procedure TrackBarServoXChange(Sender: TObject);
  private
    FSaved: Boolean;
    FInLoad: Boolean;
    procedure RefreshPositions;
    procedure SavePositions;
    procedure SetPosition(const AServoIndex, AAngle: Byte);
    procedure WMServoPosition(var AMsg: TMessage); message WM_SERVO_POSITION;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  FormDesktopControl: TFormDesktopControl;

implementation

{$R *.lfm}

{ TFormDesktopControl }

procedure TFormDesktopControl.ToggleBoxConnectChange(Sender: TObject);
begin
  SavePositions;
  Serial.Active := ToggleBoxConnect.Checked;
  if not ToggleBoxConnect.Checked then
  begin
    TrackBarServo1.Enabled := ToggleBoxConnect.Checked;
    TrackBarServo2.Enabled := ToggleBoxConnect.Checked;
    TrackBarServo3.Enabled := ToggleBoxConnect.Checked;
    TrackBarServo4.Enabled := ToggleBoxConnect.Checked;
    TrackBarServo1.Position := 0;
    TrackBarServo2.Position := 0;
    TrackBarServo3.Position := 0;
    TrackBarServo4.Position := 0;
  end
  else
    FSaved := True;
end;

procedure TFormDesktopControl.SerialRxData(Sender: TObject);
var
  VData: TServoData;
begin
  VData := Default(TServoData);
  Serial.ReadBuffer(VData, SizeOf(VData));
  SendMessage(Handle, WM_SERVO_POSITION, VData.ServoIndex, VData.Angle);
end;

procedure TFormDesktopControl.ButtonRefreshClick(Sender: TObject);
var
  VCommand: TServoCommand;
begin
  if Serial.Active then
  begin
    VCommand.CommandType := sctLoadAll;
    Serial.WriteBuffer(VCommand, SizeOf(VCommand));
  end;
end;

procedure TFormDesktopControl.ButtonSaveClick(Sender: TObject);
begin
  SavePositions;
end;

procedure TFormDesktopControl.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  SavePositions;
end;

procedure TFormDesktopControl.WMServoPosition(var AMsg: TMessage);
var
  VTrackBarServoX: TTrackBar;
begin
  VTrackBarServoX := TTrackBar(FindComponent(Format('TrackBarServo%d', [AMsg.WParam])));
  if VTrackBarServoX = nil then Exit;
  FInLoad := True;
  VTrackBarServoX.Position := AMsg.LParam;
  VTrackBarServoX.Enabled := Serial.Active;
  FInLoad := False;
end;

constructor TFormDesktopControl.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
end;

destructor TFormDesktopControl.Destroy;
begin
  inherited Destroy;
end;

procedure TFormDesktopControl.TrackBarServoXChange(Sender: TObject);
var
  VTrackBarServo: TTrackBar;
begin
  if FInLoad or not Serial.Active then
    Exit;
  VTrackBarServo := TTrackBar(Sender);
  SetPosition(VTrackBarServo.Tag, VTrackBarServo.Position);
end;

procedure TFormDesktopControl.RefreshPositions;
var
  VCommand: TServoCommand;
begin
  if Serial.Active then
  begin
    VCommand.CommandType := sctReadAll;
    Serial.WriteBuffer(VCommand, SizeOf(VCommand));
  end;
end;

procedure TFormDesktopControl.SavePositions;
var
  VCommand: TServoCommand;
begin
  if Serial.Active and not FSaved then
  begin
    FSaved := True;
    VCommand.CommandType := sctSaveAll;
    Serial.WriteBuffer(VCommand, SizeOf(VCommand));
    Sleep(100);
    Application.ProcessMessages;
    Sleep(100);
  end;
end;

procedure TFormDesktopControl.SetPosition(const AServoIndex, AAngle: Byte);
var
  VCommand: TServoCommand;
begin
  VCommand.CommandType := sctWrite;
  VCommand.Data.ServoIndex := AServoIndex;
  VCommand.Data.Angle := AAngle;
  Serial.WriteBuffer(VCommand, SizeOf(VCommand));
  FSaved := False;
end;

end.
