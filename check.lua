#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

local ok = 0
local total = 0

local function check(expr, msg)
    total = total + 1
    if expr then
        ok = ok + 1
    else
        error('FAIL "' .. tostring(msg) .. '"', 2)
    end
end

local function get_ok()
    return ok
end

local function get_total()
    return total
end

return { check = check, get_ok = get_ok, get_total = get_total }
