unit UFormISREmulator;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  Forms,
  Controls,
  Dialogs,
  StdCtrls,
  ServoI2,
  LMessages;

const
  UM_TIMER0_COMAPREA = WM_USER + 323;

type

  { TFormISREmulator }

  TFormISREmulator = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure UMTimer0ComareA(var AMsg: TLMessage); message UM_TIMER0_COMAPREA;
    procedure Timer0OnCompareA(Sender: TObject);
  public
  end;

var
  FormISREmulator: TFormISREmulator;
  VValue: Word;
  Servo0, Servo1, Servo2: TServoI;

implementation

uses
  LCLIntf,
  UISRTimers;

{$R *.lfm}

{ TFormISREmulator }

procedure TFormISREmulator.FormCreate(Sender: TObject);
begin
  Servo0.Init(11, 0);
  Servo1.Init(12, 0);
  Servo2.Init(13, 50);
  Timer0.OnCompareA := @Timer0OnCompareA;
  Timer0.Start;
end;

procedure TFormISREmulator.UMTimer0ComareA(var AMsg: TLMessage);
begin
  DoTimer0ServoCompareA(nil, 0);
end;

procedure TFormISREmulator.Button1Click(Sender: TObject);
begin
  WriteLn(VValue);
end;

procedure TFormISREmulator.Timer0OnCompareA(Sender: TObject);
begin
  SendMessage(Handle, UM_TIMER0_COMAPREA, 0, 0);
end;

end.
