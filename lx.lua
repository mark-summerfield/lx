#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

local HOME <const> = os.getenv("HOME") .. "/"
local ROCKS_PATH = HOME .. "opt/luarocks/share/lua/5.4/?.lua"
package.path = package.path .. ";" .. ROCKS_PATH
local ROCKS_SO_PATH = HOME .. "opt/luarocks/lib/lua/5.4/?.so"
package.cpath = package.cpath .. ";" .. ROCKS_SO_PATH

local function timeit(func)
    local t = os.clock()
    func()
    return os.clock() - t
end

return { timeit = timeit }
