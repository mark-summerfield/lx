#!/usr/bin/env lua

require("Str")

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

local e = "this and that"
local s = " \tthis and that\n"
local t = s:trim()
check(e == t)
check(s ~= t)
check(e == s:trim())
check(s:contains("and"))
check(not s:contains("the"))
check("XYis and XYat" == e:replace("th", "XY"))
check(e == e:replace("thx", "Z"))
check(e:startswith("thi"))
check(not e:startswith("thiS"))
check(e:endswith("hat"))
check(not e:endswith("Hat"))
check("thistle and that" == e:insert(5, "tle"))
check("A this and that" == e:insert(1, "A "))
t = " \tthis    and\t that\n"
check("this and that" == t:simplifywhitespace())

-- Report
local message = "OK"
if ok ~= total then message = "FAIL" end
io.write("Str ", ok, "/", total, " ", message, "\n")
