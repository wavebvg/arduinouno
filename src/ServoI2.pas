unit ServoI2;

{$mode objfpc}{$H-}{$Z1}
{$i TimersMacro.inc}

interface

uses
{$IFNDEF TESTING86}
  ArduinoTools,
{$ELSE}
  UISRTimers,
{$ENDIF TESTING86}
  Servo;

{$IFDEF TESTING86}
const
  ClockCyclesPerMicrosecond = 16;

type
  PTimer = Pointer;
  TTimerSubscribeEventType = Byte;
{$ENDIF TESTING86}

const
  MAX_SERVO_COUNT = 8;
  SERVO_TIMER_VALUE_COUNT = 256;
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
    FCounter: Word;
    constructor Init(const APin: byte; const AAngle: TServoAngle);
    destructor Deinit; virtual;
    procedure SetAngle(const AValue: TServoAngle); virtual;
  end;

type
  TServoInfo = packed record
    Servo: PServoI;
    Counter: Word;
  end;

  TServoInfos = array[0..MAX_SERVO_COUNT - 1] of TServoInfo;

const
  MAX_CYCLE_TIME = (1000000 div 50){1/мкс} div 4{мкс/цикл};

var
  Servos: TServoInfos;
  CycleTime: Word = MAX_CYCLE_TIME;
  OldCounterValue: Byte;
  ServoIndex: Byte;
  // DEBUG         
{$IFNDEF TESTING86}
  Counter, BeginCounter: array[0..MAX_SERVO_COUNT - 1] of Word;
{$ENDIF TESTING86}

var
  ServoCount: Byte;

{$IFDEF TESTING86}
procedure DoTimer0ServoCompareA(const ATimer: PTimer; const AType: TTimerSubscribeEventType);
{$ENDIF TESTING86}

implementation

{$IFNDEF TESTING86}
uses
  Timers;

{$ENDIF TESTING86}

procedure DoTimer0ServoCompareA(const ATimer: PTimer; const AType: TTimerSubscribeEventType);
var
  VBuffer: TServoInfo;
  j, i: Byte;
  VComplete: Boolean;
  d: Word;
begin
  if CycleTime >= MAX_CYCLE_TIME then
  begin
    for i := 0 to ServoCount - 1 do
      Servos[i].Counter := Servos[i].Servo^.FCounter;
    if ServoCount > 1 then
      for i := 1 to ServoCount - 1 do
      begin
        VComplete := True;
        for j := i to ServoCount - 1 do
          if Servos[j - 1].Counter > Servos[j].Counter then
          begin
            VBuffer := Servos[j - 1];
            Servos[j - 1] := Servos[j];
            Servos[j] := VBuffer;
            VComplete := False;
          end;
        if VComplete then
          Break;
      end;
    ServoIndex := 0;
    Timer0_ValueA := 0;
    CycleTime := 0;
    OldCounterValue := 0;
    for i := 0 to ServoCount - 1 do
    begin
{$IFNDEF TESTING86}
      DigitalWrite(Servos[i].Servo^.Pin, True);
      BeginCounter[i] := Timer1_Counter;
{$ENDIF TESTING86}
    end;
  end
  else
  begin
    if OldCounterValue >= Timer0_ValueA then
      CycleTime := CycleTime + Timer0_ValueA - OldCounterValue + SERVO_TIMER_VALUE_COUNT
    else
      CycleTime := CycleTime + Timer0_ValueA - OldCounterValue;
    while (ServoIndex < ServoCount) and (Servos[ServoIndex].Counter <= CycleTime) do
    begin
{$IFNDEF TESTING86}
      DigitalWrite(Servos[ServoIndex].Servo^.Pin, False);
      if Timer1_Counter > BeginCounter[ServoIndex] then
        Counter[ServoIndex] := Timer1_Counter - BeginCounter[ServoIndex]
      else
        Counter[ServoIndex] := High(Word) - BeginCounter[ServoIndex] + Timer1_Counter;
{$ENDIF TESTING86}
      Inc(ServoIndex);
    end;
  end;
  OldCounterValue := Timer0_ValueA;
  if ServoIndex < ServoCount then
  begin
    d := Servos[ServoIndex].Counter - CycleTime;
    if d < SERVO_TIMER_VALUE_COUNT then
      Timer0_ValueA := OldCounterValue + d
    else
      Timer0_ValueA := OldCounterValue + SERVO_TIMER_VALUE_COUNT div 2;
  end
  else
    Timer0_ValueA := 0;
end;

{ TServoI }

constructor TServoI.Init(const APin: byte; const AAngle: TServoAngle);
begin
  inherited;
{$IFNDEF TESTING86}
  IPause;
{$ENDIF TESTING86}
  Angle := Angle;
  Servos[ServoCount].Servo := @Self;
  Servos[ServoCount].Counter := FCounter;
  Inc(ServoCount);
  if ServoCount = 1 then
  begin
{$IFNDEF TESTING86}
    Timer0_ValueA := 0;
    Timer0.SetCompareAProc(@DoTimer0ServoCompareA);
{$ENDIF TESTING86}
  end;
{$IFNDEF TESTING86}
  IResume;
{$ENDIF TESTING86}
end;

destructor TServoI.Deinit;
var
  i: Byte;
  VIndex: Integer;
begin
{$IFNDEF TESTING86}
  IPause;
{$ENDIF TESTING86}
  VIndex := ServoCount - 1;
  while (VIndex > 0) and (Servos[VIndex].Servo <> @Self) do
    Dec(VIndex);
  if VIndex >= 0 then
  begin
    for i := VIndex + 1 to ServoCount - 1 do
      Servos[i - 1] := Servos[i];
    Dec(ServoCount);
{$IFNDEF TESTING86}
    if ServoCount = 0 then
      Timer0.ClearCompareAEvent;
{$ENDIF TESTING86}
  end;
{$IFNDEF TESTING86}
  IResume;
{$ENDIF TESTING86}
end;

procedure TServoI.SetAngle(const AValue: TServoAngle);
var
  VCounter: Longint;
begin
  inherited;
  VCounter := SERVO_COUNT_A;
  VCounter := VCounter * Angle;
  VCounter := VCounter + SERVO_COUNT_B;
  VCounter := VCounter div SERVO_COUNT_D;
{$IFNDEF TESTING86}
  IPause;
{$ENDIF TESTING86}
  FCounter := VCounter;
{$IFNDEF TESTING86}
  IResume;
{$ENDIF TESTING86}
end;

end.
