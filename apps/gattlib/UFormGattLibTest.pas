unit UFormGattLibTest;

{$mode objfpc}{$H+}

interface

uses
  BluetoothLE,
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Messages,
  Types,
  LMessages, ExtCtrls, Menus, ActnList, ComCtrls;

const
  BLE_SCAN_TIMEOUT = 5;

type

  { TFormGattLibTest }

  TFormGattLibTest = class(TForm)
    ActionAppExit: TAction;
    ActionList: TActionList;
    ButtonRefreshDevices: TButton;
    ComboBoxAdapters: TComboBox;
    LabelAdapters: TLabel;
    ListBoxBLEEnvironment: TListBox;
    MainMenu: TMainMenu;
    MenuItemExit: TMenuItem;
    MenuItemFile: TMenuItem;
    PageControl: TPageControl;
    PanelDevice: TPanel;
    PanelBody: TPanel;
    TabSheetBLEScan: TTabSheet;
    TabSheetAdapterInfo: TTabSheet;
    TimerRSSIUpdate: TTimer;
    ToggleBoxScanActive: TToggleBox;
    procedure ActionAppExitExecute(Sender: TObject);
    procedure ButtonConnectClick(Sender: TObject);
    procedure ButtonDisconnectClick(Sender: TObject);
    procedure ButtonDiscoverClick(Sender: TObject);
    procedure ButtonOpenServiceClick(Sender: TObject);
    procedure ButtonScanClick(Sender: TObject);
    procedure ButtonSendClick(Sender: TObject);
    procedure ComboBoxAdaptersChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ListBoxBLEEnvironmentDblClick(Sender: TObject);
    procedure MenuItemExitClick(Sender: TObject);
    procedure TimerRSSIUpdateTimer(Sender: TObject);
    procedure ToggleBoxScanActiveChange(Sender: TObject);
  private
    FAdapter: TBLEAdapter;
    FConnection: TBLEConnection;
    FService: TBLEService;
    FPoint: TPoint;
    FAdapters: TStringDynArray;
    FBLEEnv: TStrings;
    //FService1: TBLEService;
    procedure AdapterScanComplete(Sender: TObject);
    procedure PrintData(const AData: IBLEAdvertisementData; const ARSSI: Integer);
    procedure AdapterDeviceDiscovered(Sender: TObject; const AMAC, AName: String; const AData: IBLEAdvertisementData);
    procedure ConnectionAfterDisconnect(Sender: TObject);
    function GetCurrentAdapter: Pansichar;
    procedure ServiceNotificationData(Sender: TObject; const AData: TByteDynArray);
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    //
    property CurrentAdapter: Pansichar read GetCurrentAdapter;
  end;

var
  FormGattLibTest: TFormGattLibTest;

implementation

uses
  Bluetooth,
  LCLIntf,
  HandledComponent;


  {$R *.lfm}

  { TFormGattLibTest }

constructor TFormGattLibTest.Create(TheOwner: TComponent);
var
  i: Integer;
begin
  inherited Create(TheOwner);
  FBLEEnv := TStringList.Create;

  FAdapter := TBLEAdapter.Create(Self);
  FAdapter.ScanTimeout := 60;
  FAdapter.OnDeviceDiscovered := @AdapterDeviceDiscovered;


  FAdapters := GetDevices;
  ComboBoxAdapters.Items.BeginUpdate;
  try
    ComboBoxAdapters.Items.Clear;
    ComboBoxAdapters.Items.Add('Default');
    for i := 0 to Length(FAdapters) - 1 do
      ComboBoxAdapters.Items.Add(FAdapters[i]);
  finally
    ComboBoxAdapters.Items.EndUpdate;
  end;
  FAdapter.Device := CurrentAdapter;
  FAdapter.OnScanComplete := @AdapterScanComplete;
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
  FBLEEnv.Free;
  inherited Destroy;
end;

procedure TFormGattLibTest.AdapterScanComplete(Sender: TObject);
begin
  ToggleBoxScanActive.Checked := False;
  TimerRSSIUpdate.Enabled := False;
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
  //Memo1.Clear;
  //FPoint := Memo1.CaretPos;
  //VData := 'T';
  //FService.Active := True;
  //FService.WriteData(VData[1], 1, True);
end;

procedure TFormGattLibTest.ComboBoxAdaptersChange(Sender: TObject);
begin
  if FAdapter.Device = CurrentAdapter then
    Exit;
  FAdapter.Close;
  FAdapter.Device := CurrentAdapter;
end;

procedure TFormGattLibTest.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  FAdapter.Active := False;
end;

procedure TFormGattLibTest.FormShow(Sender: TObject);
begin
  //FPoint := Memo1.CaretPos;
end;

procedure TFormGattLibTest.ListBoxBLEEnvironmentDblClick(Sender: TObject);
var
  VData: IBLEAdvertisementData;
  VMAC: String;
