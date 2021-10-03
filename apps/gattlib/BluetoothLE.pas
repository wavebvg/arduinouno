unit BluetoothLE;

{$mode ObjFPC}{$H+}{$Z1}

interface

uses
  HandledComponent,
  Classes,
  SysUtils,
  gattlib,
  Contnrs,
  Controls,
  LCLClasses,
  Types,
  LMessages,
  syncobjs;

const
  BLE_MESSAGE = LM_USER + 32;
  BLEM_DISCONNECTED = BLE_MESSAGE + 1;
  BLEM_NOTIFY = BLE_MESSAGE + 2;
  BLEM_INDICATE = BLE_MESSAGE + 3;
  BLEM_DISCOVERED_DEVICE = BLE_MESSAGE + 4;

type
  PBLEUUID = ^TBLEUUID;
  TBLEUUID = uuid_t;

  TBLEUUIDStr = array[1..MAX_LEN_UUID_STR + 1] of Char;

  TBLEResult = (blerSuccess, blerInvalidParameter, blerNotFound, blerOutOfMemory, blerNoSupported,
    blerDevice, blerDBus, blerBlueZ, blerInternal);

  { IBLEPrimaryService }

  IBLEPrimaryService = interface
    function GetAttrHandleEnd: Word;
    function GetAttrHandleStart: Word;
    function GetUUID: String;
    //
    property AttrHandleStart: Word read GetAttrHandleStart;
    property AttrHandleEnd: Word read GetAttrHandleEnd;
    property UUID: String read GetUUID;
  end;

  TBLEPrimaryServices = array of IBLEPrimaryService;

  TBLECharacteristicProperty = (blecpBroadcast, blecpRead, blecpWriteWithoutResp, blecpWrite,
    blecpNotify, blecpIndicate, blecpAuth, blecpExtProper);

  TBLECharacteristicProperties = set of TBLECharacteristicProperty;

  { IBLECharacteristic }

  IBLECharacteristic = interface
    function GetHandle: Word;
    function GetProperties: TBLECharacteristicProperties;
    function GetUUID: String;
    function GetValueHandle: Word;
    //
    property Handle: Word read GetHandle;
    property Properties: TBLECharacteristicProperties read GetProperties;
    property ValueHandle: Word read GetValueHandle;
    property UUID: String read GetUUID;
  end;

  TBLECharacteristics = array of IBLECharacteristic;

  { IBLEDescriptor }

  IBLEDescriptor = interface
    function GetHandle: Word;
    function GetUUID: String;
    function GetUUID16: Word;
    //
    property Handle: Word read GetHandle;
    property UUID16: Word read GetUUID16;
    property UUID: String read GetUUID;
  end;

  TBLEDescriptors = array of IBLEDescriptor;

  { IBLEAdvertisementData }

  IBLEAdvertisementItem = interface
    function GetData: TByteDynArray;
    function GetUUID: String;
    //
    property UUID: String read GetUUID;
    property Data: TByteDynArray read GetData;
  end;

  TBLEAdvertisementItems = array of IBLEAdvertisementItem;

  { IBLEAdvertisementData }

  IBLEAdvertisementData = interface
    function GetData: TBLEAdvertisementItems;
    function GetManufacturerData: TByteDynArray;
    function GetManufacturerId: Word;
    //                             
    property Data: TBLEAdvertisementItems read GetData;
    property ManufacturerId: Word read GetManufacturerId;
    property ManufacturerData: TByteDynArray read GetManufacturerData;
  end;

  TBLEDeviceDiscoveredEvent = procedure(Sender: TObject; const AMAC, AName: String;
    const AData: IBLEAdvertisementData) of object;

  TBLEConnection = class;

  { TBLEAdapter }

  TBLEAdapter = class(THandledComponent)
  private
    FDevice: String;
    FAdapterHandle: Pointer;
    FActiveConnections: TObjectList;
    FActiveConnectionsLock: TCriticalSection;
    FOnDeviceDiscovered: TBLEDeviceDiscoveredEvent;
    FScanEnabled: Boolean;
    FScanTimeout: Integer;
    function GetActive: Boolean;
    function GetActiveConnection(const AIndex: Integer): TBLEConnection;
    function GetActiveConnectionCount: Integer;
    function GetDeviceName: PChar;
    procedure SetActive(AValue: Boolean);
    procedure SetDevice(AValue: String);
    procedure DoDeviceDiscovered(const AMAC, AName: String; const AData: IBLEAdvertisementData);
    procedure SetScanEnabled(AValue: Boolean);
  protected
    property DeviceName: PChar read GetDeviceName;
    procedure RemoveActiveConnection(const AConnection: TBLEConnection);
    procedure AddActiveConnection(const AConnection: TBLEConnection);
    property ActiveConnectionCount: Integer read GetActiveConnectionCount;
    property ActiveConnections[const AIndex: Integer]: TBLEConnection read GetActiveConnection;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Open;
    procedure Close;
    function GetAdvertisementData(const AMAC: String): IBLEAdvertisementData;
    function GetRSSI(const AMAC: String): SmallInt;
  published
    property Device: String read FDevice write SetDevice;
    property Active: Boolean read GetActive write SetActive;
    property ScanEnabled: Boolean read FScanEnabled write SetScanEnabled;
    property ScanTimeout: Integer read FScanTimeout write FScanTimeout;
    property OnDeviceDiscovered: TBLEDeviceDiscoveredEvent read FOnDeviceDiscovered write FOnDeviceDiscovered;
  end;

  TBLEService = class;

  { TBLEConnection }

  TBLEConnection = class(THandledComponent)
  private
    FConnectionHandle: pgatt_connection_t;
    FOnAfterConnect: TNotifyEvent;
    FOnAfterDisconnect: TNotifyEvent;
    FOnBeforeConnect: TNotifyEvent;
    FOnBeforeDisconnect: TNotifyEvent;
    FAdapter: TBLEAdapter;
    FMAC: String;
    FActiveServices: TObjectList;
    function GetActive: Boolean;
    function GetAdvertisementData: IBLEAdvertisementData;
    function GetDiscoverCharacteristics: TBLECharacteristics;
    function GetDiscoverDescriptors: TBLEDescriptors;
    function GetDiscoverPrimary: TBLEPrimaryServices;
{$IFDEF IsResolve_75}
    function GetRSSI: SmallInt;
{$ENDIF}
    procedure SetActive(AValue: Boolean);
    procedure SetAdapter(AValue: TBLEAdapter);
    procedure SetDisconnected;
    procedure DoAfterConnect;
    procedure DoAfterDisconnect;
    procedure DoBeforeConnect;
    procedure DoBeforeDisconnect;
    function ServiceByUUID(const AUUID: PBLEUUID): TBLEService;
    procedure SetMAC(AValue: String);
    procedure DoInternalNotify(const AUUID: PBLEUUID; const AData: Pbyte; const ADataLength: Integer);
    procedure DoInternalIndicate(const AUUID: PBLEUUID; const AData: Pbyte; const ADataLength: Integer);
    procedure InternalDisconnect(const AForce: Boolean);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Connect;
    procedure Disconnect;
    property ConnectionHandle: pgatt_connection_t read FConnectionHandle;
    property DiscoverPrimary: TBLEPrimaryServices read GetDiscoverPrimary;
    property DiscoverCharacteristics: TBLECharacteristics read GetDiscoverCharacteristics;
    property DiscoverDescriptors: TBLEDescriptors read GetDiscoverDescriptors;
    property AdvertisementData: IBLEAdvertisementData read GetAdvertisementData;
{$IFDEF IsResolve_75}
    property RSSI: SmallInt read GetRSSI;
{$ENDIF}
  published
    property Adapter: TBLEAdapter read FAdapter write SetAdapter;
    property MAC: String read FMAC write SetMAC;
    property Active: Boolean read GetActive write SetActive;
    //
    property OnBeforeConnect: TNotifyEvent read FOnBeforeConnect write FOnBeforeConnect;
    property OnAfterConnect: TNotifyEvent read FOnAfterConnect write FOnAfterConnect;
    property OnBeforeDisconnect: TNotifyEvent read FOnBeforeDisconnect write FOnBeforeDisconnect;
    property OnAfterDisconnect: TNotifyEvent read FOnAfterDisconnect write FOnAfterDisconnect;
  end;

  TBLEServiceDataEvent = procedure(Sender: TObject; const AData: TByteDynArray) of object;

  { TBLEService }

  TBLEService = class(TComponent)
  private
    FConnection: TBLEConnection;
    FNotifications: Boolean;
    FOnIndicationData: TBLEServiceDataEvent;
    FOnNotificationData: TBLEServiceDataEvent;
    FUUIDData: uuid_t;
    FUUID: String;
    FActive: Boolean;
    function GetActive: Boolean;
    procedure SetActive(AValue: Boolean);
    procedure SetConnection(AValue: TBLEConnection);
    procedure SetNotifications(AValue: Boolean);
    procedure SetUUID(AValue: String);
    procedure DoNotificationData(const AData: TByteDynArray);
    procedure DoIndicationData(const AData: TByteDynArray);
    procedure InternalDeattach(const AForce: Boolean);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
  public
    destructor Destroy; override;
    procedure Attach;
    procedure Deattach;
    //
    procedure WriteData(const AData; ASize: Integer; const ANeedResponse: Boolean = False);
  published
    property Connection: TBLEConnection read FConnection write SetConnection;
    property UUID: String read FUUID write SetUUID;
    property Active: Boolean read GetActive write SetActive;
    property Notifications: Boolean read FNotifications write SetNotifications;
    //
    property OnNotificationData: TBLEServiceDataEvent read FOnNotificationData write FOnNotificationData;
    property OnIndicationData: TBLEServiceDataEvent read FOnIndicationData write FOnIndicationData;
  end;

  EBLE = class(Exception)
  end;

  EBLEClass = class of EBLE;

  EBLEInvalidParameter = class(EBLE)
  end;

  EBLENotFound = class(EBLE)
  end;

  EBLEOutOfMemory = class(EBLE)
  end;

  EBLENotSupported = class(EBLE)
  end;

  EBLEDevice = class(EBLE)
  end;

  EBLEDBus = class(EBLE)
  end;

  EBLEBlueZ = class(EBLE)
  end;

  EBLEInternal = class(EBLE)
  end;

  EBLEConnect = class(EBLE)
  end;

