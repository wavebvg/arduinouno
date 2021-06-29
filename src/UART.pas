unit UART;

{$mode objfpc}{$H-}{$Z1}

interface

uses
  ArduinoTools;

type

  { TUART }

  TUART = object
  private
  protected
    function GetReadBufferEmpty: Boolean; virtual;
    procedure NopWait;
  public
    constructor Init(const ABaudRate: Word);
    procedure WriteBuffer(ABuffer: Pbyte; ASize: Byte); virtual;
    procedure ReadBuffer(ABuffer: Pbyte; ASize: Byte); virtual;
    procedure WriteByte(const AValue: byte);
    procedure WriteChar(const AValue: Char);
    procedure WriteString(const AValue: String);
    procedure WriteLnString(const AValue: String);
    function ReadByte: byte;
    function ReadChar: Char;
    //
    property ReadBufferEmpty: Boolean read GetReadBufferEmpty;
  end;

var
  UARTConsole: TUART;

implementation

const
  UCSZ01 = 2;

{ TUART }

function TUART.GetReadBufferEmpty: Boolean;
begin
  Result := True;
end;

procedure TUART.NopWait; assembler;
asm
         NOP
         NOP
         NOP
end;

constructor TUART.Init(const ABaudRate: Word);
begin
  UBRR0 := F_CPU div (16 * ABaudRate) - 1;
  UCSR0A := 0;
  UCSR0B := (1 shl TXEN0) or (1 shl RXEN0);
  UCSR0C := (1 shl UCSZ0) or (1 shl UCSZ01);
end;

procedure TUART.WriteBuffer(ABuffer: Pbyte; ASize: Byte);
begin
  while ASize > 0 do
  begin
    while UCSR0A and (1 shl UDRE0) = 0 do
      NopWait;
    UDR0 := ABuffer^;
    Inc(ABuffer);
    Dec(ASize);
  end;
end;

procedure TUART.ReadBuffer(ABuffer: Pbyte; ASize: Byte);
begin
  while ASize > 0 do
  begin
    while UCSR0A and (1 shl RXC0) = 0 do
      ;
    ABuffer^ := UDR0;
    Inc(ABuffer);
    Dec(ASize);
  end;
end;

procedure TUART.WriteByte(const AValue: byte);
begin
  WriteBuffer(@AValue, 1);
end;

procedure TUART.WriteChar(const AValue: Char);
begin
  WriteBuffer(@AValue, 1);
end;

procedure TUART.WriteString(const AValue: String);
begin
  WriteBuffer(@AValue[1], Length(AValue));
end;

procedure TUART.WriteLnString(const AValue: String);
begin
  WriteString(AValue);
  WriteString(#10#13);
end;

function TUART.ReadByte: byte;
begin
  ReadBuffer(@Result, 1);
end;

function TUART.ReadChar: Char;
begin
  Result := Char(ReadByte);
end;

end.