begin
  if ListBoxBLEEnvironment.ItemIndex >= 0 then
    if FAdapter.Active then
    begin
      VMAC := FBLEEnv[ListBoxBLEEnvironment.ItemIndex];
      VData := FAdapter.GetAdvertisementData(VMAC);
      WriteLn(VMAC);
      PrintData(VData, FAdapter.GetRSSI(VMAC));
    end;
end;

procedure TFormGattLibTest.PrintData(const AData: IBLEAdvertisementData; const ARSSI: Integer);
var
  i, j: Integer;
  VItem: IBLEAdvertisementItem;
begin
  if Assigned(AData) then
  begin
    WriteLn('ManufacturerId: $', IntToHex(AData.ManufacturerId, 4));
    Write('ManufacturerData:');
    for i := 0 to Length(AData.ManufacturerData) - 1 do
      Write(' ', IntToHex(AData.ManufacturerData[i], 2));
    WriteLn;
    for i := 0 to Length(AData.Data) - 1 do
    begin
      VItem := AData.Data[i];
      Write(VItem.UUID, ':');
      for j := 0 to Length(VItem.Data) - 1 do
        Write(' ', IntToHex(VItem.Data[j], 2));
    end;
  end;
  if ARSSI <> 0 then
    WriteLn('RSSI ', ARSSI);
end;

procedure TFormGattLibTest.MenuItemExitClick(Sender: TObject);
begin

end;

procedure TFormGattLibTest.TimerRSSIUpdateTimer(Sender: TObject);
var
  i: Integer;
  VRSSI: Integer;
  VFullName: String;
  VPos: Integer;
begin
  for i := FBLEEnv.Count - 1 downto 0 do
  begin
    VPos := Pos('>', ListBoxBLEEnvironment.Items[i]);
    if VPos > 0 then
    begin
      VFullName := ListBoxBLEEnvironment.Items[i];
      Delete(VFullName, 1, VPos + 1);
      VRSSI := FAdapter.GetRSSI(FBLEEnv[i]);
      if VRSSI <> 0 then
        ListBoxBLEEnvironment.Items[i] := Format('<%.2ddBm> ', [VRSSI]) + VFullName
      else
        ListBoxBLEEnvironment.Items[i] := Format('<  0dBm> ', [VRSSI]) + VFullName;
    end;
  end;
end;

procedure TFormGattLibTest.ToggleBoxScanActiveChange(Sender: TObject);
begin
  if FAdapter.ScanEnabled = ToggleBoxScanActive.Checked then
    Exit;
  if ToggleBoxScanActive.Checked then
  begin
    FBLEEnv.Clear;
    ListBoxBLEEnvironment.Clear;
    FAdapter.Active := True;
  end;
  TimerRSSIUpdate.Enabled := ToggleBoxScanActive.Checked;
  FAdapter.ScanEnabled := ToggleBoxScanActive.Checked;
end;

procedure TFormGattLibTest.AdapterDeviceDiscovered(Sender: TObject; const AMAC, AName: String; const AData: IBLEAdvertisementData);
var
  VFullName: String;
  VRSSI: SmallInt;
begin
  FBLEEnv.Add(AMAC);
  VFullName := AMAC;
  VRSSI := FAdapter.GetRSSI(AMAC);
  if VRSSI <> 0 then
    VFullName := Format('<%.2ddBm> ', [VRSSI]) + VFullName
  else
    VFullName := Format('<  0dBm> ', [VRSSI]) + VFullName;

  if AName <> '' then
    VFullName := VFullName + ' - ' + AName;
  ListBoxBLEEnvironment.AddItem(VFullName, nil);
  PrintData(AData, VRSSI);
end;

procedure TFormGattLibTest.ConnectionAfterDisconnect(Sender: TObject);
begin
  WriteLn('ConnectionAfterDisconnect');
  //Memo1.Append('Disconnected!');
  //FPoint := Memo1.CaretPos;
end;

function TFormGattLibTest.GetCurrentAdapter: Pansichar;
begin
  if ComboBoxAdapters.ItemIndex > 0 then
    Result := PAnsiChar(ComboBoxAdapters.Items[ComboBoxAdapters.ItemIndex])
  else
    Result := nil;
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
  //VText := Memo1.Lines[FPoint.Y];
  //for i := 0 to Length(AData) - 1 do
  //begin
  //  if AData[i] = 13 then
  //    Continue;
  //  if AData[i] = 10 then
  //  begin
  //    Memo1.Lines[FPoint.Y] := VText;
  //    Inc(FPoint.Y);
  //    VText := '';
  //  end
  //  else
  //  begin
  //    VText := VText + Char(AData[i]);
  //  end;
  //end;
  //Memo1.Lines[FPoint.Y] := VText;
end;

procedure TFormGattLibTest.ButtonConnectClick(Sender: TObject);
begin
  FConnection.Active := True;
end;

procedure TFormGattLibTest.ActionAppExitExecute(Sender: TObject);
begin
  Application.Terminate;
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