function UUIDToString(const AUUID: PBLEUUID): String;

function StringToUUID(const AUUID: String): TBLEUUID;

function CharacteristicPropertiesToString(const AValue: TBLECharacteristicProperties): String;

implementation

uses
  LCLIntf,
  gdk2;

const
  BLEErrorsClasses: array[TBLEResult] of EBLEClass = (
    {          blerSuccess } nil,
    { blerInvalidParameter } EBLEInvalidParameter,
    {         blerNotFound } EBLENotFound,
    {      blerOutOfMemory } EBLEOutOfMemory,
    {      blerNoSupported } EBLENotSupported,
    {           blerDevice } EBLEDevice,
    {             blerDBus } EBLEDBus,
    {            blerBlueZ } EBLEBlueZ,
    {         blerInternal } EBLEInternal
    );
  BLECharacteristicPropertyNames: array[TBLECharacteristicProperty] of String = (
    {        blecpBroadcast } 'Broadcast',
    {             blecpRead } 'Read',
    { blecpWriteWithoutResp } 'Write without resp',
    {            blecpWrite } 'Write',
    {           blecpNotify } 'Notify',
    {         blecpIndicate } 'Indicate',
    {             blecpAuth } 'Auth',
    {        blecpExtProper } 'Ext proper'
    );

