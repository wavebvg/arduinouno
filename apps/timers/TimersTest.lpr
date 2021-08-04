program TimersTest;

{$mode objfpc}{$H-}{$Z1}

uses
  ArduinoTools,
  UART,
  Timers;

  procedure TimerEvent(const {%H-}ATimer: PTimer; const AType: TTimerSubscribeEventType);
  begin
    case AType of
      tsetCompareA:
      begin
        Inc(CounterCompareA);
      end;
      tsetCompareB:
      begin
        Inc(CounterCompareB);
      end;
      tsetOverflow:
      begin
        Inc(CounterOverflow);
      end;
    end;
  end;

begin
  UARTConsole.Init(9600);
  Timer0.Subscribe(@TimerEvent, [tsetCompareA, tsetCompareB, tsetOverflow]);
  //
  Timer0.CTCMode := True;
  Timer0.OutputModes := [];
  Timer0.CounterModes := [{tcmCompareA, tcmCompareB,} tcmOverflow];
  Timer0.CLKMode := tclkm256;
  //
  SleepMicroSecs(500000);
  //                  
  UARTConsole.WriteLnString('start');
  //
  InterruptsEnable;
  //
  UARTConsole.WriteLnString('work');
  //
  SleepMicroSecs(2000000);
  //
  InterruptsDisable;
  UARTConsole.WriteLnString('finish');
  UARTConsole.WriteLnFormat('%d %d %d', [CounterCompareA, CounterCompareB, CounterOverflow]);
  repeat
  until False;
end.
