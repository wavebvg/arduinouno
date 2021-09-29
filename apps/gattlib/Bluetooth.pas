unit Bluetooth;

{$mode ObjFPC}{$H+}

interface

uses
  Types;

function GetDevices: TStringDynArray;

implementation

uses
  hcilib,
  SysUtils;

type
  PDevicesArgs = ^TDevicesArgs;

  TDevicesArgs = record
    Data: TStringDynArray;
  end;

function HCIForEachDevEvent(dd: Integer; dev_id: Integer; arg: Pointer): LongBool; cdecl;
var
  VInfo: hci_dev_info;
  VLength: Integer;
begin
  try
    if hci_devinfo(dev_id, @VInfo) <> 0 then
      Exit;
    VLength := Length(PDevicesArgs(arg)^.Data);
    SetLength(PDevicesArgs(arg)^.Data, VLength + 1);
    PDevicesArgs(arg)^.Data[VLength] := StrPas(@VInfo.Name);
    Result := True;
  except
    Result := False;
  end;
end;

function GetDevices: TStringDynArray;
var
  VArg: TDevicesArgs;
begin
  hci_for_each_dev(Ord(HCI_UP), @HCIForEachDevEvent, @VArg);
  Result := VArg.Data;
end;

initialization
  LoadLibrary;

finalization
  UnloadLibrary;

end.
