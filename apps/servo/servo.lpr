program servo;

{$mode objfpc}{$H-}{$Z1}

uses
  ArduinoTools,
  UART,
  Timers,
  ServoI,
  EEPROM;

const
  SERVO_COUNT = 4;

type
  TAngles = array[1..SERVO_COUNT] of Byte;

var
  i: Byte;
  c: Char;
  VServos: array[1..SERVO_COUNT] of TServoI;
  Angles: TAngles;
  SaveCounter: Word;
  SaveSkip: Boolean;

  procedure CheckChanges;
  var
    i: Byte;
    VAngle: Byte;
  begin
    Inc(SaveCounter);
    if SaveCounter mod 2000 = 0 then
    begin
      if SaveSkip then
        SaveSkip := False
      else
        for i := 1 to SERVO_COUNT do
          if Angles[i] = 1 then
          begin
            Angles[i] := 0;
            VAngle := VServos[i].Angle;
            ROM.WriteBuffer(i - 1, @VAngle, SizeOf(Byte));
            UARTConsole.WriteLnFormat('Servo[%d] saved', [i]);
          end;
    end;
  end;

begin
  IDisable;
  UARTConsole.Init(9600);
  //
  Angles := Default(TAngles);
  ROM.ReadBuffer(0, @Angles, SizeOf(Angles));
  for i := 1 to SERVO_COUNT do
  begin
    VServos[i] := Default(TServoI);
    VServos[i].Init(i + 9, Angles[i]);
  end;
  Angles := Default(TAngles);
  //
  Timer0.OutputModes := [];
  Timer0.CounterModes := [tcmOverflow];
  Timer0.CLKMode := tclkm64;
  Timer0.SubscribeOVFProc(@CheckChanges);
  //
  UARTConsole.WriteLnString('Start');
  //
  IEnable;
  repeat
    SleepMicroSecs(100000);
    //while SortedServoIndex >= ServoCount do
    //;
    //while SortedServoIndex < ServoCount do
    //;
    //IPause;
    for i := 1 to SERVO_COUNT do
    begin
      UARTConsole.WriteLnFormat('Servo[%d]: {angle: %d, value: %d}', [i, VServos[i].Angle,
        VServos[i].FCounter]);
    end;
    //for i := 0 to SortedServoCount - 1 do
    //begin
    //  UARTConsole.WriteLnFormat('Counter[%d]: {begin: %d, count: %d, diff: %d, tmp: %d:%d}',
    //    [i, ServoBeginCounter, ServoCounter[i], SortedServos[i].Counter, SortedServoIndex, Ord(NeedSort)]);
    //end;
    //IResume;
    c := UARTConsole.ReadChar;
    case c of
      '-':
        if VServos[1].Angle > 0 then
        begin
          VServos[1].Angle := VServos[1].Angle - 1;
          SaveSkip := True;
          Angles[1] := 1;
        end;
      '+':
        if VServos[1].Angle < 180 then
        begin
          VServos[1].Angle := VServos[1].Angle + 1;
          SaveSkip := True;
          Angles[1] := 1;
        end;
      '9':
        if VServos[2].Angle > 0 then
        begin
          VServos[2].Angle := VServos[2].Angle - 1;
          SaveSkip := True;
          Angles[2] := 1;
        end;
      '6':
        if VServos[2].Angle < 180 then
        begin
          VServos[2].Angle := VServos[2].Angle + 1;
          SaveSkip := True;
          Angles[2] := 1;
        end;
    end;
  until False;
end.
