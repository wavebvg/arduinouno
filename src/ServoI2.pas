unit ServoI2;

{$mode objfpc}{$H-}{$Z1}

interface

uses
  Servo;

const
  MAX_SERVO_COUNT = 8;

type
  PServoI = ^TServoI;

  { TServoI }

  TServoI = object(TCustomServo)
  private
    FIndex: Byte;
  public     
    FState: Boolean;
    FValue: Word;
    constructor Init(const APin: byte; const AAngle: TServoAngle);
    destructor Deinit; virtual;
  end;

var
  TestIndex: Integer;

type
  TServos = array[0..MAX_SERVO_COUNT - 1] of PServoI;

var
  ServoIndex: Byte = 0;
  Servos: TServos;

implementation

uses
  ArduinoTools,
  Timers;

procedure DoTimerOverflow(const ATimer: PTimer; const AType: TTimerSubscribeEventType);
var
  i: Byte;
begin
  Inc(TestIndex);
  for i := 0 to ServoIndex - 1 do
  begin
    if Servos[i]^.FValue = 0 then
    begin
      Servos[i]^.FState := not Servos[i]^.FState;
      DigitalWrite(Servos[i]^.Pin, Servos[i]^.FState);
      if Servos[i]^.FState then
        Servos[i]^.FValue := Servos[i]^.Angle * 10 div 200 + 31
      else
        Servos[i]^.FValue := 100;
    end
    else
      Dec(Servos[i]^.FValue);
  end;
end;

{ TServoI }

constructor TServoI.Init(const APin: byte; const AAngle: TServoAngle);
begin
  inherited;
  FIndex := ServoIndex;
  Servos[FIndex] := @Self;
  Inc(ServoIndex);
  FValue := 0;
  FState := False;
  if ServoIndex = 1 then
    Timer0.Subscribe(@DoTimerOverflow, [tsetOverflow]);
end;

destructor TServoI.Deinit;
var
  i: Byte;
begin
  for i := FIndex + 1 to ServoIndex - 1 do
    Servos[i - 1] := Servos[i];
  Dec(ServoIndex);
  if ServoIndex = 0 then
    Timer0.Unsubscribe(@DoTimerOverflow);
end;

end.
