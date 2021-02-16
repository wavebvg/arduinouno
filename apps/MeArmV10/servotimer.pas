unit ServoTimer;

{$mode objfpc}{$H-}
{$goto on}

interface

type
  { TCustomServo }             
  PCustomServo = ^TCustomServo;

  TCustomServo = object
  private
    FAngle: Word;
    FPin: byte;
  protected
    function GetInitComplete: boolean; virtual;
    function GetAngle: Word; virtual;
    procedure SetAngle(const AValue: Word); virtual;
  public
    constructor Init(const APin: byte);
    destructor Deinit; virtual;

    property InitComplete: boolean read GetInitComplete;
    property Angle: Word read GetAngle write SetAngle;
    property Pin: byte read FPin;
  end;

  { TTimerServo }

  TTimerServo = object(TCustomServo)
  private
    FIndex: SmallInt;
  protected
    function GetInitComplete: boolean; virtual;
    procedure SetAngle(const AValue: Word); virtual;
  public
    constructor Init(const APin: byte);
    destructor Deinit; virtual;
  end;

implementation

uses
  ArduinoTools,
  UInterrupts,
  ServoTimerISR;

{ TTimerServo }

constructor TTimerServo.Init(const APin: byte);
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
      InterruptsDisable; 
      PinMode(APin, avrmOutput);
      FIndex := i;
      VServo^.Angle := Angle;
      VServo^.Pin := APin;
      VServo^.Active := True;
      InterruptsEnable;
      Break;
    end;
  end;
end;

destructor TTimerServo.Deinit;
var
  VServo: PServoInfo;
begin
  InterruptsDisable;
  VServo := @ServoInfos[FIndex];
  FIndex := -1;
  VServo^.Angle := 0;
  VServo^.Pin := 0;
  VServo^.Active := False;
  InterruptsEnable;  
  inherited;
end;  

function TTimerServo.GetInitComplete: boolean;
begin
  Result := FIndex >= 0;
end;

procedure TTimerServo.SetAngle(const AValue: Word);
var
  VServo: PServoInfo;
begin   
  inherited;          
  //InterruptsDisable;
  VServo := @ServoInfos[FIndex];
  VServo^.Angle := Angle;     
  //InterruptsEnable;
end;

{ TCustomServo }  

constructor TCustomServo.Init(const APin: byte);
begin
  FPin := APin;
  PinMode(Pin, avrmOutput);
end;

destructor TCustomServo.Deinit;
begin
  FPin := 0;
end;

function TCustomServo.GetAngle: Word;
begin
  Result := FAngle;
end;

function TCustomServo.GetInitComplete: boolean;
begin
  Result := FPin > 0;
end;

procedure TCustomServo.SetAngle(const AValue: Word);
begin
  FAngle := AValue;
end;

end.
