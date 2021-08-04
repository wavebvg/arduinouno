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

  procedure WriteString(const AText: PChar);
  var
    VBuffer: Pbyte;
    VSize: Byte;
  begin
    VBuffer := Pbyte(AText);
    VSize := Length(AText);
    while VSize > 0 do
    begin
      while UCSR0A and (1 shl UDRE0) = 0 do
      ;
      UDR0 := VBuffer^;
      Inc(VBuffer);
      Dec(VSize);
    end;
  end;

begin
  UBRR0 := F_CPU div (16 * BaudRate) - 1;
  UCSR0A := 0;
  UCSR0B := (1 shl TXEN0) or (1 shl RXEN0);
  UCSR0C := (1 shl UCSZ0) or (1 shl 2);
  WriteString('Start');
  //UARTConsole.Init(BaudRate);
  //UARTConsole.WriteLnString('Start');
  VPByte := @VArray[1];
  VAddress := $1234;
  VPointer := @VAddress;
  UARTConsole.WriteLnString('Int test');
  UARTConsole.WriteLnFormat('Max low %d, low %d, zero %d, high %d, max high %d',
    [Low(Longint), -100, 0, 100, High(Longint)]);
  UARTConsole.WriteLnString('Str test');
  UARTConsole.WriteLnFormat('Empty "%s", short "%s", long "%s"', ['', 'test', 'very long test string for test']);
  UARTConsole.WriteLnString('Pointer test');
  UARTConsole.WriteLnFormat('Address $%x, hex %x (pointer $%x)', [VPByte, 100500, VPointer]);
  repeat
  until False;
end.
