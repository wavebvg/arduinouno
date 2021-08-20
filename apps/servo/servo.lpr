program servo;

{$mode objfpc}{$H-}{$Z1}

uses
  ArduinoTools,
  UART,
  Timers,
  ServoI2;

var
  Servo1, Servo2, Servo3: TServoI;
  c: Char;
  i: Byte;

begin
  UARTConsole.Init(9600);
  //
  Servo1.Init(11, 0);
  Servo2.Init(12, 0);
  //Servo3.Init(13, 0);
  //
  Timer0.OutputModes := [];
  Timer0.CounterModes := [tcmCompareA];
  Timer0.CLKMode := tclkm64;
  //
  Timer1.OutputModes := [];
  Timer1.CounterModes := [];
  Timer1.CLKMode := tclkm64;
  //
  IEnable;
  //                 
  UARTConsole.WriteLnString('Start');
  UARTConsole.WriteLnFormat('SERVO_COUNT_A %d', [SERVO_COUNT_A]);
  UARTConsole.WriteLnFormat('SERVO_COUNT_B %d', [SERVO_COUNT_B]);
  UARTConsole.WriteLnFormat('SERVO_COUNT_D %d', [SERVO_COUNT_D]);
  repeat
    //UARTConsole.WriteLnFormat('LastCurrent[%d]: %d, %d', [LastIndex, LastCounter, LastValueA]);  
    SleepMicroSecs(500000);
    for i := 0 to ServoCount - 1 do
    begin
      UARTConsole.WriteLnFormat('Servo[%d]: {angle: %d, counter: %d, value: %d}',
        [i, Servos[i].Servo^.Angle, Counter[i], Servos[i].Counter]);
    end;
    c := UARTConsole.ReadChar;
    case c of
      '-':
        if Servo1.Angle > 0 then
          Servo1.Angle := Servo1.Angle - 5;
      '+':
        if Servo1.Angle < 180 then
          Servo1.Angle := Servo1.Angle + 5;
      '9':
        if Servo2.Angle > 0 then
          Servo2.Angle := Servo2.Angle - 5;
      '6':
        if Servo2.Angle < 180 then
          Servo2.Angle := Servo2.Angle + 5;
    end;
  until False;
end.
