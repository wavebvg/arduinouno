unit gattlib;

{$mode ObjFPC}{$H+}

interface

const
  GattLibName = './libgattlib.so';
  GattLibName1 = 'libgattlib.so';

type
  PPGuid = ^PGuid;

type
  (* GattLib note: BD Address have only been introduced into Bluez v4.100.   *)
  (*               Prior to this version, only BDADDR_BREDR can be supported *)

  (* BD Address type *)
  _BDADDR_BREDR = (BDADDR_BREDR, BDADDR_LE_PUBLIC, BDADDR_LE_RANDOM);

//#if BLUEZ_VERSION_MAJOR == 5
//  #define ATT_MAX_MTU ATT_MAX_VALUE_LEN
//#endif

const
  (**
   * @name Gattlib errors
   *)
  GATTLIB_SUCCESS = 0;
  GATTLIB_INVALID_PARAMETER = 1;
  GATTLIB_NOT_FOUND = 2;
  GATTLIB_OUT_OF_MEMORY = 3;
  GATTLIB_NOT_SUPPORTED = 4;
  GATTLIB_DEVICE_ERROR = 5;
  GATTLIB_ERROR_DBUS = 6;
  GATTLIB_ERROR_BLUEZ = 7;
  GATTLIB_ERROR_INTERNAL = 8;

  (**
   * @name GATT Characteristic Properties Bitfield values
   *)
  GATTLIB_CHARACTERISTIC_BROADCAST = $01;
  GATTLIB_CHARACTERISTIC_READ = $02;
  GATTLIB_CHARACTERISTIC_WRITE_WITHOUT_RESP = $04;
  GATTLIB_CHARACTERISTIC_WRITE = $08;
  GATTLIB_CHARACTERISTIC_NOTIFY = $10;
  GATTLIB_CHARACTERISTIC_INDICATE = $20;

  (**
   * @name Options for gattlib_connect()
   *
   * @note Options with the prefix `GATTLIB_CONNECTION_OPTIONS_LEGACY_`
   *       is for Bluez prior to v5.42 (before Bluez) support
   *)
const
  GATTLIB_CONNECTION_OPTIONS_LEGACY_BDADDR_LE_PUBLIC = 1 shl 0;
  GATTLIB_CONNECTION_OPTIONS_LEGACY_BDADDR_LE_RANDOM = 1 shl 1;
  GATTLIB_CONNECTION_OPTIONS_LEGACY_BT_SEC_LOW = 1 shl 2;
  GATTLIB_CONNECTION_OPTIONS_LEGACY_BT_SEC_MEDIUM = 1 shl 3;
  GATTLIB_CONNECTION_OPTIONS_LEGACY_BT_SEC_HIGH = 1 shl 4;

function GATTLIB_CONNECTION_OPTIONS_LEGACY_PSM(const Value: Word): Cardinal;
function GATTLIB_CONNECTION_OPTIONS_LEGACY_MTU(const Value: Word): Cardinal;

function GATTLIB_CONNECTION_OPTIONS_LEGACY_GET_PSM(const Option: Cardinal): Word;
function GATTLIB_CONNECTION_OPTIONS_LEGACY_GET_MTU(const Option: Cardinal): Word;


const
  GATTLIB_CONNECTION_OPTIONS_LEGACY_DEFAULT =
    GATTLIB_CONNECTION_OPTIONS_LEGACY_BDADDR_LE_RANDOM or GATTLIB_CONNECTION_OPTIONS_LEGACY_BDADDR_LE_RANDOM or
    GATTLIB_CONNECTION_OPTIONS_LEGACY_BT_SEC_LOW;

(**
 * @name Discover filter
 *)
  GATTLIB_DISCOVER_FILTER_USE_NONE = 0;
  GATTLIB_DISCOVER_FILTER_USE_UUID = 1 shl 0;
  GATTLIB_DISCOVER_FILTER_USE_RSSI = 1 shl 1;

  (**
   * @name Gattlib Eddystone types
   *)
  GATTLIB_EDDYSTONE_TYPE_UID = 1 shl 0;
  GATTLIB_EDDYSTONE_TYPE_URL = 1 shl 1;
  GATTLIB_EDDYSTONE_TYPE_TLM = 1 shl 2;
  GATTLIB_EDDYSTONE_TYPE_EID = 1 shl 3;
  GATTLIB_EDDYSTONE_LIMIT_RSSI = 1 shl 4;

