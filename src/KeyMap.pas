unit KeyMap;

{$mode objfpc}{$H-}{$Z1}

interface

const
  KeyA = $45;
  KeyB = $46;
  KeyC = $47;
  KeyD = $44;
  KeyUP = $40;
  KeyPLUS = $43;
  KeyLEFT = $07;
  KeyOK = $15;
  KeyRIGHT = $09;
  Key0 = $16;
  KeyDOWN = $19;
  KeyMINUS = $0d;
  Key1 = $0c;
  Key2 = $18;
  Key3 = $5e;
  Key4 = $08;
  Key5 = $1c;
  Key6 = $5A;
  Key7 = $42;
  Key8 = $52;
  Key9 = $4A;

function GetKeyName(const AKey: Byte): String;

implementation

type
  TKeyMap = packed record
    Name: String[5];
    Value: Byte;
  end;

const
  Keys: array[0..20] of TKeyMap = (
    (Name: 'A'; Value: KeyA),
    (Name: 'B'; Value: KeyB),
    (Name: 'C'; Value: KeyC),
    (Name: 'D'; Value: KeyD),
    (Name: 'up'; Value: KeyUP),
    (Name: '+'; Value: KeyPLUS),
    (Name: 'left'; Value: KeyLEFT),
    (Name: 'ok'; Value: KeyOK),
    (Name: 'right'; Value: KeyRIGHT),
    (Name: '0'; Value: Key0),
    (Name: 'down'; Value: KeyDOWN),
    (Name: '-'; Value: KeyMINUS),
    (Name: '1'; Value: Key1),
    (Name: '2'; Value: Key2),
    (Name: '3'; Value: Key3),
    (Name: '4'; Value: Key4),
    (Name: '5'; Value: Key5),
    (Name: '6'; Value: Key6),
    (Name: '7'; Value: Key7),
    (Name: '8'; Value: Key8),
    (Name: '9'; Value: Key9)
    );

function GetKeyName(const AKey: Byte): String;
var
  i: Byte;
begin
  for i := 0 to Length(Keys) - 1 do
    if Keys[i].Value = AKey then
    begin
      Result := Keys[i].Name;
      Exit;
    end;
  Result := '';
end;

end.
