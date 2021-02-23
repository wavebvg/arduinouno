unit TimedServo;

{$mode objfpc}{$H-}
{$goto on}

interface

uses
  Servo;   

const
  MAX_SERVO_COUNT = 4;

type

  { TTimedServo }

  TTimedServo = object(TCustomServo)
  private
    FIndex: smallint;
    function GetPosition: word;
  protected
    function GetInitComplete: boolean; virtual;
    procedure SetAngle(const AValue: TServoAngle); virtual;
    property Position: word read GetPosition;
  public
    constructor Init(const APin: byte);
    destructor Deinit; virtual;
  end;

implementation

uses
  ArduinoTools,
  UInterrupts,
  TimedServoISR;

{ TTimedServo }

constructor TTimedServo.Init(const APin: byte);
var
  i: integer;
  VServo: PServoInfo;
begin
  inherited;
  for i := 0 to MAX_SERVO_COUNT - 1 do
  begin
    VServo := @ServoInfos[i];
    if not VServo^.Active then
    begin
      PinMode(APin, avrmOutput);
      FIndex := i;
      VServo^.Position := Position;
      VServo^.Pin := APin;
      VServo^.Active := True;
      CheckTimer;
      Break;
    end;
  end;
end;

destructor TTimedServo.Deinit;
var
  VServo: PServoInfo;
begin
  InterruptsDisable;
  VServo := @ServoInfos[FIndex];
  FIndex := -1;
  VServo^.Position := 0;
  VServo^.Pin := 0;
  VServo^.Active := False;
  InterruptsEnable;
  inherited;
end;

function TTimedServo.GetPosition: word;
begin
  Result := 126 + 494 * word(Angle) div 180;
end;

function TTimedServo.GetInitComplete: boolean;
begin
  Result := FIndex >= 0;
end;

procedure TTimedServo.SetAngle(const AValue: TServoAngle);
var
  VServo: PServoInfo;
begin
  inherited;
  VServo := @ServoInfos[FIndex];
  VServo^.Position := Position;
end;

end.
