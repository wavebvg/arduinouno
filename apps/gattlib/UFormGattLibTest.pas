unit UFormGattLibTest;

{$mode objfpc}{$H+}

interface

uses
  BluetoothLE,
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Messages,
  Types,
  LMessages;

const
  BLE_SCAN_TIMEOUT = 5;

type

  { TFormGattLibTest }

  TFormGattLibTest = class(TForm)
    ButtonConnect: TButton;
    ButtonDiscover: TButton;
    ButtonOpenService: TButton;
    ButtonSend: TButton;
    ButtonAdv: TButton;
    ButtonDisconnect: TButton;
    ButtonScan: TButton;
    Memo1: TMemo;
    procedure ButtonConnectClick(Sender: TObject);
    procedure ButtonDisconnectClick(Sender: TObject);
    procedure ButtonDiscoverClick(Sender: TObject);
    procedure ButtonOpenServiceClick(Sender: TObject);
    procedure ButtonScanClick(Sender: TObject);
    procedure ButtonSendClick(Sender: TObject);
    procedure ButtonAdvClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure Memo1DblClick(Sender: TObject);
  private
    FAdapter: TBLEAdapter;
    FConnection: TBLEConnection;
    FService: TBLEService;
    FPoint: TPoint;
    //FService1: TBLEService;
    procedure AdapterDeviceDiscovered(Sender: TObject; const AMAC, AName: String;
      const AData: IBLEAdvertisementData);
    procedure ConnectionAfterDisconnect(Sender: TObject);
    procedure ServiceNotificationData(Sender: TObject; const AData: TByteDynArray);
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  FormGattLibTest: TFormGattLibTest;

implementation

uses
  gattlib,
  LCLIntf,
  HandledComponent;


{$R *.lfm}

{ TFormGattLibTest }

constructor TFormGattLibTest.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  FAdapter := TBLEAdapter.Create(Self);
  FAdapter.ScanTimeout := BLE_SCAN_TIMEOUT;
  FAdapter.Device := '';
  FAdapter.OnDeviceDiscovered := @AdapterDeviceDiscovered;
  FConnection := TBLEConnection.Create(Self);
  FConnection.Adapter := FAdapter;
  FConnection.MAC := '50:51:A9:8E:22:EF';
  //FConnection.MAC := 'E4:15:F6:6F:F8:8E';
  FConnection.OnAfterDisconnect := @ConnectionAfterDisconnect;
  FService := TBLEService.Create(Self);
  FService.Connection := FConnection;
  FService.Notifications := True;
  FService.UUID := '0xffe1';
  FService.OnNotificationData := @ServiceNotificationData;
  //FService1 := TBLEService.Create(Self);
  //FService1.Connection := FConnection;
  //FService1.UUID := '0xdfb1';
end;

destructor TFormGattLibTest.Destroy;
begin
  inherited Destroy;
end;

procedure TFormGattLibTest.ButtonScanClick(Sender: TObject);
begin
  FAdapter.ScanEnabled := True;
  FAdapter.ScanEnabled := False;
end;

procedure TFormGattLibTest.ButtonSendClick(Sender: TObject);
var
  VData: String;
begin
  Memo1.Clear;
  FPoint := Memo1.CaretPos;
  VData := 'T';
  FService.Attach;
  FService.WriteData(VData[1], 1, True);
end;

procedure TFormGattLibTest.ButtonAdvClick(Sender: TObject);
var
  VData: IBLEAdvertisementData;
begin
  FAdapter.ScanEnabled := True;
  FAdapter.ScanEnabled := False;
  VData := FAdapter.GetAdvertisementData('CC:B1:1A:26:95:AD');
  WriteLn(VData.ManufacturerId);
  WriteLn(StrPas(@VData.ManufacturerData[0]));
  WriteLn(StrPas(@VData.Data[0]));
  WriteLn('RSSI ', FAdapter.GetRSSI('CC:B1:1A:26:95:AD'));
end;

procedure TFormGattLibTest.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  FAdapter.Active := False;
end;

procedure TFormGattLibTest.FormShow(Sender: TObject);
begin
  FPoint := Memo1.CaretPos;
end;

procedure TFormGattLibTest.Memo1Change(Sender: TObject);
begin

end;

procedure TFormGattLibTest.Memo1DblClick(Sender: TObject);
begin
  Memo1.Clear;
  FPoint := Memo1.CaretPos;
end;

procedure TFormGattLibTest.AdapterDeviceDiscovered(Sender: TObject; const AMAC, AName: String;
  const AData: IBLEAdvertisementData);
begin
  Write(AMAC);
  if AName <> '' then
    Write(' - ', AName);
  WriteLn;
end;

procedure TFormGattLibTest.ConnectionAfterDisconnect(Sender: TObject);
begin
  WriteLn('ConnectionAfterDisconnect');
  Memo1.Append('Disconnected!');
  FPoint := Memo1.CaretPos;
end;

procedure TFormGattLibTest.ServiceNotificationData(Sender: TObject; const AData: TByteDynArray);
var
  i: Integer;
  VText: String;
begin
  //VText := '';
  //for i := 0 to Length(AData) - 1 do
  //  VText := VText + Format(' %.2x', [AData[i]]);
  //Memo1.Append(VText);
  VText := Memo1.Lines[FPoint.Y];
  for i := 0 to Length(AData) - 1 do
  begin
    if AData[i] = 13 then
      Continue;
    if AData[i] = 10 then
    begin
      Memo1.Lines[FPoint.Y] := VText;
      Inc(FPoint.Y);
      VText := '';
    end
    else
    begin
      VText := VText + Char(AData[i]);
    end;
  end;
  Memo1.Lines[FPoint.Y] := VText;
end;

procedure TFormGattLibTest.ButtonConnectClick(Sender: TObject);
begin
  FConnection.Active := True;
end;

procedure TFormGattLibTest.ButtonDisconnectClick(Sender: TObject);
begin
  FConnection.Active := False;
end;

procedure TFormGattLibTest.ButtonDiscoverClick(Sender: TObject);
var
  VServices: TBLEPrimaryServices;
  VCharacteristics: TBLECharacteristics;
  //VDescriptors: TBLEDescriptors;
  i: Integer;
begin
  VServices := FConnection.DiscoverPrimary;
  for i := 0 to Length(VServices) - 1 do
    WriteLn(Format('service[%d] start_handle:%.2x end_handle:%.2x uuid:%s',
      [i, VServices[i].AttrHandleStart, VServices[i].AttrHandleEnd, VServices[i].UUID]));
  VCharacteristics := FConnection.DiscoverCharacteristics;
  for i := 0 to Length(VCharacteristics) - 1 do
    WriteLn(Format('characteristic[%d] properties: %s (%.2x) value_handle:%.4x uuid:%s',
      [i, CharacteristicPropertiesToString(VCharacteristics[i].Properties),
      Integer(VCharacteristics[i].Properties), VCharacteristics[i].ValueHandle, VCharacteristics[i].UUID]));
  //VDescriptors := FConnection.DiscoverDescriptors;
  //for i := 0 to Length(VDescriptors) - 1 do
  //  WriteLn(Format('descriptor[%d] handle:%.4x uuid16:%.4x uuid:%s',
  //    [i, VDescriptors[i].Handle, VDescriptors[i].UUID16, VDescriptors[i].UUID]));
end;

procedure TFormGattLibTest.ButtonOpenServiceClick(Sender: TObject);
begin
  FService.Active := True;
end;

end.
