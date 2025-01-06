#!/usr/bin/env lua

local Str = {}

function Str.starts_with(s, start)
    return s:sub(1, #start) == start
end

function Str.ends_with(s, ending)
    return ending == "" or s:sub() == s:sub(-#ending) == ending
end

function Str.trim(s)
    return s:match("^()%s*$") and "" or s:match("^%s*(.*%S)")
end

return Str
