unit Timers;

{$mode objfpc}{$H-}{$Z1}

interface

type
  TFrequencyDivider = (CLKt1, CLKt8, CLKt64, CLKt256, CLKt1024);

  { TCustomTimer }

  TCustomTimer = object
  private
    FDividerA: TFrequencyDivider;
    FDividerB: TFrequencyDivider;
  public
    property DividerA: TFrequencyDivider read FDividerA write FDividerA;
    property DividerB: TFrequencyDivider read FDividerB write FDividerB;
    property EnbaledIA: Boolean read GetEnbaledIA write SetEnbaledIA;
    property EnbaledIB: Boolean read GetEnbaledIB write SetEnbaledIB;
  end;

implementation

end.
