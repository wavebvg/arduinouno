program EMakeFunMotor;

{$mode objfpc}{$H-}{$Z1}
{$i ../../src/TimersMacro.inc}

uses
  ArduinoTools,
  UART,
  PWM,
  CustomIRReceiver,
  IRReceiver,
  KeyMap,
  Timers;

const
  IR_PIN_PORT = 11;
  ULTRASOUND_PIN = 3;

const
  IN1_PIN = 6;
  IN2_PIN = 10;
  IN3_PIN = 5;
  IN4_PIN = 9;

type

  { TBot }

  TBot = object
  private
  public
    constructor Init;
    procedure Up;
    procedure Down;
    procedure Left;
    procedure Right;
    procedure Stop;
  end;


  { TMotor }

  constructor TBot.Init;
  begin
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
  end;

  procedure TBot.Up;
  begin
    AnalogWrite(IN1_PIN, 200);
    AnalogWrite(IN2_PIN, 0);
    AnalogWrite(IN3_PIN, 0);
    AnalogWrite(IN4_PIN, 200);
  end;

  procedure TBot.Down;
  begin
    AnalogWrite(IN1_PIN, 0);
    AnalogWrite(IN2_PIN, 200);
    AnalogWrite(IN3_PIN, 200);
    AnalogWrite(IN4_PIN, 0);
  end;

  procedure TBot.Left;
  begin
    AnalogWrite(IN1_PIN, 200);
    AnalogWrite(IN2_PIN, 0);
    AnalogWrite(IN3_PIN, 200);
    AnalogWrite(IN4_PIN, 0);
  end;

  procedure TBot.Right;
  begin
    AnalogWrite(IN1_PIN, 0);
    AnalogWrite(IN2_PIN, 200);
    AnalogWrite(IN3_PIN, 0);
    AnalogWrite(IN4_PIN, 200);
  end;

  procedure TBot.Stop;
  begin
    AnalogWrite(IN1_PIN, 255);
    AnalogWrite(IN2_PIN, 255);
    AnalogWrite(IN3_PIN, 255);
    AnalogWrite(IN4_PIN, 255);
  end;

var
  IR: TIRReceiver;
  Command: TIRValue;
  Bot: TBot;

begin
  UARTConsole.Init(9600);
  IR.Init(IR_PIN_PORT);
  //
  Timer0.OutputModes := [];
  Timer0.CLKMode := tclkm64;
  //
  IEnable;
  UARTConsole.WriteLnString('start');
  repeat
    Command := IR.Read;
    case Command.Command of
      KeyOK:
      begin
        UARTConsole.WriteLnString('Stop');
        Bot.Stop;
      end;
      KeyUP:   
      begin
        UARTConsole.WriteLnString('Up');
        Bot.Up;
      end;
      KeyDOWN:  
      begin
        UARTConsole.WriteLnString('Down');
        Bot.Down;
      end;
      KeyRIGHT: 
      begin
        UARTConsole.WriteLnString('Right');
        Bot.Right;
      end;
      KeyLEFT:  
      begin
        UARTConsole.WriteLnString('Left');
        Bot.Left;
      end;
    end;
  until False;
end.
