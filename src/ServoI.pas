unit ServoI;

{Only PORTC}

{$mode objfpc}{$H-}{$Z1}
{$i TimersMacro.inc}

interface

uses
  ArduinoTools,
  Servo;

const
  MAX_SERVO_COUNT = 8;

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

const
  SERVO_TIME_MIN = 500;
  SERVO_TIME_MAX = 2500;
  SERVO_COUNT_A = (SERVO_TIME_MAX - SERVO_TIME_MIN);
  SERVO_COUNT_B = 180 * SERVO_TIME_MIN;
  SERVO_COUNT_D = 180 * 64 div ClockCyclesPerMicrosecond;
  MAX_CYCLE_TIME = (1000000 div 50){1/мкс} div 4{мкс/цикл};

type
  TServoIs = array[0..MAX_SERVO_COUNT - 1] of PServoI;
  
  TSortedServoI = packed record
    Pin: Byte;
    // Mask: Byte;
    Counter: Word;
  end;
  
  TSortedServoIs = array[0..MAX_SERVO_COUNT - 1] of TSortedServoI;
  
  TServoInfo = packed record
    Servo: PServoI;
    Counter: Word;
  end;

  TServoInfos = array[0..MAX_SERVO_COUNT - 1] of TServoInfo;

var
  Servos: TServoIs;
  SortedServos: TSortedServoIs;
  CycleTime: Word = MAX_CYCLE_TIME;
  OldCounterValue: Byte;
  ServoIndex: Byte;
  ServoCount: Byte;

var
  NeedSort: Boolean;
  ServoBeginCounter: Word;
  ServoCounter: array[0..MAX_SERVO_COUNT - 1] of Word;

implementation

uses
  Timers;

procedure DoTimer0ServoCompareA(const ATimer: PTimer; const AType: TTimerSubscribeEventType);
var
  VBuffer: PServoI;
  j, i: Byte;
  VComplete: Boolean;
  d: Word;
begin
  if CycleTime >= MAX_CYCLE_TIME then
  begin
    // Если нужно, сортируем пузырьком
    if NeedSort then
    begin
      if ServoCount > 1 then
        for i := 1 to ServoCount - 1 do
        begin
          VComplete := True;
          for j := i to ServoCount - 1 do
            if Servos[j - 1]^.FCounter > Servos[j]^.FCounter then
            begin
              VBuffer := Servos[j - 1];
              Servos[j - 1] := Servos[j];
              Servos[j] := VBuffer;
              VComplete := False;
            end;
          if VComplete then
            Break;
        end;
      // Загружаем сортированные значения в буфер
      for i := 0 to ServoCount - 1 do
      begin
        SortedServos[i].Counter := Servos[i]^.FCounter;
        SortedServos[i].Pin := Servos[i]^.Pin;
      end;
      NeedSort := True;
    end;
    // Инициируем счётчики 
    ServoIndex := 0;
    CycleTime := 0;
    OldCounterValue := Timer0_Counter;
    // Включаем флаг на PORTC
    for i := 0 to ServoCount - 1 do
      DigitalWrite(SortedServos[i].Pin, True);
    // Запоминаем текущее значение счетчика для отладки
    ServoBeginCounter := Timer1_Counter;
  end
  else
  begin
    // Рассчитываем, сколько прошло времени с начала ожидания
    OldCounterValue := Timer0_ValueA - OldCounterValue - 1;
    CycleTime := CycleTime + OldCounterValue + 1;
    if ServoIndex >= ServoCount then
      Exit;
    OldCounterValue := Timer0_ValueA;
    // Включаем все сервоприводы, для которых вышло время
    repeat
      DigitalWrite(SortedServos[ServoIndex].Pin, False);
      ServoCounter[ServoIndex] := CalcWordTime(@ServoBeginCounter);
      Inc(ServoIndex);
      if ServoIndex >= ServoCount then
        Exit;
    until SortedServos[ServoIndex].Counter > CycleTime;
  end;
  // Рассчитываем время активации следующего сервопривода
  if ServoIndex < ServoCount then
  begin
    d := SortedServos[ServoIndex].Counter - CycleTime;
    if d < TIMER_1B_VALUE_COUNT then
      Timer0_ValueA := OldCounterValue + d
    else
      Timer0_ValueA := OldCounterValue + TIMER_1B_VALUE_COUNT div 2;
  end;
end;

{ TServoI }

constructor TServoI.Init(const APin: byte; const AAngle: TServoAngle);
begin
  inherited;
  IPause;
  Angle := AAngle;
  Servos[ServoCount].Servo := @Self;
  Servos[ServoCount].Counter := FCounter;
  Inc(ServoCount);
  if ServoCount = 1 then
  begin
    Timer0_ValueA := 0;
    Timer0.SetCompareAProc(@DoTimer0ServoCompareA);
  end;
  IResume;
end;

destructor TServoI.Deinit;
var
  i: Byte;
  VIndex: Integer;
begin
  IPause;
  VIndex := ServoCount - 1;
  while (VIndex > 0) and (Servos[VIndex].Servo <> @Self) do
    Dec(VIndex);
  if VIndex >= 0 then
  begin
    for i := VIndex + 1 to ServoCount - 1 do
      Servos[i - 1] := Servos[i];
    Dec(ServoCount);
    if ServoCount = 0 then
      Timer0.ClearCompareAEvent;
  end;
  IResume;
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
  IPause;
  FCounter := VCounter;
  NeedSort := True;
  IResume;
end;

end.
