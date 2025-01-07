#!/usr/bin/env lua

local Tbl = require("Tbl")

local ok = 0
local total = 0

local function check(expr, msg)
    total = total + 1
    if expr then
        ok = ok + 1
    else
        error("FAIL " .. tostring(msg), 2)
    end
end

local t1 = { a = 1, b = 2, c = 3, d = 4, e = 5 }
check("{a=1, b=2, c=3, d=4, e=5}" == Tbl.tostring(t1), Tbl.tostring(t1))
local t2 = Tbl.deepcopy(t1)
check("{a=1, b=2, c=3, d=4, e=5}" == Tbl.tostring(t2), Tbl.tostring(t2))
check(t1 ~= t2)
check('"a" "b" "c" "d" "e"', Tbl.keystrings(t1))
check('"1" "2" "3" "4" "5"', Tbl.valuestrings(t1))
-- NOTE deepequal is not reliable
check(Tbl.deepequal(Tbl.keys(t1), Tbl.keys(t2)))
check(Tbl.deepequal(Tbl.values(t1), Tbl.values(t2)))
local seen = { a = 0, b = 0, c = 0, d = 0, e = 0 }
while true do
    local key = Tbl.random_key(t1)
    seen[key] = seen[key] + 1
    local done = true
    for _, value in pairs(seen) do
        if value == 0 then done = false end
    end
    if done then break end
end

-- Report
local message = "OK"
if ok ~= total then message = "FAIL" end
io.write("Tbl ", ok, "/", total, " ", message, "\n")
