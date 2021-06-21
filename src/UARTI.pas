unit UARTI;

{$mode objfpc}{$H-}{$Z1}

interface

uses
  UART;

type

  { TUARTI }

  TUARTI = object(TUART)
  private
  public
    constructor Init(const ABaudRate: Word);
    procedure WriteByte(const AValue: byte); virtual;
    function ReadByte: byte; virtual;
  end;

var
  UARTConsole: TUARTI;

implementation

type
  TUARTFullFlag = (uartffRead, uartffWrite);

  TUARTFullFlags = set of TUARTFullFlag;

  TUARTContext = packed record
    ReadBuffer: array[0..15] of Byte;
    ReadPos, ReadStart: Byte;
    FullFlags: TUARTFullFlags;
    WriteBuffer: array[Byte] of Byte;
    WritePos, WriteStart: Byte;
  end;

var
  UARTContext: TUARTContext;

{ TUARTI }

constructor TUARTI.Init(const ABaudRate: Word);
begin
  inherited Init(ABaudRate);
  UARTContext.ReadPos := 0;
  UARTContext.ReadStart := 0;
  UARTContext.WritePos := 0;
  UARTContext.WriteStart := 0;
  UARTContext.FullFlags := [];
  UCSR0B := UCSR0B or (1 shl RXCIE0);
end;

procedure TUARTI.WriteByte(const AValue: byte);
begin
  while uartffWrite in UARTContext.FullFlags do
    asm
             NOP;
             NOP;
             NOP;
    end;
  UCSR0B := UCSR0B and not (1 shl UDRIE0);
  UARTContext.WriteBuffer[UARTContext.WritePos] := AValue;
  Inc(UARTContext.WritePos);
  if UARTContext.WritePos = UARTContext.WriteStart then
    UARTContext.FullFlags := UARTContext.FullFlags + [uartffWrite];
  UCSR0B := UCSR0B or (1 shl UDRIE0);
end;

function TUARTI.ReadByte: byte;
begin
  UCSR0B := UCSR0B and not (Byte(1) shl RXCIE0);
  if (UARTContext.ReadPos = UARTContext.ReadStart) and not (uartffRead in UARTContext.FullFlags) then
    Result := inherited ReadByte
  else
  begin
    Result := UARTContext.ReadBuffer[UARTContext.ReadStart];
    Inc(UARTContext.ReadStart);
    UARTContext.ReadStart := UARTContext.ReadStart and $0F;
    UARTContext.FullFlags := UARTContext.FullFlags - [uartffRead];
  end;
  UCSR0B := UCSR0B or (1 shl RXCIE0);
end;

procedure USART__RX_ISR; public Name 'USART__RX_ISR'; interrupt;
var
  Value: Byte;
begin
  Value := UDR0;
  if not (uartffRead in UARTContext.FullFlags) then
  begin
    UARTContext.ReadBuffer[UARTContext.ReadPos] := Value;
    Inc(UARTContext.ReadPos);
    UARTContext.ReadPos := UARTContext.ReadPos and $0F;
    if UARTContext.ReadPos = UARTContext.ReadStart then
      UARTContext.FullFlags := UARTContext.FullFlags + [uartffRead];
  end;
end;

procedure USART__UDRE_ISR; public Name 'USART__UDRE_ISR'; interrupt;
begin
  UDR0 := UARTContext.WriteBuffer[UARTContext.WriteStart];
  Inc(UARTContext.WriteStart);
  UARTContext.FullFlags := UARTContext.FullFlags - [uartffWrite];
  if UARTContext.WritePos = UARTContext.WriteStart then
    UCSR0B := UCSR0B and not (1 shl UDRIE0);
end;

end.
