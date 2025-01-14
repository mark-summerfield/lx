#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

-- ***** to use add these lines *****
-- local HOME <const> = os.getenv("HOME") .. "/"
-- package.path = package.path .. ";" .. HOME .. "app/lua/?.lua"
-- -or-
-- package.path = package.path .. ";" .. os.getenv("HOME")
--      .. "/app/lua/?.lua"
-- require("lx.rocks") -- for luarocks paths
-- local pl = require("pl.import_into")()

local HOME <const> = os.getenv("HOME") .. "/"
local ROCKS_PATH = HOME .. "opt/luarocks/share/lua/5.4/?.lua"
package.path = package.path .. ";" .. ROCKS_PATH
local ROCKS_SO_PATH = HOME .. "opt/luarocks/lib/lua/5.4/?.so"
package.cpath = package.cpath .. ";" .. ROCKS_SO_PATH
