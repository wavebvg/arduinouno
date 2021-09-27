program servoempty;

{$mode objfpc}{$H-}{$Z1}

uses
  ArduinoTools,
  UART;

var
  c: Char;

begin
  UARTConsole.Init(9600);
  //
  UARTConsole.WriteLnString('Start');
  //
  repeat
    UARTConsole.WriteString('Servo[1]: 1'#10#13);
    UARTConsole.WriteString('Servo[2]: 0'#10#13);
    UARTConsole.WriteString('Servo[3]: 0'#10#13);
    UARTConsole.WriteString('Servo[4]: 0'#10#13);
    UARTConsole.WriteString('SortedServoCount: 2'#10#13);
    UARTConsole.WriteString('Servo[0]: {counter: 125, value: 125}'#10#13);
    UARTConsole.WriteString('Servo[1]: {counter: 2, value: 128}'#10#13);
    UARTConsole.ReadChar;
  until False;
end.
