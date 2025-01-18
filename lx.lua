#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

local lx = {}

function lx.fprintf(file, fmt, ...) file:write(string.format(fmt, ...)) end

function lx.printf(fmt, ...) io.stdout:write(string.format(fmt, ...)) end

function lx.sprintf(fmt, ...) return string.format(fmt, ...) end

function lx.typeof(x)
    local t = type(x)
    if t == "table" then
        local ok, name = pcall(x.typeof)
        if ok then return name end
    elseif t == "number" then
        return math.type(x)
    end
    return t
end

function lx.timeit(name, func)
    local t = os.clock()
    func()
    t = os.clock() - t
    lx.printf("%s %9.3f sec\n", name, t)
end

local function maybe_quote(x)
    if type(x) == "string" then return lx.sprintf("%q", x) end
    return tostring(x)
end

local function dump_tbl(tbl, indent, done)
    done = done or {}
    indent = indent or 0
    if type(tbl) == "table" then
        local strs = {}
        for key, value in pairs(tbl) do
            table.insert(strs, string.rep(" ", indent)) -- indent it
            if type(value) == "table" and not done[value] then
                done[value] = true
                table.insert(strs, key .. " = {\n")
                table.insert(strs, dump_tbl(value, indent + 2, done))
                table.insert(strs, string.rep(" ", indent)) -- indent it
                table.insert(strs, "}\n")
            elseif "number" == type(key) then
                table.insert(strs, maybe_quote(value) .. "\n")
            else
                table.insert(
                    strs,
                    lx.sprintf(
                        "%s = %s\n",
                        maybe_quote(key),
                        maybe_quote(value)
                    )
                )
            end
        end
        return table.concat(strs)
    else
        return tbl .. "\n"
    end
end

function lx.dump(x)
    local kind = lx.typeof(x)
    if kind == "List" or kind == "Map" or kind == "Set" then
        return x:tostring(true)
    elseif kind == "table" then
        return dump_tbl(x)
    elseif kind == "string" then
        return lx.sprintf("%q", x)
    elseif kind == "nil" then
        return tostring(nil)
    end
    return tostring(x)
end

return lx
