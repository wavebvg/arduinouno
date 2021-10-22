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

function CalcEvent1(const ADataTime, ASpaceTime: Word): TIREvent;
begin
  if ADataTime < IR_VALUE_DATA_TIME_MIN then
  begin
    Result := ireUndefined;
  end
  else
  if ADataTime < IR_VALUE_DATA_TIME_MAX then
  begin
    if ASpaceTime < IR_SPACE0_DATA_TIME_MIN then
      Result := ireUndefined
    else
    if ASpaceTime < IR_SPACE0_DATA_TIME_MAX then
      Result := ireData0
    else
    if ASpaceTime < IR_SPACE1_DATA_TIME_MIN then
      Result := ireUndefined
    else
    if ASpaceTime < IR_SPACE1_DATA_TIME_MAX then
      Result := ireData1
    else
      Result := ireUndefined;
  end
  else
  if ADataTime < IR_META_DATA_TIME_MIN then
  begin
    Result := ireUndefined;
  end
  else
  if ADataTime < IR_META_DATA_TIME_MAX then
  begin
    if ASpaceTime < IR_REPEAT_SPACE_TIME_MIN then
      Result := ireUndefined
    else
    if ASpaceTime < IR_REPEAT_SPACE_TIME_MAX then
      Result := ireRepeat
    else
    if ASpaceTime < IR_PREAMBULE_SPACE_TIME_MIN then
      Result := ireUndefined
    else
    if ASpaceTime < IR_PREAMBULE_SPACE_TIME_MAX then
      Result := irePreamble
    else
      Result := ireUndefined;
  end
  else
  begin
    Result := ireUndefined;
  end;
end;

function CalcEvent(const ADataTime{R24, R25}, ASpaceTime: Word){R22, R23}: TIREvent; assembler;
label
  exit, undefined, more_vdt_min, less_vdt_max, more_vdt_max, more_sdt_min, less_s0dt_max,
  more_s0dt_max, more_s1dt_min, more_s1dt_max, more_mdt_max, less_mdt_max, more_rst_min,
  more_rst_max, more_pst_min, more_pst_max;
