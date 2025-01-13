#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

local Set = require("set")
local check, report = require("check").checker()

local even = Set(2, 4, 6, 8)
check("{2 4 6 8}" == even:tostring(true), even)
check(#even == 4, 4)
check(even:len() == 4, 4)
local odd = Set(1, 3, 5, 7, 9)
check("{1 3 5 7 9}" == odd:tostring(true), odd)
check(#odd == 5, 5)
check(odd:len() == 5, 5)
even:add(10)
check("{10 2 4 6 8}" == even:tostring(true), even)
check(#even == 5, 5, 6)
odd:add(11, 13)
check("{1 11 13 3 5 7 9}" == odd:tostring(true), odd)
check(#odd == 7, 7)
check(even:contains(8), true)
check(not even:contains(9), false)
check(odd:contains(1), true)
check(not odd:contains(2), false)
local e2 = Set()
check("{}" == e2:tostring(true), e2)
e2 = Set(1, 2, 3, 4, 5)
check("{1 2 3 4 5}" == e2:tostring(true), e2)
e2 = even:copy()
check("{10 2 4 6 8}" == e2:tostring(true), e2)
check(#e2 == 5, 5)
check(e2 == even, true)
check(e2 ~= odd, true)
e2:clear()
check("{}" == e2:tostring(true), e2)
check(#e2 == 0, 0)
local a = even:union(odd)
check("{1 10 11 13 2 3 4 5 6 7 8 9}" == a:tostring(true), a)
local b = even | odd
check("{1 10 11 13 2 3 4 5 6 7 8 9}" == b:tostring(true), b)
local c = a & b
check(c == a, c)
c = a:intersection(b)
check(c == a, c)
local d = Set(5, 6, 7, 8, 20, 21)
check("{20 21 5 6 7 8}" == d:tostring(true), d)
c = d | even
check("{10 2 20 21 4 5 6 7 8}" == c:tostring(true), c)
c:clear()
c = d:union(even)
check("{10 2 20 21 4 5 6 7 8}" == c:tostring(true), c)
c = d & even
check("{6 8}" == c:tostring(true), c)
c:clear()
c = d:intersection(even)
check("{6 8}" == c:tostring(true), c)
c = d | even
check("{10 2 20 21 4 5 6 7 8}" == c:tostring(true), c)
c:remove(10, 20, 21)
check("{2 4 5 6 7 8}" == c:tostring(true), c)
c:remove(5)
check("{2 4 6 7 8}" == c:tostring(true), c)
d = Set(2, 4, 6, 7, 8)
check(c == d, c)
c:remove(8)
check(c ~= d, c)
a = d:difference(even)
check("{7}" == a:tostring(true), a)
a = d:difference(odd)
check("{2 4 6 8}" == a:tostring(true), a)
a = Set(1, 2, 3, 4, 5)
b = Set(4, 5, 6, 7)
c = a:symmetric_difference(b)
check("{1 2 3 6 7}" == c:tostring(true), c)
check(not a:is_subset(b))
check(not b:is_subset(a))
check(not a:is_superset(b))
check(not b:is_superset(a))
c = a | b
c:add(8, 9, 10, 11, 13)
check("{1 10 11 13 2 3 4 5 6 7 8 9}" == c:tostring(true), c)
check(even:is_subset(c))
check(c:is_superset(even))
check(odd:is_subset(c))
check(c:is_superset(odd))
check(not c:is_disjoint(odd))
check(c:is_disjoint(Set(99)))
check(even ~= odd)
check(a ~= b)
d = Set(2, 4, 6, 8)
check(d ~= even)
d:add(10)
check(d == even)
local f = even - Set(4, 6)
check(f == Set(2, 8, 10))
f:unite(Set(1, 2, 3))
check(f == Set(1, 2, 3, 8, 10))
f = Set(2, 8, 10)
f:add(1, 2, 3)
check(f == Set(1, 2, 3, 8, 10))
local seen = { a = 0, b = 0, c = 0, d = 0, e = 0, f = 0 }
a = Set("a", "b", "c", "d", "e", "f")
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
for x in a:iter(true) do
    table.insert(strs, x)
end
check("a b c d e f" == table.concat(strs, " "))
strs = {}
for x in d:iter(true) do
    table.insert(strs, tostring(x))
end
check("2 4 6 8 10" == table.concat(strs, " "))

report("Set")
