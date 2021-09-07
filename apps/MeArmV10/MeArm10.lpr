program MeArm10;

{$mode objfpc}{$H-}{$Z1}

uses
  ArduinoTools,
  UServoCommands,
  UART,
  ServoI;

const
  SERVO_COUNT = 4;

var
  i: Byte;
  VServos: array[1..SERVO_COUNT] of TServoI;
  VCommand: TServoCommand;

begin
  UARTConsole.Init(9600);
  for i := 1 to SERVO_COUNT do
  begin
    VServos[i] := Default(TServoI);
    VServos[i].Init(9 + i, 0);
  end;
  IEnable;
  repeat
    UARTConsole.ReadBuffer(@VCommand, SizeOf(VCommand));
    with VCommand do
      case CommandType of
        sctRead:
        begin
          Data.Angle := VServos[Data.ServoIndex].Angle;
          UARTConsole.WriteBuffer(@Data, SizeOf(Data));
        end;
        sctWrite:
          VServos[Data.ServoIndex].Angle := Data.Angle;
        else
          ;
      end;
  until False;
end.
