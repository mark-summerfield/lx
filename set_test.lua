#!/usr/bin/env lua

Set = require("Set")
SetX = require("SetX")

local ok = 0
local total = 0

function check(x, ...)
    total = total + 1
    if x then
        ok = ok + 1
    else
        print("FAIL", ...)
    end
end

-- Set
print("---- Set -----")
even = Set(2, 4, 6, 8)
check("{2 4 6 8}" == even.tostring(), even)
check(#even == 4, 4)
odd = Set(1, 3, 5, 7, 9)
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
e2 = even.copy()
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
check("{2 4 6 8}" == even:tostring(), even)
check(#even == 4, 4)
odd = SetX:new(1, 3, 5, 7, 9)
check("{1 3 5 7 9}" == odd:tostring(), odd)
check(#odd == 5, 5)
even:add(10)
check("{10 2 4 6 8}" == even:tostring(), even)
check(#even == 5, 5)
odd:add(11, 13)
check("{1 11 13 3 5 7 9}" == odd:tostring(), odd)
check(#odd == 7, 7)
check(even:contains(8), true)
check(not even:contains(9), false)
check(odd:contains(1), true)
check(not odd:contains(2), false)
e2 = even:copy()
check(e2 == even, true)
check(e2 == odd, false)
check("{10 2 4 6 8}" == e2:tostring(), e2)
check(#e2 == 5, 5)
e2:clear()
check("{}" == e2:tostring(), e2)
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
