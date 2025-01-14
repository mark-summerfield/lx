#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

local Lx = {}

function Lx.fprintf(file, fmt, ...)
    file:write(string.format(fmt, ...))
end

function Lx.printf(fmt, ...)
    Lx.fprintf(io.stdout, fmt, ...)
end

function Lx.type(x)
    local t = type(x)
    if t == "table" then
        local ok, name = pcall(x.typeof)
        if ok then return name end
    elseif t == "number" then
        return math.type(x)
    end
    return t
end

function Lx.dump(tbl)
    io.write("{")
    local sep = ""
    for key, value in pairs(tbl) do
        local t = Lx.type(value)
        if t == "string" then value = "[[" .. value .. "]]" end
        Lx.printf("%s%s=%s", sep, key, value)
        sep = ", "
    end
    io.write("}\n")
end

function Lx.timeit(name, func)
    local t = os.clock()
    func()
    t = os.clock() - t
    Lx.printf("%s %9.3f sec\n", name, t)
end

return Lx
