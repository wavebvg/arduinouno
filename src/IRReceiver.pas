unit IRReceiver;

{$mode objfpc}{$H-}{$Z1}
{$i TimersMacro.inc}

interface

uses
  ArduinoTools;

const
  IR_DELTA_TIME = 16 * 150;
  IR_META_DATA_TIME = 9000;
  //
  IR_META_DATA_TIME_MIN = IR_META_DATA_TIME - IR_DELTA_TIME;
  IR_META_DATA_TIME_MAX = IR_META_DATA_TIME + IR_DELTA_TIME;
  IR_PREAMBULE_SPACE_TIME_MIN = IR_META_DATA_TIME_MIN div 2;
  IR_PREAMBULE_SPACE_TIME_MAX = IR_META_DATA_TIME_MAX div 2;
  IR_REPEAT_SPACE_TIME_MIN = IR_META_DATA_TIME_MIN div 4;
  IR_REPEAT_SPACE_TIME_MAX = IR_META_DATA_TIME_MAX div 4;
  //
  IR_VALUE_DATA_TIME_MIN = IR_META_DATA_TIME_MIN div 16;
  IR_VALUE_DATA_TIME_MAX = IR_META_DATA_TIME_MAX div 16;
  IR_SPACE0_DATA_TIME_MIN = IR_META_DATA_TIME_MIN div 16;
  IR_SPACE0_DATA_TIME_MAX = IR_META_DATA_TIME_MAX div 16;
  IR_SPACE1_DATA_TIME_MIN = IR_META_DATA_TIME_MIN * 3 div 16;
  IR_SPACE1_DATA_TIME_MAX = IR_META_DATA_TIME_MAX * 3 div 16;
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
  UART,
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
  n: Longint;

  procedure Reset; inline;
  begin
    n := 0;
    VValue := 0;
    VValueIndex := 0;
    VInSpace := False;
    VTime := 0;
    VDataTime := 0;
    VStage := irsUndefined;        
    Result := Default(TIRValue);
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
      UARTConsole.WriteLnFormat('Date time %d, space time %d, event %d (%d)', [VDataTime, VTime, Ord(VEvent), n]);
      Reset;
      SleepMicroSecs(108000);
    end;
    VInSignal := DigitalRead(Pin);
    VCounter := Timer0_Counter;
    VLastCounter := VCounter - VLastCounter;
    VTime := VTime + VLastCounter + VLastCounter + VLastCounter + VLastCounter;
    VLastCounter := VCounter;
    Inc(n);
    if VInSignal then
    begin
      if VInSpace then
      begin
        VInSpace := False;
        VDataTime := VTime;
        VTime := 0;
        n := 0;
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
            begin
              VStage := irsInvalid;
              UARTConsole.WriteLnString('Invalid by event');
              Continue;
            end;
            irePreamble:
              if VStage = irsUndefined then
              begin
                VStage := irsAddress;
                VValueIndex := 0;
                VValue := 0;
              end
              else
              begin
                VStage := irsInvalid;
                UARTConsole.WriteLnString('Invalid by preamble');
                Continue;
              end;
            ireData0, ireData1:
              if VStage = irsUndefined then
              begin
                VStage := irsInvalid;
                UARTConsole.WriteLnString('Invalid by data');
                Continue;
              end
              else
              begin
                if VEvent = ireData1 then
                  sbi(@VValue, VValueIndex)
                else
                  cbi(@VValue, VValueIndex);
                if VValueIndex = 7 then
                begin
                  VValueIndex := 0;
                  case VStage of
                    irsAddress:
                      Result.Address := VValue;
                    irsAddressInvert:
                      if Result.Address xor VValue <> $FF then
                      begin
                        VStage := irsInvalid;
                        UARTConsole.WriteLnFormat('Invalid by address XOR %d %d', [Result.Address, VValue]);
                        Continue;
                      end;
                    irsCommand:
                      Result.Command := VValue;
                    irsCommandInvert:
                      if Result.Command xor VValue <> $FF then
                      begin
                        VStage := irsInvalid;
                        UARTConsole.WriteLnString('Invalid by command XOR');
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
              begin
                VStage := irsInvalid;
                UARTConsole.WriteLnString('Invalid by repeat');
                Continue;
              end;
          end;
          VDataTime := 0;
        end;
        VInSpace := True;
        VTime := 0;
        n := 0;
      end;
    end;
  until VStage = irsComplete;
  FLastValue := Result;
end;

end.
