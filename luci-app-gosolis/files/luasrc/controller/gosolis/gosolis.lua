--
-- SPDX-FileCopyrightText: Copyright (c) 2019 Andreas Sandberg <andreas@sandberg.uk>
--
-- SPDX-License-Identifier: BSD-3-Clause
--

module("luci.controller.gosolis.gosolis",package.seeall)

function index()
	if not nixio.fs.access("/etc/config/gosolis") then
		return
	end

        entry({"admin","gosolis"}, cbi("gosolis/gosolis"),_("GoSolis"),99).index=true
end
