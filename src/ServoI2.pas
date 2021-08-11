unit ServoI2;

{$mode objfpc}{$H-}{$Z1}

interface

uses
  ArduinoTools,
  Servo;

const
  MAX_SERVO_COUNT = 8;
  SERVO_TIME_MIN = 500;
  SERVO_TIME_MAX = 2500;
  SERVO_COUNT_A = (SERVO_TIME_MAX - SERVO_TIME_MIN);
  SERVO_COUNT_B = 180 * SERVO_TIME_MIN;
  SERVO_COUNT_D = 180 * 64 div ClockCyclesPerMicrosecond;

type
  PServoI = ^TServoI;

  { TServoI }

  TServoI = object(TCustomServo)
  private
  public
    FIndex: Byte;
    FCounter: Word;
    constructor Init(const APin: byte; const AAngle: TServoAngle);
    destructor Deinit; virtual;
    procedure SetAngle(const AValue: TServoAngle); virtual;
  end;

type
  TServos = array[0..MAX_SERVO_COUNT - 1] of PServoI;

var
  ServoCount: Byte;
  Servos: TServos;
  ServoInfoCounter: Word = 5000;
  ServoInfoIndex: Byte;
  ServoInfos: TServos;
  Counter, BeginCounter, EndCounter: Word;

implementation

uses
  Timers;

procedure DoTimer0ServoEvent(const ATimer: PTimer; const AType: TTimerSubscribeEventType);
var
  i, j: Byte;
  VBuffer: PServoI;
  VSorted: Boolean;
begin
  case AType of
    tsetOverflow:
    begin
      if ServoInfoCounter >= 60000 then
      begin        
        BeginCounter := Timer1.Counter;
        for i := ServoCount - 1 to 0 do
        begin
          ServoInfos[i] := Servos[i];
          //DigitalWrite(Servos[i]^.Pin, True);
          //BeginCounter := Timer1.Counter;
        end;
        //j := ServoCount - 2;
        //VSorted := False;
        //while not VSorted do
        //  for i := 0 to j do
        //  begin
        //    VSorted := True;
        //    if ServoInfos[i]^.FCounter > ServoInfos[i + 1]^.FCounter then
        //    begin
        //      VBuffer := ServoInfos[i];
        //      ServoInfos[i] := ServoInfos[i + 1];
        //      ServoInfos[i + 1] := VBuffer;
        //      VSorted := False;
        //    end;
        //    Dec(j);
        //  end;
        ServoInfoCounter := 0;
        ServoInfoIndex := 0;
        Timer0.ValueA := ServoInfos[ServoInfoIndex]^.FCounter mod 256;
      end
      else
        Inc(ServoInfoCounter, 256);
    end;
    tsetCompareA:
    begin
      if (ServoInfoIndex < ServoCount) and (Timer0.ValueA > 0) then
      begin
        Inc(ServoInfoCounter, Timer0.ValueA);
        Timer0.ValueA := 0;
        EndCounter := Timer1.Counter;
        if BeginCounter > EndCounter then
          Counter := High(Word) - BeginCounter + EndCounter
        else
          Counter := EndCounter - BeginCounter;
      end;
    end;
  end;
  //while (ServoInfoIndex < ServoCount) and (ServoInfos[ServoInfoIndex]^.FCounter >= ServoInfoCounter) do
  //begin
  //  DigitalWrite(ServoInfos[ServoInfoIndex]^.Pin, False);
  //  EndCounter := Timer1.Counter;
  //  if BeginCounter > EndCounter then
  //    Counter := High(Word) - BeginCounter + EndCounter
  //  else
  //    Counter := EndCounter - BeginCounter;
  //  Inc(ServoInfoIndex);
  //end;
  //if ServoInfoIndex < ServoCount then
  //begin
  //  Timer0.ValueA := (ServoInfos[ServoInfoIndex]^.FCounter - ServoInfoCounter) mod 256;
  //end;
end;

{ TServoI }

constructor TServoI.Init(const APin: byte; const AAngle: TServoAngle);
begin
  inherited;
  FIndex := ServoCount;
  Servos[FIndex] := @Self;
  Inc(ServoCount);
  Angle := Angle;
  if ServoCount = 1 then
  begin
    Timer0.ValueA := 0;
    Timer0.Subscribe(@DoTimer0ServoEvent, [tsetCompareA, tsetOverflow]);
  end;
end;

destructor TServoI.Deinit;
var
  i: Byte;
begin
  for i := FIndex + 1 to ServoCount - 1 do
    Servos[i - 1] := Servos[i];
  Dec(ServoCount);
  if ServoCount = 0 then
    Timer0.Unsubscribe(@DoTimer0ServoEvent);
end;

procedure TServoI.SetAngle(const AValue: TServoAngle);
begin
  inherited;
  FCounter := (SERVO_COUNT_A * Angle + SERVO_COUNT_B) div SERVO_COUNT_D;
end;

end.