asm
         PUSH    R16 {Reg for consts}
         //if ADataTime < IR_VALUE_DATA_TIME_MIN then
         CPI     R24, LO8(IR_VALUE_DATA_TIME_MIN)
         LDI     R16, HI8(IR_VALUE_DATA_TIME_MIN)
         CPC     R25, R16
         BRSH     more_vdt_min
         //begin
         //  Result := ireUndefined;
         RJMP     undefined
         //end
         //else
         more_vdt_min:
         //if ADataTime < IR_VALUE_DATA_TIME_MAX then
         CPI     R24, LO8(IR_VALUE_DATA_TIME_MAX)
         LDI     R16, HI8(IR_VALUE_DATA_TIME_MAX)
         CPC     R25, R16
         BRLO    less_vdt_max
         RJMP    more_vdt_max
         less_vdt_max:
         //begin
         //  if ASpaceTime < IR_SPACE0_DATA_TIME_MIN then
         CPI     R22, LO8(IR_SPACE0_DATA_TIME_MIN)
         LDI     R16, HI8(IR_SPACE0_DATA_TIME_MIN)
         CPC     R23, R16
         BRSH     more_sdt_min
         //    Result := ireUndefined
         RJMP     undefined
         //  else
         more_sdt_min:
         //  if ASpaceTime < IR_SPACE0_DATA_TIME_MAX then
         CPI     R22, LO8(IR_SPACE0_DATA_TIME_MAX)
         LDI     R16, HI8(IR_SPACE0_DATA_TIME_MAX)
         CPC     R23, R16
         BRLO    less_s0dt_max
         RJMP    more_s0dt_max
         less_s0dt_max:
         //    Result := ireData0
         LDI     R24, ireData0
         RJMP    exit
         //  else
         more_s0dt_max:
         //  if ASpaceTime < IR_SPACE1_DATA_TIME_MIN then
         CPI     R22, LO8(IR_SPACE1_DATA_TIME_MIN)
         LDI     R16, HI8(IR_SPACE1_DATA_TIME_MIN)
         CPC     R23, R16
         BRSH    more_s1dt_min
         //    Result := ireUndefined
         RJMP     undefined
         //  else
         more_s1dt_min:
         //  if ASpaceTime < IR_SPACE1_DATA_TIME_MAX then
         CPI     R22, LO8(IR_SPACE1_DATA_TIME_MAX)
         LDI     R16, HI8(IR_SPACE1_DATA_TIME_MAX)
         CPC     R23, R16
         BRSH    more_s1dt_max
         //    Result := ireData1
         LDI     R24, ireData1
         RJMP    exit
         //  else
         more_s1dt_max:
         //    Result := ireUndefined;
         RJMP     undefined
         //end
         //else
         more_vdt_max:
         //if ADataTime < IR_META_DATA_TIME_MIN then
         CPI     R24, LO8(IR_META_DATA_TIME_MIN)
         LDI     R16, HI8(IR_META_DATA_TIME_MIN)
         CPC     R25, R16
         BRSH    more_mdt_max
         //begin
         //  Result := ireUndefined;
         RJMP     undefined
         //end
         //else
         more_mdt_max:
         //if ADataTime < IR_META_DATA_TIME_MAX then
         CPI     R24, LO8(IR_META_DATA_TIME_MAX)
         LDI     R16, HI8(IR_META_DATA_TIME_MAX)
         CPC     R25, R16
         BRLO    less_mdt_max
         RJMP    undefined
         less_mdt_max:
         //begin
         //  if ASpaceTime < IR_REPEAT_SPACE_TIME_MIN then
         CPI     R22, LO8(IR_REPEAT_SPACE_TIME_MIN)
         LDI     R16, HI8(IR_REPEAT_SPACE_TIME_MIN)
         CPC     R23, R16
         BRSH    more_rst_min
         //    Result := ireUndefined
         RJMP     undefined
         //  else
         more_rst_min:
         //  if ASpaceTime < IR_REPEAT_SPACE_TIME_MAX then
         CPI     R22, LO8(IR_REPEAT_SPACE_TIME_MAX)
         LDI     R16, HI8(IR_REPEAT_SPACE_TIME_MAX)
         CPC     R23, R16
         BRSH    more_rst_max
         //    Result := ireRepeat
         LDI     R24, ireRepeat
         RJMP    exit
         //  else
         more_rst_max:
         //  if ASpaceTime < IR_PREAMBULE_SPACE_TIME_MIN then
         CPI     R22, LO8(IR_PREAMBULE_SPACE_TIME_MIN)
         LDI     R16, HI8(IR_PREAMBULE_SPACE_TIME_MIN)
         CPC     R23, R16
         BRSH    more_pst_min
         //    Result := ireUndefined
         RJMP     undefined
         //  else
         more_pst_min:
         //  if ASpaceTime < IR_PREAMBULE_SPACE_TIME_MAX then
         CPI     R22, LO8(IR_PREAMBULE_SPACE_TIME_MAX)
         LDI     R16, HI8(IR_PREAMBULE_SPACE_TIME_MAX)
         CPC     R23, R16
         BRSH    undefined
         //    Result := irePreamble
         LDI     R24, irePreamble
         RJMP    exit
         //  else
         //    Result := ireUndefined;
         //end
         //else
         //begin
         //  Result := ireUndefined;
         //end;
         undefined:
         CLR     R24
         exit:
         CLR     R25
         POP     R16
end;

function TIRReceiver.Read: TIRValue;
var
  VLastCounter, VCounter: Byte;
  VInSignal: Boolean;
  VInSpace: Boolean;
  VStage: TIRStage;
  VValue: Byte;
  VValueMask: Byte;
  VTime: Word;
  VDataTime: Word;
  VEvent: TIREvent;

  procedure Reset; assembler;
  asm
           PUSH    R18
           //VValue := 0;
           STD     VValue, R1
           //VValueMask := 1; 
           LDI     R18,1
           STD     VValueMask, R18
           //VInSpace := False;
           STD     VInSpace, R1
           //VTime := 0;
           STD     VTime, R1
           STD     VTime + 1, R1
           //VDataTime := 0;
           STD     VDataTime, R1
           STD     VDataTime + 1, R1
           //VStage := irsUndefined;
           STD     VStage, R1
           //Result := Default(TIRValue);
           STD     Result, R1
           STD     Result + 1, R1
           //VLastCounter := Timer0_Counter;
           IN      R18,38
           STD     VLastCounter, R18
           POP     R18
  end;

begin
  repeat
    if VStage = irsInvalid then
    begin
      UARTConsole.WriteLnFormat('Date time %d, space time %d, event %d', [VDataTime, VTime, Ord(VEvent)]);
      SleepMicroSecs(108000);
      Reset;
    end;
    VInSignal := DigitalRead(Pin);
    VCounter := Timer0_Counter;
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
          VEvent := CalcEvent(VDataTime, VTime);
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
                VValueMask := 1;
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
                  VValue := VValue or VValueMask
                else
                  VValue := VValue and not VValueMask;
                if VValueMask = 128 then
                begin
                  VValueMask := 1;
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
                  VValueMask := VValueMask shl 1;
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
      end;
    end;
  until VStage = irsComplete;
  FLastValue := Result;
end;

end.
