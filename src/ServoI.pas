unit ServoI;

{$mode objfpc}{$H-}{$Z1}   
{$i TimersMacro.inc}
{$Define USE_DEBUG_COUNTER}

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
    NotMaskB: Byte;
    NotMaskC: Byte;
    NotMaskD: Byte;
    Counter: Byte;
  end;

  TSortedServoIs = array[0..MAX_SERVO_COUNT - 1 + 3] of TSortedServoI;

{$IfDef USE_DEBUG_COUNTER}
var
  ServoBeginCounter: Word;
  ServoCounter: array[0..MAX_SERVO_COUNT - 1 + 3] of Word;
{$EndIf USE_DEBUG_COUNTER}     

var
  Servos: TServoIs;
  SortedServos: TSortedServoIs;
  CycleTime: Word = MAX_CYCLE_TIME;
  SortedServoIndex: Byte = 30;
  SortedServoCount: Byte;
  NeedSort: Boolean;
  ServoAllMaskB, ServoAllMaskC, ServoAllMaskD: Byte;
  ServoCount: Byte;

implementation

uses
  Timers;

procedure SortTimers;
var
  i, j, VMask, VAllMaskB, VAllMaskC, VAllMaskD: Byte;
  VPort: TAVRPort;
  VBuffer: PServoI;
  VComplete: Boolean;
  VOldCounter, d: Word;
begin
  //UARTConsole.WriteLnFormat('Sorted!', []);
  // Сортируем пузырьком
  if ServoCount > 1 then
    for i := 1 to ServoCount - 1 do
    begin
      VComplete := True;
      for j := 1 to ServoCount - i do
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
  // Загружаем сортированные значения в буфер с масками
  j := 255;
  VAllMaskB := 0;
  VAllMaskC := 0;
  VAllMaskD := 0;
  VOldCounter := 0;
  i := 0;
  while i < ServoCount do
  begin
    VMask := DigitalPinToBitMask[Servos[i]^.Pin];
    VPort := DigitalPinToPort[Servos[i]^.Pin];
    case VPort of
      avrpB:
        VAllMaskB := VAllMaskB or VMask;
      avrpC:
        VAllMaskC := VAllMaskC or VMask;
      avrpD:
        VAllMaskD := VAllMaskD or VMask;
    end;
    d := Servos[i]^.FCounter - VOldCounter;
    if (i = 0) or (d > 0) then
    begin
      Inc(j);
      SortedServos[j].NotMaskB := $FF;
      SortedServos[j].NotMaskC := $FF;
      SortedServos[j].NotMaskD := $FF;
      if d > 255 then
      begin
        SortedServos[j].Counter := 224;
        Inc(VOldCounter, 224);
      end
      else
      begin
        Inc(VOldCounter, d);
        SortedServos[j].Counter := d;        
        case VPort of
          avrpB:
            SortedServos[j].NotMaskB := SortedServos[j].NotMaskB and not VMask;
          avrpC:
            SortedServos[j].NotMaskC := SortedServos[j].NotMaskC and not VMask;
          avrpD:
            SortedServos[j].NotMaskD := SortedServos[j].NotMaskD and not VMask;
        end;
        Inc(i);
      end;
    end
    else
    begin
      case VPort of
        avrpB:
          SortedServos[j].NotMaskB := SortedServos[j].NotMaskB and not VMask;
        avrpC:
          SortedServos[j].NotMaskC := SortedServos[j].NotMaskC and not VMask;
        avrpD:
          SortedServos[j].NotMaskD := SortedServos[j].NotMaskD and not VMask;
      end;
      Inc(i);
    end;
  end;
  SortedServoCount := j + 1;
  ServoAllMaskB := VAllMaskB;
  ServoAllMaskC := VAllMaskC;
  ServoAllMaskD := VAllMaskD;
end;

//procedure TIMER0_COMPA_ISR; public Name 'TIMER0_COMPA_ISR'; interrupt; assembler;
procedure DoTimer0ServoCompareA; assembler;
label
  notneedsort, inwaiting, inwork, exit, inits, nexts;
  //begin
