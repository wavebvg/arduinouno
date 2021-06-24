unit UFormTerminal;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  LazSerial,
  Forms,
  Controls,
  Graphics,
  Dialogs,
  StdCtrls,
  ExtCtrls,
  LMessages,
  ActnList, UTF8Process,
  IniFiles,
  LazSynaSer;

const
  MAX_READ_TIMEOUT = 2;
  MAX_WRITE_TIMEOUT = 2;
  TERMINAL_MESSAGE = WM_USER + 435;
  TM_READTIMEOUT = TERMINAL_MESSAGE + 1;
  TM_WRITETIMEOUT = TERMINAL_MESSAGE + 2;

  MAX_KEY_PRESSED_DISLAY = 8;

type
  TPressedKeys = array[1..MAX_KEY_PRESSED_DISLAY] of Char;

  { TFormTerminal }

  TFormTerminal = class(TForm)
    ActionFlash: TAction;
    ActionClear: TAction;
    ActionConnect: TAction;
    ActionPreferences: TAction;
    ActionList: TActionList;
    ButtonClear: TButton;
    ButtonPreferences: TButton;
    ButtonPreferences1: TButton;
    EditLastKeys: TEdit;
    MemoTTY: TMemo;
    PanelBody: TPanel;
    PanelButton: TPanel;
    ProcessAVRDude: TProcessUTF8;
    Serial: TLazSerial;
    TimerTTYCheck: TTimer;
    ToggleBoxConnect: TToggleBox;
    procedure ActionClearExecute(Sender: TObject);
    procedure ActionConnectExecute(Sender: TObject);
    procedure ActionConnectUpdate(Sender: TObject);
    procedure ActionFlashExecute(Sender: TObject);
    procedure ActionFlashUpdate(Sender: TObject);
    procedure ActionPreferencesExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure MemoTTYKeyPress(Sender: TObject; var Key: Char);
    procedure SerialRxData(Sender: TObject);
    procedure SerialStatus(Sender: TObject; Reason: THookSerialReason; const Value: String);
    procedure TimerTTYCheckTimer(Sender: TObject);
    procedure ToggleBoxConnectChange(Sender: TObject);
  private
    function GetSerialCanRead: Boolean;
    procedure DisplayPressedKeys;
  private
    FAvrdudePath: String;
    FBinPath: String;
    FConfigPath: String;
    FDevice: String;
    FTermCursor: TPoint;
    FIniFile: TIniFile;
    FReadStart, FWriteStart: TDateTime;
    FTotalPressedKeys: Integer;
    FCurrentPressedKeysIndex: Integer;
    FPressedKeys: TPressedKeys;
    FTTYExist: Boolean;
    FShowTime: Boolean;
    FStartTime: TDateTime;
    FInShowTime: Boolean;
    FInFlashing: Boolean;
    procedure CheckTTYExist;
    procedure DisplayTerminal(const AText: String; const ANewLine: Boolean = False);
    procedure DisplayText(const AText: String);
    procedure DisplayConnected(const AValue: Boolean);
    procedure SetDevice(AValue: String);
    procedure LoadConfig;
    procedure SaveConfig;
  private
    procedure TMReadTimeout(var AMsg: TLMessage); message TM_READTIMEOUT;
    procedure TMWriteTimeout(var AMsg: TLMessage); message TM_WRITETIMEOUT;
  protected
    property SerialCanRead: Boolean read GetSerialCanRead;
    procedure TTYOpen;
    procedure TTYClose;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;

    property Device: String read FDevice write SetDevice;
    property ConfigPath: String read FConfigPath write FConfigPath;
    property BinPath: String read FBinPath write FBinPath;
    property AvrdudePath: String read FAvrdudePath write FAvrdudePath;
    property ShowTime: Boolean read FShowTime write FShowTime;
  end;

var
  FormTerminal: TFormTerminal;

implementation

uses
  UFormDialogPreferences,
  Clipbrd,
  LCLType,
  LCLIntf,
  DateUtils,
  process;

{$R *.lfm}

