program IRTest;

{$mode objfpc}{$H-}
{$goto on}

uses
  ArduinoTools,
  UInterrupts,
  Servo;

const
  IR_PIN_PORT: SmallInt = 11;
  IR_INTERVAL = 56;
  IR_WAIT_TIMEOUT = 15000 + IR_INTERVAL;
  IR_DATA_VALUE_TIME = 562;
  IR_SPACE_VALUE0_TIME = IR_DATA_VALUE_TIME;
  IR_SPACE_VALUE1_TIME = 3 * IR_DATA_VALUE_TIME;
  IR_DATA_PREAMBLE_TIME = 9000;
  IR_SPACE_PREAMBLE_TIME = 4500;
  IR_REPEAT_PREAMBLE_TIME = 2500;

type
  TIRState = (irsWait, irsData, irsSpace);
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

  { TIRReceiver }

  TIRReceiver = object(TCustomPinOutput)
  private
    FIsInvalid: Boolean;
    FComplete: Boolean;
    FLastValue: TIRValue;
    FCurrentValue: TIRValue;
    function AddContextValue(var AContext: TIRContext; const AValue: Boolean): Boolean;
  protected
    function InInterval(const AValue: Word; const AIntervalMiddle: Word): Boolean;
    procedure ParseEvent(var AContext: TIRContext; const AData, ASpace: Word);
    procedure DoEvent(var AContext: TIRContext; const AEvent: TIREvent);
  public
    constructor Init(const APin: byte);

    function Read: TIRValue;
  end;

  { TIRContext }

  constructor TIRReceiver.Init(const APin: byte);
  begin
    inherited;
    PinMode(Pin, avrmInput);
    FComplete := False;
    FillByte(FLastValue, SizeOf(TIRValue), 0);
    FillByte(FCurrentValue, SizeOf(TIRValue), 0);
  end;

  function TIRReceiver.AddContextValue(var AContext: TIRContext;
  const AValue: Boolean): Boolean;
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

  function TIRReceiver.InInterval(const AValue: Word;
  const AIntervalMiddle: Word): Boolean;
  begin
    Result := (AValue > AIntervalMiddle - IR_INTERVAL) and
      (AValue < AIntervalMiddle + IR_INTERVAL);
  end;

  function TIRReceiver.Read: TIRValue;
  var
    VState: TIRState;
    VData, VSpace, VTimer: Word;
    VValue: Boolean;
    VContext: TIRContext;

    procedure CheckWait;
    begin
      if VTimer > IR_WAIT_TIMEOUT then
      begin
        UARTWriteLn('Wait mode');
        FillByte(VContext, SizeOf(TIRReceiver), 0);
        FIsInvalid := False;
        FComplete := False;
        VState := irsWait;
        VTimer := 0;
      end;
    end;

  begin
    VData := 0;
    VSpace := 0;
    VTimer := 0;
    FComplete := False;
    VState := irsWait;
    FillByte(VContext, SizeOf(TIRReceiver), 0);
    repeat
      VValue := not DigitalRead(Pin);
      if not FIsInvalid then
        CheckWait
      else
      if VValue then
      begin
        case VState of
          irsWait:
          begin
            VState := irsData;
            VTimer := 0;
          end;
          irsData:
            CheckWait;
          irsSpace:
          begin
            VState := irsData;
            VSpace := VTimer;
            VTimer := 0;
            UARTWrite('Set space time to ');
            UARTWriteLn(IntToStr(VSpace));
            ParseEvent(VContext, VData, VSpace);
          end;
        end;
      end
      else
      begin
        case VState of
          irsWait:
            VTimer := 0;
          irsData:
          begin
            VState := irsSpace;
            VData := VTimer;
            VTimer := 0;
            UARTWrite('Set data time to ');
            UARTWriteLn(IntToStr(VData));
          end;
          irsSpace:
            CheckWait;
        end;
      end;
      SleepMicroSecs(IR_INTERVAL);
      Inc(VTimer, IR_INTERVAL);
    until FComplete and not FIsInvalid;
    Result := FCurrentValue;
    FLastValue := FCurrentValue;
  end;

  procedure TIRReceiver.ParseEvent(var AContext: TIRContext; const AData, ASpace: Word);
  var
    VEvent: TIREvent;
  begin
    VEvent.EventType := iretUndefined;
    VEvent.Value := False;
    if VEvent.EventType = iretUndefined then
    begin
      if InInterval(AData, IR_DATA_VALUE_TIME) then
        if InInterval(ASpace, IR_SPACE_VALUE0_TIME) then
        begin
          VEvent.EventType := iretData;
          VEvent.Value := False;
        end
        else if InInterval(ASpace, IR_SPACE_VALUE1_TIME) then
        begin
          VEvent.EventType := iretData;
          VEvent.Value := True;
        end;
    end;
    if VEvent.EventType = iretUndefined then
    begin
      if InInterval(AData, IR_DATA_PREAMBLE_TIME) then
        if InInterval(ASpace, IR_SPACE_PREAMBLE_TIME) then
          VEvent.EventType := iretPreamble
        else
        if InInterval(ASpace, IR_REPEAT_PREAMBLE_TIME) then
          VEvent.EventType := iretRepeat;
    end;
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
            if (AContext.Data[irrdAddress] xor not AContext.Data[irrdAddressInvert] =
              $FF) and (AContext.Data[irrdCommand] xor not
              AContext.Data[irrdCommandInvert] = $FF) then
            begin
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

var
  Context: TIRReceiver;
  Value: TIRValue;

begin
  UARTInit;
  Context.Init(IR_PIN_PORT);
  UARTWriteLn('start');

  repeat
    Value := Context.Read;
    UARTWrite('Address: ');
    UARTWrite(IntToStr(Value.Address));
    UARTWrite(', command: ');
    UARTWriteLn(IntToStr(Value.Command));
  until False;
end.
