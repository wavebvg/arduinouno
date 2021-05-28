unit IR;

{$mode ObjFPC}

interface

uses
  ArduinoTools;

const
  IR_PIN_PORT: SmallInt = 11;
  IR_INTERVAL = 100;
  IR_INTERVAL_DIFF = 8;
  IR_VALUE_TIME = 562;
  IR_VALUE0_TIME = 562;
  IR_VALUE1_TIME = 1687;
  IR_PREAMBLE_TIME = 9000;
  IR_DATA_TIME = 4500;
  IR_REPEAT_TIME = 2250;
  IR_INVALID_TIMEOUT = 65000;

type
  TIREventType = (iretUndefined, iretPreamble, iretRepeat, iretData);
  TIRReadData = (irrdAddress, irrdAddressInvert, irrdCommand, irrdCommandInvert);
  TIRReadDatas = array[TIRReadData] of Byte;

  TIREvent = packed record
    EventType: TIREventType;
    Value: Boolean;
  end;

  TIRValue = packed record
    Address, Command: Byte;
  end;

  TIRContext = packed record
    Pos: Byte;
    ReadData: TIRReadData;
    Data: TIRReadDatas;
    InData: Boolean;
  end;

type

  { TIRReceiver }

  TIRReceiver = object(TCustomPinOutput)
  private
    FIsInvalid: Boolean;
    FComplete: Boolean;
    FLastValue: TIRValue;
    FCurrentValue: TIRValue;
    function AddContextValue(var AContext: TIRContext; const AValue: Boolean): Boolean;
    function InInterval(const AValue: Word; const AIntervalMiddle: Word): Boolean;
      overload;
    function InInterval(const AValue: Word; const AIntervalMin, AIntervalMax: Word): Boolean; overload;
    procedure ParseEvent(var AContext: TIRContext; const AData, ASpace: Word);
    procedure DoEvent(var AContext: TIRContext; const AEvent: TIREvent);
  public
    constructor Init(const APin: byte);

    function Read: TIRValue;
  end;

implementation

{ TIRContext }

constructor TIRReceiver.Init(const APin: byte);
begin
  inherited;
  PinMode(Pin, avrmInput);
  FComplete := False;
  FillByte(FLastValue, SizeOf(TIRValue), 0);
  FillByte(FCurrentValue, SizeOf(TIRValue), 0);
end;

function TIRReceiver.AddContextValue(var AContext: TIRContext; const AValue: Boolean): Boolean;
begin
  Result := False;
  if AValue then
    AContext.Data[AContext.ReadData] :=
      AContext.Data[AContext.ReadData] or Byte((1 shr AContext.Pos))
  else
    AContext.Data[AContext.ReadData] :=
      AContext.Data[AContext.ReadData] and not (1 shr AContext.Pos);
  Inc(AContext.Pos);
  if AContext.Pos >= 8 then
  begin
    Inc(AContext.ReadData);
    AContext.Pos := 0;
  end;
  if AContext.ReadData > System.High(TIRReadData) then
  begin
    if (AContext.Data[irrdAddress] xor not AContext.Data[irrdAddressInvert] = $FF) and
      (AContext.Data[irrdCommand] xor not AContext.Data[irrdCommandInvert] = $FF) then
    begin
      Result := True;
    end;
  end;
end;

function TIRReceiver.InInterval(const AValue: Word; const AIntervalMiddle: Word): Boolean;
const
  IR_DIFF = IR_INTERVAL * 2;
begin
  Result := InInterval(AValue, AIntervalMiddle - IR_DIFF, AIntervalMiddle + IR_DIFF);
end;

function TIRReceiver.InInterval(const AValue: Word; const AIntervalMin, AIntervalMax: Word): Boolean;
begin
  Result := (AValue >= AIntervalMin) and (AValue <= AIntervalMax);
end;

function TIRReceiver.Read: TIRValue;
var
  VValue: Boolean;
  VInSpace: Boolean;
  VTimer: Word;
  VData: Word;
  VContext: TIRContext;

  procedure Invalidate;
  begin
    VTimer := 0;
    VInSpace := False;
    VData := 0;
    FIsInvalid := False;
  end;

begin
  FComplete := False;
  Invalidate;
  VContext := Default(TIRContext);
  repeat
    if FIsInvalid then
    begin
      if VTimer > IR_INVALID_TIMEOUT then
        Invalidate;
    end
    else
    begin
      VValue := DigitalRead(Pin);
      if VValue then
      begin
        if VInSpace then
        begin
          VInSpace := False;
          VData := VTimer;
          VTimer := 0;
        end;
      end
      else
      begin
        if not VInSpace then
        begin
          if VData > 0 then
          begin
            ParseEvent(VContext, VData, VTimer);
            VData := 0;
          end;
          VInSpace := True;
          VTimer := 0;
        end;
      end;
    end;
    SleepMicroSecs(IR_INTERVAL);
    Inc(VTimer, IR_INTERVAL);
    Inc(VTimer, IR_INTERVAL_DIFF);
  until FComplete;
  Result := FCurrentValue;
  FLastValue := Result;
end;

procedure TIRReceiver.ParseEvent(var AContext: TIRContext; const AData, ASpace: Word);
var
  VEvent: TIREvent;
begin
  VEvent.EventType := iretUndefined;
  VEvent := Default(TIREvent);
  if InInterval(AData, IR_PREAMBLE_TIME) then
  begin
    if InInterval(ASpace, IR_DATA_TIME) then
      VEvent.EventType := iretPreamble
    else
    if InInterval(ASpace, IR_REPEAT_TIME) then
      VEvent.EventType := iretRepeat
    else
      FIsInvalid := True;
  end
  else
  if InInterval(AData, IR_VALUE_TIME) then
  begin
    VEvent.EventType := iretData;
    if InInterval(ASpace, IR_VALUE1_TIME) then
      VEvent.Value := True
    else
    if InInterval(ASpace, IR_VALUE0_TIME) then
      VEvent.Value := False
    else
      FIsInvalid := True;
  end
  else
    FIsInvalid := True;
  if not FIsInvalid then
    DoEvent(AContext, VEvent);
end;

procedure TIRReceiver.DoEvent(var AContext: TIRContext; const AEvent: TIREvent);
begin
  case AEvent.EventType of
    iretPreamble:
    begin
      AContext.InData := True;
      AContext.ReadData := irrdAddress;
      AContext.Pos := 0;
    end;
    iretRepeat:
    begin
      FCurrentValue := FLastValue;
      FComplete := True;
    end;
    iretData:
      if AContext.InData then
      begin
        if AEvent.Value then
          sbi(@AContext.Data[AContext.ReadData], AContext.Pos)
        else
          cbi(@AContext.Data[AContext.ReadData], AContext.Pos);
        Inc(AContext.Pos);
        if AContext.Pos >= 8 then
        begin
          Inc(AContext.ReadData);
          AContext.Pos := 0;
        end;
        if AContext.ReadData > System.High(TIRReadData) then
        begin
          if (AContext.Data[irrdAddress] xor AContext.Data[irrdAddressInvert] = $FF) and
            (AContext.Data[irrdCommand] xor AContext.Data[irrdCommandInvert] = $FF) then
          begin
            FCurrentValue.Address := AContext.Data[irrdAddress];
            FCurrentValue.Command := AContext.Data[irrdCommand];
            FComplete := True;
          end
          else
            FIsInvalid := True;
        end;
      end
      else
        FIsInvalid := True;
    else
      FIsInvalid := True;
  end;
end;

end.
