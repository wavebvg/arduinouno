unit IRReceiver;

{$mode objfpc}{$H-}{$Z1}
{$i TimersMacro.inc}

interface

uses
  ArduinoTools;

const
  IR_MAX_DATA_TIME = 9000;
  IR_DELTA_TIME = 100;
  //
  IR_META_DATA_TIME = IR_MAX_DATA_TIME;
  IR_META_DATA_TIME_MIN = IR_META_DATA_TIME - IR_DELTA_TIME;
  IR_META_DATA_TIME_MAX = IR_META_DATA_TIME + IR_DELTA_TIME;
  IR_PREAMBULE_SPACE_TIME = IR_MAX_DATA_TIME div 2;
  IR_PREAMBULE_SPACE_TIME_MIN = IR_PREAMBULE_SPACE_TIME - IR_DELTA_TIME;
  IR_PREAMBULE_SPACE_TIME_MAX = IR_PREAMBULE_SPACE_TIME + IR_DELTA_TIME;
  IR_REPEAT_SPACE_TIME = IR_MAX_DATA_TIME div 4;
  IR_REPEAT_SPACE_TIME_MIN = IR_REPEAT_SPACE_TIME - IR_DELTA_TIME;
  IR_REPEAT_SPACE_TIME_MAX = IR_REPEAT_SPACE_TIME + IR_DELTA_TIME;
  //
  IR_VALUE_DATA_TIME = IR_MAX_DATA_TIME div 16;
  IR_VALUE_DATA_TIME_MIN = IR_VALUE_DATA_TIME - IR_DELTA_TIME;
  IR_VALUE_DATA_TIME_MAX = IR_VALUE_DATA_TIME + IR_DELTA_TIME;
  IR_SPACE0_DATA_TIME = IR_MAX_DATA_TIME div 16;
  IR_SPACE0_DATA_TIME_MIN = IR_SPACE0_DATA_TIME - IR_DELTA_TIME;
  IR_SPACE0_DATA_TIME_MAX = IR_SPACE0_DATA_TIME + IR_DELTA_TIME;
  IR_SPACE1_DATA_TIME = IR_MAX_DATA_TIME * 3 div 16;
  IR_SPACE1_DATA_TIME_MIN = IR_SPACE1_DATA_TIME - IR_DELTA_TIME;
  IR_SPACE1_DATA_TIME_MAX = IR_SPACE1_DATA_TIME + IR_DELTA_TIME;
//

type
  TIRStage = (irsUndefined, irsAddress, irsAddressInvert, irsCommand, irsCommandInvert, irsComplete, irsInvalid);
  TIREvent = (ireUndefined, irePreamble, ireData0, ireData1, ireRepeat);

  TIRValue = packed record
    Address, Command: Byte;
  end;

type

  { TIRReceiver }

  TIRReceiver = object(TCustomPinInput)
  private
    FLastValue: TIRValue;
  public
    constructor Init(const APin: byte);

    function Read: TIRValue;
  end;

implementation

uses
  Timers;

{ TIRReceiver }

constructor TIRReceiver.Init(const APin: byte);
begin
  inherited;
  FLastValue := Default(TIRValue);
end;

function TIRReceiver.Read: TIRValue;
var
  VInSignal: Boolean;
  VInSpace: Boolean;
  VStage: TIRStage;
  VValue: Byte;
  VValueIndex: Byte;
  VLastCounter, VCounter: Byte;
  VTime: Word;
  VDataTime: Word;
  VEvent: TIREvent;

  procedure Reset; inline;
  begin
    VValue := 0;
    VInSpace := False;
    VTime := 0;
    VDataTime := 0;
    VStage := irsUndefined;
    VLastCounter := Timer0_Counter;
  end;

  function CalcEvent: TIREvent; inline;
  begin
    if VDataTime < IR_VALUE_DATA_TIME_MIN then
    begin
      Result := ireUndefined;
    end
    else
    if VDataTime < IR_VALUE_DATA_TIME_MAX then
    begin
      if VTime < IR_SPACE0_DATA_TIME_MIN then
        Result := ireUndefined
      else
      if VTime < IR_SPACE0_DATA_TIME_MAX then
        Result := ireData0
      else
      if VTime < IR_SPACE1_DATA_TIME_MIN then
        Result := ireUndefined
      else
      if VTime < IR_SPACE1_DATA_TIME_MAX then
        Result := ireData1
      else
        Result := ireUndefined;
    end
    else
    if VDataTime < IR_META_DATA_TIME_MIN then
    begin
      Result := ireUndefined;
    end
    else
    if VDataTime < IR_META_DATA_TIME_MAX then
    begin
      if VTime < IR_REPEAT_SPACE_TIME_MIN then
        Result := ireUndefined
      else
      if VTime < IR_REPEAT_SPACE_TIME_MAX then
        Result := ireRepeat
      else
      if VTime < IR_PREAMBULE_SPACE_TIME_MIN then
        Result := ireUndefined
      else
      if VTime < IR_PREAMBULE_SPACE_TIME_MAX then
        Result := irePreamble
      else
        Result := ireUndefined;
    end
    else
    begin
      Result := ireUndefined;
    end;
  end;

begin
  Reset;
  repeat
    if VStage = irsInvalid then
    begin
      Reset;
      SleepMicroSecs(108000);
    end;
    VCounter := Timer0_Counter;
    VInSignal := DigitalRead(Pin);
    VLastCounter := VCounter - VLastCounter;
    VTime := VTime + VLastCounter + VLastCounter + VLastCounter + VLastCounter;
    VLastCounter := VCounter;
    if VInSignal then
    begin
      if VInSpace then
      begin
        VInSpace := False;
        VDataTime := VTime;
        VTime := 0;
      end;
    end
    else
    begin
      if not VInSpace then
      begin
        if VDataTime > 0 then
        begin
          VEvent := CalcEvent;
          case VEvent of
            ireUndefined:
              VStage := irsInvalid;
            irePreamble:
              if VStage = irsUndefined then
              begin
                VStage := irsAddress;
                VValueIndex := 0;
                VValue := 0;
              end
              else
                VStage := irsInvalid;
            ireData0, ireData1:
              if VStage = irsUndefined then
                VStage := irsInvalid
              else
              begin
                if VEvent = ireData1 then
                  sbi(@VValue, VValueIndex)
                else
                  cbi(@VValue, VValueIndex);
                if VValueIndex = 7 then
                begin
                  case VStage of
                    irsAddress:
                      Result.Address := VValue;
                    irsAddressInvert:
                      if Result.Address xor VValue <> $FF then
                      begin
                        VStage := irsInvalid;
                        Continue;
                      end;
                    irsCommand:
                      Result.Command := VValue;
                    irsCommandInvert:
                      if Result.Command xor VValue <> $FF then
                      begin
                        VStage := irsInvalid;
                        Continue;
                      end;
                  end;
                  Inc(VStage);
                end
                else
                  Inc(VValueIndex);
              end;
            ireRepeat:
              if VStage = irsUndefined then
              begin
                Result := FLastValue;
                Exit;
              end
              else
                VStage := irsInvalid;
          end;
          VDataTime := 0;
        end;
        VInSpace := True;
        VTime := 0;
      end;
    end;
  until VStage = irsComplete;
  FLastValue := Result;
end;

end.