{ TFormTerminal }

constructor TFormTerminal.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  FIniFile := TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
  CheckTTYExist;
  LoadConfig;
end;

destructor TFormTerminal.Destroy;
begin
  FIniFile.Free;
  inherited Destroy;
end;

procedure TFormTerminal.ActionConnectExecute(Sender: TObject);
begin
  if ToggleBoxConnect.Checked xor Serial.Active then
    try
      if Serial.Active then
      begin
        DisplayTerminal(Serial.ReadData);
        TTYClose;
      end
      else
      begin
        FReadStart := 0;
        FWriteStart := 0;
        TTYOpen;
      end;
    except
      on E: Exception do
      begin
        Serial.Close;
        DisplayText(E.Message);
        ToggleBoxConnect.Checked := False;
      end;
    end;
end;

procedure TFormTerminal.ActionConnectUpdate(Sender: TObject);
begin
  TCustomAction(Sender).Enabled := not FInFlashing and FTTYExist;
  ToggleBoxConnect.Enabled := TCustomAction(Sender).Enabled;
end;

procedure TFormTerminal.ActionFlashExecute(Sender: TObject);
var
  VLastConnected: Boolean;
begin
  VLastConnected := Serial.Active;
  TTYClose;
  DisplayText('Begin flashing');
  FInFlashing := True;
  try         
    ActionConnect.Update;
    ActionFlash.Update;
    ProcessAVRDude.Parameters.Clear;
    ProcessAVRDude.Executable := AvrdudePath;
    ProcessAVRDude.Parameters.Add(Format('-C%s', [ConfigPath]));
    ProcessAVRDude.Parameters.Add('-q');
    ProcessAVRDude.Parameters.Add('-q');
    ProcessAVRDude.Parameters.Add('-patmega328p');
    ProcessAVRDude.Parameters.Add('-carduino');
    ProcessAVRDude.Parameters.Add('-b115200');
    ProcessAVRDude.Parameters.Add('-D');
    ProcessAVRDude.Parameters.Add(Format('-P%s', [Device]));
    ProcessAVRDude.Parameters.Add(Format('-Uflash:w:%s:i', [BinPath]));
    TTYOpen;
    Application.ProcessMessages;
    Sleep(300);
    Application.ProcessMessages;
    TTYClose;
    ProcessAVRDude.Execute;
    while not ProcessAVRDude.WaitOnExit(100) do
      Application.ProcessMessages;
    ActionConnect.Update;
    ProcessAVRDude.Active := False;
  finally
    FInFlashing := False;
  end;
  DisplayText('End  flashing');
  if VLastConnected then
    TTYOpen;
end;

procedure TFormTerminal.ActionFlashUpdate(Sender: TObject);
begin
  TCustomAction(Sender).Enabled := not FInFlashing and FTTYExist;
end;

procedure TFormTerminal.ActionClearExecute(Sender: TObject);
begin
  MemoTTY.Lines.Clear;
  FTermCursor := MemoTTY.CaretPos;
  FTotalPressedKeys := 0;
  FCurrentPressedKeysIndex := 0;
  DisplayPressedKeys;
end;

procedure TFormTerminal.ActionPreferencesExecute(Sender: TObject);
begin
  FormDialogPreferences.Device := Device;
  FormDialogPreferences.ConfigPath := ConfigPath;
  FormDialogPreferences.BinPath := BinPath;
  FormDialogPreferences.AvrdudePath := AvrdudePath;
  FormDialogPreferences.ShowTime := ShowTime;
  if FormDialogPreferences.ShowModal = mrOk then
  begin
    Device := FormDialogPreferences.Device;
    ConfigPath := FormDialogPreferences.ConfigPath;
    BinPath := FormDialogPreferences.BinPath;
    AvrdudePath := FormDialogPreferences.AvrdudePath;
    ShowTime := FormDialogPreferences.ShowTime;
    SaveConfig;
  end;
end;

procedure TFormTerminal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ProcessAVRDude.Active then
    CanClose := False
  else
  begin
    TTYClose;
    CanClose := True;
  end;
