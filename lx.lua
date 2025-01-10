#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

local HOME <const> = os.getenv("HOME") .. "/"
local ROCKS_PATH = HOME .. "opt/luarocks/share/lua/5.4/?.lua"
package.path = package.path .. ";" .. ROCKS_PATH
local ROCKS_SO_PATH = HOME .. "opt/luarocks/lib/lua/5.4/?.so"
package.cpath = package.cpath .. ";" .. ROCKS_SO_PATH

local function dumptbl(tbl, name)
    if name then io.write(name, ": ") end
    local sep = "{"
    for key, value in pairs(tbl) do
        io.write(sep, key, "=", value)
        sep = ", "
    end
    io.write("}\n")
end

local function timeit(func)
    local t = os.clock()
    func()
    return os.clock() - t
end

return { dumptbl = dumptbl, timeit = timeit }
