#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

function string:contains(other)
    return self:find(other, 1, true) ~= nil
end

function string:at(pos) -- returns the ASCII char or nil if invalid pos
    return self:sub(pos, pos)
end

function string:startswith(start)
    return self:sub(1, #start) == start
end

function string:endswith(ending)
    return ending == "" or self:sub(-#ending) == ending
end

function string:insert(pos, text)
    return self:sub(1, pos - 1) .. text .. self:sub(pos)
end

function string:trim()
    return self:match("^%s*(.-)%s*$")
end

function string:trimright()
    return self:match("^(.-)%s*$")
end

function string:trimleft()
    return self:match("^%s*(.-)$")
end

function string:clean()
    return self:trim():gsub("%s+", " ")
end

function string:replace(old, new)
    local s = self
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
