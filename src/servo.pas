unit Servo;

{$mode objfpc}{$H-}
{$goto on}

interface

uses
  ArduinoTools;

const
  MIN_PULSE_WIDTH: longint = 450;
  MAX_PULSE_WIDTH: longint = 2400;

type
  TServoAngle = 0..180;

  { TCustomServo }

  TCustomServo = object(TCustomPinOutput)
  private
    FAngle: TServoAngle;
  protected
    function GetInitComplete: boolean; virtual;
    function GetAngle: TServoAngle; virtual;
    procedure SetAngle(const AValue: TServoAngle); virtual;
  public
    constructor Init(const APin: byte; const AAngle: TServoAngle);
    destructor Deinit; virtual;

    property InitComplete: boolean read GetInitComplete;
    property Angle: TServoAngle read GetAngle write SetAngle;
  end;

  { TServo }

  PServo = ^TServo;

  TServo = object(TCustomServo)
  protected
    procedure SetAngle(const AValue: TServoAngle); virtual;
  public
    constructor Init(const APin: byte);
  end;

implementation

{ TCustomServo }

constructor TCustomServo.Init(const APin: byte; const AAngle: TServoAngle);
begin
  inherited Init(APin);
  Angle := AAngle;
end;

destructor TCustomServo.Deinit;
begin
end;

function TCustomServo.GetAngle: TServoAngle;
begin
  Result := FAngle;
end;

function TCustomServo.GetInitComplete: boolean;
begin
  Result := Pin > 0;
end;

procedure TCustomServo.SetAngle(const AValue: TServoAngle);
begin
  if AValue > 180 then
    FAngle := 180
  else
    FAngle := AValue;
end;

{ TServo }

constructor TServo.Init(const APin: byte);
begin
  inherited;
  PinMode(Pin, avrmOutput);
end;

procedure TServo.SetAngle(const AValue: TServoAngle);
var
  VTime: longint;
  i: byte;
begin
  inherited;
  VTime := (MAX_PULSE_WIDTH - MIN_PULSE_WIDTH) * Angle div 180 + MIN_PULSE_WIDTH;
  for i := 1 to 5 do
  begin
    DigitalWrite(Pin, True);
    SleepMicroSecs(VTime);
    DigitalWrite(Pin, False);
    SleepMicroSecs(20000 - VTime);
  end;
end;

end.
