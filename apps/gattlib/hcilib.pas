unit hcilib;

{$mode ObjFPC}{$H+}

interface

const
  HCILibName1 = './libbluetooth.so.3';
  HCILibName = 'libbluetooth.so.3';

type
  bdaddr_t = array[0..5] of Byte;

  hci_dev_stats = record
    err_rx: Cardinal;
    err_tx: Cardinal;
    cmd_tx: Cardinal;
    evt_rx: Cardinal;
    acl_tx: Cardinal;
    acl_rx: Cardinal;
    sco_tx: Cardinal;
    sco_rx: Cardinal;
    byte_rx: Cardinal;
    byte_tx: Cardinal;
  end;

  phci_dev_info = ^hci_dev_info;

  hci_dev_info = record
    dev_id: Word;
    Name: array[1..8] of Ansichar;
    bdaddr: bdaddr_t;
    flags: Cardinal;
    _type: Byte;
    features: array[1..8] of Byte;
    pkt_type: Cardinal;
    link_policy: Cardinal;
    link_mode: Cardinal;
    acl_mtu: Word;
    acl_pkts: Word;
    sco_mtu: Word;
    sco_pkts: Word;
    stat: hci_dev_stats;
  end;

  (* HCI device flags *)
  TCIDeviceFlag = (
    HCI_UP,
    HCI_INIT,
    HCI_RUNNING,
    HCI_PSCAN,
    HCI_ISCAN,
    HCI_AUTH,
    HCI_ENCRYPT,
    HCI_INQUIRY,
    HCI_RAW
    );

  hci_each_dev_cb = function(dd: Integer; dev_id: Integer; arg: Pointer): LongBool; cdecl;
  hci_for_each_dev_func = function(flag: Integer; func: hci_each_dev_cb; arg: Pointer): Integer; cdecl;
  hci_read_local_name_func = function(dd: Integer; len: Integer; Name: Pansichar; _to: Integer): Integer; cdecl;
  hci_devid_func = function(const str: Pansichar): Integer; cdecl;
  hci_devinfo_func = function(dev_id: Integer; di: phci_dev_info): Integer; cdecl;

function LoadLibrary: Boolean;
procedure UnloadLibrary;
function LibraryLoaded: Boolean;

var
  hci_for_each_dev: hci_for_each_dev_func;
  hci_read_local_name: hci_read_local_name_func;
  hci_devid: hci_devid_func;
  hci_devinfo: hci_devinfo_func;

implementation

var
  LibHCILibHandle: TLibHandle;

function IsAssigned(const AArgs: array of const): Boolean;
var
  i: Integer;
begin
  i := Length(AArgs) - 1;
  while (i >= 0) and (AArgs[i].VPointer <> nil) do
    Dec(i);
  Result := i = -1;
end;

function LibraryLoaded: Boolean;
begin
  Result := LibHCILibHandle <> 0;
end;

function LoadLibrary: Boolean;
begin
  if LibraryLoaded then
    Result := True
  else
  begin
    Result := False;
    LibHCILibHandle := System.LoadLibrary(HCILibName);
    if not LibraryLoaded then
    begin
      WriteLn(GetLoadErrorStr);
      LibHCILibHandle := System.LoadLibrary(HCILibName1);
    end;
    if not LibraryLoaded then
    begin
      WriteLn(GetLoadErrorStr);
      Exit;
    end;
    if not LibraryLoaded then
      Exit;
    Pointer(hci_for_each_dev) := GetProcAddress(LibHCILibHandle, 'hci_for_each_dev');
    Pointer(hci_read_local_name) := GetProcAddress(LibHCILibHandle, 'hci_read_local_name');
    Pointer(hci_devid) := GetProcAddress(LibHCILibHandle, 'hci_devid');
    Pointer(hci_devinfo) := GetProcAddress(LibHCILibHandle, 'hci_devinfo');
    Result := IsAssigned([hci_for_each_dev, hci_read_local_name, hci_devid, hci_devinfo]);
  end;
end;

procedure UnloadLibrary;
begin
  hci_for_each_dev := nil;
  hci_read_local_name := nil;
  hci_devid := nil;
  hci_devinfo := nil;
  System.UnloadLibrary(LibHCILibHandle);
end;

end.
