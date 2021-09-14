unit UFormGattLibTest;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

const
  BLE_SCAN_TIMEOUT = 4;

type

  { TFormGattLibTest }

  TFormGattLibTest = class(TForm)
    ButtonScan: TButton;
    procedure ButtonScanClick(Sender: TObject);
  private

  public

  end;

var
  FormGattLibTest: TFormGattLibTest;

implementation

uses
  gattlib;

{$R *.lfm}

procedure ble_discovered_device(adapter: Pointer; const addr: PChar; const Name: PChar; user_data: Pointer); cdecl;
begin
  if Name <> nil then
    WriteLn(addr, ' - ', Name)
  else
    WriteLn(addr);
end;

{ TFormGattLibTest }

procedure TFormGattLibTest.ButtonScanClick(Sender: TObject);
var
  VRet: Integer;
  VAdapter: Pointer = nil;
begin
  if LoadLibrary then
  begin
    try
      VRet := gattlib_adapter_open(nil, @VAdapter);
      WriteLn('gattlib_adapter_open: ', VRet);
      VRet := gattlib_adapter_scan_enable(VAdapter, @ble_discovered_device, BLE_SCAN_TIMEOUT, nil);
      WriteLn('gattlib_adapter_scan_enable: ', VRet);
      WriteLn('Scan completed');
      VRet := gattlib_adapter_scan_disable(VAdapter);
      WriteLn('gattlib_adapter_scan_disable: ', VRet);
      VRet := gattlib_adapter_close(VAdapter);
      WriteLn('gattlib_adapter_close: ', VRet);
    finally
      UnloadLibrary;
    end;
  end;
end;

end.
