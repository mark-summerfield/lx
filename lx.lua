#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

local Lx = {}

function Lx.fprintf(file, fmt, ...)
    file:write(string.format(fmt, ...))
end

function Lx.printf(fmt, ...)
    Lx.fprintf(io.stdout, fmt, ...)
end

function Lx.typeof(x)
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
        local t = Lx.typeof(value)
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

local function clone(orig, copies_) -- call with ONE table only!
    copies_ = copies_ or {}
    local orig_type = type(orig)
    local copy
    if orig_type == "table" then
        if copies_[orig] then
            copy = copies_[orig]
        else
            copy = {}
            copies_[orig] = copy
            for orig_key, orig_value in next, orig, nil do
                copy[clone(orig_key, copies_)] =
                    clone(orig_value, copies_)
            end
            setmetatable(copy, clone(getmetatable(orig), copies_))
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function Lx.clone(tbl)
    return clone(tbl)
end

return Lx