type

  { TBLEPrimaryService }

  TBLEPrimaryService = class(TInterfacedObject, IBLEPrimaryService)
  private
    FData: gattlib_primary_service_t;
    function GetAttrHandleEnd: Word;
    function GetAttrHandleStart: Word;
    function GetUUID: String;
  public
    constructor Create(const ASrc: gattlib_primary_service_t);
    //
    property AttrHandleStart: Word read GetAttrHandleStart;
    property AttrHandleEnd: Word read GetAttrHandleEnd;
    property UUID: String read GetUUID;
  end;

  { TBLECharacteristic }

  TBLECharacteristic = class(TInterfacedObject, IBLECharacteristic)
  private
    FData: gattlib_characteristic_t;
    function GetHandle: Word;
    function GetProperties: TBLECharacteristicProperties;
    function GetUUID: String;
    function GetValueHandle: Word;
  public
    constructor Create(const ASrc: gattlib_characteristic_t);
    //
    property Handle: Word read GetHandle;
    property Properties: TBLECharacteristicProperties read GetProperties;
    property ValueHandle: Word read GetValueHandle;
    property UUID: String read GetUUID;
  end;

  { TBLEDescriptor }

  TBLEDescriptor = class(TInterfacedObject, IBLEDescriptor)
  private
    FData: gattlib_descriptor_t;
    function GetHandle: Word;
    function GetUUID: String;
    function GetUUID16: Word;
  public
    constructor Create(const ASrc: gattlib_descriptor_t);
    property Handle: Word read GetHandle;
    property UUID16: Word read GetUUID16;
    property UUID: String read GetUUID;
  end;

  { TBLEAdvertisementItem }

  TBLEAdvertisementItem = class(TInterfacedObject, IBLEAdvertisementItem)
  private
    FUUID: uuid_t;
    FData: TByteDynArray;
    function GetData: TByteDynArray;
    function GetUUID: String;
  public
    constructor Create(const ASrc: gattlib_advertisement_data_t);
    property UUID: String read GetUUID;
    property Data: TByteDynArray read GetData;
  end;

  { TBLEAdvertisementData }

  TBLEAdvertisementData = class(TInterfacedObject, IBLEAdvertisementData)
  private
    FData: TBLEAdvertisementItems;
    FManufacturerId: Word;
    FManufacturerData: TByteDynArray;
    function GetData: TBLEAdvertisementItems;
    function GetManufacturerData: TByteDynArray;
    function GetManufacturerId: Word;
  public
    constructor Create(const AData: pgattlib_advertisement_data_t; const ADataLength: Integer;
      const AManufacturerId: Word; const AManufacturerData: Pbyte; const AManufacturerDataLength: Integer);
    property Data: TBLEAdvertisementItems read GetData;
    property ManufacturerId: Word read GetManufacturerId;
    property ManufacturerData: TByteDynArray read GetManufacturerData;
  end;

