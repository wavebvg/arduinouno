unit IRRemote;

{$mode objfpc}{$H-}
{$goto on}

interface

uses
  ArduinoTools;

type

  { TIRRemote }

  TIRRemote = object(TCustomPinInput)
  public
    constructor Init(const APin: byte);
    destructor Deinit; virtual;
  end;

implementation

uses
  IRRemoteISR;

{ TIRRemote }

constructor TIRRemote.Init(const APin: byte);
begin
  inherited;
  Params.RecvPin := Pin;
end;

destructor TIRRemote.Deinit;
begin

end;

end.