type
  pgatt_connection_t = ^gatt_connection_t;
  gatt_connection_t = packed record
  end;


  ppgatt_stream_t = ^pgatt_stream_t;
  pgatt_stream_t = ^gatt_stream_t;
  gatt_stream_t = packed record
  end;



  (**
   * Structure to represent a GATT Service and its data in the BLE advertisement packet
   *)
  ppgattlib_advertisement_data_t = ^ pgattlib_advertisement_data_t;
  pgattlib_advertisement_data_t = ^ gattlib_advertisement_data_t;

  gattlib_advertisement_data_t = record
    uuid: TGuid;         (**< UUID of the GATT Service *)
    Data: Pbyte;         (**< Data attached to the GATT Service *)
    data_length: SizeUInt;  (**< Length of data attached to the GATT Service *)
  end;

  gattlib_event_handler_t = procedure(const uuid: TGuid; const Data: Pbyte; const data_length: SizeUInt;
    user_data: Pointer); cdecl;

  (**
   * @brief Handler called on disconnection
   *
   * @param connection Connection that is disconnecting
   * @param user_data  Data defined when calling `gattlib_register_on_disconnect()`
   *)
  gattlib_disconnection_handler_t = procedure(user_data: Pointer); cdecl;

  (**
   * @brief Handler called on new discovered BLE device
   *
   * @param adapter is the adapter that has found the BLE device
   * @param addr is the MAC address of the BLE device
   * @param name is the name of BLE device if advertised
   * @param user_data  Data defined when calling `gattlib_register_on_disconnect()`
   *)
  gattlib_discovered_device_t = procedure(adapter: Pointer; const addr: PChar; const Name: PChar;
    user_data: Pointer); cdecl;

  (**
   * @brief Handler called on new discovered BLE device
   *
   * @param adapter is the adapter that has found the BLE device
   * @param addr is the MAC address of the BLE device
   * @param name is the name of BLE device if advertised
   * @param advertisement_data is an array of Service UUID and their respective data
   * @param advertisement_data_count is the number of elements in the advertisement_data array
   * @param manufacturer_id is the ID of the Manufacturer ID
   * @param manufacturer_data is the data following Manufacturer ID
   * @param manufacturer_data_size is the size of manufacturer_data
   * @param user_data  Data defined when calling `gattlib_register_on_disconnect()`
   *)
  gattlib_discovered_device_with_data_t = procedure(adapter: Pointer; const addr: PChar;
    const Name: PChar; advertisement_data: pgattlib_advertisement_data_t; advertisement_data_count: SizeUInt;
    manufacturer_id: Word; manufacturer_data: Pbyte; manufacturer_data_size: SizeUInt; user_data: Pointer); cdecl;

  (**
   * @brief Handler called on asynchronous connection when connection is ready
   *
   * @param connection Connection that is disconnecting
   * @param user_data  Data defined when calling `gattlib_register_on_disconnect()`
   *)
  gatt_connect_cb_t = procedure(connection: pgatt_connection_t; user_data: Pointer); cdecl;