procedure CheckLoadGattLib;
begin
  if not gattlib.LoadLibrary then
    raise EBLE.Create('Library gattlib not loaded!');
end;

procedure WriteThreadInfo(const AMsg: String);
begin
  WriteLn(AMsg, ' (current ', GetCurrentThreadId, ', main ', MainThreadID, ')');
end;

procedure CheckResult(const AResult: Integer; const AProcName: String);
var
  VExceptionClass: EBLEClass;
begin
  VExceptionClass := BLEErrorsClasses[TBLEResult(AResult)];
  if VExceptionClass <> nil then
    raise VExceptionClass.CreateFmt('Error: call %s', [AProcName]);
end;

function UUIDToString(const AUUID: PBLEUUID): String;
var
  VBuffer: TBLEUUIDStr;
begin
  CheckLoadGattLib;
  CheckResult(gattlib_uuid_to_string(AUUID, @VBuffer, Length(VBuffer)), 'gattlib_uuid_to_string');
  Result := StrPas(@VBuffer);
end;

function StringToUUID(const AUUID: String): TBLEUUID;
var
  VBuffer: TBLEUUIDStr;
begin
  VBuffer := AUUID;
  CheckLoadGattLib;
  CheckResult(gattlib_string_to_uuid(@VBuffer, Length(VBuffer) + 1, @Result), 'gattlib_string_to_uuid');
end;

function CharacteristicPropertiesToString(const AValue: TBLECharacteristicProperties): String;
var
  i: TBLECharacteristicProperty;
begin
  Result := '';
  for i := Low(TBLECharacteristicProperty) to High(TBLECharacteristicProperty) do
    if i in AValue then
    begin
      if Result <> '' then
        Result := Result + ', ';
      Result := Result + BLECharacteristicPropertyNames[i];
    end;
end;

procedure BLEAdapterDiscoveredDevice(adapter: Pointer; const addr: PChar; const Name: PChar;
  user_data: Pointer); cdecl;
var
  VAdapter: TBLEAdapter;
begin
  VAdapter := TBLEAdapter(user_data);
  VAdapter.DoDeviceDiscovered(StrPas(addr), StrPas(Name), nil);
end;

procedure BLEAdapterDiscoveredDeviceWithData(adapter: Pointer; const addr: PChar; const Name: PChar;
  advertisement_data: pgattlib_advertisement_data_t; advertisement_data_count: SizeUInt;
  manufacturer_id: Word; manufacturer_data: Pbyte; manufacturer_data_size: SizeUInt; user_data: Pointer); cdecl;
var
  VAdapter: TBLEAdapter;
  VDiscoveredDevice: IBLEAdvertisementData;
begin
  WriteThreadInfo('BLEAdapterDiscoveredDevice');
  VAdapter := TBLEAdapter(user_data);
  if (advertisement_data <> nil) or (manufacturer_data <> nil) or (manufacturer_id <> 0) then
    VDiscoveredDevice := TBLEAdvertisementData.Create(advertisement_data, advertisement_data_count,
      manufacturer_id, manufacturer_data, manufacturer_data_size)
  else
    VDiscoveredDevice := nil;
  VAdapter.DoDeviceDiscovered(StrPas(addr), StrPas(Name), VDiscoveredDevice);
end;

procedure BLEConnectionDiconnected(user_data: Pointer); cdecl;
var
  VConnection: TBLEConnection;
begin
  WriteThreadInfo('BLEConnectionDiconnected');
  VConnection := TBLEConnection(user_data);
  VConnection.InternalDisconnect(True);
  VConnection.SetDisconnected;
end;

procedure BLEConnectionNotification(const uuid: PBLEUUID; const Data: Pbyte; const data_length: SizeUInt;
  user_data: Pointer); cdecl;
var
  VConnection: TBLEConnection;
begin
  VConnection := TBLEConnection(user_data);
  VConnection.DoInternalNotify(uuid, Data, data_length);
end;

procedure BLEConnectionIndication(const uuid: PBLEUUID; const Data: Pbyte; const data_length: SizeUInt;
  user_data: Pointer); cdecl;
var
  VConnection: TBLEConnection;
begin
  VConnection := TBLEConnection(user_data);
  VConnection.DoInternalIndicate(uuid, Data, data_length);
end;

{ TBLEAdvertisementData }

function TBLEAdvertisementData.GetData: TBLEAdvertisementItems;
begin
  Result := FData;
end;

function TBLEAdvertisementData.GetManufacturerData: TByteDynArray;
begin
  Result := FManufacturerData;
end;