end;

procedure TFormTerminal.MemoTTYKeyPress(Sender: TObject; var Key: Char);
begin
  if FTotalPressedKeys < MAX_KEY_PRESSED_DISLAY then
    Inc(FTotalPressedKeys);
  if FCurrentPressedKeysIndex >= MAX_KEY_PRESSED_DISLAY then
    FCurrentPressedKeysIndex := 1
  else
    Inc(FCurrentPressedKeysIndex);
  FPressedKeys[FCurrentPressedKeysIndex] := Key;
  Serial.WriteData(Key);
  DisplayPressedKeys;
end;

procedure TFormTerminal.SerialRxData(Sender: TObject);
var
  VBuffer: String;
begin
  try
    if SerialCanRead then
    begin
      VBuffer := Serial.ReadData;
      DisplayTerminal(VBuffer);
    end;
  except
    on E: Exception do
      WriteLn(E.Message);
  end;
end;

procedure TFormTerminal.SerialStatus(Sender: TObject; Reason: THookSerialReason; const Value: String);
begin
  if (FReadStart > 0) and (SecondsBetween(Now, FReadStart) > MAX_READ_TIMEOUT) then
  begin
    PostMessage(Handle, TM_READTIMEOUT, 0, 0);
    FReadStart := 0;
    Exit;
  end;
  if (FWriteStart > 0) and (SecondsBetween(Now, FWriteStart) > MAX_WRITE_TIMEOUT) then
  begin
    PostMessage(Handle, TM_WRITETIMEOUT, 0, 0);
    FWriteStart := 0;
    Exit;
  end;
  case Reason of
    HR_SerialClose: ;
    HR_Connect: ;
    HR_CanRead:
      if FReadStart = 0 then
        FReadStart := Now;
    HR_CanWrite:
      if FWriteStart = 0 then
        FWriteStart := Now;
    HR_ReadCount:
      FReadStart := 0;
    HR_WriteCount:
      FWriteStart := 0;
    HR_Wait: ;
  end;
end;

procedure TFormTerminal.TimerTTYCheckTimer(Sender: TObject);
begin
  CheckTTYExist;
  ActionConnect.Update;
end;

procedure TFormTerminal.ToggleBoxConnectChange(Sender: TObject);
begin
  ActionConnect.Execute;
end;

function TFormTerminal.GetSerialCanRead: Boolean;
begin
  Result := Serial.Active and ToggleBoxConnect.Checked and not Application.Terminated;
end;

procedure TFormTerminal.DisplayPressedKeys;
var
  i, VIndex: Integer;
  VText: String;
  c: Char;
begin
  VText := '';
  for i := FTotalPressedKeys downto 1 do
  begin
    if FTotalPressedKeys < MAX_KEY_PRESSED_DISLAY then
      VIndex := i
    else
      VIndex := i + FCurrentPressedKeysIndex;
    if VIndex > MAX_KEY_PRESSED_DISLAY then
      VIndex := VIndex - MAX_KEY_PRESSED_DISLAY;
    c := FPressedKeys[VIndex];
    VText := VText + ' ' + c + ' (#' + IntToStr(Ord(c)) + ')';
  end;
  EditLastKeys.Text := Copy(VText, 2, Length(VText) - 1);
end;

procedure TFormTerminal.CheckTTYExist;
begin
  FTTYExist := FileExists(Device);
end;

procedure TFormTerminal.DisplayText(const AText: String);
begin
  DisplayTerminal(AText, True);
end;

