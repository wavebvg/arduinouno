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
  ActnList,
  IniFiles;

const
  MAX_ERROR_COUNT = 10;

  WM_ADDLINE = WM_USER + 434;
  WM_DISPLAYCONNECTED = WM_ADDLINE + 1;
  WM_SERIAL = WM_ADDLINE + 2;

type

  { TFormTerminal }

  TFormTerminal = class(TForm)
    ActionClear: TAction;
    ActionConnect: TAction;
    ActionPreferences: TAction;
    ActionList: TActionList;
    ButtonClear: TButton;
    ButtonPreferences: TButton;
    EditLastKeys: TEdit;
    MemoTTY: TMemo;
    PanelBody: TPanel;
    PanelButton: TPanel;
    Serial: TLazSerial;
    ToggleBoxConnect: TToggleBox;
    procedure ActionClearExecute(Sender: TObject);
    procedure ActionConnectExecute(Sender: TObject);
    procedure ActionPreferencesExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure SerialRxData(Sender: TObject);
    procedure ToggleBoxConnectChange(Sender: TObject);
  private
    FAvrdudePath: String;
    FBinPath: String;
    FConfigPath: String;
    FDevice: String;
    FTermCursor: TPoint;
    FIniFile: TIniFile;
    FLines: TStrings;
    procedure AddLine(const AText: String);
    procedure DisplayConnected(const AValue: Boolean);
    procedure SetDevice(AValue: String);
    procedure LoadConfig;
    procedure SaveConfig;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;

    property Device: String read FDevice write SetDevice;
    property ConfigPath: String read FConfigPath write FConfigPath;
    property BinPath: String read FBinPath write FBinPath;
    property AvrdudePath: String read FAvrdudePath write FAvrdudePath;
  end;

var
  FormTerminal: TFormTerminal;

implementation

uses
  UFormDialogPreferences,
  Clipbrd,
  LCLType,
  LCLIntf,
  process;

{$R *.lfm}

{ TFormTerminal }

constructor TFormTerminal.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  FLines := TStringList.Create;
  FIniFile := TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
  LoadConfig;
end;

destructor TFormTerminal.Destroy;
begin
  FIniFile.Free;
  FLines.Free;
  inherited Destroy;
end;

procedure TFormTerminal.ActionConnectExecute(Sender: TObject);
begin
  if ToggleBoxConnect.Checked xor Serial.Active then
    try
      if ToggleBoxConnect.Checked then
        Serial.Open
      else
        Serial.Close;
    except
      on E: Exception do
      begin
        Serial.Close;
        AddLine(E.Message);
        ToggleBoxConnect.Checked := False;
      end;
    end;
end;

procedure TFormTerminal.ActionClearExecute(Sender: TObject);
begin
  WriteLn('ActionClearExecute ', GetCurrentThreadId, ' (main: ', MainThreadID, ')');
  MemoTTY.Clear;
  EditLastKeys.Text := '';
  FTermCursor := MemoTTY.CaretPos;
end;

procedure TFormTerminal.ActionPreferencesExecute(Sender: TObject);
begin
  FormDialogPreferences.Device := Device;
  FormDialogPreferences.ConfigPath := ConfigPath;
  FormDialogPreferences.BinPath := BinPath;
  FormDialogPreferences.AvrdudePath := AvrdudePath;
  if FormDialogPreferences.ShowModal = mrOk then
  begin
    Device := FormDialogPreferences.Device;
    ConfigPath := FormDialogPreferences.ConfigPath;
    BinPath := FormDialogPreferences.BinPath;
    AvrdudePath := FormDialogPreferences.AvrdudePath;
    SaveConfig;
  end;
end;

procedure TFormTerminal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  Serial.Close;
end;

procedure TFormTerminal.SerialRxData(Sender: TObject);
var
  i: Integer;
  VCurrentLine: String;
begin
  WriteLn('SerialRxData ', GetCurrentThreadId, ' (main: ', MainThreadID, ')');
  FLines.Text := Serial.ReadData;
  if FLines.Count = 0 then
    Exit;
  MemoTTY.Lines.BeginUpdate;
  try
    MemoTTY.CaretPos := FTermCursor;
    while MemoTTY.Lines.Count > FTermCursor.Y + 1 do
      MemoTTY.Lines.Delete(MemoTTY.Lines.Count - 1);
    VCurrentLine := Copy(MemoTTY.Lines[FTermCursor.Y], 1, FTermCursor.X) + FLines[0];
    MemoTTY.Lines[FTermCursor.Y] := VCurrentLine;
    for i := 1 to FLines.Count - 1 do
    begin
      VCurrentLine := FLines[i];
      MemoTTY.Lines[FTermCursor.Y + i] := VCurrentLine;
    end;
    FTermCursor.Y := MemoTTY.Lines.Count;
    FTermCursor.X := Length(VCurrentLine);
  finally
    MemoTTY.Lines.EndUpdate;
  end;
  FLines.Clear;
end;

procedure TFormTerminal.ToggleBoxConnectChange(Sender: TObject);
begin
  ActionConnect.Execute;
end;

procedure TFormTerminal.AddLine(const AText: String);
begin
  WriteLn('AddLine ', GetCurrentThreadId, ' (main: ', MainThreadID, ')');
  if Application.Terminated then
    Exit;
  if AText = '' then
    Exit;
  if Trim(MemoTTY.Lines[FTermCursor.Y]) <> '' then
    Inc(FTermCursor.Y);
  MemoTTY.Lines[FTermCursor.Y] := AText;
  FTermCursor.Y := MemoTTY.Lines.Count;
  MemoTTY.CaretPos := FTermCursor;
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
end;

procedure TFormTerminal.SaveConfig;
begin
  FIniFile.WriteString('MAIN', 'device', Device);
  FIniFile.WriteString('MAIN', 'config_path', ConfigPath);
  FIniFile.WriteString('MAIN', 'bin_path', BinPath);
  FIniFile.WriteString('MAIN', 'avrdude_path', AvrdudePath);
end;

end.
