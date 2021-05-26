unit UFormDialogPreferences;

//home/safiya/Загрузки/arduino-1.8.13/hardware/tools/avr/bin/avrdude
//home/safiya/Загрузки/arduino-1.8.13/hardware/tools/avr/etc/avrdude.conf
//dev/ttyACM0
//home/safiya/tmp/projects/tests/avr/botuno/bin/botmotor.hex

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  Forms,
  Controls,
  Graphics,
  Dialogs,
  ExtCtrls,
  ButtonPanel,
  StdCtrls;

type

  { TFormDialogPreferences }

  TFormDialogPreferences = class(TForm)
    ButtonConfigPath: TButton;
    ButtonBinPath: TButton;
    ButtonAvrdude: TButton;
    ButtonPanel: TButtonPanel;
    CheckBoxShowTime: TCheckBox;
    ComboBoxTTY: TComboBox;
    EditConfigPath: TEdit;
    EditBinPath: TEdit;
    EditAvrdude: TEdit;
    LabelConfigPath: TLabel;
    LabelBinPath: TLabel;
    LabelAvrdude: TLabel;
    LabelTTY: TLabel;
    OpenDialog: TOpenDialog;
    PanelBody: TPanel;
    procedure ButtonAvrdudeClick(Sender: TObject);
    procedure ButtonBinPathClick(Sender: TObject);
    procedure ButtonConfigPathClick(Sender: TObject);
  private
    FAvrdudePath: String;
    FBinPath: String;
    FConfigPath: String;
    FDevice: String;
    FShowTime: Boolean;
  public
    function ShowModal: Integer; override;

    property Device: String read FDevice write FDevice;
    property ConfigPath: String read FConfigPath write FConfigPath;
    property AvrdudePath: String read FAvrdudePath write FAvrdudePath;
    property BinPath: String read FBinPath write FBinPath;
    property ShowTime: Boolean read FShowTime write FShowTime;
  end;

var
  FormDialogPreferences: TFormDialogPreferences;

implementation

uses
  FileUtil;

{$R *.lfm}

{ TFormDialogPreferences }

procedure TFormDialogPreferences.ButtonConfigPathClick(Sender: TObject);
begin
  if OpenDialog.Execute then
    EditConfigPath.Text := OpenDialog.FileName;
end;

procedure TFormDialogPreferences.ButtonBinPathClick(Sender: TObject);
begin
  if OpenDialog.Execute then
    EditBinPath.Text := OpenDialog.FileName;
end;

procedure TFormDialogPreferences.ButtonAvrdudeClick(Sender: TObject);
begin
  if OpenDialog.Execute then
    EditAvrdude.Text := OpenDialog.FileName;
end;

function TFormDialogPreferences.ShowModal: Integer;
var
  VTTYFiles: TStrings;
  i: Integer;
begin
  VTTYFiles := TStringList.Create;
  try
    FindAllFiles(VTTYFiles, '/dev/', 'ttyACM*', False);
    for i := VTTYFiles.Count - 1 downto 0 do
      if Pos('ttyACM', VTTYFiles[i]) = 0 then
        VTTYFiles.Delete(i);
    ComboBoxTTY.Items.BeginUpdate;
    try
      ComboBoxTTY.Items.Assign(VTTYFiles);
      ComboBoxTTY.Items.Insert(0, '');
    finally
      ComboBoxTTY.Items.EndUpdate;
    end;
  finally
    VTTYFiles.Free;
  end;
  ComboBoxTTY.Caption := Device;
  EditConfigPath.Text := ConfigPath;
  EditBinPath.Text := BinPath;
  EditAvrdude.Text := AvrdudePath;
  CheckBoxShowTime.Checked := ShowTime;
  Result := inherited ShowModal;
  if Result = mrOk then
  begin
    Device := ComboBoxTTY.Caption;
    ConfigPath := EditConfigPath.Text;
    BinPath := EditBinPath.Text;
    AvrdudePath := EditAvrdude.Text;
    ShowTime := CheckBoxShowTime.Checked;
  end;
end;

end.
