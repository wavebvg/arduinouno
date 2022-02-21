unit RGBLed;

{$mode objfpc}{$H-}{$Z1}

interface

// WS2811
// TOTAL 2.5us   (40)
//   T0H 0.5us   (8    ~ 8)   ±150ns
//   T0L 2.0us   (32   ~ 32)  ±150ns
//   T1H 1.2us   (19,2 ~ 19)  ±150ns
//   T1L 1.3us   (20,8 ~ 21)  ±150ns

// WS2812
//  TOTAL 1.15-1.3us (18,4-20,8)
//    T0H 0.35us (5.6  ~ 6)   ±150ns
//    T0L 0.8us  (12,8 ~ 13)  ±150ns
//    T1H 0.7us  (11,2 ~ 11)  ±150ns
//    T1L 0.6us  (9,6  ~ 10)  ±150ns

// WS2812B
//  TOTAL 1.25us (20)
//    T0H 0.4us  (6.4  ~ 6)   ±150ns
//    T0L 0.85us (13,6 ~ 14)  ±150ns
//    T1H 0.8us  (12,8 ~ 13)  ±150ns
//    T1L 0.45us (7,2  ~ 7)   ±150ns

// WS281X
//  TOTAL 1.25us (20)
//    T0H 0.375us (6)   ±150ns
//    T0L 0.875us (14)  ±150ns
//    T1H 0.875us (14)  ±150ns
//    T1L 0.375us (6)   ±150ns

// RES low voltage time Above 50μs

uses
  ArduinoTools;

const
  MAX_LED_COUNT = 85;

type
  TRGBColor = record
    R, G, B: Byte;
  end;

  TRGBColors = array[0..MAX_LED_COUNT - 1] of TRGBColor;

  { TRGBLeds }
  PRGBLeds = ^TRGBLeds;

  TRGBLeds = object(TCustomPinOutput)
  private
    FCount: Byte;
    FColors: TRGBColors;
    FUpdateIndex: Integer;
    function GetColor(const AIndex: Integer): TRGBColor;
    procedure SetAllColor(AValue: TRGBColor);
    procedure SetColor(const AIndex: Integer; AValue: TRGBColor);
    procedure SetCount(AValue: Byte);
    procedure InternalUpdate;
  public
    constructor Init(const APin: byte; const ACount: Word);
    //
    procedure BeginUpdate;
    procedure EndUpdate;
    //
    property Colors[const AIndex: Integer]: TRGBColor read GetColor write SetColor;
    property AllColors: TRGBColor write SetAllColor;
    property Count: Byte read FCount write SetCount;
  end;

implementation

{ TRGBLeds }

constructor TRGBLeds.Init(const APin: byte; const ACount: Word);
begin
  inherited Init(APin);
  FCount := ACount;
  FColors := Default(TRGBColors);
  InternalUpdate;
end;

procedure TRGBLeds.BeginUpdate;
begin
  Inc(FUpdateIndex);
end;

procedure TRGBLeds.EndUpdate;
begin
  Dec(FUpdateIndex);
  if FUpdateIndex = 0 then
    InternalUpdate;
end;

procedure TRGBLeds.SetCount(AValue: Byte);
begin
  if FCount = AValue then
    Exit;
  FCount := AValue;
  InternalUpdate;
end;

function TRGBLeds.GetColor(const AIndex: Integer): TRGBColor;
begin
  Result := FColors[AIndex];
  InternalUpdate;
end;

procedure TRGBLeds.SetAllColor(AValue: TRGBColor);
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    FColors[i] := AValue;
  InternalUpdate;
end;

procedure TRGBLeds.SetColor(const AIndex: Integer; AValue: TRGBColor);
begin
  FColors[AIndex] := AValue;
end;

procedure TRGBLeds.InternalUpdate;
label
  loop, complete, Next, next_byte;
var
  VPortAddr{Y+4 (+2)}: Pbyte;
  VLMask{Y+6 (+1)}, VHMask{Y+7 (+1)}: Byte;
  VByteCount{Y+8 (+1)}: Byte;
  VPortMask{Y+9 (+1)}: Byte;
begin
  VPortAddr := PortToOutput[DigitalPinToPort[Pin]];
  VPortMask := DigitalPinToBitMask[Pin];
  VHMask := VPortAddr^ or VPortMask;
  VLMask := VHMask and not VPortMask;
  VByteCount := Count * 3;
  if VPortAddr^ <> VLMask then
  begin
    VPortAddr^ := VLMask;
    SleepMicroSecs(50000);
  end;
  asm
           PUSH    R10     {HMask}
           PUSH    R11     {LMask}
           PUSH    R16     {BitNo}
           PUSH    R17     {Current Color}
           PUSH    R18     {ByteCount}
           PUSH    XL      {Current ColorAddr}
           PUSH    XH      {Current ColorAddr}
           PUSH    ZL      {POUT}
           PUSH    ZH   {POUT}

           { R18 <= ByteCount }
           LDD     R18, Y+8

           { X <= ColorAddr }
           MOVW    XL, R24
           ADIW    XL, FColors

           { Z <= PortAddr }
           LDD     ZL, Y+4
           LDD     ZH, Y+5

           { R10 <= LMask }
           LDD     R10, Y+6

           { R11 <= HMask }
           LDD     R11, Y+7
           //
           LD      R17, X+
           DEC     R18
           LDI     R16, 8
           //
           loop:                                 { [1]         [0]}
           NOP                      {1}
           ST      Z,  R11          {2}
           RJMP    0                {2}           { 0+2}       { 0+2}
           NOP                      {1}           { 2+1}       { 2+1}   
           next:
           SBRS    R17, 7           {1|2}         { 3+2}       { 3+1}
           ST      Z, R10           {2}           { 5+0}       { 4+2} {6!}
           SBRC    R17, 7           {1|2}         { 5+1}       { 0+2}
           RJMP    0                {2}           { 6+2}       { 2+0}
           SBRS    R16, 1           {1|2}         { 8+2}       { 2+2}
           RJMP    next_byte        {1}           {10+0}       { 4+0}
           NOP                      {2}           {10+1}       { 4+1}
           LSL     R17              {1}           {11+1}       { 5+1}
           ST      Z, R10           {2}           {12+2} {14!} { 6+2}
           DEC     R16              {1}           { 0+1}       { 8+1}
           JMP     loop             {2}           { 1+3} {6!}  { 9+3} {14!}
           //
           next_byte:                             {11+0}       { 5+0}
           LDI     R16, 8           {1}           {11+1}       { 5+1}
           ST      Z, R10           {2}           {12+2} {14!} { 6+2}
           LD      R17, X+          {2}           { 0+2}       { 8+2}
           DEC     R18              {1}           { 2+1}       {10+1}
           BREQ    complete         {1|2}         { 3+1}       {11+1}
           ST      Z,  R11          {2}           { 4+2} {6!}  {12+2} {14!}
           LSL     R17              {1}           { 0+1}       { 0+1}
           RJMP    next             {2}           { 1+2}       { 1+2}
           //
           complete:

           POP     ZH
           POP     ZL
           POP     XH
           POP     XL
           POP     R18
           POP     R17
           POP     R16
           POP     R11
           POP     R10
  end;
end;

end.
