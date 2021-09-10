unit UServoCommands;

{$mode objfpc}{$H-}{$Z1}

interface

type
  TServoCommandType = (sctWrite, sctReadAll, sctSaveAll, sctLoadAll);

  TServoData = packed record
    ServoIndex: Byte;
    Angle: Byte;
  end;

  TServoCommand = packed record
    CommandType: TServoCommandType;
    Data: TServoData;
  end;

implementation

end.
