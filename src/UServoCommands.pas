unit UServoCommands;

{$mode objfpc}{$H-}{$Z1}

interface

type
  TServoCommandType = (sctRead, sctWrite);

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
