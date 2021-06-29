program TimersTest;

{$mode objfpc}{$H-}{$Z1}

uses
  ArduinoTools,
  UART,
  Timers;

var
  CounterCompareA, CounterCompareB, CounterOverflow: Longint;

  procedure Timer1Event(const {%H-}ATimer: PCustomTimer; const AType: TTimerSubscribeEventType);
  begin
    case AType of
      tsetCompareA:
        Inc(CounterCompareA);
      tsetCompareB:
        Inc(CounterCompareB);
      tsetOverflow:
        Inc(CounterOverflow);
    end;
  end;

begin
  UARTConsole.Init(9600);
  Timer1.Subscribe(@Timer1Event, [tsetCompareA, tsetCompareB, tsetOverflow]);
  //
  InterruptsEnable;
  //
  UARTConsole.WriteLnString('start');
  repeat
    SleepMicroSecs(5000000);
    Timer1.CounterModes := [];
    Timer1.ValueA := 0;
    Timer1.ValueB := 0;
    UARTConsole.WriteString(IntToStr(CounterCompareA));
    UARTConsole.WriteString(' ');
    UARTConsole.WriteString(IntToStr(CounterCompareB));
    UARTConsole.WriteString(' ');
    UARTConsole.WriteLnString(IntToStr(CounterOverflow));
    CounterCompareA := 0;
    CounterCompareB := 0;
    CounterOverflow := 0;
    Timer1.ValueA := System.High(Word) div 4;
    Timer1.ValueB := System.High(Word) div 2;
    Timer1.CounterModes := [tcmOverflow, tcmCompareA, tcmCompareB];
  until False;
end.
