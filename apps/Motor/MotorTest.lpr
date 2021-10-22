program MotorTest;

{$mode objfpc}{$H-}{$Z1}

uses
  ArduinoTools,
  UART,
  Timers,
  PWM;

const
  IN1_PIN = 6;
  IN2_PIN = 10;
  IN3_PIN = 5;
  IN4_PIN = 9;

var
  i: SmallInt;

begin
  UARTConsole.Init(9600);
  //
  PinMode(IN1_PIN, avrmOutput);
  AnalogWrite(IN1_PIN, 0);
  //
  PinMode(IN2_PIN, avrmOutput);
  AnalogWrite(IN2_PIN, 0);
  //
  PinMode(IN3_PIN, avrmOutput);
  AnalogWrite(IN3_PIN, 0);
  //
  PinMode(IN4_PIN, avrmOutput);
  AnalogWrite(IN4_PIN, 0);
  //
  Timer0.OutputModes := [];
  Timer0.CLKMode := tclkm64;
  //
  UARTConsole.WriteLnString('Start');
  //
  IEnable;
  repeat
    UARTConsole.WriteLnString('Forward');
    analogWrite(IN1_PIN, 100);
    analogWrite(IN2_PIN, 0);
    analogWrite(IN3_PIN, 0);
    analogWrite(IN4_PIN, 100);
    SleepMicroSecs(5000000);
    //******** ******************************//forward
    analogWrite(IN1_PIN, 255);
    analogWrite(IN2_PIN, 255);
    analogWrite(IN3_PIN, 255);
    analogWrite(IN4_PIN, 255);
    SleepMicroSecs(5000000);//********************************************//stop
    analogWrite(IN1_PIN, 0);
    analogWrite(IN2_PIN, 100);
    analogWrite(IN3_PIN, 100);
    analogWrite(IN4_PIN, 0);
    SleepMicroSecs(5000000);//*********************************************//back
    analogWrite(IN1_PIN, 255);
    analogWrite(IN2_PIN, 255);
    analogWrite(IN3_PIN, 255);
    analogWrite(IN4_PIN, 255);
    SleepMicroSecs(5000000);
    //******* ***************************************//stop
    analogWrite(IN1_PIN, 200);
    analogWrite(IN2_PIN, 0);
    analogWrite(IN3_PIN, 200);
    analogWrite(IN4_PIN, 0);
    SleepMicroSecs(5000000);
    //*******************************************//left
    analogWrite(IN1_PIN, 255);
    analogWrite(IN2_PIN, 255);
    analogWrite(IN3_PIN, 255);
    analogWrite(IN4_PIN, 255);
    SleepMicroSecs(5000000); //*******************************************//stop
    analogWrite(IN1_PIN, 0);
    analogWrite(IN2_PIN, 200);
    analogWrite(IN3_PIN, 0);
    analogWrite(IN4_PIN, 200);
    SleepMicroSecs(5000000);//*** ***************************************//right
  until False;
end.
