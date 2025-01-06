#!/usr/bin/env lua

local Set = require("Set")
local SetX = require("SetX")

local ok = 0
local total = 0

local function check(x, ...)
    total = total + 1
    if x then
        ok = ok + 1
    else
        print("FAIL", ...)
    end
end

-- Set
print("---- Set -----")
local even = Set(2, 4, 6, 8)
check("{2 4 6 8}" == even.tostring(), even)
check(#even == 4, 4)
local odd = Set(1, 3, 5, 7, 9)
check("{1 3 5 7 9}" == odd.tostring(), odd)
check(#odd == 5, 5)
even.add(10)
check("{10 2 4 6 8}" == even.tostring(), even)
check(#even == 5, 5)
odd.add(11, 13)
check("{1 11 13 3 5 7 9}" == odd.tostring(), odd)
check(#odd == 7, 7)
check(even.contains(8), true)
check(not even.contains(9), false)
check(odd.contains(1), true)
check(not odd.contains(2), false)
local e2 = even.copy()
check(e2 == even, true)
check(e2 == odd, false)
check("{10 2 4 6 8}" == e2.tostring(), e2)
check(#e2 == 5, 5)
e2.clear()
check("{}" == e2.tostring(), e2)
check(#e2 == 0, 0)
-- TODO remove()
-- TODO every() all < 10 → false & all < 20 → true
-- TODO union()
-- TODO intersection()
-- TODO difference()
-- TODO symmetric_difference()
-- TODO is_superset()
-- TODO ==

-- SetX
print("---- SetX ----")
even = SetX:new(2, 4, 6, 8)
check("{2 4 6 8}" == even:__tostring(), even, 1)
check(#even == 4, 4, 2)
odd = SetX:new(1, 3, 5, 7, 9)
check("{1 3 5 7 9}" == odd:__tostring(), odd, 3)
check(#odd == 5, 5, 4)
even:add(10)
check("{10 2 4 6 8}" == even:__tostring(), even, 5)
check(#even == 5, 5, 6)
odd:add(11, 13)
check("{1 11 13 3 5 7 9}" == odd:__tostring(), odd, 7)
check(#odd == 7, 7, 8)
check(even:contains(8), true, 9)
check(not even:contains(9), false, 10)
check(odd:contains(1), true, 11)
check(not odd:contains(2), false, 12)
e2 = even:copy()
check("{10 2 4 6 8}" == e2:__tostring(), #e2, e2, e2:__tostring(), 13)
check(#e2 == 5, 5)
check(e2 == even, true, 14)
check(e2 == odd, false, 15)
e2:clear()
check("{}" == e2:__tostring(), e2)
check(#e2 == 0, 0)
-- TODO remove()
-- TODO every() all < 10 → false & all < 20 → true
-- TODO union()
-- TODO intersection()
-- TODO difference()
-- TODO symmetric_difference()
-- TODO is_superset()
-- TODO ==

-- Report
local message = "OK"
if ok ~= total then message = "FAIL" end
io.write(ok, "/", total, " ", message, "\n")
