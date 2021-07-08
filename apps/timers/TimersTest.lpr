program TimersTest;

{$mode objfpc}{$H-}{$Z1}

uses
  ArduinoTools,
  UART,
  Timers;

  procedure TimerEvent(const {%H-}ATimer: PTimer; const AType: TTimerSubscribeEventType);
  var
    VValue1, VValue2: Word;
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
        VValue1 := Timer1.Counter;
        Inc(CounterOverflow);
        VValue2 := Timer1.Counter;
        UARTConsole.WriteFormat('%s => %s', [VValue1, VValue2]);
      end;
    end;
  end;

begin
  InterruptsDisable;
  UARTConsole.Init(9600);
  Timer0.Subscribe(@TimerEvent, [tsetCompareA, tsetCompareB, tsetOverflow]);
  //
  Timer0.OutputModes := [];
  Timer0.CounterModes := [tcmCompareA, tcmCompareB, tcmOverflow];
  Timer0.CLKMode := tclkm1024;
  //
  Timer1.CLKMode := tclkm1;
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
