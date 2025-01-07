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

-- Report
local message = "OK"
if ok ~= total then message = "FAIL" end
print("TODO test_Tbl.lua") -- DELETE and reinstate following line
-- io.write("Tbl ", ok, "/", total, " ", message, "\n")
