program terminal;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, LazSerialPort, UFormTerminal, UFormDialogPreferences;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFormTerminal, FormTerminal);
  Application.CreateForm(TFormDialogPreferences, FormDialogPreferences);
  Application.Run;
end.