(**
 * @brief Callback called when GATT characteristic read value has been received
 *
 * @param buffer contains the value to read.
 * @param buffer_len Length of the read data
 *
 *)
  gatt_read_cb_t = procedure(buffer: pointer; buffer_len: SizeUInt); cdecl;


 (**
  * @brief Open Bluetooth adapter
  *
  * @param adapter_name    With value NULL, the default adapter will be selected.
  * @param adapter is the context of the newly opened adapter
  *
  * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
  *)
  gattlib_adapter_open_func = function(const adapter_name: PChar; adapter: PPointer): Integer; cdecl;

 (**
  * @brief Enable Bluetooth scanning on a given adapter
  *
  * @param adapter is the context of the newly opened adapter
  * @param discovered_device_cb is the function callback called for each new Bluetooth device discovered
  * @param timeout defines the duration of the Bluetooth scanning
  * @param user_data is the data passed to the callback `discovered_device_cb()`
  *
  * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
  *)
  gattlib_adapter_scan_enable_func = function(adapter: Pointer; discovered_device_cb: gattlib_discovered_device_t;
    timeout: Integer; user_data: Pointer): Integer; cdecl;

 (**
  * @brief Enable Bluetooth scanning on a given adapter
  *
  * @param adapter is the context of the newly opened adapter
  * @param uuid_list is a NULL-terminated list of UUIDs to filter. The rule only applies to advertised UUID.
  *        Returned devices would match any of the UUIDs of the list.
  * @param rssi_threshold is the imposed RSSI threshold for the returned devices.
  * @param enabled_filters defines the parameters to use for filtering. There are selected by using the macros
  *        GATTLIB_DISCOVER_FILTER_USE_UUID and GATTLIB_DISCOVER_FILTER_USE_RSSI.
  * @param discovered_device_cb is the function callback called for each new Bluetooth device discovered
  * @param timeout defines the duration of the Bluetooth scanning
  * @param user_data is the data passed to the callback `discovered_device_cb()`
  *
  * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
  *)
  gattlib_adapter_scan_enable_with_filter_func = function(adapter: Pointer; uuid_list: PPGuid;
    rssi_threshold: SmallInt; enabled_filters: Cardinal; discovered_device_cb: gattlib_discovered_device_t;
    timeout: Integer; user_data: Pointer): Integer; cdecl;

 (**
  * @brief Enable Eddystone Bluetooth Device scanning on a given adapter
  *
  * @param adapter is the context of the newly opened adapter
  * @param rssi_threshold is the imposed RSSI threshold for the returned devices.
  * @param eddystone_types defines the type(s) of Eddystone advertisement data type to select.
  *        The types are defined by the macros `GATTLIB_EDDYSTONE_TYPE_*`. The macro `GATTLIB_EDDYSTONE_LIMIT_RSSI`
  *        can also be used to limit RSSI with rssi_threshold.
  * @param discovered_device_cb is the function callback called for each new Bluetooth device discovered
  * @param timeout defines the duration of the Bluetooth scanning
  * @param user_data is the data passed to the callback `discovered_device_cb()`
  *
  * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
  *)
  gattlib_adapter_scan_eddystone_func = function(adapter: Pointer; rssi_threshold: SmallInt;
    eddystone_types: Cardinal; discovered_device_cb: gattlib_discovered_device_with_data_t;
    timeout: Integer; user_data: Pointer): Integer; cdecl;

 (**
  * @brief Disable Bluetooth scanning on a given adapter
  *
  * @param adapter is the context of the newly opened adapter
  *
  * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
  *)
  gattlib_adapter_scan_disable_func = function(adapter: Pointer): Integer; cdecl;

 (**
  * @brief Close Bluetooth adapter context
  *
  * @param adapter is the context of the newly opened adapter
  *
  * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
  *)
  gattlib_adapter_close_func = function(adapter: Pointer): Integer; cdecl;

 (**
  * @brief Function to connect to a BLE device
  *
  * @param src    Local Adaptater interface
  * @param dst    Remote Bluetooth address
  * @param options  Options to connect to BLE device. See `GATTLIB_CONNECTION_OPTIONS_*`
  *)
  gattlib_connect_func = function(const src: PChar; const dst: PChar; options: Cardinal): pgatt_connection_t; cdecl;

 (**
  * @brief Function to asynchronously connect to a BLE device
  *
  * @note This function is mainly used before Bluez v5.42 (prior to D-BUS support)
  *
  * @param src    Local Adaptater interface
  * @param dst    Remote Bluetooth address
  * @param options  Options to connect to BLE device. See `GATTLIB_CONNECTION_OPTIONS_*`
  * @param connect_cb is the callback to call when the connection is established
  * @param user_data is the user specific data to pass to the callback
  *)
  gattlib_connect_async_func = function(const src: PChar; const dst: PChar; options: Cardinal;
    connect_cb: gatt_connect_cb_t; user_data: Pointer): pgatt_connection_t; cdecl;

 (**
  * @brief Function to disconnect the GATT connection
  *
  * @param connection Active GATT connection
  *
  * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
  *)
  gattlib_disconnect_func = function(connection: pgatt_connection_t): Integer; cdecl;

 (**
  * @brief Function to register a callback on GATT disconnection
  *
  * @param connection Active GATT connection
  * @param handler is the callaback to invoke on disconnection
  * @param user_data is user specific data to pass to the callaback
  *
  * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
  *)
  gattlib_register_on_disconnect_func = procedure(connection: pgatt_connection_t;
    handler: gattlib_disconnection_handler_t; user_data: Pointer); cdecl;