function TBLEAdvertisementData.GetManufacturerId: Word;
begin
  Result := FManufacturerId;
end;

constructor TBLEAdvertisementData.Create(const AData: pgattlib_advertisement_data_t;
  const ADataLength: Integer; const AManufacturerId: Word; const AManufacturerData: Pbyte;
  const AManufacturerDataLength: Integer);
var
  i: Integer;
begin
  SetLength(FData, ADataLength);
  for i := 0 to ADataLength - 1 do
    FData[i] := TBLEAdvertisementItem.Create(AData[i]);
  FManufacturerId := AManufacturerId;
  SetLength(FManufacturerData, AManufacturerDataLength);
  Move(AManufacturerData^, FManufacturerData[0], AManufacturerDataLength);
end;

{ TBLEAdvertisementItem }

constructor TBLEAdvertisementItem.Create(const ASrc: gattlib_advertisement_data_t);
begin
  SetLength(FData, ASrc.data_length);
  Move(ASrc.Data^, FData[0], ASrc.data_length);
  FUUID := ASrc.uuid;
end;

function TBLEAdvertisementItem.GetData: TByteDynArray;
begin
  Result := FData;
end;

function TBLEAdvertisementItem.GetUUID: String;
begin
  Result := UUIDToString(@FUUID);
end;

{ TBLEDescriptor }

constructor TBLEDescriptor.Create(const ASrc: gattlib_descriptor_t);
begin
  FData := ASrc;
end;

function TBLEDescriptor.GetHandle: Word;
begin
  Result := FData.handle;
end;

function TBLEDescriptor.GetUUID: String;
begin
  Result := UUIDToString(@FData.uuid);
end;

function TBLEDescriptor.GetUUID16: Word;
begin
  Result := FData.uuid16;
end;

{ TBLECharacteristic }

constructor TBLECharacteristic.Create(const ASrc: gattlib_characteristic_t);
begin
  FData := ASrc;
end;

function TBLECharacteristic.GetUUID: String;
begin
  Result := UUIDToString(@FData.uuid);
end;

function TBLECharacteristic.GetHandle: Word;
begin
  Result := FData.handle;
end;

function TBLECharacteristic.GetProperties: TBLECharacteristicProperties;
var
  VValue: Integer;
begin
  VValue := FData.properties;
  Result := TBLECharacteristicProperties(VValue);
end;

function TBLECharacteristic.GetValueHandle: Word;
begin
  Result := FData.value_handle;
end;

{ TBLEPrimaryService }

constructor TBLEPrimaryService.Create(const ASrc: gattlib_primary_service_t);
begin
  FData := ASrc;
end;

function TBLEPrimaryService.GetAttrHandleEnd: Word;
begin
  Result := FData.attr_handle_end;
end;

function TBLEPrimaryService.GetAttrHandleStart: Word;
begin
  Result := FData.attr_handle_start;
end;

function TBLEPrimaryService.GetUUID: String;
begin
  Result := UUIDToString(@FData.uuid);
end;

{ TBLEAdapter }

function TBLEAdapter.GetActive: Boolean;
begin
  Result := FAdapterHandle <> nil;
end;

function TBLEAdapter.GetActiveConnection(const AIndex: Integer): TBLEConnection;
begin
  FActiveConnectionsLock.Enter;
  try
    Result := TBLEConnection(FActiveConnections[AIndex]);
  finally
    FActiveConnectionsLock.Leave;
  end;
end;

function TBLEAdapter.GetActiveConnectionCount: Integer;
begin
  FActiveConnectionsLock.Enter;
  try
    Result := FActiveConnections.Count;
  finally
    FActiveConnectionsLock.Leave;
  end;
end;

function TBLEAdapter.GetDeviceName: PChar;
begin
  if Device = '' then
    Result := nil
  else
    Result := PChar(Device);
end;

procedure TBLEAdapter.SetActive(AValue: Boolean);
begin
  if Active xor AValue then
    if AValue then
      Open
    else
      Close;
end;

procedure TBLEAdapter.SetDevice(AValue: String);
begin
  if FDevice = AValue then Exit;
  if Active then
    raise EBLE.Create('Adapter already active');
  FDevice := AValue;
end;

procedure TBLEAdapter.DoDeviceDiscovered(const AMAC, AName: String; const AData: IBLEAdvertisementData);
begin
  if Assigned(FOnDeviceDiscovered) then
    FOnDeviceDiscovered(Self, AMAC, AName, AData);
end;

procedure TBLEAdapter.SetScanEnabled(AValue: Boolean);
begin
  if FScanEnabled = AValue then
    Exit;
  FScanEnabled := AValue;
  CheckLoadGattLib;
  if ScanEnabled then
  begin
    Active := True;
    CheckResult(gattlib_adapter_scan_enable(FAdapterHandle, @BLEAdapterDiscoveredDevice, ScanTimeout, Self),
      'gattlib_adapter_scan_enable');
  end
  else
    CheckResult(gattlib_adapter_scan_disable(FAdapterHandle), 'gattlib_adapter_scan_disable');
