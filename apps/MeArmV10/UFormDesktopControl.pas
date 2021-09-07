unit UFormDesktopControl;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  UServoCommands, LazSerial;

type

  { TFormDesktopControl }

  TFormDesktopControl = class(TForm)
    ButtonRefresh: TButton;
    Serial: TLazSerial;
    ToggleBoxConnect: TToggleBox;
    TrackBarServo1: TTrackBar;
    TrackBarServo2: TTrackBar;
    TrackBarServo3: TTrackBar;
    TrackBarServo4: TTrackBar;
    procedure ButtonRefreshClick(Sender: TObject);
    procedure SerialRxData(Sender: TObject);
    procedure ToggleBoxConnectChange(Sender: TObject);
    procedure TrackBarServoXChange(Sender: TObject);
  private
    FServoPositions: array[1..4] of Byte;
    FInLoad: Boolean;
    FCommand: TServoCommand;
    procedure RefreshPositions;
    procedure SetPosition(const AServoIndex, AAngle: Byte);
  public
  end;

var
  FormDesktopControl: TFormDesktopControl;

implementation

{$R *.lfm}

{ TFormDesktopControl }

procedure TFormDesktopControl.ToggleBoxConnectChange(Sender: TObject);
begin
  Serial.Active := ToggleBoxConnect.Checked;
  RefreshPositions;
end;

procedure TFormDesktopControl.SerialRxData(Sender: TObject);
begin
  Serial.ReadBuffer(FCommand.Data, SizeOf(FCommand.Data));
  FServoPositions[FCommand.Data.ServoIndex] := FCommand.Data.Angle;
end;

procedure TFormDesktopControl.ButtonRefreshClick(Sender: TObject);
begin
  RefreshPositions;
end;

procedure TFormDesktopControl.TrackBarServoXChange(Sender: TObject);
var
  VTrackBarServo: TTrackBar;
begin
  if FInLoad then
    Exit;
  VTrackBarServo := TTrackBar(Sender);
  SetPosition(VTrackBarServo.Tag, VTrackBarServo.Position);
end;

procedure TFormDesktopControl.RefreshPositions;
var
  VCommand: TServoCommand;
  i: Byte;
begin
  Sleep(100);
  Application.ProcessMessages;
  if Serial.Active then
  begin
    FInLoad := True;
    for i := 1 to 4 do
    begin
      VCommand.CommandType := sctRead;
      VCommand.Data.ServoIndex := i;
      Serial.WriteBuffer(VCommand, SizeOf(VCommand));
      Sleep(100);
      Application.ProcessMessages;
    end;
    FInLoad := False;
    TrackBarServo1.Position := FServoPositions[1];
    TrackBarServo2.Position := FServoPositions[2];
    TrackBarServo3.Position := FServoPositions[3];
    TrackBarServo4.Position := FServoPositions[4];
  end
  else
  begin
    TrackBarServo1.Position := 0;
    TrackBarServo2.Position := 0;
    TrackBarServo3.Position := 0;
    TrackBarServo4.Position := 0;
  end;
  TrackBarServo1.Enabled := Serial.Active;
  TrackBarServo2.Enabled := Serial.Active;
  TrackBarServo3.Enabled := Serial.Active;
  TrackBarServo4.Enabled := Serial.Active;
end;

procedure TFormDesktopControl.SetPosition(const AServoIndex, AAngle: Byte);
begin
  FCommand.CommandType := sctWrite;
  FCommand.Data.ServoIndex := AServoIndex;
  FCommand.Data.Angle := AAngle;
  Serial.WriteBuffer(FCommand, SizeOf(FCommand));
  Sleep(100);
end;

end.
