--
-- SPDX-FileCopyrightText: Copyright (c) 2019, 2022 Andreas Sandberg <andreas@sandberg.uk>
--
-- SPDX-License-Identifier: BSD-3-Clause
--

local nixio = require "nixio"

m = Map("gosolis", translate("GoSolis"),
        translate("GoSolis configuration"))

local hostname = luci.model.uci.cursor():get_first("system", "system", "hostname")

local function time_validate(self, value)
   local time, unit = value:match("^(%d+%.%d+)(%a+)$")
   if time == nil then
      time, unit = value:match("^(%d+)(%a+)$")
   end
   if time == nil then
      return nil
   end

   if unit == "s" or unit == "ms" or unit == "h" then
      return value
   else
      return nil
   end
end

local function glob_values(opt, glob)
   for port in nixio.fs.glob(glob) do
      opt:value(port)
   end
end

--
-- Global configuration
--

global = m:section(TypedSection, "global",
                   translate("Global Parameters"))
global.anonymous=true

o = global:option(Value, "port", translate("Serial Port"),
                  translate("Specifies the serial port connected to the RS485 bus"))
o.datatype = "device"
glob_values(o, "/dev/ttyUSB*")
glob_values(o, "/dev/ttyACM*")
glob_values(o, "/dev/ttyS*")

o = global:option(Value, "baud", translate("Baud Rate"),
                     translate("Baud rate of the RS485 bus"))
o.default = 9600
o.datatype = "uinteger"

o = global:option(Value, "addr", translate("Inverter address"),
                  translate("Inverter address"))
o.default = 1
o.datatype = "uinteger"


o = global:option(Value, "timeout", translate("Inverter timeout"),
                        translate("Inverter timeout"))
o.default = "200ms"
o.validate = time_validate

o = global:option(Value, "interval", translate("Sampling interval"),
                  translate("Sampling interval"))
o.default = "10s"
o.validate = time_validate

--
-- Messaging services
--
msg = m:section(TypedSection, "messaging",
                   translate("Messaging Services"))
msg.addremove=true

o = msg:option(ListValue, "type", translate("Message Bus Type"))
o:value("mqtt", "MQTT")
o.default = "mqtt"

--
-- Messaging: MQTT
--
o = msg:option(Value, "client_id", translate("MQTT Client ID"))
o:depends("type", "mqtt")
o.default = hostname

o = msg:option(Value, "url", translate("MQTT Server URL"))
o:depends("type", "mqtt")
o.default = "tcp://localhost:1883"

o = msg:option(FileUpload, "ca_cert", translate("server CA file (PEM)"))
o:depends("type", "mqtt")
o = msg:option(FileUpload, "auth_cert", translate("client certificate file (PEM)"))
o:depends("type", "mqtt")
o = msg:option(FileUpload, "auth_key", translate("client private key file (PEM)"))
o:depends("type", "mqtt")

o = msg:option(Value, "topic", translate("MQTT Topic"))
o:depends("type", "mqtt")
o.default = "test/inverter"

o = msg:option(ListValue, "format", translate("MQTT Message Format"))
o:depends("type", "mqtt")
o:value("json", "JSON")
o:value("value", "Value")
o:value("time-value", "UNIX time + value")
o.default = "json"


return m
