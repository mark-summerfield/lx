#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

local Str = {}

function Str.contains(s, t)
    return s:find(t, 1, true) ~= nil
end

function Str.at(s, pos) -- returns the ASCII char or nil if invalid pos
    return s:sub(pos, pos)
end

function Str.startswith(s, start)
    return s:sub(1, #start) == start
end

function Str.endswith(s, ending)
    return ending == "" or s:sub(-#ending) == ending
end

function Str.insert(s, pos, text)
    return s:sub(1, pos - 1) .. text .. s:sub(pos)
end

function Str.trim(s)
    return s:match("^%s*(.-)%s*$")
end

function Str.trimright(s)
    return s:match("^(.-)%s*$")
end

function Str.trimleft(s)
    return s:match("^%s*(.-)$")
end

function Str.clean(s)
    return Str.trim(s:gsub("%s+", " "))
end

function Str.replace(s, old, new)
    local search_start_pos = 1
    while true do
        local start_pos, end_pos = s:find(old, search_start_pos, true)
        if not start_pos then break end
        local postfix = s:sub(end_pos + 1)
        s = s:sub(1, (start_pos - 1)) .. new .. postfix
        search_start_pos = -1 * postfix:len()
    end
    return s
end

return Str
