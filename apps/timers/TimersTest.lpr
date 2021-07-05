program TimersTest;

{$mode objfpc}{$H-}{$Z1}

uses
  ArduinoTools,
  UART,
  Timers;

  procedure TimerEvent(const {%H-}ATimer: PCustomTimer; const AType: TTimerSubscribeEventType);
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
        Inc(CounterOverflow);
    end;
  end;

begin
  InterruptsDisable;
  UARTConsole.Init(9600);
  Timer2.Subscribe(@TimerEvent, [tsetCompareA, tsetCompareB, tsetOverflow]);
  //
  Timer2.OutputModes := [];
  Timer2.CounterModes := [tcmCompareA, tcmCompareB, tcmOverflow];
  //
  Timer2.CLKMode := t2clkm256;
  //
  SleepMicroSecs(500000);
  //
  UARTConsole.WriteLnString('start');
  //
  InterruptsEnable;
  //
  SleepMicroSecs(1000000);
  //
  InterruptsDisable;
  UARTConsole.WriteString(IntToStr(CounterCompareA));
  UARTConsole.WriteString(' ');
  UARTConsole.WriteString(IntToStr(CounterCompareB));
  UARTConsole.WriteString(' ');
  UARTConsole.WriteLnString(IntToStr(CounterOverflow));
  repeat
  until False;
end.
