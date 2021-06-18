unit IR;

{$mode ObjFPC}
{$Z1}

interface

uses
  ArduinoTools;

const
  IR_INTERVAL = 50;
  IR_INTERVAL_DIFF = 8;
  IR_VALUE_TIME = 562;
  IR_VALUE_TIME_MIN = IR_VALUE_TIME - 2 * (IR_INTERVAL + IR_INTERVAL_DIFF);
  IR_VALUE_TIME_MAX = IR_VALUE_TIME + 2 * (IR_INTERVAL + IR_INTERVAL_DIFF);
  IR_VALUE0_TIME = IR_VALUE_TIME;
  IR_VALUE0_TIME_MIN = IR_VALUE0_TIME - 2 * (IR_INTERVAL + IR_INTERVAL_DIFF);
  IR_VALUE0_TIME_MAX = IR_VALUE0_TIME + 2 * (IR_INTERVAL + IR_INTERVAL_DIFF);
  IR_VALUE1_TIME = IR_VALUE_TIME * 3;
  IR_VALUE1_TIME_MIN = IR_VALUE1_TIME - 2 * (IR_INTERVAL + IR_INTERVAL_DIFF);
  IR_VALUE1_TIME_MAX = IR_VALUE1_TIME + 2 * (IR_INTERVAL + IR_INTERVAL_DIFF);
  IR_PREAMBLE_TIME = 9000;
  IR_PREAMBLE_TIME_MIN = IR_PREAMBLE_TIME - 2 * (IR_INTERVAL + IR_INTERVAL_DIFF);
  IR_PREAMBLE_TIME_MAX = IR_PREAMBLE_TIME + 2 * (IR_INTERVAL + IR_INTERVAL_DIFF);
  IR_DATA_TIME = 4500;
  IR_DATA_TIME_MIN = IR_DATA_TIME - 2 * (IR_INTERVAL + IR_INTERVAL_DIFF);
  IR_DATA_TIME_MAX = IR_DATA_TIME + 2 * (IR_INTERVAL + IR_INTERVAL_DIFF);
  IR_REPEAT_TIME = 2250;
  IR_REPEAT_TIME_MIN = IR_REPEAT_TIME - 2 * (IR_INTERVAL + IR_INTERVAL_DIFF);
  IR_REPEAT_TIME_MAX = IR_REPEAT_TIME + 2 * (IR_INTERVAL + IR_INTERVAL_DIFF);
  IR_INVALID_TIMEOUT = 65000;

type
  TIREventType = (iretUndefined, iretPreamble, iretRepeat, iretData);
  TIRReadData = (irrdAddress, irrdAddressInvert, irrdCommand, irrdCommandInvert);
  TIRReadDatas = array[TIRReadData] of Byte;

  TIREvent = packed record
    EventType: TIREventType;
    Value: Boolean;
  end;

  TIRValue = packed record
    Address, Command: Byte;
  end;

  TIRContextFlag = (ircfInvalid, ircfComplete, ircfData, ircfLastValue);

  TIRContextFlags = set of TIRContextFlag;

  TIRContext = packed record
    Pos: Byte;
    Data: TIRReadDatas;
    Flags: TIRContextFlags;
    ReadData: TIRReadData;
    CurrentValue: TIRValue;
  end;

type

  { TIRReceiver }

  TIRReceiver = object(TCustomPinInput)
  private
    FLastValue: TIRValue;
    (*function InternalRead1(const APin: Pbyte; const AMask: Byte): TIRValue; assembler;*)
    function InternalRead(const APin: Pbyte; const AMask: Byte): TIRValue;
  public
    constructor Init(const APin: byte);

    function Read: TIRValue;
  end;

implementation