end;

procedure TBLEAdapter.AddActiveConnection(const AConnection: TBLEConnection);
begin
  FActiveConnectionsLock.Enter;
  try
    FActiveConnections.Add(AConnection);
  finally
    FActiveConnectionsLock.Leave;
  end;
end;

procedure TBLEAdapter.RemoveActiveConnection(const AConnection: TBLEConnection);
begin
  FActiveConnectionsLock.Enter;
  try
    FActiveConnections.Remove(AConnection);
  finally
    FActiveConnectionsLock.Leave;
  end;
end;

constructor TBLEAdapter.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  HandleNeeded;
  FActiveConnectionsLock := TCriticalSection.Create;
  FActiveConnections := TObjectList.Create(False);
end;

destructor TBLEAdapter.Destroy;
begin
  Close;
  FActiveConnections.Free;
  FActiveConnectionsLock.Free;
  inherited Destroy;
end;

procedure TBLEAdapter.Open;
begin
  if Active then
    Close;
  CheckLoadGattLib;
  CheckResult(gattlib_adapter_open(DeviceName, @FAdapterHandle), 'open adapter');
end;

procedure TBLEAdapter.Close;
begin
  if Active then
  begin
    while ActiveConnectionCount > 0 do
      ActiveConnections[0].Disconnect;
    CheckLoadGattLib;
    CheckResult(gattlib_adapter_close(FAdapterHandle), 'close adapter');
    FAdapterHandle := nil;
  end;
end;

function TBLEAdapter.GetAdvertisementData(const AMAC: String): IBLEAdvertisementData;
var
  advertisement_data: pgattlib_advertisement_data_t = nil;
  advertisement_data_count: SizeUInt = 0;
  manufacturer_id: Word = 0;
  manufacturer_data: Pbyte = nil;
  manufacturer_data_size: SizeUInt = 0;
begin
  Active := True;
  CheckLoadGattLib;
  CheckResult(gattlib_get_advertisement_data_from_mac(FAdapterHandle, Pansichar(AMAC),
    @advertisement_data, @advertisement_data_count, @manufacturer_id, @manufacturer_data, @manufacturer_data_size),
    'close gattlib_get_advertisement_data_from_mac_func');
  Result := TBLEAdvertisementData.Create(advertisement_data, advertisement_data_count,
    manufacturer_id, manufacturer_data, manufacturer_data_size);
end;

function TBLEAdapter.GetRSSI(const AMAC: String): SmallInt;
begin
  CheckLoadGattLib;
  CheckResult(gattlib_get_rssi_from_mac(FAdapterHandle, Pansichar(AMAC), @Result), 'gattlib_get_rssi_from_mac');
end;

{ TBLEConnection }

function TBLEConnection.GetActive: Boolean;
begin
  Result := FConnectionHandle <> nil;
end;

procedure TBLEConnection.SetActive(AValue: Boolean);
begin
  if Active xor AValue then
    if AValue then
      Connect
    else
      Disconnect;
end;

procedure TBLEConnection.SetAdapter(AValue: TBLEAdapter);
begin
  if FAdapter = AValue then Exit;
  if Active then
    raise EBLE.Create('Connection already active');
  FAdapter := AValue;
end;

procedure TBLEConnection.DoAfterConnect;
begin
  if Assigned(FOnAfterConnect) then
    FOnAfterConnect(Self);
end;

procedure TBLEConnection.DoAfterDisconnect;
begin
  if Assigned(FOnAfterDisconnect) then
    FOnAfterDisconnect(Self);
end;

procedure TBLEConnection.DoBeforeConnect;
begin
  if Assigned(FOnBeforeConnect) then
    FOnBeforeConnect(Self);
end;

procedure TBLEConnection.DoBeforeDisconnect;
begin
  if Assigned(FOnBeforeDisconnect) then
    FOnBeforeDisconnect(Self);
end;

function TBLEConnection.ServiceByUUID(const AUUID: PBLEUUID): TBLEService;
var
  i: Integer;
begin
  CheckLoadGattLib;
  for i := 0 to FActiveServices.Count - 1 do
  begin
    Result := TBLEService(FActiveServices[i]);
    if gattlib_uuid_cmp(AUUID, @Result.FUUIDData) = 0 then
      Exit;
  end;
  Result := nil;
end;

procedure TBLEConnection.SetMAC(AValue: String);
begin
  if FMAC = AValue then Exit;
  if Active then
    raise EBLE.Create('Connection already active');
  FMAC := AValue;
end;

