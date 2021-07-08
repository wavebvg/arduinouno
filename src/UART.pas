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
    procedure NopWait; assembler;
  public
    constructor Init(const ABaudRate: Word);
    procedure WriteBuffer(ABuffer: Pbyte; ASize: Byte); virtual;
    procedure ReadBuffer(ABuffer: Pbyte; ASize: Byte); virtual;
    procedure WriteByte(const AValue: byte);
    procedure WriteChar(const AValue: Char);
    procedure WriteString(const AValue: String);
    procedure WriteFormat(const AFormat: String; const AArgs: array of const);
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

procedure TUART.WriteFormat(const AFormat: String; const AArgs: array of const);
var
  i, j, c, L: Integer;
  VDecim: String;
begin
  if high(AArgs) < 0 then
  begin
    WriteString(AFormat);
    exit;
  end;
  L := length(AFormat);
  if L = 0 then exit;
  i := 1;
  c := 0;
  while (i <= L) do
  begin
    j := i;
    while (i <= L) and (AFormat[i] <> '%') do Inc(i);
    case i - j of
      0: ;
      1: WriteChar(AFormat[j]);
      else
        WriteString(copy(AFormat, j, i - j));
    end;
    Inc(i);
    if i > L then break;
    if (Ord(AFormat[i]) in [Ord('0')..Ord('9')]) and (i < L) and (AFormat[i + 1] = ':') then
    begin
      c := Ord(AFormat[i]) - 48;
      Inc(i, 2);
      if i > L then break;
    end;
    if AFormat[i] = '%' then
      WriteChar('%')
    else
    if (AFormat[i] = '.') and (i + 2 <= L) and (c <= high(AArgs)) and (Ord(AFormat[i + 1]) in
      [Ord('1')..Ord('9')]) and (Ord(AFormat[i + 2]) in [Ord('d'), Ord('x'), Ord('p')]) and
      (AArgs[c].VType = vtInteger) then
    begin
      j := AArgs[c].VInteger;
      if AFormat[i + 2] = 'd' then
        VDecim := IntToStr(j)
      else
        VDecim := IntToHex(j, Ord(AFormat[i + 1]) - 49);
      for j := length(VDecim) to Ord(AFormat[i + 1]) - 49 do
        VDecim := '0' + VDecim;
      WriteString(VDecim);
      Inc(c);
      Inc(i, 2);
    end
    else
    if c <= high(AArgs) then
    begin
      with AArgs[c] do
        case AFormat[i] of
          's': case VType of
              vtString: WriteString(String(VString^));
              vtPChar: WriteString(String(VPChar));
              vtChar: WriteChar(VChar);
            end;
          'd': if VType = vtInteger then
              WriteString(IntToStr(VInteger));
          'x', 'p': if VType in [vtInteger, vtPointer] then
              WriteString(IntToHex(VInteger, 8))
        end;
      Inc(c);
    end;
    Inc(i);
  end;
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
