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
  LazSynaSer,
  LMessages, ActnList,
  syncobjs,
  IniFiles,
  UTF8Process;

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
    ActionFlash: TAction;
    ActionList: TActionList;
    ButtonClear: TButton;
    ButtonPreferences: TButton;
    ButtonFlash: TButton;
    EditLastKeys: TEdit;
    MemoTTY: TMemo;
    PanelBody: TPanel;
    PanelButton: TPanel;
    Serial: TLazSerial;
    ProcessTimer: TTimer;
    ToggleBoxConnect: TToggleBox;
    procedure ActionClearExecute(Sender: TObject);
    procedure ActionConnectExecute(Sender: TObject);
    procedure ActionConnectUpdate(Sender: TObject);
    procedure ActionFlashExecute(Sender: TObject);
    procedure ActionFlashUpdate(Sender: TObject);
    procedure ActionPreferencesExecute(Sender: TObject);
    procedure ActionPreferencesUpdate(Sender: TObject);
    procedure ButtonPreferencesClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure MemoTTYKeyPress(Sender: TObject; var Key: char);
    procedure MemoTTYKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure MemoTTYMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure MemoTTYMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure ProcessTimerTimer(Sender: TObject);
    procedure SerialRxData(Sender: TObject);
    procedure SerialStatus(Sender: TObject; Reason: THookSerialReason;
      const Value: string);
    procedure ToggleBoxConnectChange(Sender: TObject);
  private
    FAvrdudePath: string;
    FBinPath: string;
    FConfigPath: string;
    FDevice: string;
    FErrorCount: integer;
    FMouseDownLock: boolean;
    FTermCursor: TPoint;
    FLines: TStringStream;
    FKeys: TStrings;
    FSyncEvent: TEvent;
    FIniFile: TIniFile;
    FProcess: TProcessUTF8;
    FProcessRunning: boolean;
    FOutputLines: TStrings;
    FBeforeRunConnected: boolean;
    function GetUpdateLocked: boolean;
    procedure AddLine(const AText: string);
    procedure DisplayConnected(const AValue: boolean);
    procedure SetDevice(AValue: string);
    procedure WMSerial(var AMsg: TLMessage); message WM_SERIAL;
    procedure LoadConfig;
    procedure SaveConfig;
    procedure UpdateControls;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    property UpdateLocked: boolean read GetUpdateLocked;

    property Device: string read FDevice write SetDevice;
    property ConfigPath: string read FConfigPath write FConfigPath;
    property BinPath: string read FBinPath write FBinPath;
    property AvrdudePath: string read FAvrdudePath write FAvrdudePath;
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
  FOutputLines := TStringList.Create;
  FSyncEvent := TSimpleEvent.Create;
  FLines := TStringStream.Create('');
  FKeys := TStringList.Create;
  FProcess := TProcessUTF8.Create(Self);
  FProcess.Options := FProcess.Options + [poUsePipes, poStderrToOutput];
  FIniFile := TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
  LoadConfig;
end;

destructor TFormTerminal.Destroy;
begin
  FIniFile.Free;
  FKeys.Free;
  FLines.Free;
  FSyncEvent.Free;
  FOutputLines.Free;
  inherited Destroy;
end;

procedure TFormTerminal.ButtonPreferencesClick(Sender: TObject);
begin

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
  MemoTTY.Clear;
  FTermCursor := MemoTTY.CaretPos;
end;

procedure TFormTerminal.ActionConnectUpdate(Sender: TObject);
begin
  TCustomAction(Sender).Enabled := not FProcessRunning;
end;

procedure TFormTerminal.ActionFlashExecute(Sender: TObject);
begin
  FBeforeRunConnected := Serial.Active;
  Serial.Close;
  FProcess.Executable := AvrdudePath;
  FProcess.Parameters.Add(Format('-C%s', [ConfigPath]));
  FProcess.Parameters.Add('-q');
  FProcess.Parameters.Add('-q');
  FProcess.Parameters.Add('-patmega328p');
  FProcess.Parameters.Add('-carduino');
  FProcess.Parameters.Add('-b115200');
  FProcess.Parameters.Add('-D');
  FProcess.Parameters.Add(Format('-P%s', [Device]));
  FProcess.Parameters.Add(Format('-Uflash:w:%s:i', [BinPath]));
  AddLine('Begin flashing');
  FProcess.Execute;
  ProcessTimer.Enabled := True;
end;

procedure TFormTerminal.ActionFlashUpdate(Sender: TObject);
begin
  TCustomAction(Sender).Enabled := not FProcessRunning;
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

procedure TFormTerminal.ActionPreferencesUpdate(Sender: TObject);
begin
  //TCustomAction(Sender).Enabled := ;
end;

procedure TFormTerminal.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  Serial.Close;
end;

procedure TFormTerminal.MemoTTYKeyPress(Sender: TObject; var Key: char);
begin
  if not Serial.Active then
    Exit;
  Serial.WriteData(Key);
  FKeys.Insert(0, Format('#%0.3d', [Ord(Key)]));
  if FKeys.Count > 10 then
    FKeys.Delete(FKeys.Count - 1);
  EditLastKeys.Text := StringReplace(FKeys.Text, LineEnding, ' ', [rfReplaceAll]);
end;

procedure TFormTerminal.MemoTTYKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  MemoTTY.CaretPos := FTermCursor;
end;

procedure TFormTerminal.MemoTTYMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  FMouseDownLock := True;
end;

procedure TFormTerminal.MemoTTYMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
var
  VSelText: string;
begin
  FMouseDownLock := False;
  VSelText := MemoTTY.SelText;
  if VSelText <> '' then
    Clipboard.AsText := VSelText;
  MemoTTY.CaretPos := FTermCursor;
  if Serial.Active then
    SerialRxData(nil);
