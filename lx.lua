#!/usr/bin/env lua

local lx = {}

-- Strings

function lx.starts_with(s, start) return s:sub(1, #start) == start end

function lx.ends_with(s, ending)
    return ending == "" or s:sub() == s:sub(-#ending) == ending
end

function lx.trim(s)
    return s:match("^()%s*$") and "" or s:match("^%s*(.*%S)")
end

-- Hash Tables

-- doesn't work with recursive tables
function lx.deepcopy(old)
    local old_type = type(old)
    local new
    if old_type == "table" then
        new = {}
        for old_key, old_value in next, old, nil do
            new[lx.deepcopy(old_key)] = lx.deepcopy(old_value)
        end
        setmetatable(new, lx.deepcopy(getmetatable(old)))
    else -- number, string, boolean, etc
        new = old
    end
    return new
end

return lx
