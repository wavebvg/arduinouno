program servoempty;

{$mode objfpc}{$H-}{$Z1}

uses
  ArduinoTools,
  UART;

var
  c: Char;
  i: Integer;

begin
  UARTConsole.Init(9600);
  UARTConsole.BLECompatibleTime := 6;
  IEnable;
  //
  UARTConsole.WriteLnString('Start');
  //
  repeat
    for i := 1 to 20 do
    begin
      UARTConsole.WriteString('Servo[1]: 1 Servo[1]: 1 Servo[1]: 1 Servo[1]: 1 Servo[1]: 1 Servo[1]: 1'#10#13);
      UARTConsole.WriteString('Servo[1]: 1 Servo[1]: 1 Servo[1]: 1 Servo[1]: 1 Servo[1]: 1 Servo[1]: 1'#10#13);
      UARTConsole.WriteString('Servo[1]: 1 Servo[1]: 1 Servo[1]: 1 Servo[1]: 1 Servo[1]: 1 Servo[1]: 1'#10#13);
      UARTConsole.WriteString('Servo[1]: 1 Servo[1]: 1 Servo[1]: 1 Servo[1]: 1 Servo[1]: 1 Servo[1]: 1'#10#13);
    end;
    c := UARTConsole.ReadChar;
  until False;
end.
