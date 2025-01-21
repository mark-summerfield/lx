#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

local sx = {}

function sx.isin(s, ...) -- is given string or list of strings in s
    local args = type(...) == "string" and { ... } or ...
    for _, t in ipairs(args) do
        if s == t then return true end
    end
    return false
end

function sx.contains(s, t) -- does s contain t
    return s:find(t, 1, true) ~= nil
end

function sx.at(s, pos) -- returns the ASCII char or nil if invalid pos
    return s:sub(pos, pos)
end

function sx.startswith(s, t) -- does s start with t
    return s:sub(1, #t) == t
end

function sx.endswith(s, t) -- does s end with t
    return t == "" or s:sub(-#t) == t
end

function sx.insert(s, pos, t) -- insert t into s at pos
    return s:sub(1, pos - 1) .. t .. s:sub(pos)
end

function sx.trim(s) return s:match("^%s*(.-)%s*$") end

function sx.trimright(s) return s:match("^(.-)%s*$") end

function sx.trimleft(s) return s:match("^%s*(.-)$") end

function sx.clean(s) -- trim whitespace and normalize internal whitespace
    return sx.trim(s:gsub("%s+", " "))
end

function sx.replace(s, old, new)
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

function sx.chars(s)
    local chars = {}
    for _, c in utf8.codes(s) do
        table.insert(chars, utf8.char(c))
    end
    return chars
end

return sx
