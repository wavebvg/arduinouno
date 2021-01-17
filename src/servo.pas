unit Servo;

{$mode objfpc}

interface

const
  MIN_PULSE_WIDTH: longint = 450;
  MAX_PULSE_WIDTH: longint = 2400;

type

  { TServo }

  TServo = object
  private
    FAngle: byte;
    FPin: byte;
    function GetAngle: byte;
    function GetInitComplete: boolean;
    procedure SetAngle(const AValue: byte);
  public
    procedure Init(const APin: byte);
    procedure Deinit;

    property InitComplete: boolean read GetInitComplete;
    property Angle: byte read GetAngle write SetAngle;
    property Pin: byte read FPin;
  end;

implementation

uses
  ArduinoTools,
  UInterrupts;

{ TServo }

function TServo.GetAngle: byte;
begin
  Result := FAngle;
end;

function TServo.GetInitComplete: boolean;
begin
  Result := FPin > 0;
end;

procedure TServo.SetAngle(const AValue: byte);
var
  VTime: longint;
  i: integer;
begin
  FAngle := AValue;
  UARTWriteLn('Rotate to angle ' + IntToStr(Angle));
  VTime := (MAX_PULSE_WIDTH - MIN_PULSE_WIDTH) * Angle div 180 + MIN_PULSE_WIDTH;
  for i := 1 to 5 do
  begin
    DigitalWrite(Pin, True);
    SleepMillisecs(VTime);
    DigitalWrite(Pin, False);
    Sleep10ms(1);
  end;
end;

procedure TServo.Init(const APin: byte);
begin
  FPin := APin;
end;

procedure TServo.Deinit;
begin
  FPin := 0;
end;

end.