procedure TBLEConnection.DoInternalNotify(const AUUID: PBLEUUID; const AData: Pbyte; const ADataLength: Integer);
var
  VService: TBLEService;
  VData: TByteDynArray;
begin
  VData := nil;
  VService := ServiceByUUID(AUUID);
  if Assigned(VService) then
  begin
    SetLength(VData, ADataLength);
    Move(AData[0], VData[0], ADataLength);
    gdk_threads_enter;
    try
      VService.DoNotificationData(VData);
    finally
      gdk_threads_leave;
    end;
  end;
end;

procedure TBLEConnection.DoInternalIndicate(const AUUID: PBLEUUID; const AData: Pbyte; const ADataLength: Integer);
var
  VService: TBLEService;
  VData: TByteDynArray;
begin
  VData := nil;
  VService := ServiceByUUID(AUUID);
  if Assigned(VService) then
  begin
    SetLength(VData, ADataLength);
    Move(AData[0], VData[0], ADataLength);
    gdk_threads_enter;
    try
      VService.DoIndicationData(VData);
    finally
      gdk_threads_leave;
    end;
  end;
end;

procedure TBLEConnection.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
    if AComponent = Adapter then
      Adapter := nil;
end;

constructor TBLEConnection.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  HandleNeeded;
  FActiveServices := TObjectList.Create(False);
end;

destructor TBLEConnection.Destroy;
begin
  Disconnect;
  FActiveServices.Free;
  inherited Destroy;
end;

procedure TBLEConnection.Connect;
begin
  CheckLoadGattLib;
  if Active then
    Disconnect;
  DoBeforeConnect;
  Adapter.Active := True;
  try
    FConnectionHandle := gattlib_connect(Adapter.FAdapterHandle, Pansichar(MAC),
      GATTLIB_CONNECTION_OPTIONS_LEGACY_DEFAULT);
  except
    FConnectionHandle := nil;
  end;
  if FConnectionHandle = nil then
    raise EBLEConnect.CreateFmt('Can''t connect to "%s"', [MAC])
  else
  begin
    gattlib_register_on_disconnect(FConnectionHandle, @BLEConnectionDiconnected, Self);
    gattlib_register_notification(FConnectionHandle, @BLEConnectionNotification, Self);
    gattlib_register_indication(FConnectionHandle, @BLEConnectionIndication, Self);
    Adapter.AddActiveConnection(Self);
    DoAfterConnect;
  end;
end;

procedure TBLEConnection.Disconnect;
begin
  if Active then
  begin
    DoBeforeDisconnect;
    InternalDisconnect(False);
    SetDisconnected;
  end;
end;

function TBLEConnection.GetDiscoverPrimary: TBLEPrimaryServices;
var
  VServices: pgattlib_primary_service_t;
  VCount: Integer;
  i: Integer;
begin
  Result := nil;
  Active := True;
  CheckResult(gattlib_discover_primary(FConnectionHandle, @VServices, @VCount), 'gattlib_discover_primary');
  try
    SetLength(Result, VCount);
    for i := 0 to VCount - 1 do
      Result[i] := TBLEPrimaryService.Create(VServices[i]);
  finally
    gattlib.Free(VServices);
  end;
end;

{$IFDEF IsResolve_75}
function TBLEConnection.GetRSSI: SmallInt;
begin
  CheckLoadGattLib;
  CheckResult(gattlib_get_rssi(FConnectionHandle, @Result), 'gattlib_get_rssi');
end;

{$ENDIF}

function TBLEConnection.GetDiscoverCharacteristics: TBLECharacteristics;
var
  VCharacteristics: pgattlib_characteristic_t;
  VCount: Integer;
  i: Integer;
begin
  Result := nil;
  Active := True;
  CheckResult(gattlib_discover_char(FConnectionHandle, @VCharacteristics, @VCount), 'gattlib_discover_char');
  try
    SetLength(Result, VCount);
    for i := 0 to VCount - 1 do
      Result[i] := TBLECharacteristic.Create(VCharacteristics[i]);
  finally
    gattlib.Free(VCharacteristics);
  end;
end;

function TBLEConnection.GetDiscoverDescriptors: TBLEDescriptors;
var
  VDescriptors: pgattlib_descriptor_t;
  VCount: Integer;
  i: Integer;
begin
  Result := nil;
  Active := True;
  CheckResult(gattlib_discover_desc(FConnectionHandle, @VDescriptors, @VCount), 'gattlib_discover_desc');
  try
    SetLength(Result, VCount);
    for i := 0 to VCount - 1 do
      Result[i] := TBLEDescriptor.Create(VDescriptors[i]);
  finally
    gattlib.Free(VDescriptors);
  end;
end;

function TBLEConnection.GetAdvertisementData: IBLEAdvertisementData;
var
  advertisement_data: pgattlib_advertisement_data_t;
  advertisement_data_count: SizeUInt;
  manufacturer_id: Word;
  manufacturer_data: Pbyte;
  manufacturer_data_size: SizeUInt;
