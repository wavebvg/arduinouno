program notifications;

uses     
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  dynlibs,
  SysUtils,
  gattlib;

var
  VRet: Integer;
  VAdapter: Pointer = nil;
  VConnection: pgatt_connection_t;
  VCharacteristics: pgattlib_characteristic_t;
  VCharacteristicCount: Integer;
  i: Integer;
  VRx, VTx: uuid_t;
  VRxHandle, VTxHandle: Word;
  VTestText: String;
  VResponse: PChar;

  function UUIDToStr(const AUUID: puuid_t): String;
  begin
    SetLength(Result, 36);
    FillChar(Result[1], Length(Result), #0);
    gattlib_uuid_to_string(AUUID, Pansichar(Result), 37);
  end;

  function StrToUUID(const AUUIDStr: String): uuid_t;
  begin
    gattlib_string_to_uuid(PChar(AUUIDStr), 38, @Result);
  end;

  procedure notification_cb(const uuid: puuid_t; const Data: Pbyte; const data_length: SizeUInt;
    user_data: Pointer); cdecl;
  var
    i: Integer;
  begin
    for i := 0 to data_length - 1 do
      Write(Char(Data[i]));
  end;

begin

  if LoadLibrary then
  begin
    try
      VRxHandle := 0;
      VTxHandle := 0;
      VRx := StrToUUID('0xffe1');
      WriteLn(UUIDToStr(@VRx));
      VTx := StrToUUID('0xffe1');

      //exit;
      VRet := gattlib_adapter_open(nil, @VAdapter);
      WriteLn('gattlib_adapter_open: ', VRet);
      if VRet <> 0 then
        Exit;
      try
        VConnection := gattlib_connect(nil, {'E4:15:F6:6F:F8:8E'}'50:51:A9:8E:22:EF',
          GATTLIB_CONNECTION_OPTIONS_LEGACY_DEFAULT);
        WriteLn('gattlib_connect: ', Integer(VConnection));
        if VConnection = nil then
          Exit;
        try
          //VRet := gattlib_discover_char(VConnection, @VCharacteristics, @VCharacteristicCount);
          //WriteLn('gattlib_discover_char: ', VRet);
          //if VRet <> 0 then
          //  Exit;
          //try
          //  WriteLn('CharacteristicCount ', VCharacteristicCount);
          //  for i := 0 to VCharacteristicCount - 1 do
          //  begin
          //    if VRet <> 0 then
          //      Exit;
          //    //WriteLn(VGuidStr, ' ', VCharacteristics[i].properties);
          //    with VCharacteristics[i] do
          //    begin
          //      WriteLn(Format('handle = 0x%.4x, char properties = 0x%.2x, char value handle = 0x%.4x %s',
          //        [handle, properties, value_handle, UUIDToStr(@uuid)]));
          //    end;
          //    if (gattlib_uuid_cmp(@VRx, @VCharacteristics[i].uuid) = 0) or (VTxHandle <> 0) then
          //      VRxHandle := VCharacteristics[i].value_handle;
          //    if gattlib_uuid_cmp(@VTx, @VCharacteristics[i].uuid) = 0 then
          //      VTxHandle := VCharacteristics[i].value_handle;
          //  end;
          //finally
          //  gattlib.Free(VCharacteristics);
          //end;
          gattlib_register_notification(VConnection, @notification_cb, nil);
          VRet := gattlib_notification_start(VConnection, @VRx);
          WriteLn('gattlib_notification_start: ', VRet);
          if VRet <> 0 then
            Exit;
          Sleep(600000);
              {VRet := gattlib_read_char_by_uuid(VConnection, @VRx, @VResponse, @VCharacteristicCount);
              WriteLn('gattlib_read_char_by_uuid: ', VRet);
              if VRet <> 0 then
                Exit;
              VTestText := StrPas(VResponse);
              SetLength(VTestText, VCharacteristicCount);
              WriteLn(VTestText);}
        finally
          VRet := gattlib_disconnect(VConnection);
          WriteLn('gattlib_disconnect: ', VRet);
        end;
        if VRet <> 0 then
          Exit;
      finally
        VRet := gattlib_adapter_close(VAdapter);
        WriteLn('gattlib_adapter_close: ', VRet);
      end;
      if VRet <> 0 then
        Exit;
    finally
      UnloadLibrary;
    end;
  end;

end.
