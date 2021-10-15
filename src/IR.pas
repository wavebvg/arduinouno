unit IR;

{$mode objfpc}{$H-}{$Z1}

interface

uses
  ArduinoTools;

const
  IR_INTERVAL = 50;
  IR_INTERVAL_DIFF = 3;
  IR_VALUE_TIME = 562;
  IR_VALUE_TIME_MIN = IR_VALUE_TIME - 150;
  IR_VALUE_TIME_MAX = IR_VALUE_TIME + 150;
  IR_VALUE0_TIME = IR_VALUE_TIME;
  IR_VALUE0_TIME_MIN = IR_VALUE0_TIME - 150;
  IR_VALUE0_TIME_MAX = IR_VALUE0_TIME + 150;
  IR_VALUE1_TIME = IR_VALUE_TIME * 3;
  IR_VALUE1_TIME_MIN = IR_VALUE1_TIME - 150;
  IR_VALUE1_TIME_MAX = IR_VALUE1_TIME + 150;
  IR_DATA_PREAMBLE_TIME = 9000;
  IR_DATA_PREAMBLE_TIME_MIN = IR_DATA_PREAMBLE_TIME - 1200;
  IR_DATA_PREAMBLE_TIME_MAX = IR_DATA_PREAMBLE_TIME + 1200;
  IR_SPACE_TIME = 4500;
  IR_SPACE_TIME_MIN = IR_SPACE_TIME - 500;
  IR_SPACE_TIME_MAX = IR_SPACE_TIME + 500;
  IR_REPEAT_TIME = 2250;
  IR_REPEAT_TIME_MIN = IR_REPEAT_TIME - 1100;
  IR_REPEAT_TIME_MAX = IR_REPEAT_TIME + 1100;
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

  TIRContextFlag = (ircfInvalid, ircfComplete, ircfData, ircfLastValue);

  TIRContextFlags = set of TIRContextFlag;

  TIRContext = packed record
    Pos: Byte;
    Data: TIRReadDatas;
    Flags: TIRContextFlags;
    ReadData: TIRReadData;
    CurrentValue: TIRValue;
  end;

type

  { TIRReceiver }

  TIRReceiver = object(TCustomPinInput)
  private
    FLastValue: TIRValue;
    function InternalRead(const APin: Pbyte; const AMask: Byte): TIRValue;
  public
    constructor Init(const APin: byte);

    function Read: TIRValue;
  end;

implementation

uses
  UART;

var
  LastData, LastSpace, LastIndex: Word;

procedure UARTPrint(const AData, ASpace: Word);
begin
  UARTConsole.WriteString(IntToStr(LastIndex));
  UARTConsole.WriteString(': ');
  UARTConsole.WriteString(IntToStr(AData));
  UARTConsole.WriteString(' - ');
  UARTConsole.WriteLnString(IntToStr(ASpace));
end;

procedure DoEvent(var AContext: TIRContext; const AEvent: TIREvent);
begin
  case AEvent.EventType of
    iretPreamble:
    begin
      AContext.Flags := AContext.Flags + [ircfData];
      AContext.ReadData := irrdAddress;
      AContext.Pos := 0;
    end;
    iretRepeat:
    begin
      AContext.Flags := AContext.Flags + [ircfComplete, ircfLastValue];
    end;
    iretData:
      if ircfData in AContext.Flags then
      begin
        if AEvent.Value then
          AContext.Data[AContext.ReadData] := AContext.Data[AContext.ReadData] or (Byte(1) shl AContext.Pos)
        else
          AContext.Data[AContext.ReadData] := AContext.Data[AContext.ReadData] and not (Byte(1) shl AContext.Pos);
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
            AContext.CurrentValue.Address := AContext.Data[irrdAddress];
            AContext.CurrentValue.Command := AContext.Data[irrdCommand];
            AContext.Flags := AContext.Flags + [ircfComplete];
          end
          else
            AContext.Flags := AContext.Flags + [ircfInvalid];
        end;
      end
      else
        AContext.Flags := AContext.Flags + [ircfInvalid];
    else
      AContext.Flags := AContext.Flags + [ircfInvalid];
  end;
end;

procedure ParseEvent(var AContext: TIRContext; const AData, ASpace: Word);
var
  VEvent: TIREvent;
begin
  LastData := AData;
  LastSpace := ASpace;
  Inc(LastIndex);
  VEvent.EventType := iretUndefined;
  VEvent := Default(TIREvent);
  if (AData >= IR_DATA_PREAMBLE_TIME_MIN) and (AData <= IR_DATA_PREAMBLE_TIME_MAX) then
  begin
    if (ASpace >= IR_SPACE_TIME_MIN) and (ASpace <= IR_SPACE_TIME_MAX) then
    begin
      VEvent.EventType := iretPreamble;
    end
    else
    if (ASpace >= IR_REPEAT_TIME_MIN) and (ASpace <= IR_REPEAT_TIME_MAX) then
      VEvent.EventType := iretRepeat
    else
      AContext.Flags := AContext.Flags + [ircfInvalid];
  end
  else
  if (AData >= IR_VALUE_TIME_MIN) and (AData <= IR_VALUE_TIME_MAX) then
  begin
    VEvent.EventType := iretData;
    if (ASpace >= IR_VALUE1_TIME_MIN) and (ASpace <= IR_VALUE1_TIME_MAX) then
      VEvent.Value := True
    else
    if (ASpace >= IR_VALUE0_TIME_MIN) and (ASpace <= IR_VALUE0_TIME_MAX) then
      VEvent.Value := False
    else
      AContext.Flags := AContext.Flags + [ircfInvalid];
  end
  else
    AContext.Flags := AContext.Flags + [ircfInvalid];
  if not (ircfInvalid in AContext.Flags) then
    DoEvent(AContext, VEvent);
end;

{ TIRReceiver }

constructor TIRReceiver.Init(const APin: byte);
begin
  inherited;
  FLastValue := Default(TIRValue);
end;

function TIRReceiver.InternalRead(const APin: Pbyte; const AMask: Byte): TIRValue;
var
  VValue: Boolean;
  VInSpace: Boolean;    
  VData: Word;
  VTimer: Word;
  VContext: TIRContext;

  procedure Reset; inline;
  begin             
    VContext := Default(TIRContext);
    VTimer := 0;
    LastIndex := 0;   
    VInSpace := False;
    VData := 0;
  end;

begin
  Reset;
  repeat
    if ircfInvalid in VContext.Flags then
    begin
      //UARTPrint(LastData, LastSpace);
      SleepMicroSecs(IR_INVALID_TIMEOUT);
      Reset;
    end
    else
    begin
      VValue := (APin^ and AMask) <> 0;
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
  until ircfComplete in VContext.Flags;
  if ircfLastValue in VContext.Flags then
    Result := FLastValue
  else
    Result := VContext.CurrentValue;
end;

function TIRReceiver.Read: TIRValue;
var
  VBit: Byte;
  VPort: TAVRPort;
begin
  VBit := DigitalPinToBitMask[Pin];
  VPort := DigitalPinToPort[Pin];
  Result := InternalRead(PortToInput[VPort], VBit);
  FLastValue := Result;
end;

end.