begin
  Active := True;
  CheckLoadGattLib;
  CheckResult(gattlib_get_advertisement_data(FConnectionHandle, @advertisement_data,
    @advertisement_data_count, @manufacturer_id, @manufacturer_data, @manufacturer_data_size),
    'close gattlib_get_advertisement_data_from_mac_func');
  Result := TBLEAdvertisementData.Create(advertisement_data, advertisement_data_count,
    manufacturer_id, manufacturer_data, manufacturer_data_size);
end;

procedure TBLEConnection.InternalDisconnect(const AForce: Boolean);
begin
  WriteThreadInfo('InternalDisconnect');
  while FActiveServices.Count > 0 do
    TBLEService(FActiveServices[0]).InternalDeattach(AForce);
  gattlib_register_on_disconnect(FConnectionHandle, nil, nil);
  gattlib_register_notification(FConnectionHandle, nil, nil);
  gattlib_register_indication(FConnectionHandle, nil, nil);
  CheckResult(gattlib_disconnect(FConnectionHandle), 'gattlib_disconnect');
end;

procedure TBLEConnection.SetDisconnected;
begin
  WriteThreadInfo('SetDisconnected');
  Adapter.RemoveActiveConnection(Self);
  FConnectionHandle := nil;
  gdk_threads_enter;
  try
    DoAfterDisconnect;
  finally
    gdk_threads_leave;
  end;
end;

{ TBLEService }

function TBLEService.GetActive: Boolean;
begin
  Result := FActive;
end;

procedure TBLEService.SetActive(AValue: Boolean);
begin
  if Active xor AValue then
    if AValue then
      Attach
    else
      Deattach;
end;

procedure TBLEService.SetConnection(AValue: TBLEConnection);
begin
  if FConnection = AValue then Exit;
  if Active then
    raise EBLE.Create('Service already active');
  FConnection := AValue;
end;

procedure TBLEService.SetNotifications(AValue: Boolean);
begin
  if FNotifications = AValue then Exit;
  if Active then
    raise EBLE.Create('Service already active');
  FNotifications := AValue;
end;

procedure TBLEService.SetUUID(AValue: String);
begin
  if FUUID = AValue then Exit;
  if Active then
    raise EBLE.Create('Service already active');
  FUUID := AValue;
  CheckLoadGattLib;
  FUUIDData := StringToUUID(UUID);
end;

procedure TBLEService.DoNotificationData(const AData: TByteDynArray);
begin
  if Assigned(FOnNotificationData) then
    FOnNotificationData(Self, AData);
end;

procedure TBLEService.DoIndicationData(const AData: TByteDynArray);
begin
  if Assigned(FOnNotificationData) then
    FOnNotificationData(Self, AData);
end;

procedure TBLEService.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
    if AComponent = Connection then
      Connection := nil;
end;

destructor TBLEService.Destroy;
begin
  Deattach;
  inherited Destroy;
end;

procedure TBLEService.Attach;
begin
  if Active then
    Deattach;
  Connection.Active := True;
  if Notifications then
  begin
    try
      CheckResult(gattlib_notification_start(Connection.FConnectionHandle, @FUUIDData),
        'gattlib_notification_start');
    except
      raise;
    end;
  end;
  Connection.FActiveServices.Add(Self);
  FActive := True;
end;

procedure TBLEService.Deattach;
begin
  InternalDeattach(False);
end;

procedure TBLEService.InternalDeattach(const AForce: Boolean);
begin
  if Active then
  begin
    if Notifications and not AForce then
    begin
      CheckResult(gattlib_notification_stop(Connection.FConnectionHandle, @FUUIDData),
        'gattlib_notification_stop');
    end;
    Connection.FActiveServices.Remove(Self);
    FActive := False;
  end;
end;

procedure TBLEService.WriteData(const AData; ASize: Integer; const ANeedResponse: Boolean);
var
  VPacketSize: Integer;
  VData: Pbyte;
begin
  if ASize = 0 then
    Exit;
  Active := True;
  VData := @AData;
  repeat
    if ASize > 20 then
      VPacketSize := 20
    else
      VPacketSize := ASize;
    if ANeedResponse then
    begin
      CheckResult(gattlib_write_char_by_uuid(Connection.FConnectionHandle, @FUUIDData, VData, VPacketSize),
        'gattlib_write_char_by_uuid');
    end
    else
      CheckResult(gattlib_write_without_response_char_by_uuid(Connection.FConnectionHandle,
        @FUUIDData, VData, VPacketSize), 'gattlib_write_without_response_char_by_uuid');
    Dec(ASize, VPacketSize);
    Inc(VData, VPacketSize);
  until ASize = 0;
end;

end.
