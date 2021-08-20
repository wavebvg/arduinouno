program TimersTest;

{$mode objfpc}{$H-}{$Z1}

uses
  ArduinoTools,
  UART,
  Timers;

var
  VValue: Word;

  procedure TimerEvent(const {%H-}ATimer: PTimer; const AType: TTimerSubscribeEventType);
  begin
    case AType of
      tsetCompareA:
      begin
        Inc(CounterCompareA);
        VValue := Timer1.Counter;
      end;
      tsetCompareB:
      begin
        Inc(CounterCompareB);
      end;
      tsetOverflow:
      begin
        Inc(CounterOverflow);
        Timer0.Counter := 0;
        Timer1.Counter := 0;
      end;
    end;
  end;

begin
  UARTConsole.Init(9600);
  Timer0.SubscribeOVFProc(@TimerEvent);
  Timer0.SetCompareAProc(@TimerEvent);
  Timer0.SetCompareBProc(@TimerEvent);
  //
  Timer0.ValueA := 129;
  Timer0.OutputModes := [];
  Timer0.CounterModes := [tcmCompareA {,tcmCompareB}, tcmOverflow];
  Timer0.CLKMode := tclkm64;
  //
  Timer1.OutputModes := [];
  Timer1.CounterModes := [];
  Timer1.CLKMode := tclkm64;
  //
  SleepMicroSecs(500000);
  //
  UARTConsole.WriteLnString('start');
  //
  IEnable;
  //
  UARTConsole.WriteLnString('work');
  //
  SleepMicroSecs(1000000);
  //
  IDisable;
  UARTConsole.WriteLnString('finish');
  UARTConsole.WriteLnFormat('%d %d %d', [CounterCompareA, CounterCompareB, CounterOverflow]);
  UARTConsole.WriteLnFormat('%d', [VValue]);
  repeat
  until False;
end.
