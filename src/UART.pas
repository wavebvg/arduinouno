unit UART;

{$mode objfpc}

interface

uses
  ArduinoTools;

type

  { TUART }

  TUART = object
  private
  public
    constructor Init(const ABaudRate: Word);
    procedure WriteByte(const AValue: byte); virtual;
    procedure WriteChar(const AValue: Char);
    procedure WriteString(const AValue: String);
    procedure WriteLnString(const AValue: String);
    function ReadByte: byte; virtual;
    function ReadChar: Char;
  end; 

var
  UARTConsole: TUART;

implementation

const
  UCSZ00 = 1;
  UCSZ01 = 2;

{ TUART }

constructor TUART.Init(const ABaudRate: Word);
begin
  UBRR0 := F_CPU div (16 * ABaudRate) - 1;
  UCSR0A := 0;
  UCSR0B := (1 shl TXEN0) or (1 shl RXEN0);
  UCSR0C := (1 shl UCSZ00) or (1 shl UCSZ01);
end;

procedure TUART.WriteByte(const AValue: byte);
begin
  while UCSR0A and (1 shl UDRE0) = 0 do ;
  UDR0 := AValue;
end;

procedure TUART.WriteChar(const AValue: Char);
begin
  WriteByte(Byte(AValue));
end;

procedure TUART.WriteString(const AValue: String);
var
  i: SizeInt;
begin
  for i := 1 to Length(AValue) do
    WriteChar(AValue[i]);
end;

procedure TUART.WriteLnString(const AValue: String);
begin
  WriteString(AValue);
  WriteString(#10#13);
end;

function TUART.ReadByte: byte;
begin
  while UCSR0A and (1 shl RXC0) = 0 do ;
  Result := UDR0;                    // Read character
end;

function TUART.ReadChar: Char;
begin
  Result := Char(ReadByte);
end;

end.
