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
    procedure WriteBuffer(ABuffer: PChar; ASize: Byte); virtual;
    procedure ReadBuffer(ABuffer: PChar; ASize: Byte); virtual;
    procedure WriteByte(const AValue: byte);
    procedure WriteChar(const AValue: Char);
    procedure WriteString(const AValue: String);
    procedure WriteFormat(const AFormat: String; const AArgs: array of const);
    procedure WriteLnString(const AValue: String);
    procedure WriteLnFormat(const AFormat: String; const AArgs: array of const);
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

procedure TUART.WriteBuffer(ABuffer: PChar; ASize: Byte);
begin
  while ASize > 0 do
  begin
    while UCSR0A and (1 shl UDRE0) = 0 do
      NopWait;
    UDR0 := Byte(ABuffer^);
    Inc(ABuffer);
    Dec(ASize);
  end;
end;

procedure TUART.ReadBuffer(ABuffer: PChar; ASize: Byte);
begin
  while ASize > 0 do
  begin
    while UCSR0A and (1 shl RXC0) = 0 do
    ;
    ABuffer^ := Char(UDR0);
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
type
  TFormatState = (fsFind);
  TFormatStates = set of TFormatState;
var
  s: TFormatStates;
  p, b, e, i: Byte;
  c: Char;
  VArg: TVarRec;
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
        VArg := AArgs[i];
        case c of
          '%':
          begin
            WriteChar('%');
          end;
          's':
          begin
            case VArg.VType of
              vtString:
                WriteString(VArg.VString^);
              vtAnsiString:
                WriteString(PChar(VArg.VAnsiString));
              vtPChar:
                WriteString(VArg.VPChar);
              vtChar:
                WriteChar(VArg.VChar);
              else
                WriteChar('?')
            end;
            Inc(i);
          end;
          'd':
          begin
            if VArg.VType = vtInteger then
              WriteString(IntToStr(VArg.VInteger))
            else if VArg.VType = vtInt64 then
              WriteString(IntToStr(VArg.VInt64^))
            else
              WriteChar('?');
            Inc(i);
          end;
          'x', 'p':
          begin
            if VArg.VType = vtInteger then
              WriteString(IntToHex(VArg.VInteger, 8))
            else
            if VArg.VType in [vtInteger, vtPointer] then
              WriteString(IntToHex(Word(VArg.VPointer), 4))
            else
              WriteChar('?');
            Inc(i);
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
  WriteBuffer(PChar(@AValue[1]), Length(AValue));
  WriteBuffer(#10#13, 2);
end;

procedure TUART.WriteLnFormat(const AFormat: String; const AArgs: array of const);
begin
  WriteFormat(AFormat, AArgs);
  WriteBuffer(#10#13, 2);
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