asm
         //  if SortedServoIndex >= 30 then
         //  begin
         //    Инициируем счётчики
         LDS     R18, SortedServoIndex
         CPI     R18, 30
         brsh    inits 
         MOV     R24, R18
         RJMP    nexts
         inits:
         //    if NeedSort then
         LDS     R19, NeedSort
         CP      R19, R1
         BREQ    notneedsort
         //    begin     
         //      NeedSort := False;
         STS     NeedSort, R1
         //      SortTimers;
         CALL    SortTimers
         //    end;
         notneedsort:
         //    SortedServoIndex := 0;
         STS     SortedServoIndex,  R1
         //    CycleTime := 0;
         STS     CycleTime,   R1
         STS     CycleTime+1, R1
         //    R20 := SortedServos[0].Counter - 2
         //LDI     R26, LO8(SortedServos)
         //LDI     R27, HI8(SortedServos)
         //ADIW    R26, 3
         //LD      R20, X
         LDS      R20, SortedServos + 3
         SBCI    R20, 2          
{$IfDef USE_DEBUG_COUNTER}
         //    Запоминаем текущее значение счетчика для отладки
         //    ServoBeginCounter := Timer1_Counter;
         LDS     R0, 132
         STS     ServoBeginCounter, R0
         LDS     R0, 133
         STS     ServoBeginCounter + 1, R0
{$EndIf USE_DEBUG_COUNTER}
         //    Включаем флаг на PORTB
         //    PORTB := PORTB or ServoAllMaskB;
         IN      R27, 5
         LDS     R26, ServoAllMaskB
         OR      R26, R27
         OUT     5, R26
         //    PORTC := PORTC or ServoAllMaskC;
         IN      R27, 8
         LDS     R26, ServoAllMaskC
         OR      R26, R27
         OUT     8, R26
         //    PORTD := PORTD or ServoAllMaskD;
         IN      R27, 11
         LDS     R26, ServoAllMaskD
         OR      R26, R27
         OUT     11, R26
         //    Timer0_ValueA := Timer0_Counter + SortedServos[0].Counter;
         IN      R19, 38
         ADD     R19, R20
         OUT     39,  R19
         JMP     exit
         //  end
         //  else
         //  begin
         nexts:
         //    if SortedServoIndex < SortedServoCount then
         {LDS     R18, SortedServoIndex}
         LDS     R19, SortedServoCount
         CP      R18, R19
         BRLO    inwork
         JMP     inwaiting
         //    begin
         inwork:
         LSL     R18
{$IfDef USE_DEBUG_COUNTER}
         //      ServoCounter[SortedServoIndex] := Timer1_Counter - ServoBeginCounter;
         LDS     R20, ServoBeginCounter        {3}
         LDS     R21, ServoBeginCounter + 1    {3}
         LDI     R28, LO8(ServoCounter)        {1}
         LDI     R29, HI8(ServoCounter)        {1}
         ADD     R28, R18                      {1}
         ADC     R29, R1                       {1}
         LDS     R22, 132                      {3}
         LDS     R23, 133                      {3}
         SUB     R22, R20                      {1}
         SBC     R23, R21                      {1}
         ST      Y+,  R22                      {2}
         ST      Y,   R23                      {2}
{$EndIf USE_DEBUG_COUNTER}
         //      Включаем все сервоприводы, для которых вышло время
         //      PORTB := PORTB and SortedServos[SortedServoIndex].NotMaskB;
         (*LDS     R18, SortedServoIndex*)
         LSL     R18
         LDI     R26, LO8(SortedServos)
         LDI     R27, HI8(SortedServos)
         ADD     R26, R18
         ADC     R27, R1
         LD      R22, X+
         IN      R23, 5
         AND     R23, R22
         OUT     5,   R23
         //      PORTC := PORTC and SortedServos[SortedServoIndex].NotMaskC;
         LD      R22, X+
         IN      R23, 8
         AND     R23, R22
         OUT     8,   R23
         //      PORTD := PORTD and SortedServos[SortedServoIndex].NotMaskD;
         LD      R22, X+
         IN      R23, 11
         AND     R23, R22
         OUT     11,   R23
         //    end;
         inwaiting:
         //    Inc(SortedServoIndex);
         (*LDS     R18, SortedServoIndex*)
         INC     R24
         STS     SortedServoIndex, R24
         //    if SortedServoIndex < SortedServoCount then
         CP      R24, R19
         BRSH    exit
         //      Timer0_ValueA := Timer0_ValueA + SortedServos[SortedServoIndex].Counter;
             (*LDS     R18, SortedServoIndex
             LSL     R18
             LDI     r26, lo8(SortedServos)
             LDI     R27, hi8(SortedServos)
             ADD     r26, R18
             ADC     R27, R1*)
         ADIW    R26, 4
         LD      R20, X
         IN      R21, 39
         ADD     R21, R20
         OUT     39,  R21
         //  end;
         exit:
end;

{ TServoI }

constructor TServoI.Init(const APin: byte; const AAngle: TServoAngle);
begin
  inherited;
  IPause;
  Angle := AAngle;
  Servos[ServoCount] := @Self;
  Inc(ServoCount);
  if ServoCount = 1 then
  begin
    Timer0_ValueA := 0;
    Timer0.SetCompareAProc(@DoTimer0ServoCompareA);
    Timer0.CounterModes := Timer0.CounterModes + [tcmCompareA];
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
  while (VIndex > 0) and (Servos[VIndex] <> @Self) do
    Dec(VIndex);
  if VIndex >= 0 then
  begin
    for i := VIndex + 1 to ServoCount - 1 do
      Servos[i - 1] := Servos[i];
    Dec(ServoCount);
    if ServoCount = 0 then
    begin
      Timer0.CounterModes := Timer0.CounterModes - [tcmCompareA];
      Timer0.ClearCompareAEvent;
    end;
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

initialization
  PORTB := 0;

end.
