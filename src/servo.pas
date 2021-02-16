unit Servo;

{$mode objfpc}{$H-}
{$goto on}

interface

const
  MIN_PULSE_WIDTH: longint = 450;
  MAX_PULSE_WIDTH: longint = 2400;

type

  { TServo }

  PServo = ^TServo;

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
  ArduinoTools;

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
  VTimer: TAVRTimer;
  VTimerInterval: Byte;
begin
  VTimer := DigitalPinTimerPGM[Pin];
  if VTimer = avrtNo then
  begin
    FAngle := AValue;
    VTime := (MAX_PULSE_WIDTH - MIN_PULSE_WIDTH) * FAngle div 180 + MIN_PULSE_WIDTH;
    for i := 1 to 5 do
    begin
      DigitalWrite(Pin, True);
      SleepMicroSecs(VTime);
      DigitalWrite(Pin, False);
      SleepMicroSecs(20000 - VTime);
    end;
  end
  else
  begin
    // Configure PD5 and PD6 as outputs
    // avrt0A
    PinMode(Pin, avrmOutput);
    // Configure in PWM mode
    TimerCounterControlRegister[VTimer]^ := 0;   
      TimerClockControlRegister[VTimer]^ := 0;
    TimerCounterControlRegister[VTimer]^ := (%10 shl TimerRegisterOutputMode[VTimer]) or (1 shl WGM0);
    // Enable timer
    if AValue <= 156 then
    begin
      TimerClockControlRegister[VTimer]^ := TimerClockControlRegister[VTimer]^ or %11;
      UARTWriteLn(IntToStr(AValue));
      VTimerInterval := (Integer(194) * Integer(AValue)) div 156 + 60;
      UARTWriteLn(IntToStr(VTimerInterval));
    end else
    begin       
      TimerClockControlRegister[VTimer]^ := TimerClockControlRegister[VTimer]^ or %100;
      UARTWriteLn(IntToStr(AValue));
      VTimerInterval := (18* Integer(AValue - 156)) div 24 + 60;
      UARTWriteLn(IntToStr(VTimerInterval));
    end;     
      TimerOutputCompareRegister[VTimer]^ := VTimerInterval;
  end;
end;

procedure TServo.Init(const APin: byte);
begin
  FPin := APin;
  PinMode(Pin, avrmOutput);
end;

procedure TServo.Deinit;
begin
  FPin := 0;
end;

end.
