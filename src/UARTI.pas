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
    procedure WriteBuffer(AData: Pbyte; ASize: Byte); virtual;
    procedure ReadBuffer(ABuffer: Pbyte; ASize: Byte); virtual;
  end;

var
  UARTConsole: TUARTI;

implementation

type
  TUARTFlag = (uartfReadFull, uartfReadNotEmpty, uartfWriteFull, uartfWriteNotEmpty);

  TUARTFlags = set of TUARTFlag;

  TUARTContext = packed record
    WriteBuffer: array[Byte] of Byte;
    ReadBuffer: array[0..15] of Byte;
    ReadPos, ReadStart: Byte;
    WritePos, WriteStart: Byte;
    Flags: TUARTFlags;
  end;

var
  UARTContext: TUARTContext;

{ TUARTI }

constructor TUARTI.Init(const ABaudRate: Word);
begin
  inherited Init(ABaudRate);
  UARTContext := Default(TUARTContext);
  UCSR0B := UCSR0B or (1 shl RXCIE0);
end;

procedure TUARTI.WriteBuffer(AData: Pbyte; ASize: Byte);
begin
  while ASize > 0 do
  begin
    while uartfWriteFull in UARTContext.Flags do
      NopWait;
    UCSR0B := UCSR0B and not (1 shl UDRIE0);
    while not (uartfWriteFull in UARTContext.Flags) and (ASize > 0) do
    begin
      UARTContext.WriteBuffer[UARTContext.WritePos] := AData^;
      Inc(UARTContext.WritePos);
      UARTContext.Flags := UARTContext.Flags + [uartfWriteNotEmpty];
      if UARTContext.WritePos = UARTContext.WriteStart then
        UARTContext.Flags := UARTContext.Flags + [uartfWriteFull];
      //
      Inc(AData);
      Dec(ASize);
    end;
    if uartfWriteNotEmpty in UARTContext.Flags then
      UCSR0B := UCSR0B or (1 shl UDRIE0);
  end;
end;

function TUARTI.GetReadBufferEmpty: Boolean;
begin
  Result := not (uartfReadNotEmpty in UARTContext.Flags);
end;

procedure TUARTI.ReadBuffer(ABuffer: Pbyte; ASize: Byte);
begin
  if ASize = 0 then
    Exit;
  UCSR0B := UCSR0B and not (Byte(1) shl RXCIE0);
  while (uartfReadNotEmpty in UARTContext.Flags) and (ASize > 0) do
  begin
    ABuffer^ := UARTContext.ReadBuffer[UARTContext.ReadStart];
    Inc(UARTContext.ReadStart);
    UARTContext.ReadStart := UARTContext.ReadStart and $0F;
    UARTContext.Flags := UARTContext.Flags - [uartfReadFull];
    if UARTContext.ReadPos = UARTContext.ReadStart then
      UARTContext.Flags := UARTContext.Flags - [uartfReadNotEmpty];
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
  Value: Byte;
begin
  Value := UDR0;
  UARTContext.ReadBuffer[UARTContext.ReadPos] := Value;
  Inc(UARTContext.ReadPos);
  UARTContext.ReadPos := UARTContext.ReadPos and $0F;
  UARTContext.Flags := UARTContext.Flags + [uartfReadNotEmpty];
  if UARTContext.ReadPos = UARTContext.ReadStart then
  begin
    UCSR0B := UCSR0B and not (Byte(1) shl RXCIE0);
    UARTContext.Flags := UARTContext.Flags + [uartfReadFull];
  end;
end;

procedure USART__UDRE_ISR; public Name 'USART__UDRE_ISR'; interrupt;
begin
  UDR0 := UARTContext.WriteBuffer[UARTContext.WriteStart];
  Inc(UARTContext.WriteStart);
  UARTContext.Flags := UARTContext.Flags - [uartfWriteFull];
  if UARTContext.WritePos = UARTContext.WriteStart then
  begin
    UCSR0B := UCSR0B and not (1 shl UDRIE0);
    UARTContext.Flags := UARTContext.Flags - [uartfWriteNotEmpty];
  end;
end;

end.
