#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

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
