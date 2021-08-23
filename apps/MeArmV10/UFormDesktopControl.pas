unit UFormDesktopControl;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  UServoCommands, LazSerial;

type

  { TFormDesktopControl }

  TFormDesktopControl = class(TForm)
    Serial: TLazSerial;
    ToggleBoxConnect: TToggleBox;
    TrackBarServo0: TTrackBar;
    TrackBarServo1: TTrackBar;
    TrackBarServo2: TTrackBar;
    TrackBarServo3: TTrackBar;
    procedure SerialRxData(Sender: TObject);
    procedure ToggleBoxConnectChange(Sender: TObject);
    procedure TrackBarServoXChange(Sender: TObject);
  private
    FServoPositions: array[0..3] of Byte;
    FInLoad: Boolean;
    FCommand: TServoCommand;
    procedure SetPosition(const AServoIndex, AAngle: Byte);
  public
  end;

var
  FormDesktopControl: TFormDesktopControl;

implementation

{$R *.lfm}

{ TFormDesktopControl }

procedure TFormDesktopControl.ToggleBoxConnectChange(Sender: TObject);
var
  VCommand: TServoCommand;
  i: Byte;
begin
  Serial.Active := ToggleBoxConnect.Checked;
  if Serial.Active then
  begin
    for i := 0 to 3 do
    begin
      VCommand.CommandType := sctRead;
      VCommand.Data.ServoIndex := i;
      Serial.WriteBuffer(VCommand, SizeOf(VCommand));
      Sleep(100);
      Application.ProcessMessages;
    end;
    FInLoad := True;
    TrackBarServo0.Position := FServoPositions[0];
    TrackBarServo1.Position := FServoPositions[1];
    TrackBarServo2.Position := FServoPositions[2];
    TrackBarServo3.Position := FServoPositions[3];
    FInLoad := False;
  end;
  TrackBarServo0.Enabled := Serial.Active;
  TrackBarServo1.Enabled := Serial.Active;
  TrackBarServo2.Enabled := Serial.Active;
  TrackBarServo3.Enabled := Serial.Active;
end;

procedure TFormDesktopControl.SerialRxData(Sender: TObject);
begin
  Serial.ReadBuffer(FCommand.Data, SizeOf(FCommand.Data));
  FServoPositions[FCommand.Data.ServoIndex] := FCommand.Data.Angle;
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

procedure TFormDesktopControl.SetPosition(const AServoIndex, AAngle: Byte);
begin
  FCommand.CommandType := sctWrite;
  FCommand.Data.ServoIndex := AServoIndex;
  FCommand.Data.Angle := AAngle;
  Serial.WriteBuffer(FCommand, SizeOf(FCommand));
  Sleep(50);
end;

end.