procedure DoEvent(var AContext: TIRContext; const AEvent: TIREvent);
begin
  //mov  r19,r24                                // 1
  case AEvent.EventType of
    //  movw  r30,r22                           // 1
    //  ld  r20,Z                               // 2*
    //  cpi  r20,1                              // 1
    //  brsh  .Lj28                             // 1/2
    //.Ll3:
    //  rjmp  .Lj6                              // 2
    //.Lj28:
    //.Ll4:
    //  mov  r18,r20                            // 1
    //  dec  r20                                // 1
    //  cpi  r18,1                              // 1
    //  breq  .Lj7                              // 1/2
    //  mov  r18,r20                            // 1
    //  dec  r20                                // 1
    //  cpi  r18,1                              // 1
    //  breq  .Lj8                              // 1/2
    //  mov  r18,r20                            // 1
    //  dec  r20                                // 1
    //  cpi  r18,1                              // 1
    //  breq  .Lj9                              // 1/2
    //  rjmp  .Lj6                              // 2
    iretPreamble:
    begin
      AContext.Flags := AContext.Flags + [ircfData];
      //mov  r30,r19                            // 1
      //mov  r31,r25                            // 1
      //ldd  r18,Z+5                            // 2*
      //ori  r18,4                              // 1
      //mov  r30,r19                            // 1
      //mov  r31,r25                            // 1
      //std  Z+5,r18                            // 2*
      AContext.ReadData := irrdAddress;
      //mov  r18,r1                             // 1
      //mov  r30,r19                            // 1
      //mov  r31,r25                            // 1
      //std  Z+6,r18                            // 2*
      AContext.Pos := 0;
      //mov  r18,r1                             // 1
      //mov  r30,r19                            // 1
      //mov  r31,r25                            // 1
      //st  Z,r18                               // 2*
      //rjmp  .Lj5                              // 2
    end;
    iretRepeat:
    begin
      AContext.Flags := AContext.Flags + [ircfComplete, ircfLastValue];
      //mov  r30,r19                            // 1
      //mov  r31,r25                            // 1
      //ldd  r18,Z+5                            // 2*
      //ori  r18,10                             // 1
      //mov  r30,r19                            // 1
      //mov  r31,r25                            // 1
      //std  Z+5,r18                            // 2*
      //rjmp  .Lj5                              // 2
    end;
    iretData:
      if ircfData in AContext.Flags then
        //mov  r30,r19                          // 1
        //mov  r31,r25                          // 1
        //ldd  r18,Z+5                          // 2*
        //lsr  r18                              // 1
        //lsr  r18                              // 1
        //sbrs  r18,0                           // 1/2/3
        //rjmp  .Lj11                           // 2
      begin
        if AEvent.Value then
          //  movw  r30,r22                     // 1
          //  ldd  r18,Z+1                      // 2*
          //  cp  r18,r1                        // 1
          //  brne  .Lj29                       // 1/2
          //.Ll11:
          //  rjmp  .Lj13                       // 2
          AContext.Data[AContext.ReadData] := AContext.Data[AContext.ReadData] or (Byte(1) shl AContext.Pos)
        //  mov  r30,r19                        // 1
        //  mov  r31,r25                        // 1
        //  ldd  r22,Z+6                        // 2*
        //  mov  r18,r1                         // 1
        //  ldi  r20,1                          // 1
        //  mov  r30,r19                        // 1
        //  mov  r31,r25                        // 1
        //  ld  r21,Z                           // 2*
        //  tst  r21                            // 1
        //  breq  .Lj15                         // 1/2
        //.Lj14:
        //  lsl  r20                            // 1
        //  dec  r21                            // 1
        //  brne  .Lj14                         // 1/2
        //.Lj15:
        //  mov  r30,r19                        // 1
        //  mov  r31,r25                        // 1
        //  add  r30,r22                        // 1
        //  adc  r31,r18                        // 1
        //  adiw  r30,1                         // 1
        //  ld  r18,Z                           // 2*
        //  or  r20,r18                         // 1
        //  mov  r30,r19                        // 1
        //  mov  r31,r25                        // 1
        //  ldd  r21,Z+6                        // 2*
        //  mov  r18,r1                         // 1
        //  mov  r30,r19                        // 1
        //  mov  r31,r25                        // 1
        //  add  r30,r21                        //
        //  adc  r31,r18                        // 1
        //  adiw  r30,1                         // 2
        //  st  Z,r20                           // 2*
        //  rjmp  .Lj16                         // 2
        else
          AContext.Data[AContext.ReadData] := AContext.Data[AContext.ReadData] and not (Byte(1) shl AContext.Pos);
        //  ldi  r20,1                          // 1
        //  mov  r30,r19                        // 1
        //  mov  r31,r25                        // 1
        //  ld  r18,Z                           // 2*
        //  tst  r18                            // 1
        //  breq  .Lj18                         // 1/2
        //.Lj17:
        //  lsl  r20                            // 1
        //  dec  r18                            // 1
        //  brne  .Lj17                         // 1/2
        //.Lj18:
        //  com  r20                            // 1
        //  mov  r30,r19                        // 1
        //  mov  r31,r25                        // 1
        //  ldd  r21,Z+6                        // 2*
        //  mov  r18,r1                         // 1
        //  mov  r30,r19                        // 1
        //  mov  r31,r25                        // 1
        //  add  r30,r21                        // 1
        //  adc  r31,r18                        // 1
        //  adiw  r30,1                         // 2
        //  ld  r21,Z                           // 2*
        //  and  r21,r20                        // 1
        //  mov  r30,r19                        // 1
        //  mov  r31,r25                        // 1
        //  ldd  r20,Z+6                        // 2*
        //  mov  r18,r1                         // 1
        //  mov  r30,r19                        // 1
        //  mov  r31,r25                        // 1
        //  add  r30,r20                        // 1
        //  adc  r31,r18                        // 1
        //  adiw  r30,1                         // 2
        //  st  Z,r21                           // 2*
        Inc(AContext.Pos);
        // mov  r30,r19                         // 1
        //mov  r31,r25                          // 1
        //ld  r18,Z                             // 2*
        //inc  r18                              // 1
        //mov  r30,r19                          // 1
        //mov  r31,r25                          // 1
        //st  Z,r18                             // 2*
        if AContext.Pos >= 8 then
          //mov  r30,r19                        // 1
          //mov  r31,r25                        // 1
          //ld  r18,Z                           // 2*
          //cpi  r18,8                          // 1
          //brlo  .Lj20                         // 1/2
        begin
          Inc(AContext.ReadData);
          //mov  r30,r19                        // 1
          //mov  r31,r25                        // 1
          //ldd  r18,Z+6                        // 2*
          //inc  r18                            // 1
          //mov  r30,r19                        // 1
          //mov  r31,r25                        // 1
          //std  Z+6,r18                        // 2*
          AContext.Pos := 0;
          //mov  r18,r1                         // 1
          //mov  r30,r19                        // 1
          //mov  r31,r25                        // 1
          //st  Z,r18                           // 2*
        end;
        if AContext.ReadData > System.High(TIRReadData) then
          //  mov  r30,r19                      // 1
          //  mov  r31,r25                      // 1
          //  ldd  r20,Z+6                      // 2*
          //  ldi  r18,3                        // 1
          //  cp  r18,r20                       // 1
          //  brlo  .Lj30                       // 1/2
          //.Ll19:
          //  rjmp  .Lj5                        // 2
          //.Lj30:
          //.Ll20:
        begin
          if (AContext.Data[irrdAddress] xor AContext.Data[irrdAddressInvert] = $FF) and
            (AContext.Data[irrdCommand] xor AContext.Data[irrdCommandInvert] = $FF) then
            //mov  r30,r19                      // 1
            //mov  r31,r25                      // 1
            //ldd  r20,Z+1                      // 2*
            //mov  r30,r19                      // 1
            //mov  r31,r25                      // 1
            //ldd  r18,Z+2                      // 2*
            //eor  r18,r20                      // 1
            //cpi  r18,-1                       // 1
            //breq  .Lj31                       // 1/2
            //.Ll21:
            //rjmp  .Lj24                       // 2
            //.Lj31:
            //.Ll22:
            //mov  r30,r19                      // 1
            //mov  r31,r25                      // 1
            //ldd  r20,Z+3                      // 2*
            //mov  r30,r19                      // 1
            //mov  r31,r25                      // 1
            //ldd  r18,Z+4                      // 2*
            //eor  r18,r20                      // 1
            //cpi  r18,-1                       // 1
            //breq  .Lj32                       // 1/2
            //.Ll23:
            //rjmp  .Lj24                       // 2
            //.Lj32:
            //.Ll24:
          begin
            AContext.CurrentValue.Address := AContext.Data[irrdAddress];
            //mov  r30,r19                      // 1
            //mov  r31,r25                      // 1
            //adiw  r30,1                       // 2
            //ldi  r18,lo8(7)                   // 1
            //ldi  r20,hi8(7)                   // 1
            //add  r18,r19                      // 1
            //adc  r20,r25                      // 1
            //mov  r26,r18                      // 1
            //mov  r27,r20                      // 1
            //ld  r0,Z                          // 2*
            //st  X,r0                          // 2*
            AContext.CurrentValue.Command := AContext.Data[irrdCommand];
            //mov  r30,r19                      // 1
            //mov  r31,r25                      // 1
            //adiw  r30,3                       // 2
            //ldi  r18,lo8(8)                   // 1
            //ldi  r20,hi8(8)                   // 1
            //add  r18,r19                      // 1
            //adc  r20,r25                      // 1
            //mov  r26,r18                      // 1
            //mov  r27,r20                      // 1
            //ld  r0,Z                          // 2*
            //st  X,r0                          // 2*
            AContext.Flags := AContext.Flags + [ircfComplete];
            //mov  r30,r19                      // 1
            //mov  r31,r25                      // 1
            //ldd  r18,Z+5                      // 2*
            //ori  r18,2                        // 1
            //mov  r30,r19                      // 1
            //mov  r31,r25                      // 1
            //std  Z+5,r18                      // 2*
            //rjmp  .Lj5                        // 2
          end
          else
            //.Lj24:
            //.Ll27:
            AContext.Flags := AContext.Flags + [ircfInvalid];
          //mov  r30,r19                        // 1
          //mov  r31,r25                        // 1
          //ldd  r18,Z+5                        // 2*
          //ori  r18,1                          // 1
          //mov  r30,r19                        // 1
          //mov  r31,r25                        // 1
          //std  Z+5,r18                        // 2*
          //rjmp  .Lj5                          // 2
        end;
      end
      else
        //.Lj11:
        //.Ll28:
        AContext.Flags := AContext.Flags + [ircfInvalid];
      //mov  r30,r19                            // 1
      //mov  r31,r25                            // 1
      //ldd  r18,Z+5                            // 2*
      //ori  r18,1                              // 1
      //mov  r30,r19                            // 1
      //mov  r31,r25                            // 1
      //std  Z+5,r18                            // 2*
      //rjmp  .Lj5                              // 2
    else
      //.Lj6:
      //.Ll29:
      AContext.Flags := AContext.Flags + [ircfInvalid];
      //mov  r30,r19                            // 1
      //mov  r31,r25                            // 1
      //ldd  r18,Z+5                            // 2*
      //ori  r18,1                              // 1
      //mov  r30,r19                            // 1
      //mov  r31,r25                            // 1
      //std  Z+5,r18                            // 2*
  end;
  //.Lj5:
  //.Ll30:
  //  ret                                       // 1
  //.Lc1:
  //.Lt2:
  //.Le0:
end;

procedure ParseEvent(var AContext: TIRContext; const AData, ASpace: Word);
var
  VEvent: TIREvent;
begin
  //push  r29                                   // 2
  //push  r28                                   // 2
  //push  r7                                    // 2
  //push  r6                                    // 2
  //push  r5                                    // 2
  //push  r4                                    // 2
  //push  r3                                    // 2
  //push  r2                                    // 2
  //in  r28,61                                  // 1
  //in  r29,62                                  // 1
  //subi  r28,6                                 // 1
  //sbci  r29,0                                 // 1
  //in  r0,63                                   // 1
  //cli                                         // 1
  //out  62,r29                                 // 1
  //out  63,r0                                  // 1
  //out  61,r28                                 // 1
  //
  //  movw  r4,r24                              // 1
  //  mov  r3,r22                               // 1
  //  mov  r7,r23                               // 1
  //  mov  r2,r20                               // 1
  //  mov  r6,r21                               // 1
  //.Ll33:
  //  ldi  r24,lo8(4)                           // 1
  //  ldi  r25,hi8(4)                           // 1
  //  add  r24,r28                              // 1
  //  adc  r25,r29                              // 1
  //  mov  r20,r1                               // 1
  //  ldi  r22,2                                // 1
  //  mov  r23,r1                               // 1
  //  call  SYSTEM_ss_FILLCHARsformalsSMALLINTsBYTE  // 4/5*
  VEvent.EventType := iretUndefined;
  //std  Y+2,r1                                 // 2*
  VEvent := Default(TIREvent);
  //ldd  r0,Y+4                                 // 2*
  //std  Y+2,r0                                 // 2*
  //ldd  r0,Y+5                                 // 2*
  //std  Y+3,r0                                 // 2*
  if (AData >= IR_PREAMBLE_TIME_MIN) and (AData <= IR_PREAMBLE_TIME_MIN) then
    //mov  r19,r3                               // 1
    //mov  r18,r7                               // 1
    //subi  r19,-76                             // 1
    //sbci  r18,34                              // 1
    //cp  r1,r19                                // 1
    //cpc  r1,r18                               // 1
    //brsh  .Lj55                               // 1/2
    //rjmp  .Lj36                               // 2
  begin
    if (ASpace >= IR_DATA_TIME_MIN) and (ASpace <= IR_DATA_TIME_MAX) then
      //mov  r20,r2                             // 1
      //mov  r19,r6                             // 1
      //subi  r20,32                            // 1
      //sbci  r19,17                            // 1
      //ldi  r21,-24                            // 1
      //mov  r18,r1                             // 1
      //cp  r21,r20                             // 1
      //cpc  r18,r19                            // 1
      //brlo  .Lj38                             // 1/2
      VEvent.EventType := iretPreamble
    //ldi  r18,1                                // 1
    //std  Y+2,r18                              // 2*
    //rjmp  .Lj43                               // 2
    else
    if (ASpace >= IR_REPEAT_TIME_MIN) and (ASpace <= IR_REPEAT_TIME_MAX) then
      //mov  r20,r2                             // 1
      //mov  r18,r6                             // 1
      //subi  r20,86                            // 1
      //sbci  r18,8                             // 1
      //ldi  r21,-24                            // 1
      //mov  r19,r1                             // 1
      //cp  r21,r20                             // 1
      //cpc  r19,r18                            // 1
      //brlo  .Lj41                             // 1/2
      VEvent.EventType := iretRepeat
    //ldi  r18,2                                // 1
    //std  Y+2,r18                              // 2*
    //rjmp  .Lj43                               // 2
    else
      //movw  r30,r4                            // 1
      //ldd  r18,Z+5                            // 2*
      //ori  r18,1                              // 1
      //movw  r30,r4                            // 1
      //std  Z+5,r18                            // 2*
      //rjmp  .Lj43                             // 2
      AContext.Flags := AContext.Flags + [ircfInvalid];
  end
  else
  if (AData >= IR_VALUE_TIME_MIN) and (AData <= IR_VALUE_TIME_MAX) then
    //  mov  r19,r3                             // 1
    //  mov  r20,r7                             // 1
    //  subi  r19,-66                           // 1
    //  sbci  r20,1                             // 1
    //  ldi  r21,-24                            // 1
    //  mov  r18,r1                             // 1
    //  cp  r21,r19                             // 1
    //  cpc  r18,r20                            // 1
    //  brsh  .Lj56                             // 1/2
    //.Ll44:
    //  rjmp  .Lj45                             // 2
  begin
    VEvent.EventType := iretData;
    //ldi  r18,3                                // 1
    //std  Y+2,r18                              // 2*
    if (ASpace >= IR_VALUE1_TIME_MIN) and (ASpace <= IR_VALUE1_TIME_MAX) then
      //mov  r19,r2                             // 1
      //mov  r20,r6                             // 1
      //subi  r19,34                            // 1
      //sbci  r20,6                             // 1
      //ldi  r21,-24                            // 1
      //mov  r18,r1                             // 1
      //cp  r21,r19                             // 1
      //cpc  r18,r20                            // 1
      //brlo  .Lj47                             // 1/2
      VEvent.Value := True
    //ldi  r18,1                                // 1
    //std  Y+3,r18                              // 2*
    //rjmp  .Lj43                               // 2
    else
    if (ASpace >= IR_VALUE0_TIME_MIN) and (ASpace <= IR_VALUE0_TIME_MAX) then
      //mov  r19,r6                             // 1
      //ldi  r26,-66                            // 1
      //sub  r2,r26                             // 1
      //sbci  r19,1                             // 1
      //ldi  r20,-24                            // 1
      //mov  r18,r1                             // 1
      //cp  r20,r2                              // 1
      //cpc  r18,r19                            // 1
      //brlo  .Lj50                             // 1/2
      VEvent.Value := False
    //std  Y+3,r1                               // 2*
    //rjmp  .Lj43                               // 2
    else
      AContext.Flags := AContext.Flags + [ircfInvalid];
    //movw  r30,r4                              // 1
    //ldd  r18,Z+5                              // 2*
    //ori  r18,1                                // 1
    //movw  r30,r4                              // 1
    //std  Z+5,r18                              // 2*
    //rjmp  .Lj43                               // 2
  end
  else
    AContext.Flags := AContext.Flags + [ircfInvalid];
  //movw  r30,r4                                // 1
  //ldd  r18,Z+5                                // 2*
  //ori  r18,1                                  // 1
  //movw  r30,r4                                // 1
  //std  Z+5,r18                                // 2*
  if not (ircfInvalid in AContext.Flags) then
    //movw  r30,r4                              // 1
    //ldd  r18,Z+5                              // 2*
    //sbrc  r18,0                               // 1/2/3
    //rjmp  .Lj54                               // 2
    DoEvent(AContext, VEvent);
  //ldi  r22,lo8(2)                             // 1
  //ldi  r23,hi8(2)                             // 1
  //add  r22,r28                                // 1
  //adc  r23,r29                                // 1
  //movw  r24,r4                                // 1
  //call  IR_ss_DOEVENTsTIRCONTEXTsTIREVENT     // 4/5*
  //  
  //subi  r28,-6                                // 1
  //sbci  r29,-1                                // 1
  //in  r0,63                                   // 1
  //cli                                         // 1
  //out  62,r29                                 // 1
  //out  63,r0                                  // 1
  //out  61,r28                                 // 1
  //pop  r2                                     // 2
  //pop  r3                                     // 2
  //pop  r4                                     // 2
  //pop  r5                                     // 2
  //pop  r6                                     // 2
  //pop  r7                                     // 2
  //pop  r28                                    // 2
  //pop  r29                                    // 2
  //ret                                         // 2
