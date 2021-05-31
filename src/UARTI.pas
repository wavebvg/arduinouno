unit UARTI;

{$mode ObjFPC}

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

implementation

type
  TUARTContext = packed record
    ReadBuffer: array[0..15] of Byte;
    ReadPos, ReadStart: Byte;
    ReadIsFull: Boolean;
    WriteBuffer: array[Byte] of Byte;
    WritePos, WriteStart: Byte;
    WriteIsFull: Boolean;
  end;

var
  UARTContext: TUARTContext;

{ TUARTI }

constructor TUARTI.Init(const ABaudRate: Word);
begin
  inherited;
  UCSR0B := UCSR0B or (1 shl RXCIE0);
  UARTContext.ReadPos := 0;
  UARTContext.ReadStart := 0;
end;

procedure TUARTI.WriteByte(const AValue: byte);
begin
  while UARTContext.WriteIsFull do
    asm
             NOP;
             NOP;
             NOP;
    end;
  UCSR0B := UCSR0B and not (1 shl UDRIE0);
  UARTContext.WriteBuffer[UARTContext.WritePos] := AValue;
  Inc(UARTContext.WritePos);
  UARTContext.WriteIsFull := UARTContext.WritePos = UARTContext.WriteStart;
  UCSR0B := UCSR0B or (1 shl UDRIE0);
end;

function TUARTI.ReadByte: byte;
begin
  if (UARTContext.ReadPos = UARTContext.ReadStart) and not UARTContext.ReadIsFull then
    Result := inherited ReadByte
  else
  begin
    UCSR0B := UCSR0B and not (1 shl RXCIE0);
    Result := UARTContext.ReadBuffer[UARTContext.ReadStart];
    Inc(UARTContext.ReadStart);
    UARTContext.ReadStart := UARTContext.ReadStart and $0F;
    UARTContext.ReadIsFull := False;
    UCSR0B := UCSR0B or (1 shl RXCIE0);
  end;
end;

procedure USART__RX_ISR; alias: 'USART__RX_ISR'; interrupt; public;
var
  Value: Byte;
begin
  Value := UDR0;
  if not UARTContext.ReadIsFull then
  begin
    UARTContext.ReadBuffer[UARTContext.ReadPos] := Value;
    Inc(UARTContext.ReadPos);
    UARTContext.ReadPos := UARTContext.ReadPos and $0F;
    UARTContext.ReadIsFull := UARTContext.ReadPos = UARTContext.ReadStart;
  end;
end;

procedure USART__UDRE_ISR; {alias: 'USART__UDRE_ISR'; interrupt; public;}
begin
  UDR0 := UARTContext.WriteBuffer[UARTContext.WriteStart];
  Inc(UARTContext.WriteStart);
  UARTContext.WriteIsFull := False;
  if UARTContext.WritePos = UARTContext.WriteStart then
    UCSR0B := UCSR0B and not (1 shl UDRIE0);
end;

end.
