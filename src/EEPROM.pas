unit EEPROM;

{$Mode objfpc}{$H-}{$Z1}


interface

type

  { TEEPROM }

  TEEPROM = object
  public
    procedure WriteBuffer(AAddress: Word; AData: PChar; ASize: Byte);
    procedure ReadBuffer(AAddress: Word; ABuffer: PChar; ASize: Byte);
  end;

var
  ROM: TEEPROM;

implementation

uses
  ArduinoTools;

{ TEEPROM }

procedure TEEPROM.WriteBuffer(AAddress: Word; AData: PChar; ASize: Byte);
begin
  while ASize > 0 do
  begin
    while EECR and (1 shl EEPE) > 0 do
      NopWait;
    EEAR := AAddress;
    EEDR := Byte(AData^);
    EECR := EECR or (1 shl EEMPE);
    EECR := EECR or (1 shl EEPE);
    Inc(AData);
    Dec(ASize);
    Inc(AAddress);
  end;
end;

procedure TEEPROM.ReadBuffer(AAddress: Word; ABuffer: PChar; ASize: Byte);
begin
  while ASize > 0 do
  begin
    while EECR and (1 shl EEPE) > 0 do
      NopWait;    
    EEAR := AAddress;
    EECR := EECR or (1 shl EERE);
    ABuffer^ := Char(EEDR);
    Inc(ABuffer);
    Dec(ASize);  
    Inc(AAddress);
  end;
end;

end.