end;

{ TIRReceiver }

constructor TIRReceiver.Init(const APin: byte);
begin
  inherited;
  FLastValue := Default(TIRValue);
end;

function TIRReceiver.InternalRead(const APin: Pbyte; const AMask: Byte): TIRValue;
var
  VValue: Boolean;
  VInSpace: Boolean;
  VTimer: Word;
  VData: Word;
  VContext: TIRContext;

  procedure Reset;
  begin
    VTimer := 0;
    VInSpace := False;
    VData := 0;
    VContext := Default(TIRContext);
  end;

begin
  Reset;
  repeat
    if ircfInvalid in VContext.Flags then
    begin
      if VTimer < IR_INVALID_TIMEOUT then
        SleepMicroSecs(IR_INVALID_TIMEOUT);
      Reset;
    end
    else
    begin
      VValue := (APin^ and AMask) <> 0;
      //mov  r30,r7                                             // 1
      //mov  r31,r2                                             // 1
      //ld  r19,Z                                               // 2*
      //mov  r18,r8                                             // 1
      //and  r18,r19                                            // 1
      //cp  r18,r1                                              // 1
      //ldi  r16,1                                              // 1
      //brne  .Lj84                                             // 1/2
      //mov  r16,r1                                             // 1
      if VValue then
        //cp  r16,r1                                            // 1
        //breq  .Lj86                                           // 1/2
      begin
        if VInSpace then
          //ldd  r18,Y+2                                        // 2*
          //cp  r18,r1                                          // 1
          //brne  .Lj97                                         // 1/2
        begin
          VInSpace := False;
          //std  Y+2,r1                                         // 2*
          VData := VTimer;
          //ldd  r0,Y+3                                         // 2*
          //std  Y+5,r0                                         // 2*
          //ldd  r0,Y+4                                         // 2*
          //std  Y+6,r0                                         // 2*
          VTimer := 0;
          //mov  r18,r1                                         // 1
          //mov  r19,r1                                         // 1
          //std  Y+3,r18                                        // 2*
          //std  Y+4,r19                                        // 2*
          //rjmp  .Lj83                                         // 2
        end;
      end
      else
      begin
        if not VInSpace then
          //ldd  r18,Y+2                                        // 2*
          //cp  r1,r18                                          // 1
          //brne  .Lj83                                         // 1/2
        begin
          if VData > 0 then
            //ldd  r18,Y+5                                      // 2*
            //ldd  r19,Y+6                                      // 2*
            //cp  r1,r18                                        // 1
            //cpc  r1,r19                                       // 1
            //brsh  .Lj93                                       // 1/2
          begin
            ParseEvent(VContext, VData, VTimer);
            //ldd  r20,Y+3                                      // 2*
            //ldd  r21,Y+4                                      // 2*
            //ldd  r22,Y+5                                      // 2*
            //ldd  r23,Y+6                                      // 2*
            //ldi  r24,lo8(7)                                   // 1
            //ldi  r25,hi8(7)                                   // 1
            //add  r24,r28                                      // 1
            //adc  r25,r29                                      // 1
            //call  IR_ss_PARSEEVENTsTIRCONTEXTsWORDsWORD       // 4/5*
            VData := 0;
            //mov  r18,r1                                       // 1
            //mov  r19,r1                                       // 1
            //std  Y+5,r18                                      // 2*
            //std  Y+6,r19                                      // 2*
          end;
          VInSpace := True;
          //ldi  r18,1                                          // 1
          //std  Y+2,r18                                        // 2*
          VTimer := 0;
          //mov  r19,r1                                         // 1
          //mov  r18,r1                                         // 1
          //std  Y+3,r19                                        // 2*
          //std  Y+4,r18                                        // 2*
        end;
      end;
    end;
    SleepMicroSecs(IR_INTERVAL);
    //ldi  r22,50                                               // 1
    //mov  r23,r1                                               // 1
    //mov  r24,r1                                               // 1
    //mov  r25,r1                                               // 1
    //call  ARDUINOTOOLS_ss_SLEEPMICROSECSsLONGWORD             // 4/5*
    Inc(VTimer, IR_INTERVAL);
    //ldd  r20,Y+3                                              // 2*
    //ldd  r19,Y+4                                              // 2*
    //ldi  r18,58                                               // 1
    //add  r20,r18                                              // 1
    //adc  r19,r1                                               // 1
    //std  Y+3,r20                                              // 2*
    //std  Y+4,r19                                              // 2*
    Inc(VTimer, IR_INTERVAL_DIFF);
    //ldd  r20,Y+3                                              // 2*
    //ldd  r19,Y+4                                              // 2*
    //ldi  r18,8                                                // 1
    //add  r20,r18                                              // 1
    //adc  r19,r1                                               // 1
    //std  Y+3,r20                                              // 2*
    //std  Y+4,r19                                              // 2*
  until ircfComplete in VContext.Flags;
  //ldd  r18,Y+12                                               // 2*
  //lsr  r18                                                    // 1
  //sbrs  r18,0                                                 // 1/2/3
  //rjmp  .Lj76                                                 // 2
  if ircfLastValue in VContext.Flags then
    Result := FLastValue
  else
    Result := VContext.CurrentValue;
