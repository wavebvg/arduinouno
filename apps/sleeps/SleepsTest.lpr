program SleepsTest;

{$mode objfpc}{$H-}
{$goto on}

uses
  ArduinoTools,
  UARTI;

  //function Div1024(const AValue: Longint): Longint; assembler;
  //asm
  //         PUSH    R17                   // 2
  //         PUSH    R18                   // 2
  //         PUSH    R19                   // 2
  //         MOV     R17, R23              // 1
  //         LSR     R17                   // 1
  //         LSR     R17                   // 1
  //         //
  //         MOV     R18, R24              // 1
  //         SBRC    R18, 0                // 1|2
  //         ORI     R17, 64               // 1
  //         LSR     R18                   // 1
  //         SBRC    R18, 0                // 1|2
  //         ORI     R17, 128              // 1
  //         LSR     R18                   // 1
  //         //
  //         MOV     R19, R25              // 1
  //         SBRC    R19, 0                // 1|2
  //         ORI     R18, 64               // 1
  //         LSR     R19                   // 1
  //         SBRC    R19, 0                // 1|2
  //         ORI     R18, 128              // 1
  //         LSR     R19                   // 1
  //         //
  //         LDI     R25, 0                // 1 
  //         POP     R17                   // 2
  //         POP     R18                   // 2
  //         POP     R19                   // 2
  //end;

  procedure TestSleep(const ASecs: Byte);
  var
    i, j: Byte;
  begin
    for i := 1 to 5 do
    begin
      SleepMicroSecs(ASecs * 1000000);
      UARTConsole.WriteString(IntToStr(ASecs));
      UARTConsole.WriteLnString('s+');
    end;
    //for i := 1 to 5 do
    //begin
    //  j := 0;
    //  while j < ASecs - 1 do
    //  begin
    //    Sleep10ms(ASecs * 200);
    //    Inc(j, 2);
    //  end;
    //  if j < ASecs then
    //    Sleep10ms(ASecs * 200);
    //  UARTIConsole.WriteString(IntToStr(ASecs));
    //  UARTIConsole.WriteLnString('s');
    //end;
  end;

begin
  UARTConsole.Init(9600);
  InterruptsEnable;
  UARTConsole.WriteLnString('start');
  TestSleep(1);
  TestSleep(2);
  TestSleep(5);
  TestSleep(10);
  TestSleep(15);
  TestSleep(20);
  repeat
  until False;
end.
