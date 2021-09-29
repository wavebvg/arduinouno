unit UART;

{$mode objfpc}{$H-}{$Z1}

interface

uses
  ArduinoTools;

type

  { TUART }

  TUART = object
  private
    FBLECompatibleCounter: Byte;
    FBLECompatibleTime: Byte;
  protected
    procedure DoBLECompatible;
    function GetReadBufferEmpty: Boolean; virtual;
  public
    constructor Init(const ABaudRate: Word);
    procedure WriteBuffer(ABuffer: PChar; ASize: Byte); virtual;
    procedure ReadBuffer(ABuffer: PChar; ASize: Byte); virtual;
    procedure WriteByte(const AValue: byte);
    procedure WriteChar(const AValue: Char);
    procedure WriteString(const AValue: String);
    procedure WriteFormat(const AFormat: String; const AArgs: array of const);
    procedure WriteLnString(const AValue: PChar);
    procedure WriteLnFormat(const AFormat: String; const AArgs: array of const);
    function ReadByte: byte;
    function ReadChar: Char;
    //
    property ReadBufferEmpty: Boolean read GetReadBufferEmpty;
    property BLECompatibleTime: Byte read FBLECompatibleTime write FBLECompatibleTime;
  end;

var
  UARTConsole: TUART;

implementation

const
  UCSZ01 = 2;
  URSEL0 = 7;

{ TUART }

procedure TUART.DoBLECompatible;
begin
  Inc(FBLECompatibleCounter);
  if FBLECompatibleCounter = 20 then
  begin
    FBLECompatibleCounter := 0;
    SleepMicroSecs(FBLECompatibleTime * 1000);
  end;
end;

function TUART.GetReadBufferEmpty: Boolean;
begin
  Result := True;
end;

constructor TUART.Init(const ABaudRate: Word);
begin
  UBRR0 := F_CPU div (16 * ABaudRate) - 1;
  UCSR0A := 0;
  UCSR0B := (1 shl TXEN0) or (1 shl RXEN0);
  UCSR0C := (1 shl URSEL0) or (1 shl UCSZ0) or (1 shl UCSZ01);
end;

procedure TUART.WriteBuffer(ABuffer: PChar; ASize: Byte);
begin
  while ASize > 0 do
  begin
    while UCSR0A and (1 shl UDRE0) = 0 do
    ;
    UDR0 := Byte(ABuffer^);
    Inc(ABuffer);
    Dec(ASize);
    if FBLECompatibleTime > 0 then
      DoBLECompatible;
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
            WriteBuffer('@#', 1);
          end;
          's':
          begin
            case VArg.VType of
              vtString:
                WriteBuffer(@VArg.VString^[1], Byte(VArg.VString^[0]));
              vtAnsiString:
                WriteBuffer(VArg.VPChar, StrLen(VArg.VPChar));
              vtPChar:
                WriteBuffer(VArg.VPChar, StrLen(VArg.VPChar));
              vtChar:
                WriteBuffer(@VArg.VChar, 1);
              else
                WriteBuffer('?', 1)
            end;
            Inc(i);
          end;
          'd':
          begin
            if VArg.VType = vtInteger then
              with IntToStr(VArg.VInteger) do
                WriteBuffer(@Str[1], Length)
            {else if VArg.VType = vtInt64 then
              WriteBuffer(IntToStr(VArg.VInt64^))}
            else
              WriteBuffer('?', 1);
            Inc(i);
          end;
          'x', 'p':
          begin
            if VArg.VType = vtInteger then
              with IntToHex(VArg.VInteger, 8) do
                WriteBuffer(@Str[1], Length)
            else
            if VArg.VType in [vtInteger, vtPointer] then
              with IntToHex(VArg.VPointer) do
                WriteBuffer(@Str[1], Length)
            else
              WriteBuffer('?', 1);
            Inc(i);
          end;
          else
          begin
            WriteBuffer('?', 1);
          end;
        end;
        b := p + 1;
        s := [];
      end
      else
      if c = '%' then
      begin
        if p > b then
          WriteBuffer(@AFormat[b], p - b);
        s := [fsFind];
      end;
      Inc(p);
    until p > e;
    if p > b then
      WriteBuffer(@AFormat[b], p - b);
  end
  else
    WriteBuffer(@AFormat[1], Length(AFormat));
end;

procedure TUART.WriteLnString(const AValue: PChar);
begin
  WriteBuffer(AValue, Length(AValue));
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