type
 (**
  * Structure to represent GATT Primary Service
  *)
  ppgattlib_primary_service_t = ^pgattlib_primary_service_t;
  pgattlib_primary_service_t = ^gattlib_primary_service_t;

  gattlib_primary_service_t = record
    attr_handle_start: Word; (**< First attribute handle of the GATT Primary Service *)
    attr_handle_end: Word;   (**< Last attibute handle of the GATT Primary Service *)
    uuid: TGuid;              (**< UUID of the Primary Service *)
  end;

 (**
  * Structure to represent GATT Characteristic
  *)
  ppgattlib_characteristic_t = ^pgattlib_characteristic_t;
  pgattlib_characteristic_t = ^gattlib_characteristic_t;

  gattlib_characteristic_t = record
    handle: Word;        (**< Handle of the GATT characteristic *)
    properties: Byte;    (**< Property of the GATT characteristic *)
    value_handle: Word;  (**< Handle for the value of the GATT characteristic *)
    uuid: TGuid;          (**< UUID of the GATT characteristic *)
  end;

 (**
  * Structure to represent GATT Descriptor
  *)
  ppgattlib_descriptor_t = ^pgattlib_descriptor_t;
  pgattlib_descriptor_t = ^gattlib_descriptor_t;

  gattlib_descriptor_t = record
    handle: Word;        (**< Handle of the GATT Descriptor *)
    uuid16: Word;        (**< UUID16 of the GATT Descriptor *)
    uuid: TGuid;          (**< UUID of the GATT Descriptor *)
  end;

 (**
  * @brief Function to discover GATT Services
  *
  * @note This function can be used to force GATT services/characteristic discovery
  *
  * @param connection Active GATT connection
  * @param services array of GATT services allocated by the function. Can be NULL.
  * @param services_count Number of GATT services discovered. Can be NULL
  *
  * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
  *)
  gattlib_discover_primary_func = function(connection: pgatt_connection_t; services: ppgattlib_primary_service_t;
    services_count: PInteger): Integer; cdecl;

 (**
  * @brief Function to discover GATT Characteristic
  *
  * @note This function can be used to force GATT services/characteristic discovery
  *
  * @param connection Active GATT connection
  * @param start is the index of the first handle of the range
  * @param end is the index of the last handle of the range
  * @param characteristics array of GATT characteristics allocated by the function. Can be NULL.
  * @param characteristics_count Number of GATT characteristics discovered. Can be NULL
  *
  * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
  *)
  gattlib_discover_char_range_func = function(connection: pgatt_connection_t; start: Integer;
    _end: Integer; characteristics: ppgattlib_characteristic_t; characteristics_count: PInteger): Integer;
    cdecl;

 (**
  * @brief Function to discover GATT Characteristic
  *
  * @note This function can be used to force GATT services/characteristic discovery
  *
  * @param connection Active GATT connection
  * @param characteristics array of GATT characteristics allocated by the function. Can be NULL.
  * @param characteristics_count Number of GATT characteristics discovered. Can be NULL
  *
  * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
  *)
  gattlib_discover_char_func = function(connection: pgatt_connection_t; characteristics: ppgattlib_characteristic_t;
    characteristics_count: PInteger): Integer; cdecl;

 (**
  * @brief Function to discover GATT Descriptors in a range of handles
  *
  * @param connection Active GATT connection
  * @param start is the index of the first handle of the range
  * @param end is the index of the last handle of the range
  * @param descriptors array of GATT descriptors allocated by the function. Can be NULL.
  * @param descriptors_count Number of GATT descriptors discovered. Can be NULL
  *
  * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
  *)
  gattlib_discover_desc_range_func = function(connection: pgatt_connection_t; start: Integer;
    _end: Integer; descriptors: ppgattlib_descriptor_t; descriptors_count: Integer): Integer; cdecl;

 (**
  * @brief Function to discover GATT Descriptor
  *
  * @param connection Active GATT connection
  * @param descriptors array of GATT descriptors allocated by the function. Can be NULL.
  * @param descriptors_count Number of GATT descriptors discovered. Can be NULL
  *
  * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
  *)
  gattlib_discover_desc_func = function(connection: pgatt_connection_t; descriptors: ppgattlib_descriptor_t;
    descriptors_count: Integer): Integer; cdecl;

 (**
  * @brief Function to read GATT characteristic
  *
  * @note buffer is allocated by the function. It is the responsibility of the caller to free the buffer.
  *
  * @param connection Active GATT connection
  * @param uuid UUID of the GATT characteristic to read
  * @param buffer contains the value to read. It is allocated by the function.
  * @param buffer_len Length of the read data
  *
  * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
  *)
  gattlib_read_char_by_uuid_func = function(connection: pgatt_connection_t; uuid: PGUID;
    buffer: PPointer; buffer_len: SizeUInt): Integer; cdecl;

 (**
  * @brief Function to asynchronously read GATT characteristic
  *
  * @param connection Active GATT connection
  * @param uuid UUID of the GATT characteristic to read
  * @param gatt_read_cb is the callback to read when the GATT characteristic is available
  *
  * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
  *)
  gattlib_read_char_by_uuid_async_func = function(connection: pgatt_connection_t; uuid: PGUID;
    gatt_read_cb: gatt_read_cb_t): Integer; cdecl;

 (**
  * @brief Function to write to the GATT characteristic UUID
  *
  * @param connection Active GATT connection
  * @param uuid UUID of the GATT characteristic to read
  * @param buffer contains the values to write to the GATT characteristic
  * @param buffer_len is the length of the buffer to write
  *
  * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
  *)
  gattlib_write_char_by_uuid_func = function(connection: pgatt_connection_t; uuid: PGUID;
    const buffer: Pointer; buffer_len: SizeUInt): Integer; cdecl;

 (**
  * @brief Function to write to the GATT characteristic handle
  *
  * @param connection Active GATT connection
  * @param handle is the handle of the GATT characteristic
  * @param buffer contains the values to write to the GATT characteristic
  * @param buffer_len is the length of the buffer to write
  *
  * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
  *)
  gattlib_write_char_by_handle_func = function(connection: pgatt_connection_t; handle: Word;
    const buffer: Pointer; buffer_len: SizeUInt): Integer; cdecl;

 (**
  * @brief Function to write without response to the GATT characteristic UUID
  *
  * @param connection Active GATT connection
  * @param uuid UUID of the GATT characteristic to read
  * @param buffer contains the values to write to the GATT characteristic
  * @param buffer_len is the length of the buffer to write
  *
  * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
  *)
  gattlib_write_without_response_char_by_uuid_func = function(connection: pgatt_connection_t;
    uuid: PGUID; const buffer: Pointer; buffer_len: SizeUInt): Integer; cdecl;

 (**
  * @brief Create a stream to a GATT characteristic to write data in continue
  *
  * @note: The GATT characteristic must support 'Write-Without-Response'
  *
  * @param connection Active GATT connection
  * @param uuid UUID of the GATT characteristic to write
  * @param stream is the object that is attached to the GATT characteristic that is used to write data to
  * @param mtu is the MTU of the GATT connection to optimise the stream writting
  *
  * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
  *)
  gattlib_write_char_by_uuid_stream_open_func = function(connection: pgatt_connection_t;
    uuid: PGUID; stream: ppgatt_stream_t; mtu: PWord): Integer; cdecl;

 (**
  * @brief Write data to the stream previously created with `gattlib_write_char_by_uuid_stream_open()`
  *
  * @param stream is the object that is attached to the GATT characteristic that is used to write data to
  * @param buffer is the data to write to the stream
  * @param buffer_len is the length of the buffer to write
  *
  * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
  *)
  gattlib_write_char_stream_write_func = function(stream: pgatt_stream_t; const buffer: Pointer;
    buffer_len: SizeUInt): Integer; cdecl;

 (**
  * @brief Close the stream previously created with `gattlib_write_char_by_uuid_stream_open()`
  *
  * @param stream is the object that is attached to the GATT characteristic that is used to write data to
  *
  * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
  *)
  gattlib_write_char_stream_close_func = function(stream: pgatt_stream_t): Integer; cdecl;

 (**
  * @brief Function to write without response to the GATT characteristic handle
  *
  * @param connection Active GATT connection
  * @param handle is the handle of the GATT characteristic
  * @param buffer contains the values to write to the GATT characteristic
  * @param buffer_len is the length of the buffer to write
  *
  * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
  *)
  gattlib_write_without_response_char_by_handle_func = function(connection: pgatt_connection_t;
    handle: Word; const buffer: Pointer; buffer_len: SizeUInt): Integer; cdecl;

 (*
  * @brief Enable notification on GATT characteristic represented by its UUID
  *
  * @param connection Active GATT connection
  * @param uuid UUID of the characteristic that will trigger the notification
  *
  * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
  *)
  gattlib_notification_start_func = function(connection: pgatt_connection_t; const uuid: PGUID): Integer; cdecl;

 (*
  * @brief Disable notification on GATT characteristic represented by its UUID
  *
  * @param connection Active GATT connection
  * @param uuid UUID of the characteristic that will trigger the notification
  *
  * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
  *)
  gattlib_notification_stop_func = function(connection: pgatt_connection_t; const uuid: PGUID): Integer; cdecl;

 (*
  * @brief Register a handle for the GATT notifications
  *
  * @param connection Active GATT connection
  * @param notification_handler is the handler to call on notification
  * @param user_data if the user specific data to pass to the handler
  *
  * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
  *)
  gattlib_register_notification_func = procedure(connection: pgatt_connection_t;
    notification_handler: gattlib_event_handler_t; user_data: Pointer); cdecl;

 (*
  * @brief Register a handle for the GATT indications
  *
  * @param connection Active GATT connection
  * @param notification_handler is the handler to call on indications
  * @param user_data if the user specific data to pass to the handler
  *
  * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
  *)
  gattlib_register_indication_func = procedure(connection: pgatt_connection_t;
    indication_handler: gattlib_event_handler_t; user_data: Pointer); cdecl;


  //{$IFDEF IsResolve_75}
  // Disable until https://github.com/labapart/gattlib/issues/75 is resolved
 (**
  * @brief Function to retrieve RSSI from a GATT connection
  *
  * @param connection Active GATT connection
  * @param rssi is the Received Signal Strength Indicator of the remote device
  *
  * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
  *)
  gattlib_get_rssi_func = function(connection: pgatt_connection_t; rssi: PWord): Integer; cdecl;
  //{$ENDIF}
 (**
  * @brief Function to retrieve RSSI from a MAC Address
  *
  * @note: This function is mainly used before a connection is established. Once the connection
  * established, the function `gattlib_get_rssi()` should be preferred.
  *
  * @param adapter is the adapter the new device has been seen
  * @param mac_address is the MAC address of the device to get the RSSI
  * @param rssi is the Received Signal Strength Indicator of the remote device
  *
  * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
  *)
  gattlib_get_rssi_from_mac_func = function(adapter: Pointer; const mac_address: PChar; rssi: PWord): Integer;
    cdecl;

 (**
  * @brief Function to retrieve Advertisement Data from a MAC Address
  *
  * @param connection Active GATT connection
  * @param advertisement_data is an array of Service UUID and their respective data
  * @param advertisement_data_count is the number of elements in the advertisement_data array
  * @param manufacturer_id is the ID of the Manufacturer ID
  * @param manufacturer_data is the data following Manufacturer ID
  * @param manufacturer_data_size is the size of manufacturer_data
  *
  * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
  *)
  gattlib_get_advertisement_data_func = function(connection: pgatt_connection_t;
    advertisement_data: ppgattlib_advertisement_data_t; advertisement_data_count: SizeUInt;
    manufacturer_id: PWord; manufacturer_data: PPByte; manufacturer_data_size: SizeUInt): Integer; cdecl;

 (**
  * @brief Function to retrieve Advertisement Data from a MAC Address
  *
  * @param adapter is the adapter the new device has been seen
  * @param mac_address is the MAC address of the device to get the RSSI
  * @param advertisement_data is an array of Service UUID and their respective data
  * @param advertisement_data_count is the number of elements in the advertisement_data array
  * @param manufacturer_id is the ID of the Manufacturer ID
  * @param manufacturer_data is the data following Manufacturer ID
  * @param manufacturer_data_size is the size of manufacturer_data
  *
  * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
  *)
  gattlib_get_advertisement_data_from_mac_func = function(adapter: Pointer; const mac_address: PChar;
    advertisement_data: ppgattlib_advertisement_data_t; advertisement_data_count: SizeUInt;
    manufacturer_id: PWord; manufacturer_data: PPByte; manufacturer_data_size: SizeUInt): Integer; cdecl;

 (**
  * @brief Convert a UUID into a string
  *
  * @param uuid is the UUID to convert
  * @param str is the buffer that will contain the string
  * @param size is the size of the buffer
  *
  * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
  *)
  gattlib_uuid_to_string_func = function(const uuid: PGUID; str: PChar; size: SizeUInt): Integer; cdecl;

 (**
  * @brief Convert a string representing a UUID into a UUID structure
  *
  * @param str is the buffer containing the string
  * @param size is the size of the buffer
  * @param uuid is the UUID structure that would receive the UUID
  *
  * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
  *)
  gattlib_string_to_uuid_func = function(str: PChar; size: SizeUInt; uuid: PGUID): Integer; cdecl;

 (**
  * @brief Compare two UUIDs
  *
  * @param uuid1 is the one of the UUID to compare with
  * @param uuid2 is the other UUID to compare with
  *
  * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
  *)
  gattlib_uuid_cmp_func = function(const uuid1: PGUID; const uuid2: PGUID): Integer; cdecl;


