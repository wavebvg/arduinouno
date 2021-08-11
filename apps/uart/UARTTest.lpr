program UARTTest;

{$mode objfpc}{$H-}{$Z1}

uses
  ArduinoTools,
  UART;

var
  VArray: array[1..1024] of Byte;
  VPByte: Pbyte;
  VPointer: Pointer;
  VAddress: Word;

begin
  UARTConsole.Init(BaudRate);
  InterruptsEnable;
  //
  UARTConsole.WriteLnString('Start');
  //
  SleepMicroSecs(100000000);
  VPByte := @VArray[1];
  VAddress := $1234;
  VPointer := @VAddress;
  ///
  UARTConsole.WriteLnString('Int test');
  UARTConsole.WriteLnFormat('Max low %d, low %d, zero %d, high %d, max high %d',
    [Low(Longint), -100, 0, 100, High(Longint)]);
  SleepMicroSecs(100000000);
  //
  UARTConsole.WriteLnString('Str test');
  UARTConsole.WriteLnFormat('Empty "%s", short "%s", long "%s"', ['', 'test', 'very long test string for test']);
  SleepMicroSecs(100000000);
  //
  UARTConsole.WriteLnString('Pointer test');
  UARTConsole.WriteLnFormat('Address $%x, hex %x', [VPByte, 100500, VPointer]);
  UARTConsole.WriteLnFormat('Address $%x, hex %x (pointer $%x)', [VPByte, 100500, VPointer]);
  repeat
  until False;
end.
