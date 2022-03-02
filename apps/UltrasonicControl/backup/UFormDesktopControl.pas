unit UFormDesktopControl;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  LazSerial, LMessages,
  LCLIntf, ExtCtrls, UTF8Process, process;

const
  WM_SERVO_POSITION = WM_USER + 435;

type

  { TFormDesktopControl }

  TFormDesktopControl = class(TForm)
    ButtonRefresh: TButton;
    ButtonSave: TButton;
    Serial: TLazSerial;
    Timer: TTimer;
    ToggleBoxConnect: TToggleBox;
    TrackBarServo1: TTrackBar;
    procedure SerialRxData(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure ToggleBoxConnectChange(Sender: TObject);
  private
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  FormDesktopControl: TFormDesktopControl;

implementation

{$R *.lfm}

{ TFormDesktopControl }

procedure TFormDesktopControl.SerialRxData(Sender: TObject);
var
  VDistance: Word;
begin
  Serial.ReadBuffer(VDistance, SizeOf(VDistance));
  TrackBarServo1.Position := VDistance;
  if not Timer.Enabled and (VDistance < 15) then
  begin
    Timer.Interval := 1000;
    Timer.Enabled := True;
  end;
end;

procedure TFormDesktopControl.TimerTimer(Sender: TObject);
var
  VOut: String;
begin
  if Timer.Interval = 1000 then
  begin
    Timer.Interval := 10000;
    ExecuteProcess('/media/fa/FA-FLASH/projects/git/arduinouno/apps/UltrasonicControl/hello.sh', '');
  end
  else
    Timer.Enabled := False;
end;

procedure TFormDesktopControl.ToggleBoxConnectChange(Sender: TObject);
begin
  Serial.Active := ToggleBoxConnect.Checked;
end;

constructor TFormDesktopControl.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
end;

destructor TFormDesktopControl.Destroy;
begin
  inherited Destroy;
end;

end.