end;

procedure TFormTerminal.ProcessTimerTimer(Sender: TObject);
begin
  ProcessTimer.Enabled := False;
  try
    FProcessRunning := FProcess.Running;
    FOutputLines.LoadFromStream(FProcess.Output);
    MemoTTY.Lines.AddStrings(FOutputLines);
    FOutputLines.Clear;
    UpdateControls;
    if not FProcessRunning then
      AddLine('End   flashing');
    if not FProcessRunning and FBeforeRunConnected then
      Serial.Open;
  finally
    ProcessTimer.Enabled := FProcessRunning;
  end;
end;

procedure TFormTerminal.SerialRxData(Sender: TObject);
var
  VLine: string;

  procedure DropLine;
  var
    VCurrentLine: string;
    VLinePos: integer;
    VSpaces: string;
  begin
    VCurrentLine := MemoTTY.Lines[FTermCursor.Y];
    if Length(VLine) = 1 then
      VLinePos := 1
    else
      VLinePos := 1;
    if Length(VCurrentLine) < FTermCursor.X then
    begin
      SetLength(VSpaces, FTermCursor.X - Length(VCurrentLine));
      FillChar(VSpaces[1], Length(VSpaces), ' ');
      VCurrentLine := VCurrentLine + VSpaces;
    end
    else
      while (Length(VCurrentLine) >= FTermCursor.X + 1) and
        (Length(VLine) >= VLinePos) do
      begin
        VCurrentLine[FTermCursor.X + 1] := VLine[VLinePos];
        Inc(VLinePos);
        Inc(FTermCursor.X);
      end;
    if Length(VLine) >= VLinePos then
    begin
      VCurrentLine := VCurrentLine + Copy(VLine, VLinePos, Length(VLine) - VLinePos + 1);
      Inc(FTermCursor.X, Length(VLine) - VLinePos + 1);
    end;
    VLine := '';
    MemoTTY.Lines[FTermCursor.Y] := VCurrentLine;
    MemoTTY.CaretPos := FTermCursor;
  end;

var
  VData: string;
  VChar: byte;
begin
  VData := Serial.ReadData;
  if VData = '' then
    Exit;
  MemoTTY.Lines.BeginUpdate;
  try
    FLines.WriteString(VData);
    if UpdateLocked then
      Exit;
    FErrorCount := 0;
    FLines.Position := 0;
    VLine := '';
    while FLines.Position < FLines.Size do
    begin
      VChar := FLines.ReadByte;
      case VChar of
        10:
        begin
          DropLine;
          FTermCursor.X := 0;
          MemoTTY.CaretPos := FTermCursor;
        end;
        13:
        begin
          DropLine;
          Inc(FTermCursor.Y);
          DropLine;
        end;
        else
          VLine := VLine + Chr(VChar);
      end;
    end;
    DropLine;
    FLines.Size := 0;
  finally
    MemoTTY.Lines.EndUpdate;
  end;
end;

procedure TFormTerminal.SerialStatus(Sender: TObject; Reason: THookSerialReason;
  const Value: string);
begin
  if Application.Terminated then
    Exit;
  if MainThreadID = GetCurrentThreadId then
    SendMessage(Handle, WM_SERIAL, WParam(PChar(Value)), Ord(Reason))
  else
  begin
    PostMessage(Handle, WM_SERIAL, WParam(PChar(Value)), Ord(Reason));
    FSyncEvent.WaitFor(INFINITE);
    FSyncEvent.ResetEvent;
  end;
end;

procedure TFormTerminal.ToggleBoxConnectChange(Sender: TObject);
begin
  ActionConnect.Execute;
end;

function TFormTerminal.GetUpdateLocked: boolean;
begin
  Result := FMouseDownLock;
end;

procedure TFormTerminal.AddLine(const AText: string);
begin
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

procedure TFormTerminal.DisplayConnected(const AValue: boolean);
begin
  if Application.Terminated then
    Exit;
  ToggleBoxConnect.Checked := AValue;
end;

procedure TFormTerminal.SetDevice(AValue: string);
var
  VSerialActive: boolean;
begin
  if FDevice = AValue then Exit;
  FDevice := AValue;
  VSerialActive := Serial.Active;
  Serial.Close;
  Serial.Device := Device;
  Serial.Active := VSerialActive;
end;

procedure TFormTerminal.WMSerial(var AMsg: TLMessage);
var
  VText, Value: string;
  Reason: THookSerialReason;
begin
  if Application.Terminated then
    Exit;
  Value := PChar(AMsg.WParam);
  Reason := THookSerialReason(AMsg.LParam);
  VText := '';
  case Reason of
    HR_SerialClose:
    begin
      DisplayConnected(False);
      VText := Format('Disconnect %s', [Value]);
    end;
    HR_Connect:
    begin
      DisplayConnected(True);
      VText := Format('Connect %s', [Value]);
    end;
    HR_CanRead:
    begin
      Inc(FErrorCount);
      Sleep(100);
    end;
    HR_CanWrite:
    begin
      Inc(FErrorCount);
      Sleep(100);
    end;
    HR_ReadCount:
    begin
      FErrorCount := 0;
    end;
    HR_WriteCount:
    begin
      FErrorCount := 0;
    end
    else
    begin
      FErrorCount := 0;
      Exit;
    end;
  end;
  if VText <> '' then
  begin
    AddLine(VText);
  end
  else
  if FErrorCount >= MAX_ERROR_COUNT then
  begin
    AddLine(Format('Disconnect %s', [Serial.Device]));
    DisplayConnected(False);
    Serial.Close;
  end;
  FSyncEvent.SetEvent;
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

procedure TFormTerminal.UpdateControls;
begin
  ToggleBoxConnect.Enabled := not FProcessRunning;
end;

end.
