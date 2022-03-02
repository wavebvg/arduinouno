program UltrasonicFW;

{$mode objfpc}{$H-}{$Z1}
{$i ../../src/TimersMacro.inc}

uses
  ArduinoTools,
  UART,
  Timers;

const
  ULTRASOUND_PIN = 3;


var
  VDuration: Cardinal;
  VDistance: Word;

begin
  UARTConsole.Init(9600);
  //
  Timer0.OutputModes := [];
  Timer0.CLKMode := tclkm64;
  //
  IEnable;
  //UARTConsole.WriteLnString('start');
  repeat
    PinMode(ULTRASOUND_PIN, avrmOutput);
    DigitalWrite(ULTRASOUND_PIN, False);
    SleepMicroSecs(2);
    DigitalWrite(ULTRASOUND_PIN, True);
    SleepMicroSecs(10);
    DigitalWrite(ULTRASOUND_PIN, False);
    PinMode(ULTRASOUND_PIN, avrmInput);
    VDuration := PulseIn(ULTRASOUND_PIN, True);
    if VDuration = $FFFFFFFF then
    begin
      //UARTConsole.WriteLnFormat('Invalid or timeout', []);
    end
    else
    begin
      VDistance := VDuration div 58;
      UARTConsole.WriteBuffer(@VDistance, SizeOf(VDistance));
    end;
    SleepMicroSecs(1000000);
  until False;
end.