procedure TFormTerminal.DisplayTerminal(const AText: String; const ANewLine: Boolean);

  procedure NewLine;
  begin
    Inc(FTermCursor.Y);
  end;

  procedure CarriageReturn;
  begin
    FTermCursor.X := 0;
  end;

  procedure AddChar(const c: Char);
  var
    VLine: String;
    VMS: Integer;
  begin
    if not FInShowTime and ShowTime and (FTermCursor.X = 0) and (FStartTime > 0) and SerialCanRead then
    begin
      VMS := MilliSecondsBetween(Now, FStartTime);
      FInShowTime := True;
      try
        DisplayTerminal(IntToStr(VMS) + ': ');
      finally
        FInShowTime := False;
      end;
    end;
    while MemoTTY.Lines.Count < FTermCursor.Y do
      MemoTTY.Lines.Add('');
    VLine := MemoTTY.Lines[FTermCursor.Y];
    while Length(VLine) < FTermCursor.X do
      VLine := VLine + ' ';
    if Length(VLine) = FTermCursor.X then
      VLine := VLine + c
    else
      VLine[FTermCursor.X + 1] := c;
    MemoTTY.Lines[FTermCursor.Y] := VLine;
    Inc(FTermCursor.X);
  end;

var
  i: Integer;
  c: Char;
begin
  if FInFlashing then
    Exit;
  MemoTTY.Lines.BeginUpdate;
  try
    if ANewLine and (FTermCursor.X > 0) then
    begin
      NewLine;
      CarriageReturn;
    end;
    WriteLn(Length(AText));
    for i := 1 to Length(AText) do
    begin
      c := AText[i];
      case c of
        #10:
          NewLine;
        #13:
          CarriageReturn;
        else
          AddChar(c);
      end;
    end;
    if ANewLine then
    begin
      NewLine;
      CarriageReturn;
    end;
    MemoTTY.CaretPos := Point(FTermCursor.X, FTermCursor.Y + 1);
    MemoTTY.Perform(LM_VSCROLL, SB_LINEDOWN, 0);
  finally
    MemoTTY.Lines.EndUpdate;
  end;
end;

procedure TFormTerminal.DisplayConnected(const AValue: Boolean);
begin
  if Application.Terminated then
    Exit;
  ToggleBoxConnect.Checked := AValue;
end;

procedure TFormTerminal.SetDevice(AValue: String);
var
  VSerialActive: Boolean;
begin
  if FDevice = AValue then Exit;
  FDevice := AValue;
  VSerialActive := Serial.Active;
  Serial.Close;
  Serial.Device := Device;
  Serial.Active := VSerialActive;
end;

procedure TFormTerminal.LoadConfig;
begin
  Device := FIniFile.ReadString('MAIN', 'device', '');
  ConfigPath := FIniFile.ReadString('MAIN', 'config_path', '');
  BinPath := FIniFile.ReadString('MAIN', 'bin_path', '');
  AvrdudePath := FIniFile.ReadString('MAIN', 'avrdude_path', '');
  ShowTime := FIniFile.ReadBool('MAIN', 'show_time', False);
end;

procedure TFormTerminal.SaveConfig;
begin
  FIniFile.WriteString('MAIN', 'device', Device);
  FIniFile.WriteString('MAIN', 'config_path', ConfigPath);
  FIniFile.WriteString('MAIN', 'bin_path', BinPath);
  FIniFile.WriteString('MAIN', 'avrdude_path', AvrdudePath);
  FIniFile.WriteBool('MAIN', 'show_time', ShowTime);
end;

procedure TFormTerminal.TMReadTimeout(var AMsg: TLMessage);
begin
  if ToggleBoxConnect.Checked then
  begin
    DisplayText('Read timeout');
    TTYClose;
  end;
end;

procedure TFormTerminal.TMWriteTimeout(var AMsg: TLMessage);
begin
  if ToggleBoxConnect.Checked then
  begin
    DisplayText('Write timeout');
    TTYClose;
  end;
end;

procedure TFormTerminal.TTYOpen;
begin
  if not Serial.Active then
  begin
    DisplayText('Connect');
    Serial.Open;
    if ShowTime then
      FStartTime := Now;
    ToggleBoxConnect.Checked := True;
  end;
end;

procedure TFormTerminal.TTYClose;
begin
  if Serial.Active then
  begin
    Serial.Close;
    ToggleBoxConnect.Checked := False;
    FStartTime := 0;
    DisplayText('Disconnected');
  end;
end;

end.
