program MeArm10;

{$mode objfpc}{$H-}{$Z1}

uses
  ArduinoTools,
  UServoCommands,
  UART,
  EEPROM,
  Servo,
  Timers,
  ServoI;

const
  SERVO_COUNT = 4;

type
  TAngles = array[1..SERVO_COUNT] of Byte;

var
  Servos: array[1..SERVO_COUNT] of TServoI;
  Angles: TAngles;
  SaveCounter: Word;

  procedure SaveServo(const AIndex: Integer);
  var
    VAngle: Byte;
  begin
    Angles[AIndex] := 0;
    VAngle := Servos[AIndex].Angle;
    ROM.WriteBuffer(AIndex - 1, @VAngle, SizeOf(Byte));
  end;

  procedure SaveChanges;
  var
    i: Byte;
  begin
    Inc(SaveCounter);
    if SaveCounter mod (2 * 1024) = 0 then
    begin
      for i := 1 to SERVO_COUNT do
        if Angles[i] = 1 then
          SaveServo(i);
    end;
  end;

var
  i: Byte;
  Command: TServoCommand;

begin
  UARTConsole.Init(9600);
  //
  Angles := Default(TAngles);
  ROM.ReadBuffer(0, @Angles, SizeOf(Angles));
  for i := 1 to SERVO_COUNT do
  begin
    Servos[i] := Default(TServoI);
    Servos[i].Init(9 + i, Angles[i]);
  end;
  Angles := Default(TAngles);
  //
  Timer0.OutputModes := [];
  Timer0.CounterModes := [tcmOverflow];
  Timer0.CLKMode := tclkm64;
  Timer0.SubscribeOVFProc(@SaveChanges);
  //       
  for i := 1 to SERVO_COUNT do
    with Command do
    begin
      Data.ServoIndex := i;
      Data.Angle := Servos[i].Angle;
      UARTConsole.WriteBuffer(@Data, SizeOf(Data));
    end;
  //
  IEnable;
  repeat
    UARTConsole.ReadBuffer(@Command, SizeOf(Command));
    with Command do
      case CommandType of
        sctReadAll:
          for i := 1 to SERVO_COUNT do
          begin
            Data.ServoIndex := i;
            Data.Angle := Servos[i].Angle;
            UARTConsole.WriteBuffer(@Data, SizeOf(Data));
          end;
        sctWrite:
        begin
          SaveCounter := 0;
          Servos[Data.ServoIndex].Angle := Data.Angle;
          Angles[Data.ServoIndex] := 1;
        end;
        sctSaveAll:
        begin
          Angles := Default(TAngles);
          SaveCounter := 0;
          for i := 1 to SERVO_COUNT do
            SaveServo(i);
        end;
        sctLoadAll:
        begin
          SaveCounter := 0;
          Angles := Default(TAngles);
          IPause;
          ROM.ReadBuffer(0, @Angles, SizeOf(Angles));
          IResume;
          for i := 1 to SERVO_COUNT do
            with Command do
            begin
              Data.ServoIndex := i;
              Data.Angle := Angles[i];
              UARTConsole.WriteBuffer(@Data, SizeOf(Data));
            end;
          Angles := Default(TAngles);
        end
        else
          ;
      end;
  until False;
end.
