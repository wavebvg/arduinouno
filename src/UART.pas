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
    procedure WriteFormat1(const AFormat: String; const AArgs: array of const);
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

procedure TUART.WriteFormat1(const AFormat: String; const AArgs: array of const);
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
              WriteString(IntToHex(VInteger, 4))
        end;
      Inc(c);
    end;
    Inc(i);
  end;
end;

procedure TUART.WriteFormat(const AFormat: String; const AArgs: array of const);
type
  TFormatState = (fsFind);
  TFormatStates = set of TFormatState;
var
  b, e, p, i: Byte;
  c: Char;
  s: TFormatStates;

begin
  if (Length(AFormat) > 1) and (Length(AArgs) > 0) then
  begin
    b := 1;
    e := Length(AFormat);
    p := 1;
    i := 0;
    s := [];
    repeat
      c := AFormat[p];
      if fsFind in s then
      begin
        with AArgs[i] do
          case c of
            '%':
              WriteChar('%');
            's':
            begin
              case VType of
                vtString:
                  WriteString(VString^);
                vtAnsiString:
                  WriteString(PChar(VAnsiString));
                vtPChar:
                  WriteString(VPChar);
                vtChar:
                  WriteChar(VChar);
                else
                  WriteChar('?')
              end;
            end;
            'd':
            begin
              if VType = vtInteger then
                WriteString(IntToStr(VInteger))
              else if VType = vtInt64 then
                WriteString(IntToStr(VInt64^))
              else
                WriteChar('?');
            end;
            'x', 'p':
            begin
              if VType in [vtInteger, vtPointer] then
                WriteString(IntToHex(VInteger, 4))
              else
                WriteChar('?');
            end;
            else
            begin
              WriteChar('?');
            end;
          end;
        b := p + 1;
        s := [];
      end
      else
      if c = '%' then
      begin
        if p > b then
          WriteString(Copy(AFormat, b, p - b));
        s := [fsFind];
      end;
      Inc(p);
    until p > e;
    if p > b then
      WriteString(Copy(AFormat, b, p - b));
  end
  else
    WriteString(AFormat);
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
