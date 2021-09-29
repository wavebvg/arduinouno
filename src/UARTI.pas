unit UARTI;

{$mode objfpc}{$H-}{$Z1}

interface

uses
  UART;

type

  { TUARTI }

  TUARTI = object(TUART)
  protected
    function GetReadBufferEmpty: Boolean; virtual;
  public
    constructor Init(const ABaudRate: Word);
    procedure WriteBuffer(AData: PChar; ASize: Byte); virtual;
    procedure ReadBuffer(ABuffer: PChar; ASize: Byte); virtual;
  end;

var
  UARTConsole: TUARTI;

type
  TUARTFlag = (uartfReadFull, uartfReadNotEmpty, uartfWriteFull, uartfWriteNotEmpty);

  TUARTFlags = set of TUARTFlag;

const
  WRITE_DATA_SIZE = 128;
  READ_DATA_SIZE = 128;

var
  WriteData: array[0..WRITE_DATA_SIZE - 1] of Char;
  ReadData: array[0..READ_DATA_SIZE - 1] of Char;
  ReadPos, ReadStart: Byte;
  WritePos, WriteStart: Byte;
  Flags: TUARTFlags;

implementation

uses
  ArduinoTools;

{ TUARTI }

constructor TUARTI.Init(const ABaudRate: Word);
begin
  inherited Init(ABaudRate);
  //
  FillChar(WriteData, SizeOf(WriteData), 0);
  FillByte(ReadData, SizeOf(ReadData), 0);
  ReadPos := 0;
  ReadStart := 0;
  WritePos := 0;
  WriteStart := 0;
  Flags := [];
  //
  UCSR0B := UCSR0B or (1 shl RXCIE0);
end;

procedure TUARTI.WriteBuffer(AData: PChar; ASize: Byte);
begin
  while ASize > 0 do
  begin
    while uartfWriteFull in Flags do
      NopWait;
    UCSR0B := UCSR0B and not (1 shl UDRIE0);
    while not (uartfWriteFull in Flags) and (ASize > 0) do
    begin
      WriteData[WritePos] := AData^;
      WritePos := (WritePos + 1) and (WRITE_DATA_SIZE - 1);
      Flags := Flags + [uartfWriteNotEmpty];
      if WritePos = WriteStart then
        Flags := Flags + [uartfWriteFull];
      //
      Inc(AData);
      Dec(ASize);
    end;
    if uartfWriteNotEmpty in Flags then
      UCSR0B := UCSR0B or (1 shl UDRIE0);
  end;
end;

function TUARTI.GetReadBufferEmpty: Boolean;
begin
  Result := not (uartfReadNotEmpty in Flags);
end;

procedure TUARTI.ReadBuffer(ABuffer: PChar; ASize: Byte);
begin
  if ASize = 0 then
    Exit;
  UCSR0B := UCSR0B and not (1 shl RXCIE0);
  while (uartfReadNotEmpty in Flags) and (ASize > 0) do
  begin
    ABuffer^ := ReadData[ReadStart];
    ReadStart := (ReadStart + 1) and (READ_DATA_SIZE - 1);
    Flags := Flags - [uartfReadFull];
    if ReadPos = ReadStart then
      Flags := Flags - [uartfReadNotEmpty];
    //
    Inc(ABuffer);
    Dec(ASize);
  end;
  if ASize > 0 then
    inherited ReadBuffer(ABuffer, ASize);
  UCSR0B := UCSR0B or (1 shl RXCIE0);
end;

procedure USART__RX_ISR; public Name 'USART__RX_ISR'; interrupt;
var
  Value: Char;
begin
  Value := Char(UDR0);
  ReadData[ReadPos] := Value;
  ReadPos := (ReadPos + 1) and (READ_DATA_SIZE - 1);
  Flags := Flags + [uartfReadNotEmpty];
  if ReadPos = ReadStart then
  begin
    UCSR0B := UCSR0B and not (1 shl RXCIE0);
    Flags := Flags + [uartfReadFull];
  end;
end;

procedure USART__UDRE_ISR; public Name 'USART__UDRE_ISR'; interrupt;
begin
  if FBLECompatibleTime > 0 then
    UARTConsole.DoBLEcompatible;
  Char(UDR0) := WriteData[WriteStart];
  WriteStart := (WriteStart + 1) and (WRITE_DATA_SIZE - 1);
  Flags := Flags - [uartfWriteFull];
  if WritePos = WriteStart then
  begin
    UCSR0B := UCSR0B and not (1 shl UDRIE0);
    Flags := Flags - [uartfWriteNotEmpty];
  end;
end;

end.
