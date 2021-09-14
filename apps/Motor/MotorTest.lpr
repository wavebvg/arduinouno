program MotorTest;

{$mode objfpc}{$H-}{$Z1}

uses
  ArduinoTools,
  KeyMap,
  IR,
  UART, PWM;

const
  IR_PIN_PORT = 11;
  MOTOR_IN1_PIN = 6;
  MOTOR_IN2_PIN = 10;
  MOTOR_IN3_PIN = 5;
  MOTOR_IN4_PIN = 9;

var
  IRData: TIRReceiver;
  Value: TIRValue;
  Timer: Word;
begin
  UARTConsole.Init(9600);
  IRData.Init(IR_PIN_PORT);
  //
  PinMode(MOTOR_IN1_PIN, avrmOutput);
  PinMode(MOTOR_IN2_PIN, avrmOutput);
  PinMode(MOTOR_IN3_PIN, avrmOutput);
  PinMode(MOTOR_IN4_PIN, avrmOutput);
  //
  DigitalWrite(MOTOR_IN1_PIN, False);
  DigitalWrite(MOTOR_IN2_PIN, False);
  DigitalWrite(MOTOR_IN3_PIN, False);
  DigitalWrite(MOTOR_IN4_PIN, False);
  //
  UARTConsole.WriteLnString('start');
  //
  //
  IEnable;
  // Forward
  Timer := 0;
  repeat
    Inc(Timer);
    DigitalWrite(MOTOR_IN1_PIN, True);
    DigitalWrite(MOTOR_IN2_PIN, False);
    DigitalWrite(MOTOR_IN3_PIN, False);
    DigitalWrite(MOTOR_IN4_PIN, True);
    SleepMicroSecs(780);
    DigitalWrite(MOTOR_IN1_PIN, False);
    DigitalWrite(MOTOR_IN2_PIN, False);
    DigitalWrite(MOTOR_IN3_PIN, False);
    DigitalWrite(MOTOR_IN4_PIN, False);
    SleepMicroSecs(1218);
  until Timer mod 2500 = 0;
  // Stop
  Timer := 0;
  repeat
    Inc(Timer);
    DigitalWrite(MOTOR_IN1_PIN, True);
    DigitalWrite(MOTOR_IN2_PIN, True);
    DigitalWrite(MOTOR_IN3_PIN, True);
    DigitalWrite(MOTOR_IN4_PIN, True);
    SleepMicroSecs(1998);
  until Timer mod 2500 = 0;
  // Back
  Timer := 0;
  repeat
    Inc(Timer);
    DigitalWrite(MOTOR_IN1_PIN, False);
    DigitalWrite(MOTOR_IN2_PIN, True);
    DigitalWrite(MOTOR_IN3_PIN, True);
    DigitalWrite(MOTOR_IN4_PIN, False);
    SleepMicroSecs(780);
    DigitalWrite(MOTOR_IN1_PIN, False);
    DigitalWrite(MOTOR_IN2_PIN, False);
    DigitalWrite(MOTOR_IN3_PIN, False);
    DigitalWrite(MOTOR_IN4_PIN, False);
    SleepMicroSecs(1218);
  until Timer mod 2500 = 0;
  // Stop
  Timer := 0;
  repeat
    Inc(Timer);
    DigitalWrite(MOTOR_IN1_PIN, True);
    DigitalWrite(MOTOR_IN2_PIN, True);
    DigitalWrite(MOTOR_IN3_PIN, True);
    DigitalWrite(MOTOR_IN4_PIN, True);
    SleepMicroSecs(1998);
  until Timer mod 2500 = 0;
  // Left
  Timer := 0;
  repeat
    Inc(Timer);
    DigitalWrite(MOTOR_IN1_PIN, True);
    DigitalWrite(MOTOR_IN2_PIN, False);
    DigitalWrite(MOTOR_IN3_PIN, True);
    DigitalWrite(MOTOR_IN4_PIN, False);
    SleepMicroSecs(780);
    DigitalWrite(MOTOR_IN1_PIN, False);
    DigitalWrite(MOTOR_IN2_PIN, False);
    DigitalWrite(MOTOR_IN3_PIN, False);
    DigitalWrite(MOTOR_IN4_PIN, False);
    SleepMicroSecs(1218);
  until Timer mod 2500 = 0;
  // Stop
  Timer := 0;
  repeat
    Inc(Timer);
    DigitalWrite(MOTOR_IN1_PIN, True);
    DigitalWrite(MOTOR_IN2_PIN, True);
    DigitalWrite(MOTOR_IN3_PIN, True);
    DigitalWrite(MOTOR_IN4_PIN, True);
    SleepMicroSecs(1998);
  until Timer mod 2500 = 0;
  // Right
  Timer := 0;
  repeat
    Inc(Timer);
    DigitalWrite(MOTOR_IN1_PIN, False);
    DigitalWrite(MOTOR_IN2_PIN, True);
    DigitalWrite(MOTOR_IN3_PIN, False);
    DigitalWrite(MOTOR_IN4_PIN, True);
    SleepMicroSecs(780);
    DigitalWrite(MOTOR_IN1_PIN, False);
    DigitalWrite(MOTOR_IN2_PIN, False);
    DigitalWrite(MOTOR_IN3_PIN, False);
    DigitalWrite(MOTOR_IN4_PIN, False);
    SleepMicroSecs(1218);
  until Timer mod 2500 = 0;
  // Stop
  Timer := 0;
  repeat
    Inc(Timer);
    DigitalWrite(MOTOR_IN1_PIN, True);
    DigitalWrite(MOTOR_IN2_PIN, True);
    DigitalWrite(MOTOR_IN3_PIN, True);
    DigitalWrite(MOTOR_IN4_PIN, True);
    SleepMicroSecs(1998);
  until Timer mod 2500 = 0;
  repeat
    //Value := IRData.Read;
    //UARTConsole.WriteLnFormat('Key: %s', [GetKeyName(Value.Command)]);
  until False;
end.
