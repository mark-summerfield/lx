#!/usr/bin/env lua

local Set = require("Set")

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

local even = Set:new(2, 4, 6, 8)
check("{2 4 6 8}" == even:tostring(), even)
check(#even == 4, 4)
local odd = Set:new(1, 3, 5, 7, 9)
check("{1 3 5 7 9}" == odd:tostring(), odd)
check(#odd == 5, 5)
even:add(10)
check("{10 2 4 6 8}" == even:tostring(), even)
check(#even == 5, 5, 6)
odd:add(11, 13)
check("{1 11 13 3 5 7 9}" == odd:tostring(), odd)
check(#odd == 7, 7)
check(even:contains(8), true)
check(not even:contains(9), false)
check(odd:contains(1), true)
check(not odd:contains(2), false)
local e2 = Set:new()
check("{}" == e2:tostring(), e2)
e2 = Set:new(1, 2, 3, 4, 5)
check("{1 2 3 4 5}" == e2:tostring(), e2)
e2 = even:copy()
check("{10 2 4 6 8}" == e2:tostring(), e2)
check(#e2 == 5, 5)
check(e2 == even, true)
check(e2 ~= odd, true)
e2:clear()
check("{}" == e2:tostring(), e2)
check(#e2 == 0, 0)
local a = even:union(odd)
check("{1 10 11 13 2 3 4 5 6 7 8 9}" == a:tostring(), a)
local b = even | odd
check("{1 10 11 13 2 3 4 5 6 7 8 9}" == b:tostring(), b)
local c = a & b
check(c == a, c)
c = a:intersect(b)
check(c == a, c)
local d = Set:new(5, 6, 7, 8, 20, 21)
check("{20 21 5 6 7 8}" == d:tostring(), d)
c = d | even
check("{10 2 20 21 4 5 6 7 8}" == c:tostring(), c)
c:clear()
c = d:union(even)
check("{10 2 20 21 4 5 6 7 8}" == c:tostring(), c)
c = d & even
check("{6 8}" == c:tostring(), c)
c:clear()
c = d:intersect(even)
check("{6 8}" == c:tostring(), c)
c = d | even
check("{10 2 20 21 4 5 6 7 8}" == c:tostring(), c)
c:remove(10, 20, 21)
check("{2 4 5 6 7 8}" == c:tostring(), c)
c:remove(5)
check("{2 4 6 7 8}" == c:tostring(), c)
d = Set:new(2, 4, 6, 7, 8)
check(c == d, c)
c:remove(8)
check(c ~= d, c)
a = d:difference(even)
check("{7}" == a:tostring(), a)
a = d:difference(odd)
check("{2 4 6 8}" == a:tostring(), a)
a = Set:new(1, 2, 3, 4, 5)
b = Set:new(4, 5, 6, 7)
c = a:symmetric_difference(b)
check("{1 2 3 6 7}" == c:tostring(), c)
check(not a:is_subset(b))
check(not b:is_subset(a))
check(not a:is_superset(b))
check(not b:is_superset(a))
c = a | b
c:add(8, 9, 10, 11, 13)
check("{1 10 11 13 2 3 4 5 6 7 8 9}" == c:tostring(), c)
check(even:is_subset(c))
check(c:is_superset(even))
check(odd:is_subset(c))
check(c:is_superset(odd))
check(not c:is_disjoint(odd))
check(c:is_disjoint(Set:new(99)))
check(even ~= odd)
check(a ~= b)
d = Set:new(2, 4, 6, 8)
check(d ~= even)
d:add(10)
check(d == even)
local seen = { a = 0, b = 0, c = 0, d = 0, e = 0, f = 0 }
a = Set:new("a", "b", "c", "d", "e", "f")
while true do
    local item = a:random_item()
    seen[item] = seen[item] + 1
    local done = true
    for _, value in pairs(seen) do
        if value == 0 then done = false end
    end
    if done then break end
end
local strs = {}
for x in a:iter() do
    table.insert(strs, x)
end
check("a b c d e f" == table.concat(strs, " "))
strs = {}
for x in d:iter() do
    table.insert(strs, tostring(x))
end
check("2 4 6 8 10" == table.concat(strs, " "))

-- Report
local message = "OK"
if ok ~= total then message = "FAIL" end
io.write("Set ", ok, "/", total, " ", message, "\n")
