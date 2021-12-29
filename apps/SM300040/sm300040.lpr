program sm300040;

{$mode objfpc}{$H-}{$Z1}

uses
  ArduinoTools,
  KeyMap,
  IR,
  Timers,
  PWM,
  UART;

const
  IN1_PIN = 6;
  IN2_PIN = 10;
  IN3_PIN = 5;
  IN4_PIN = 9;

const
  IR_PIN_PORT = 11;

const
  DEFAULT_SPEED = 160;
  ROTATE_SPEED = 240;

var
  IReceiver: TIRReceiver;
  Value: TIRValue;

  procedure ResetSpeed;
  begin
    AnalogWrite(IN1_PIN, 255);
    AnalogWrite(IN2_PIN, 255);
    AnalogWrite(IN3_PIN, 255);
    AnalogWrite(IN4_PIN, 255);
    SleepMicroSecs(100000);
  end;

begin
  UARTConsole.Init(9600);

  IReceiver.Init(IR_PIN_PORT);
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

  Timer0.OutputModes := [];
  Timer0.CLKMode := tclkm64;
  //
  IEnable;
  UARTConsole.WriteLnString('start');
  repeat
    Value := IReceiver.Read;
    UARTConsole.WriteLnFormat('Key: %s', [GetKeyName(Value.Command)]);
    case Value.Command of
      KeyOK:
      begin
        ResetSpeed;
      end;
      KeyUP:
      begin
        AnalogWrite(IN1_PIN, DEFAULT_SPEED);
        AnalogWrite(IN2_PIN, 0);
        AnalogWrite(IN3_PIN, 0);
        AnalogWrite(IN4_PIN, DEFAULT_SPEED);
      end;
      KeyDOWN:
      begin
        ResetSpeed;
        AnalogWrite(IN1_PIN, 0);
        AnalogWrite(IN2_PIN, DEFAULT_SPEED);
        AnalogWrite(IN3_PIN, DEFAULT_SPEED);
        AnalogWrite(IN4_PIN, 0);
      end;
      KeyLEFT:
      begin
        ResetSpeed;
        AnalogWrite(IN1_PIN, ROTATE_SPEED);
        AnalogWrite(IN2_PIN, 0);
        AnalogWrite(IN3_PIN, ROTATE_SPEED);
        AnalogWrite(IN4_PIN, 0);
      end;
      KeyRIGHT:
      begin
        ResetSpeed;
        AnalogWrite(IN1_PIN, 0);
        AnalogWrite(IN2_PIN, ROTATE_SPEED);
        AnalogWrite(IN3_PIN, 0);
        AnalogWrite(IN4_PIN, ROTATE_SPEED);
      end;
    end;
  until False;
end.