var
  gattlib_adapter_open: gattlib_adapter_open_func;

  gattlib_adapter_scan_enable: gattlib_adapter_scan_enable_func;

  gattlib_adapter_scan_enable_with_filter: gattlib_adapter_scan_enable_with_filter_func;

  gattlib_adapter_scan_eddystone: gattlib_adapter_scan_eddystone_func;

  gattlib_adapter_scan_disable: gattlib_adapter_scan_disable_func;

  gattlib_adapter_close: gattlib_adapter_close_func;

  gattlib_connect: gattlib_connect_func;

  gattlib_connect_async: gattlib_connect_async_func;

  gattlib_disconnect: gattlib_disconnect_func;

  gattlib_register_on_disconnect: gattlib_register_on_disconnect_func;


  gattlib_discover_primary: gattlib_discover_primary_func;

  gattlib_discover_char_range: gattlib_discover_char_range_func;

  gattlib_discover_char: gattlib_discover_char_func;

  gattlib_discover_desc_range: gattlib_discover_desc_range_func;

  gattlib_discover_desc: gattlib_discover_desc_func;

  gattlib_read_char_by_uuid: gattlib_read_char_by_uuid_func;

  gattlib_read_char_by_uuid_async: gattlib_read_char_by_uuid_async_func;

  gattlib_write_char_by_uuid: gattlib_write_char_by_uuid_func;

  gattlib_write_char_by_handle: gattlib_write_char_by_handle_func;

  gattlib_write_without_response_char_by_uuid: gattlib_write_without_response_char_by_uuid_func;

  gattlib_write_char_by_uuid_stream_open: gattlib_write_char_by_uuid_stream_open_func;

  gattlib_write_char_stream_write: gattlib_write_char_stream_write_func;

  gattlib_write_char_stream_close: gattlib_write_char_stream_close_func;

  gattlib_write_without_response_char_by_handle: gattlib_write_without_response_char_by_handle_func;

  gattlib_notification_start: gattlib_notification_start_func;

  gattlib_notification_stop: gattlib_notification_stop_func;

  gattlib_register_notification: gattlib_register_notification_func;

  gattlib_register_indication: gattlib_register_indication_func;


  {$IFDEF IsResolve_75}
  // Disable until https://github.com/labapart/gattlib/issues/75 is resolved
  gattlib_get_rssi: gattlib_get_rssi_func;
  {$ENDIF}
  gattlib_get_rssi_from_mac: gattlib_get_rssi_from_mac_func;

  gattlib_get_advertisement_data: gattlib_get_advertisement_data_func;

  gattlib_get_advertisement_data_from_mac: gattlib_get_advertisement_data_from_mac_func;

  gattlib_uuid_to_string: gattlib_uuid_to_string_func;

  gattlib_string_to_uuid: gattlib_string_to_uuid_func;

  gattlib_uuid_cmp: gattlib_uuid_cmp_func;

