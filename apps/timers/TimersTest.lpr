program TimersTest;

{$mode objfpc}{$H-}{$Z1}

uses
  ArduinoTools,
  UART,
  Timers;

  procedure Timer1Event(const {%H-}ATimer: PCustomTimer; const AType: TTimerSubscribeEventType);
  var
    VNewValue: Word;
  begin
    case AType of
      tsetCompareA:
      begin
        Inc(CounterCompareA);
        //if ATimer^.Bits = 16 then
        //begin
        //  VNewValue := PTimer16(ATimer)^.Counter + 1024;
        //  PTimer16(ATimer)^.ValueA := VNewValue;
        //end;
      end;
      tsetCompareB:
      begin
        Inc(CounterCompareB);
        //if ATimer^.Bits = 16 then
        //begin
        //  VNewValue := PTimer16(ATimer)^.Counter + 1024;
        //  PTimer16(ATimer)^.ValueB := VNewValue;
        //end;
      end;
      tsetOverflow:
        Inc(CounterOverflow);
    end;
  end;

begin
  InterruptsDisable;
  UARTConsole.Init(9600);
  Timer0.Subscribe(@Timer1Event, [tsetCompareA, tsetCompareB, tsetOverflow]);
  //
  Timer0.OutputModes := [];
  Timer0.CounterModes := [tcmCompareA, tcmCompareB, tcmOverflow];
  //
  Timer0.CLKMode := tclkm64;
  //Timer0.CTCMode := True;
  //Timer0.ValueA := 1024;
  //Timer0.ValueB := 2048;
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
