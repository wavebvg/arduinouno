unit RGBLed;

{$mode objfpc}{$H-}{$Z1}

interface

//  TOTAL 20 OPs
//  TD0 0.4us  (6.4  ~ 6)  ±150ns
//  TS0 0.85us (13,6 ~ 14) ±150ns
//  TD1 0.8us  (12,8 ~ 13) ±150ns
//  TS1 0.45us (7,2  ~ 7)  ±150ns
//
//RES low voltage time Above 50μs

uses
  ArduinoTools;

type
  TRGBColor = record
    R, G, B: Byte;
  end;

  { TRGBLed }
  PRGBLed = ^TRGBLed;

  TRGBLed = object(TCustomPinOutput)
  private
    FCount: Word;
    FColor: TRGBColor;
    procedure SetColor(AValue: TRGBColor);
    procedure SetCount(AValue: Word);
    procedure InternalUpdate; assembler;
  public
    constructor Init(const APin: byte; const ACount: Word);
    property Color: TRGBColor read FColor write SetColor;
    property Count: Word read FCount write SetCount;
  end;

implementation

{ TRGBLed }

constructor TRGBLed.Init(const APin: byte; const ACount: Word);
begin
  inherited Init(APin);
  FCount := ACount;
  FColor := Default(TRGBColor);
  InternalUpdate;
end;

procedure TRGBLed.SetColor(AValue: TRGBColor);
begin
  if (AValue.R = FColor.R) and (AValue.G = FColor.G) and (AValue.B = FColor.B) then
    Exit;
  FColor := AValue;
  InternalUpdate;
end;

procedure TRGBLed.SetCount(AValue: Word);
begin
  if FCount = AValue then
    Exit;
  FCount := AValue;
  InternalUpdate;
end;

procedure TRGBLed.InternalUpdate; assembler;
label
  exit, bitloop, rgbloop, ledloop, skipoff;
asm
         PUSH    R16 {Pin} {VPort} {VMaskOff}         {2}
         PUSH    R17 {VBitMask}    {VMaskOn}          {2}
         PUSH    R20 {RGB counter}                    {2}
         PUSH    R21 {Data bit counter}               {2}
         PUSH    R22 {Data value}                     {2}
         PUSH    XL  {ConstAddress} {LedCount}        {2}
         PUSH    XH  {ConstAddress} {LedCount}        {2}
         PUSH    YL  {Self}                           {2}
         PUSH    YH  {Self}                           {2}
         PUSH    ZL  {VPortAddr}                      {2}
         PUSH    ZH  {VPortAddr}                      {2}
         RJMP    exit
         // Save self to Y
         MOVW    YL,  R24                             {1}
         PUSH    R24                                  {2}
         // Load pin
         LD      R16, Y                               {2}
         // VBitMask := DigitalPinToBitMask[Pin];
         LDI     XL,  LO8(DigitalPinToBitMask)        {1}
         LDI     XH,  HI8(DigitalPinToBitMask)        {1}
         ADD     XL,  R16                             {1}
         ADC     XH,  R1                              {1}
         LD      R17, X                               {2} {VBitMask => R17}
         // VPort := DigitalPinToPort[Pin];
         LSL     R16
         LDI     XL,  LO8(DigitalPinToPort)           {1}
         LDI     XH,  HI8(DigitalPinToPort)           {1}
         ADD     XL,  R16                             {1}
         ADC     XH,  R1                              {1}
         LD      R16, X                               {2} {VPort => R16}
         // VPortValue := PortToOutput[VPort]^;
         LSL     R16                                  {1}
         LDI     R26, LO8(PortToOutput)               {1}
         LDI     R27, HI8(PortToOutput)               {1}
         ADD     R26, R16                             {1}
         ADC     R27, R1                              {1}
         LD      ZL,  X+                              {2}
         LD      ZH,  X                               {2} {VPortAddr => Z}
         // Load LedCount
         LDD     XL,  Y+4                             {2} {LedCount => X}
         LDD     XH,  Y+5                             {2} {LedCount => X}
         CP      XL,  R1                              {1}
         CPC     XH,  R1                              {1}
         BREQ    exit                                 {1|2}
         // Calc mask on/off
         LD      R16, Z                               {2} {VPortAddr^ => R16}
         COM     R17                                  {1}
         AND     R16, R17                             {1} {VMaskOff => R16}
         COM     R17                                  {1}
         OR      R17, R16                             {1} {VMaskOn => R17}
         //
         ADIW    YL,  6                               {2} {Addr(FColor) => Y}
         ledloop:
         LDI     R20, 3                               {1} {RGB counter => R20}
         rgbloop:
         LD      R22, Y+                              {2} {RGBValue => R22}
         LDI     R21, 8                               {1} {BitCounter => R21}
         // begin мигающий цикл
         bitloop:        {0.4мкс => 6,4 (6|14), 0.8мкс => 12.8 (13|7)}
         ST      Z,   R17                             {2}
         ADIW    R24, 0                               {2}
         NOP                                          {1}
         SBRS    R22, 7                               {1|2}
         ST      Z,   R16                             {2}
         ADIW    R24, 0                               {2}
         ADIW    R24, 0                               {2}
         LSL     R22                                  {1}
         BRCC    skipoff                              {1|2}
         ST      Z,   R16                             {2}
         skipoff:
         ADIW    R24, 0                               {2}
         DEC     R21                                  {1}
         BRNE    bitloop                              {1|2}
         // end   мигающий цикл
         DEC     R20                                  {1}
         BRNE    rgbloop                              {1|2}
         SBIW    YL,  3                               {1}
         SBIW    XL,  1                               {1}
         CP      XL,  R1                              {1}
         CPC     XH,  R1                              {1}
         BRNE    ledloop                              {1|2}
         //
         exit:
         POP     ZH                                   {2}
         POP     ZL                                   {2}
         POP     YH                                   {2}
         POP     YL                                   {2}
         POP     XH                                   {2}
         POP     XL                                   {2}
         POP     R22                                  {2}
         POP     R21                                  {2}
         POP     R20                                  {2}
         POP     R17                                  {2}
         POP     R16                                  {2}
end;

end.
