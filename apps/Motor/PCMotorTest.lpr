program PCMotorTest;

uses
  SysUtils,
  ArduinoTools,
  PWM;

var
  i: Integer;

begin
  AnalogWrite(9, 250);
  //AnalogWrite(2, 2);
  //AnalogWrite(3, 3);
  //AnalogWrite(4, 4);
  //AnalogWrite(5, 5);
  //AnalogWrite(6, 6);
  //AnalogWrite(7, 7);
  //AnalogWrite(8, 8);  
  WriteLn(Format('PWMChanged: %d', [Ord(PWMChanged)]));
  WriteLn(Format('PWMCount: %d', [PWMCount]));
  for i := 0 to PWMCount - 1 do
    WriteLn(Format('  PWM[%d]: %d', [PWMPins[i].Pin, PWMPins[i].Counter]));
  DoTimer0ServoCompareB;
  DoTimer0ServoCompareB;
  DoTimer0ServoCompareB;
  DoTimer0ServoCompareB;
  DoTimer0ServoCompareB;
  DoTimer0ServoCompareB;
  DoTimer0ServoCompareB;
  DoTimer0ServoCompareB;
  DoTimer0ServoCompareB;
  DoTimer0ServoCompareB;
  DoTimer0ServoCompareB;
  DoTimer0ServoCompareB;
  DoTimer0ServoCompareB;
  DoTimer0ServoCompareB;
  DoTimer0ServoCompareB;
  DoTimer0ServoCompareB;
  DoTimer0ServoCompareB;
  DoTimer0ServoCompareB;
  DoTimer0ServoCompareB;
  DoTimer0ServoCompareB;
  WriteLn(Format('SortedPWMCount: %d', [SortedPWMCount]));
  if SortedPWMCount > 0 then
    for i := 0 to SortedPWMCount - 1 do
      WriteLn(Format('  PWM[%d]: {counter: %d, value: %d}',
        [i, SortedPWMs[i].Counter, PWMCounter[i]]));
end.