function LoadLibrary: Boolean;
procedure UnloadLibrary;
function LibraryLoaded: Boolean;

implementation

var
  LibGattLibHandle: TLibHandle;

function IsAssigned(const AArgs: array of const): Boolean;
var
  i: Integer;
begin
  i := Length(AArgs);
  while (i >= 0) and (AArgs[i].VPointer <> nil) do
    Dec(i);
  Result := i = -1;
end;

function LibraryLoaded: Boolean;
begin
  Result := LibGattLibHandle <> 0;
end;

function LoadLibrary: Boolean;
begin
  if LibraryLoaded then
    Result := True
  else
  begin
    Result := False;
    LibGattLibHandle := System.LoadLibrary(GattLibName);
    if not LibraryLoaded then
    begin
      WriteLn(GetLoadErrorStr);
      LibGattLibHandle := System.LoadLibrary(GattLibName1);
    end;
    if not LibraryLoaded then
    begin
      WriteLn(GetLoadErrorStr);
      Exit;
    end;
    if not LibraryLoaded then
      Exit;
    Pointer(gattlib_adapter_open) := GetProcAddress(LibGattLibHandle, 'gattlib_adapter_open');
    Pointer(gattlib_adapter_scan_enable) := GetProcAddress(LibGattLibHandle, 'gattlib_adapter_scan_enable');
    Pointer(gattlib_adapter_scan_enable_with_filter) :=
      GetProcAddress(LibGattLibHandle, 'gattlib_adapter_scan_enable_with_filter');
    Pointer(gattlib_adapter_scan_eddystone) := GetProcAddress(LibGattLibHandle, 'gattlib_adapter_scan_eddystone');
    Pointer(gattlib_adapter_scan_disable) := GetProcAddress(LibGattLibHandle, 'gattlib_adapter_scan_disable');
    Pointer(gattlib_adapter_close) := GetProcAddress(LibGattLibHandle, 'gattlib_adapter_close');
    Pointer(gattlib_connect) := GetProcAddress(LibGattLibHandle, 'gattlib_connect');
    Pointer(gattlib_connect_async) := GetProcAddress(LibGattLibHandle, 'gattlib_connect_async');
    Pointer(gattlib_disconnect) := GetProcAddress(LibGattLibHandle, 'gattlib_disconnect');
    Pointer(gattlib_register_on_disconnect) := GetProcAddress(LibGattLibHandle, 'gattlib_register_on_disconnect');
    Pointer(gattlib_discover_primary) := GetProcAddress(LibGattLibHandle, 'gattlib_discover_primary');
    Pointer(gattlib_discover_char_range) := GetProcAddress(LibGattLibHandle, 'gattlib_discover_char_range');
    Pointer(gattlib_discover_char) := GetProcAddress(LibGattLibHandle, 'gattlib_discover_char');
    Pointer(gattlib_discover_desc_range) := GetProcAddress(LibGattLibHandle, 'gattlib_discover_desc_range');
    Pointer(gattlib_discover_desc) := GetProcAddress(LibGattLibHandle, 'gattlib_discover_desc');
    Pointer(gattlib_read_char_by_uuid) := GetProcAddress(LibGattLibHandle, 'gattlib_read_char_by_uuid');
    Pointer(gattlib_read_char_by_uuid_async) := GetProcAddress(LibGattLibHandle, 'gattlib_read_char_by_uuid_async');
    Pointer(gattlib_write_char_by_uuid) := GetProcAddress(LibGattLibHandle, 'gattlib_write_char_by_uuid');
    Pointer(gattlib_write_char_by_handle) := GetProcAddress(LibGattLibHandle, 'gattlib_write_char_by_handle');
    Pointer(gattlib_write_without_response_char_by_uuid) :=
      GetProcAddress(LibGattLibHandle, 'gattlib_write_without_response_char_by_uuid');
    Pointer(gattlib_write_char_by_uuid_stream_open) :=
      GetProcAddress(LibGattLibHandle, 'gattlib_write_char_by_uuid_stream_open');
    Pointer(gattlib_write_char_stream_write) := GetProcAddress(LibGattLibHandle, 'gattlib_write_char_stream_write');
    Pointer(gattlib_write_char_stream_close) := GetProcAddress(LibGattLibHandle, 'gattlib_write_char_stream_close');
    Pointer(gattlib_write_without_response_char_by_handle) :=
      GetProcAddress(LibGattLibHandle, 'gattlib_write_without_response_char_by_handle');
    Pointer(gattlib_notification_start) := GetProcAddress(LibGattLibHandle, 'gattlib_notification_start');
    Pointer(gattlib_notification_stop) := GetProcAddress(LibGattLibHandle, 'gattlib_notification_stop');
    Pointer(gattlib_register_notification) := GetProcAddress(LibGattLibHandle, 'gattlib_register_notification');
    Pointer(gattlib_register_indication) := GetProcAddress(LibGattLibHandle, 'gattlib_register_indication');
  {$IFDEF IsResolve_75}
    Pointer(gattlib_get_rssi) := GetProcAddress(LibGattLibHandle, 'gattlib_get_rssi');
  {$ENDIF}
    Pointer(gattlib_get_rssi_from_mac) := GetProcAddress(LibGattLibHandle, 'gattlib_get_rssi_from_mac');
    Pointer(gattlib_get_advertisement_data) := GetProcAddress(LibGattLibHandle, 'gattlib_get_advertisement_data');
    Pointer(gattlib_get_advertisement_data_from_mac) :=
      GetProcAddress(LibGattLibHandle, 'gattlib_get_advertisement_data_from_mac');
    Pointer(gattlib_uuid_to_string) := GetProcAddress(LibGattLibHandle, 'gattlib_uuid_to_string');
    Pointer(gattlib_string_to_uuid) := GetProcAddress(LibGattLibHandle, 'gattlib_string_to_uuid');
    Pointer(gattlib_uuid_cmp) := GetProcAddress(LibGattLibHandle, 'gattlib_uuid_cmp');
    Result := IsAssigned([gattlib_adapter_open, gattlib_adapter_scan_enable,
      gattlib_adapter_scan_enable_with_filter, gattlib_adapter_scan_eddystone, gattlib_adapter_scan_disable,
      gattlib_adapter_close, gattlib_connect, gattlib_connect_async, gattlib_disconnect,
      gattlib_register_on_disconnect, gattlib_discover_primary, gattlib_discover_char_range,
      gattlib_discover_char, gattlib_discover_desc_range, gattlib_discover_desc,
      gattlib_read_char_by_uuid, gattlib_read_char_by_uuid_async, gattlib_write_char_by_uuid,
      gattlib_write_char_by_handle, gattlib_write_without_response_char_by_uuid,
      gattlib_write_char_by_uuid_stream_open, gattlib_write_char_stream_write,
      gattlib_write_char_stream_close, gattlib_write_without_response_char_by_handle,
      gattlib_notification_start, gattlib_notification_stop, gattlib_register_notification,
      gattlib_register_indication,
    {$IFDEF IsResolve_75}
      gattlib_get_rssi,
    {$ENDIF}
      gattlib_get_rssi_from_mac, gattlib_get_advertisement_data, gattlib_get_advertisement_data_from_mac,
      gattlib_uuid_to_string, gattlib_string_to_uuid, gattlib_uuid_cmp]);
  end;
