
unit gattlib;
interface

{
  Automatically converted by H2Pas 1.0.0 from /media/fa/FA-FLASH/projects/git/arduinouno/docs/gattlib_0.2-dev_x86_64/include/gattlib.h
  The following command line parameters were used:
    /media/fa/FA-FLASH/projects/git/arduinouno/docs/gattlib_0.2-dev_x86_64/include/gattlib.h
}

    Type
    Pchar  = ^char;
    Pgatt_connection_t  = ^gatt_connection_t;
    Pgatt_stream_t  = ^gatt_stream_t;
    Pgattlib_advertisement_data_t  = ^gattlib_advertisement_data_t;
    Pgattlib_characteristic_t  = ^gattlib_characteristic_t;
    Pgattlib_descriptor_t  = ^gattlib_descriptor_t;
    Pgattlib_primary_service_t  = ^gattlib_primary_service_t;
    Pint16_t  = ^int16_t;
    Plongint  = ^longint;
    Psize_t  = ^size_t;
    Puint16_t  = ^uint16_t;
    Puint8_t  = ^uint8_t;
    Puuid_t  = ^uuid_t;
{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


  {
   *
   *  GattLib - GATT Library
   *
   *  Copyright (C) 2016-2019 Olivier Martin <olivier@labapart.org>
   *
   *
   *  This program is free software; you can redistribute it and/or modify
   *  it under the terms of the GNU General Public License as published by
   *  the Free Software Foundation; either version 2 of the License, or
   *  (at your option) any later version.
   *
   *  This program is distributed in the hope that it will be useful,
   *  but WITHOUT ANY WARRANTY; without even the implied warranty of
   *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   *  GNU General Public License for more details.
   *
   *  You should have received a copy of the GNU General Public License
   *  along with this program; if not, write to the Free Software
   *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
   *
    }
{$ifndef __GATTLIB_H__}
{$define __GATTLIB_H__}  
{ C++ extern C conditionnal removed }
{$include <stdint.h>}
{$include <bluetooth/bluetooth.h>}
{$include <bluetooth/sdp.h>}
{$include <bluetooth/sdp_lib.h>}
{$ifndef BDADDR_BREDR}
  { GattLib note: BD Address have only been introduced into Bluez v4.100.    }
  {               Prior to this version, only BDADDR_BREDR can be supported  }
  { BD Address type  }

  const
    BDADDR_BREDR = $00;    
    BDADDR_LE_PUBLIC = $01;    
    BDADDR_LE_RANDOM = $02;    
{$endif}
{$if BLUEZ_VERSION_MAJOR == 5}

  const
    ATT_MAX_MTU = ATT_MAX_VALUE_LEN;    
{$endif}
  {*
   * @name Gattlib errors
    }
  {@ }

  const
    GATTLIB_SUCCESS = 0;    
    GATTLIB_INVALID_PARAMETER = 1;    
    GATTLIB_NOT_FOUND = 2;    
    GATTLIB_OUT_OF_MEMORY = 3;    
    GATTLIB_NOT_SUPPORTED = 4;    
    GATTLIB_DEVICE_ERROR = 5;    
    GATTLIB_ERROR_DBUS = 6;    
    GATTLIB_ERROR_BLUEZ = 7;    
    GATTLIB_ERROR_INTERNAL = 8;    
  {@ }
  {*
   * @name GATT Characteristic Properties Bitfield values
    }
  {@ }
    GATTLIB_CHARACTERISTIC_BROADCAST = $01;    
    GATTLIB_CHARACTERISTIC_READ = $02;    
    GATTLIB_CHARACTERISTIC_WRITE_WITHOUT_RESP = $04;    
    GATTLIB_CHARACTERISTIC_WRITE = $08;    
    GATTLIB_CHARACTERISTIC_NOTIFY = $10;    
    GATTLIB_CHARACTERISTIC_INDICATE = $20;    
  {@ }
  {*
   * Helper function to create UUID16 from a 16bit integer
    }
(* error 
#define CREATE_UUID16(value16) { .type=SDP_UUID16, .value.uuid16=(value16) }
in define line 81 *)
    {*
     * @name Options for gattlib_connect()
     *
     * @note Options with the prefix `GATTLIB_CONNECTION_OPTIONS_LEGACY_`
     *       is for Bluez prior to v5.42 (before Bluez) support
      }
    {@ }
      GATTLIB_CONNECTION_OPTIONS_LEGACY_BDADDR_LE_PUBLIC = 1 shl 0;      
      GATTLIB_CONNECTION_OPTIONS_LEGACY_BDADDR_LE_RANDOM = 1 shl 1;      
      GATTLIB_CONNECTION_OPTIONS_LEGACY_BT_SEC_LOW = 1 shl 2;      
      GATTLIB_CONNECTION_OPTIONS_LEGACY_BT_SEC_MEDIUM = 1 shl 3;      
      GATTLIB_CONNECTION_OPTIONS_LEGACY_BT_SEC_HIGH = 1 shl 4;      
    { was #define dname(params) para_def_expr }
    { argument types are unknown }
    { return type might be wrong }   

    function GATTLIB_CONNECTION_OPTIONS_LEGACY_PSM(value : longint) : longint;    {< We encode PSM on 10 bits (up to 1023) }

  { was #define dname(params) para_def_expr }
  { argument types are unknown }
  { return type might be wrong }   
  function GATTLIB_CONNECTION_OPTIONS_LEGACY_MTU(value : longint) : longint;  {< We encode MTU on 10 bits (up to 1023) }

  { was #define dname(params) para_def_expr }
  { argument types are unknown }
  { return type might be wrong }   
  function GATTLIB_CONNECTION_OPTIONS_LEGACY_GET_PSM(options : longint) : longint;  

  { was #define dname(params) para_def_expr }
  { argument types are unknown }
  { return type might be wrong }   
  function GATTLIB_CONNECTION_OPTIONS_LEGACY_GET_MTU(options : longint) : longint;  

(* error 
		GATTLIB_CONNECTION_OPTIONS_LEGACY_BDADDR_LE_PUBLIC | \
in define line 104 *)
    {@ }
    {*
     * @name Discover filter
      }
    {@ }
    const
      GATTLIB_DISCOVER_FILTER_USE_NONE = 0;      
      GATTLIB_DISCOVER_FILTER_USE_UUID = 1 shl 0;      
      GATTLIB_DISCOVER_FILTER_USE_RSSI = 1 shl 1;      
    {@ }
    {*
     * @name Gattlib Eddystone types
      }
    {@ }
      GATTLIB_EDDYSTONE_TYPE_UID = 1 shl 0;      
      GATTLIB_EDDYSTONE_TYPE_URL = 1 shl 1;      
      GATTLIB_EDDYSTONE_TYPE_TLM = 1 shl 2;      
      GATTLIB_EDDYSTONE_TYPE_EID = 1 shl 3;      
      GATTLIB_EDDYSTONE_LIMIT_RSSI = 1 shl 4;      
    {@ }

    type
      _gatt_connection_t = gatt_connection_t;
      _gatt_stream_t = gatt_stream_t;
    {*
     * Structure to represent a GATT Service and its data in the BLE advertisement packet
      }
    {*< UUID of the GATT Service  }
    {*< Data attached to the GATT Service  }
    {*< Length of data attached to the GATT Service  }

      gattlib_advertisement_data_t = record
          uuid : uuid_t;
          data : ^uint8_t;
          data_length : size_t;
        end;
(* Const before type ignored *)
(* Const before type ignored *)

      gattlib_event_handler_t = procedure (uuid:Puuid_t; data:Puint8_t; data_length:size_t; user_data:pointer);cdecl;
    {*
     * @brief Handler called on disconnection
     *
     * @param connection Connection that is disconnecting
     * @param user_data  Data defined when calling `gattlib_register_on_disconnect()`
      }

      gattlib_disconnection_handler_t = procedure (user_data:pointer);cdecl;
    {*
     * @brief Handler called on new discovered BLE device
     *
     * @param adapter is the adapter that has found the BLE device
     * @param addr is the MAC address of the BLE device
     * @param name is the name of BLE device if advertised
     * @param user_data  Data defined when calling `gattlib_register_on_disconnect()`
      }
(* Const before type ignored *)
(* Const before type ignored *)

      gattlib_discovered_device_t = procedure (adapter:pointer; addr:Pchar; name:Pchar; user_data:pointer);cdecl;
    {*
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
      }
(* Const before type ignored *)
(* Const before type ignored *)

      gattlib_discovered_device_with_data_t = procedure (adapter:pointer; addr:Pchar; name:Pchar; advertisement_data:Pgattlib_advertisement_data_t; advertisement_data_count:size_t; 
                    manufacturer_id:uint16_t; manufacturer_data:Puint8_t; manufacturer_data_size:size_t; user_data:pointer);cdecl;
    {*
     * @brief Handler called on asynchronous connection when connection is ready
     *
     * @param connection Connection that is disconnecting
     * @param user_data  Data defined when calling `gattlib_register_on_disconnect()`
      }

      gatt_connect_cb_t = procedure (connection:Pgatt_connection_t; user_data:pointer);cdecl;
    {*
     * @brief Callback called when GATT characteristic read value has been received
     *
     * @param buffer contains the value to read.
     * @param buffer_len Length of the read data
     *
      }
(* Const before type ignored *)

      gatt_read_cb_t = function (buffer:pointer; buffer_len:size_t):pointer;cdecl;
    {*
     * @brief Open Bluetooth adapter
     *
     * @param adapter_name    With value NULL, the default adapter will be selected.
     * @param adapter is the context of the newly opened adapter
     *
     * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
      }
(* Const before type ignored *)

    function gattlib_adapter_open(adapter_name:Pchar; adapter:Ppointer):longint;

    {*
     * @brief Enable Bluetooth scanning on a given adapter
     *
     * @param adapter is the context of the newly opened adapter
     * @param discovered_device_cb is the function callback called for each new Bluetooth device discovered
     * @param timeout defines the duration of the Bluetooth scanning
     * @param user_data is the data passed to the callback `discovered_device_cb()`
     *
     * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
      }
    function gattlib_adapter_scan_enable(adapter:pointer; discovered_device_cb:gattlib_discovered_device_t; timeout:longint; user_data:pointer):longint;

    {*
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
      }
    function gattlib_adapter_scan_enable_with_filter(adapter:pointer; uuid_list:PPuuid_t; rssi_threshold:int16_t; enabled_filters:uint32_t; discovered_device_cb:gattlib_discovered_device_t; 
               timeout:longint; user_data:pointer):longint;

    {*
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
      }
    function gattlib_adapter_scan_eddystone(adapter:pointer; rssi_threshold:int16_t; eddystone_types:uint32_t; discovered_device_cb:gattlib_discovered_device_with_data_t; timeout:longint; 
               user_data:pointer):longint;

    {*
     * @brief Disable Bluetooth scanning on a given adapter
     *
     * @param adapter is the context of the newly opened adapter
     *
     * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
      }
    function gattlib_adapter_scan_disable(adapter:pointer):longint;

    {*
     * @brief Close Bluetooth adapter context
     *
     * @param adapter is the context of the newly opened adapter
     *
     * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
      }
    function gattlib_adapter_close(adapter:pointer):longint;

    {*
     * @brief Function to connect to a BLE device
     *
     * @param src		Local Adaptater interface
     * @param dst		Remote Bluetooth address
     * @param options	Options to connect to BLE device. See `GATTLIB_CONNECTION_OPTIONS_*`
      }
(* Const before type ignored *)
(* Const before type ignored *)
    function gattlib_connect(src:Pchar; dst:Pchar; options:dword):^gatt_connection_t;

    {*
     * @brief Function to asynchronously connect to a BLE device
     *
     * @note This function is mainly used before Bluez v5.42 (prior to D-BUS support)
     *
     * @param src		Local Adaptater interface
     * @param dst		Remote Bluetooth address
     * @param options	Options to connect to BLE device. See `GATTLIB_CONNECTION_OPTIONS_*`
     * @param connect_cb is the callback to call when the connection is established
     * @param user_data is the user specific data to pass to the callback
      }
(* Const before type ignored *)
(* Const before type ignored *)
    function gattlib_connect_async(src:Pchar; dst:Pchar; options:dword; connect_cb:gatt_connect_cb_t; user_data:pointer):^gatt_connection_t;

    {*
     * @brief Function to disconnect the GATT connection
     *
     * @param connection Active GATT connection
     *
     * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
      }
    function gattlib_disconnect(connection:Pgatt_connection_t):longint;

    {*
     * @brief Function to register a callback on GATT disconnection
     *
     * @param connection Active GATT connection
     * @param handler is the callaback to invoke on disconnection
     * @param user_data is user specific data to pass to the callaback
     *
     * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
      }
    procedure gattlib_register_on_disconnect(connection:Pgatt_connection_t; handler:gattlib_disconnection_handler_t; user_data:pointer);

    {*
     * Structure to represent GATT Primary Service
      }
    {*< First attribute handle of the GATT Primary Service  }
    {*< Last attibute handle of the GATT Primary Service  }
    {*< UUID of the Primary Service  }

    type
      gattlib_primary_service_t = record
          attr_handle_start : uint16_t;
          attr_handle_end : uint16_t;
          uuid : uuid_t;
        end;
    {*
     * Structure to represent GATT Characteristic
      }
    {*< Handle of the GATT characteristic  }
    {*< Property of the GATT characteristic  }
    {*< Handle for the value of the GATT characteristic  }
    {*< UUID of the GATT characteristic  }

      gattlib_characteristic_t = record
          handle : uint16_t;
          properties : uint8_t;
          value_handle : uint16_t;
          uuid : uuid_t;
        end;
    {*
     * Structure to represent GATT Descriptor
      }
    {*< Handle of the GATT Descriptor  }
    {*< UUID16 of the GATT Descriptor  }
    {*< UUID of the GATT Descriptor  }

      gattlib_descriptor_t = record
          handle : uint16_t;
          uuid16 : uint16_t;
          uuid : uuid_t;
        end;
    {*
     * @brief Function to discover GATT Services
     *
     * @note This function can be used to force GATT services/characteristic discovery
     *
     * @param connection Active GATT connection
     * @param services array of GATT services allocated by the function. Can be NULL.
     * @param services_count Number of GATT services discovered. Can be NULL
     *
     * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
      }

    function gattlib_discover_primary(connection:Pgatt_connection_t; services:PPgattlib_primary_service_t; services_count:Plongint):longint;

    {*
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
      }
    function gattlib_discover_char_range(connection:Pgatt_connection_t; start:longint; end:longint; characteristics:PPgattlib_characteristic_t; characteristics_count:Plongint):longint;

    {*
     * @brief Function to discover GATT Characteristic
     *
     * @note This function can be used to force GATT services/characteristic discovery
     *
     * @param connection Active GATT connection
     * @param characteristics array of GATT characteristics allocated by the function. Can be NULL.
     * @param characteristics_count Number of GATT characteristics discovered. Can be NULL
     *
     * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
      }
    function gattlib_discover_char(connection:Pgatt_connection_t; characteristics:PPgattlib_characteristic_t; characteristics_count:Plongint):longint;

    {*
     * @brief Function to discover GATT Descriptors in a range of handles
     *
     * @param connection Active GATT connection
     * @param start is the index of the first handle of the range
     * @param end is the index of the last handle of the range
     * @param descriptors array of GATT descriptors allocated by the function. Can be NULL.
     * @param descriptors_count Number of GATT descriptors discovered. Can be NULL
     *
     * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
      }
    function gattlib_discover_desc_range(connection:Pgatt_connection_t; start:longint; end:longint; descriptors:PPgattlib_descriptor_t; descriptors_count:Plongint):longint;

    {*
     * @brief Function to discover GATT Descriptor
     *
     * @param connection Active GATT connection
     * @param descriptors array of GATT descriptors allocated by the function. Can be NULL.
     * @param descriptors_count Number of GATT descriptors discovered. Can be NULL
     *
     * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
      }
    function gattlib_discover_desc(connection:Pgatt_connection_t; descriptors:PPgattlib_descriptor_t; descriptors_count:Plongint):longint;

    {*
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
      }
    function gattlib_read_char_by_uuid(connection:Pgatt_connection_t; uuid:Puuid_t; buffer:Ppointer; buffer_len:Psize_t):longint;

    {*
     * @brief Function to asynchronously read GATT characteristic
     *
     * @param connection Active GATT connection
     * @param uuid UUID of the GATT characteristic to read
     * @param gatt_read_cb is the callback to read when the GATT characteristic is available
     *
     * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
      }
    function gattlib_read_char_by_uuid_async(connection:Pgatt_connection_t; uuid:Puuid_t; gatt_read_cb:gatt_read_cb_t):longint;

    {*
     * @brief Function to write to the GATT characteristic UUID
     *
     * @param connection Active GATT connection
     * @param uuid UUID of the GATT characteristic to read
     * @param buffer contains the values to write to the GATT characteristic
     * @param buffer_len is the length of the buffer to write
     *
     * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
      }
(* Const before type ignored *)
    function gattlib_write_char_by_uuid(connection:Pgatt_connection_t; uuid:Puuid_t; buffer:pointer; buffer_len:size_t):longint;

    {*
     * @brief Function to write to the GATT characteristic handle
     *
     * @param connection Active GATT connection
     * @param handle is the handle of the GATT characteristic
     * @param buffer contains the values to write to the GATT characteristic
     * @param buffer_len is the length of the buffer to write
     *
     * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
      }
(* Const before type ignored *)
    function gattlib_write_char_by_handle(connection:Pgatt_connection_t; handle:uint16_t; buffer:pointer; buffer_len:size_t):longint;

    {*
     * @brief Function to write without response to the GATT characteristic UUID
     *
     * @param connection Active GATT connection
     * @param uuid UUID of the GATT characteristic to read
     * @param buffer contains the values to write to the GATT characteristic
     * @param buffer_len is the length of the buffer to write
     *
     * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
      }
(* Const before type ignored *)
    function gattlib_write_without_response_char_by_uuid(connection:Pgatt_connection_t; uuid:Puuid_t; buffer:pointer; buffer_len:size_t):longint;

    {*
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
      }
    function gattlib_write_char_by_uuid_stream_open(connection:Pgatt_connection_t; uuid:Puuid_t; stream:PPgatt_stream_t; mtu:Puint16_t):longint;

    {*
     * @brief Write data to the stream previously created with `gattlib_write_char_by_uuid_stream_open()`
     *
     * @param stream is the object that is attached to the GATT characteristic that is used to write data to
     * @param buffer is the data to write to the stream
     * @param buffer_len is the length of the buffer to write
     *
     * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
      }
(* Const before type ignored *)
    function gattlib_write_char_stream_write(stream:Pgatt_stream_t; buffer:pointer; buffer_len:size_t):longint;

    {*
     * @brief Close the stream previously created with `gattlib_write_char_by_uuid_stream_open()`
     *
     * @param stream is the object that is attached to the GATT characteristic that is used to write data to
     *
     * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
      }
    function gattlib_write_char_stream_close(stream:Pgatt_stream_t):longint;

    {*
     * @brief Function to write without response to the GATT characteristic handle
     *
     * @param connection Active GATT connection
     * @param handle is the handle of the GATT characteristic
     * @param buffer contains the values to write to the GATT characteristic
     * @param buffer_len is the length of the buffer to write
     *
     * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
      }
(* Const before type ignored *)
    function gattlib_write_without_response_char_by_handle(connection:Pgatt_connection_t; handle:uint16_t; buffer:pointer; buffer_len:size_t):longint;

    {
     * @brief Enable notification on GATT characteristic represented by its UUID
     *
     * @param connection Active GATT connection
     * @param uuid UUID of the characteristic that will trigger the notification
     *
     * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
      }
(* Const before type ignored *)
    function gattlib_notification_start(connection:Pgatt_connection_t; uuid:Puuid_t):longint;

    {
     * @brief Disable notification on GATT characteristic represented by its UUID
     *
     * @param connection Active GATT connection
     * @param uuid UUID of the characteristic that will trigger the notification
     *
     * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
      }
(* Const before type ignored *)
    function gattlib_notification_stop(connection:Pgatt_connection_t; uuid:Puuid_t):longint;

    {
     * @brief Register a handle for the GATT notifications
     *
     * @param connection Active GATT connection
     * @param notification_handler is the handler to call on notification
     * @param user_data if the user specific data to pass to the handler
     *
     * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
      }
    procedure gattlib_register_notification(connection:Pgatt_connection_t; notification_handler:gattlib_event_handler_t; user_data:pointer);

    {
     * @brief Register a handle for the GATT indications
     *
     * @param connection Active GATT connection
     * @param notification_handler is the handler to call on indications
     * @param user_data if the user specific data to pass to the handler
     *
     * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
      }
    procedure gattlib_register_indication(connection:Pgatt_connection_t; indication_handler:gattlib_event_handler_t; user_data:pointer);

{$if 0 // Disable until https://github.com/labapart/gattlib/issues/75 is resolved}
    {*
     * @brief Function to retrieve RSSI from a GATT connection
     *
     * @param connection Active GATT connection
     * @param rssi is the Received Signal Strength Indicator of the remote device
     *
     * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
      }

    function gattlib_get_rssi(connection:Pgatt_connection_t; rssi:Pint16_t):longint;

{$endif}
    {*
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
      }
(* Const before type ignored *)

    function gattlib_get_rssi_from_mac(adapter:pointer; mac_address:Pchar; rssi:Pint16_t):longint;

    {*
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
      }
    function gattlib_get_advertisement_data(connection:Pgatt_connection_t; advertisement_data:PPgattlib_advertisement_data_t; advertisement_data_count:Psize_t; manufacturer_id:Puint16_t; manufacturer_data:PPuint8_t; 
               manufacturer_data_size:Psize_t):longint;

    {*
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
      }
(* Const before type ignored *)
    function gattlib_get_advertisement_data_from_mac(adapter:pointer; mac_address:Pchar; advertisement_data:PPgattlib_advertisement_data_t; advertisement_data_count:Psize_t; manufacturer_id:Puint16_t; 
               manufacturer_data:PPuint8_t; manufacturer_data_size:Psize_t):longint;

    {*
     * @brief Convert a UUID into a string
     *
     * @param uuid is the UUID to convert
     * @param str is the buffer that will contain the string
     * @param size is the size of the buffer
     *
     * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
      }
(* Const before type ignored *)
    function gattlib_uuid_to_string(uuid:Puuid_t; str:Pchar; size:size_t):longint;

    {*
     * @brief Convert a string representing a UUID into a UUID structure
     *
     * @param str is the buffer containing the string
     * @param size is the size of the buffer
     * @param uuid is the UUID structure that would receive the UUID
     *
     * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
      }
(* Const before type ignored *)
    function gattlib_string_to_uuid(str:Pchar; size:size_t; uuid:Puuid_t):longint;

    {*
     * @brief Compare two UUIDs
     *
     * @param uuid1 is the one of the UUID to compare with
     * @param uuid2 is the other UUID to compare with
     *
     * @return GATTLIB_SUCCESS on success or GATTLIB_* error code
      }
(* Const before type ignored *)
(* Const before type ignored *)
    function gattlib_uuid_cmp(uuid1:Puuid_t; uuid2:Puuid_t):longint;

{ C++ end of extern C conditionnal removed }
{$endif}

implementation

    { was #define dname(params) para_def_expr }
    { argument types are unknown }
    { return type might be wrong }   
    function GATTLIB_CONNECTION_OPTIONS_LEGACY_PSM(value : longint) : longint;
    begin
      GATTLIB_CONNECTION_OPTIONS_LEGACY_PSM:=(value(@($3FF))) shl 11;
    end;

  { was #define dname(params) para_def_expr }
  { argument types are unknown }
  { return type might be wrong }   
  function GATTLIB_CONNECTION_OPTIONS_LEGACY_MTU(value : longint) : longint;
  begin
    GATTLIB_CONNECTION_OPTIONS_LEGACY_MTU:=(value(@($3FF))) shl 21;
  end;

  { was #define dname(params) para_def_expr }
  { argument types are unknown }
  { return type might be wrong }   
  function GATTLIB_CONNECTION_OPTIONS_LEGACY_GET_PSM(options : longint) : longint;
  begin
    GATTLIB_CONNECTION_OPTIONS_LEGACY_GET_PSM:=(options shr 11) and (@($3FF));
  end;

  { was #define dname(params) para_def_expr }
  { argument types are unknown }
  { return type might be wrong }   
  function GATTLIB_CONNECTION_OPTIONS_LEGACY_GET_MTU(options : longint) : longint;
  begin
    GATTLIB_CONNECTION_OPTIONS_LEGACY_GET_MTU:=(options shr 21) and (@($3FF));
  end;

    function gattlib_adapter_open(adapter_name:Pchar; adapter:Ppointer):longint;
    begin
      { You must implement this function }
    end;
    function gattlib_adapter_scan_enable(adapter:pointer; discovered_device_cb:gattlib_discovered_device_t; timeout:longint; user_data:pointer):longint;
    begin
      { You must implement this function }
    end;
    function gattlib_adapter_scan_enable_with_filter(adapter:pointer; uuid_list:PPuuid_t; rssi_threshold:int16_t; enabled_filters:uint32_t; discovered_device_cb:gattlib_discovered_device_t; 
               timeout:longint; user_data:pointer):longint;
    begin
      { You must implement this function }
    end;
    function gattlib_adapter_scan_eddystone(adapter:pointer; rssi_threshold:int16_t; eddystone_types:uint32_t; discovered_device_cb:gattlib_discovered_device_with_data_t; timeout:longint; 
               user_data:pointer):longint;
    begin
      { You must implement this function }
    end;
    function gattlib_adapter_scan_disable(adapter:pointer):longint;
    begin
      { You must implement this function }
    end;
    function gattlib_adapter_close(adapter:pointer):longint;
    begin
      { You must implement this function }
    end;
    function gattlib_connect(src:Pchar; dst:Pchar; options:dword):Pgatt_connection_t;
    begin
      { You must implement this function }
    end;
    function gattlib_connect_async(src:Pchar; dst:Pchar; options:dword; connect_cb:gatt_connect_cb_t; user_data:pointer):Pgatt_connection_t;
    begin
      { You must implement this function }
    end;
    function gattlib_disconnect(connection:Pgatt_connection_t):longint;
    begin
      { You must implement this function }
    end;
    procedure gattlib_register_on_disconnect(connection:Pgatt_connection_t; handler:gattlib_disconnection_handler_t; user_data:pointer);
    begin
      { You must implement this function }
    end;
    function gattlib_discover_primary(connection:Pgatt_connection_t; services:PPgattlib_primary_service_t; services_count:Plongint):longint;
    begin
      { You must implement this function }
    end;
    function gattlib_discover_char_range(connection:Pgatt_connection_t; start:longint; end:longint; characteristics:PPgattlib_characteristic_t; characteristics_count:Plongint):longint;
    begin
      { You must implement this function }
    end;
    function gattlib_discover_char(connection:Pgatt_connection_t; characteristics:PPgattlib_characteristic_t; characteristics_count:Plongint):longint;
    begin
      { You must implement this function }
    end;
    function gattlib_discover_desc_range(connection:Pgatt_connection_t; start:longint; end:longint; descriptors:PPgattlib_descriptor_t; descriptors_count:Plongint):longint;
    begin
      { You must implement this function }
    end;
    function gattlib_discover_desc(connection:Pgatt_connection_t; descriptors:PPgattlib_descriptor_t; descriptors_count:Plongint):longint;
    begin
      { You must implement this function }
    end;
    function gattlib_read_char_by_uuid(connection:Pgatt_connection_t; uuid:Puuid_t; buffer:Ppointer; buffer_len:Psize_t):longint;
    begin
      { You must implement this function }
    end;
    function gattlib_read_char_by_uuid_async(connection:Pgatt_connection_t; uuid:Puuid_t; gatt_read_cb:gatt_read_cb_t):longint;
    begin
      { You must implement this function }
    end;
    function gattlib_write_char_by_uuid(connection:Pgatt_connection_t; uuid:Puuid_t; buffer:pointer; buffer_len:size_t):longint;
    begin
      { You must implement this function }
    end;
    function gattlib_write_char_by_handle(connection:Pgatt_connection_t; handle:uint16_t; buffer:pointer; buffer_len:size_t):longint;
    begin
      { You must implement this function }
    end;
    function gattlib_write_without_response_char_by_uuid(connection:Pgatt_connection_t; uuid:Puuid_t; buffer:pointer; buffer_len:size_t):longint;
    begin
      { You must implement this function }
    end;
    function gattlib_write_char_by_uuid_stream_open(connection:Pgatt_connection_t; uuid:Puuid_t; stream:PPgatt_stream_t; mtu:Puint16_t):longint;
    begin
      { You must implement this function }
    end;
    function gattlib_write_char_stream_write(stream:Pgatt_stream_t; buffer:pointer; buffer_len:size_t):longint;
    begin
      { You must implement this function }
    end;
    function gattlib_write_char_stream_close(stream:Pgatt_stream_t):longint;
    begin
      { You must implement this function }
    end;
    function gattlib_write_without_response_char_by_handle(connection:Pgatt_connection_t; handle:uint16_t; buffer:pointer; buffer_len:size_t):longint;
    begin
      { You must implement this function }
    end;
    function gattlib_notification_start(connection:Pgatt_connection_t; uuid:Puuid_t):longint;
    begin
      { You must implement this function }
    end;
    function gattlib_notification_stop(connection:Pgatt_connection_t; uuid:Puuid_t):longint;
    begin
      { You must implement this function }
    end;
    procedure gattlib_register_notification(connection:Pgatt_connection_t; notification_handler:gattlib_event_handler_t; user_data:pointer);
    begin
      { You must implement this function }
    end;
    procedure gattlib_register_indication(connection:Pgatt_connection_t; indication_handler:gattlib_event_handler_t; user_data:pointer);
    begin
      { You must implement this function }
    end;
    function gattlib_get_rssi(connection:Pgatt_connection_t; rssi:Pint16_t):longint;
    begin
      { You must implement this function }
    end;
    function gattlib_get_rssi_from_mac(adapter:pointer; mac_address:Pchar; rssi:Pint16_t):longint;
    begin
      { You must implement this function }
    end;
    function gattlib_get_advertisement_data(connection:Pgatt_connection_t; advertisement_data:PPgattlib_advertisement_data_t; advertisement_data_count:Psize_t; manufacturer_id:Puint16_t; manufacturer_data:PPuint8_t; 
               manufacturer_data_size:Psize_t):longint;
    begin
      { You must implement this function }
    end;
    function gattlib_get_advertisement_data_from_mac(adapter:pointer; mac_address:Pchar; advertisement_data:PPgattlib_advertisement_data_t; advertisement_data_count:Psize_t; manufacturer_id:Puint16_t; 
               manufacturer_data:PPuint8_t; manufacturer_data_size:Psize_t):longint;
    begin
      { You must implement this function }
    end;
    function gattlib_uuid_to_string(uuid:Puuid_t; str:Pchar; size:size_t):longint;
    begin
      { You must implement this function }
    end;
    function gattlib_string_to_uuid(str:Pchar; size:size_t; uuid:Puuid_t):longint;
    begin
      { You must implement this function }
    end;
    function gattlib_uuid_cmp(uuid1:Puuid_t; uuid2:Puuid_t):longint;
    begin
      { You must implement this function }
    end;

end.
