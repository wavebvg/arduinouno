unit CustomIRReceiver;

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


type
  TIRValue = packed record
    Address, Command: Byte;
  end;

type

  { TCustomIRReceiver }

  TCustomIRReceiver = object(TCustomPinInput)
  public
    function Read: TIRValue; virtual; abstract;
  end;

implementation

end.