end;

procedure UnloadLibrary;
begin
  gattlib_adapter_open := nil;
  gattlib_adapter_scan_enable := nil;
  gattlib_adapter_scan_enable_with_filter := nil;
  gattlib_adapter_scan_eddystone := nil;
  gattlib_adapter_scan_disable := nil;
  gattlib_adapter_close := nil;
  gattlib_connect := nil;
  gattlib_connect_async := nil;
  gattlib_disconnect := nil;
  gattlib_register_on_disconnect := nil;
  gattlib_discover_primary := nil;
  gattlib_discover_char_range := nil;
  gattlib_discover_char := nil;
  gattlib_discover_desc_range := nil;
  gattlib_discover_desc := nil;
  gattlib_read_char_by_uuid := nil;
  gattlib_read_char_by_uuid_async := nil;
  gattlib_write_char_by_uuid := nil;
  gattlib_write_char_by_handle := nil;
  gattlib_write_without_response_char_by_uuid := nil;
  gattlib_write_char_by_uuid_stream_open := nil;
  gattlib_write_char_stream_write := nil;
  gattlib_write_char_stream_close := nil;
  gattlib_write_without_response_char_by_handle := nil;
  gattlib_notification_start := nil;
  gattlib_notification_stop := nil;
  gattlib_register_notification := nil;
  gattlib_register_indication := nil;
  {$IFDEF IsResolve_75}
  gattlib_get_rssi := nil;
  {$ENDIF}
  gattlib_get_rssi_from_mac := nil;
  gattlib_get_advertisement_data := nil;
  gattlib_get_advertisement_data_from_mac := nil;
  gattlib_uuid_to_string := nil;
  gattlib_string_to_uuid := nil;
  gattlib_uuid_cmp := nil;
  System.UnloadLibrary(LibGattLibHandle);
end;

function GATTLIB_CONNECTION_OPTIONS_LEGACY_PSM(const Value: Word): Cardinal;
begin
  Result := (Value and $3FF) shl 11;
end;

function GATTLIB_CONNECTION_OPTIONS_LEGACY_MTU(const Value: Word): Cardinal;
begin
  Result := (Value and $3FF) shl 21;
end;

function GATTLIB_CONNECTION_OPTIONS_LEGACY_GET_PSM(const Option: Cardinal): Word;
begin
  Result := (Option shr 11) and $3FF;
end;

function GATTLIB_CONNECTION_OPTIONS_LEGACY_GET_MTU(const Option: Cardinal): Word;
begin
  Result := (Option shr 21) and $3FF;
end;

end.