end;

(*
function TIRReceiver.InternalRead1(const APin: Pbyte; const AMask: Byte): TIRValue; assembler;
label
  loop, reset, addtimer, pinfalse, noninvalid;
var
  VContext: TIRContext;
asm
         // Temporary var
         PUSH    R16
         // Temporary var
         PUSH    R17
         // In space
         PUSH    R25
         // Low timer
         PUSH    R26
         // High timer
         PUSH    R27
         // Low data
         PUSH    R28
         // High data
         PUSH    R29
         // Low pin
         PUSH    R30
         // High pin
         PUSH    R31
         // Set Pin value
         MOV     R30, R22
         MOV     R31, R23
         reset:
         // Reset all values
         CLR     R25
         CLR     R26
         CLR     R27
         CLR     R28
         CLR     R29
         STD     VContext.Pos, R0
         STD     VContext.Flags, R0
         STD     VContext.Data, R0
         STD     VContext.ReadData + 0, R0
         STD     VContext.ReadData + 1, R0
         STD     VContext.ReadData + 2, R0
         STD     VContext.ReadData + 3, R0
         STD     VContext.CurrentValue + 0, R0
         STD     VContext.CurrentValue + 1, R0
         loop:
         // Load flags
         // Check invalid
         LDD     R16, VContext.Flags
         ANDI    R16, ircfInvalid
         CPI     R16, 0
         BREQ    noninvalid
         // Run invalid timer
         PUSH    R22
         PUSH    R23
         PUSH    R24
         PUSH    R25
         // Call sleep of 65535mks
         LDI     R22, 255
         LDI     R23, 255
         CLR     R24
         CLR     R25
         RCALL   SleepMicroSecs
         POP     R25
         POP     R24
         POP     R23
         POP     R22
         RJMP    reset
         noninvalid:
         // Read Pin value
         LD      R16, Z
         // Apply bit mask
         AND     R16, R24
         // Check readed value
         CPI     R16, 0
         BREQ    pinfalse
         // True value in Pin
         CPI     R25, 0
         BREQ    addtimer
         //
         LDI     R25, 0
         MOV     R28,R26
         MOV     R29,R27
         CLR     R26
         CLR     R27
         RJMP    addtimer
         pinfalse:
         // False value in Pin
         /// ????        
         CPI     R25, 0
         BRNE    addtimer
         //           
         LDI     R25, 1
         CLR     R26
         CLR     R27
         CPI     R28, 0
         CPC     R29, R0
         BREQ    addtimer
         // ParseEvent(VContext, VData, VTimer);
         CLR     R28
         CLR     R29
         //
         RJMP    addtimer
         addtimer:
         // Add timer value     
         LDI     R22, 50
         CLR     R23
         CLR     R24
         CLR     R25
         RCALL   SleepMicroSecs
         POP     R25
         POP     R24
         POP     R23
         POP     R22
         ADIW    R26, 60              // 2
         RJMP    loop
         // Save result value!
         /// ?????
         //
         POP     R31
         POP     R30
         POP     R29
         POP     R28
         POP     R27
         POP     R26
         POP     R17
         POP     R16
end;
*)
function TIRReceiver.Read: TIRValue;
var
  VBit: Byte;
  VPort: TAVRPort;
begin
  VBit := DigitalPinToBitMaskPGM[Pin];
  VPort := DigitalPinToPortPGM[Pin];
  Result := InternalRead(PortToInputPGM[VPort], VBit);
  FLastValue := Result;
end;

end.
