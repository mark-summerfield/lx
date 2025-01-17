#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

local List = require("list")
local Map = require("map")
local Set = require("set")
local tx = require("tx")
local check, report = require("check").checker()
local SHOWTIMES = false

-- Set usage
local even = Set(2, 4, 6, 8)
check(not even:isempty())
check("{2 4 6 8}" == even:tostring(true), even)
check(#even == 4, 4)
check(even:len() == 4, 4)
local odd = Set(1, 3, 5, 7, 9)
check(not odd:isempty())
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
check(e2:isempty())
check("{}" == e2:tostring(true), e2)
e2 = Set(1, 2, 3, 4, 5)
check(not e2:isempty())
check("{1 2 3 4 5}" == e2:tostring(true), e2)
e2 = tx.clone(even)
check(not e2:isempty())
check("{10 2 4 6 8}" == e2:tostring(true), e2)
check(#e2 == 5, 5)
check(e2 == even, true)
check(e2 ~= odd, true)
check(not e2:isempty())
e2:clear()
check(e2:isempty())
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
check(a:tostring(true) == "{«a» «b» «c» «d» «e» «f»}")
while true do
    local element = a:random_value()
    seen[element] = seen[element] + 1
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
check("a b c d e f" == table.concat(a:values(true), " "))
strs = {}
for x in d:iter(true) do
    table.insert(strs, tostring(x))
end
check("2 4 6 8 10" == table.concat(strs, " "))
check(a:typeof() == "Set")
check(a.typeof() == "Set")

-- List usage
a = List()
check(a:isempty())
check(tostring(a) == "[]")
b = List(12, 6, 1, 0, 1, 2, 4, 8, 16)
check(not b:isempty())
check(tostring(b) == "[12 6 1 0 1 2 4 8 16]")
c = List("a", "b", "c or d")
check(tostring(c) == "[«a» «b» «c or d»]")
check(a:typeof() == "List")
check(#a == 0, a)
check(a:isempty())
check(#b == 9, b)
check(#c == 3, c)
check(a:at(6) == nil)
check(b:at(6) == 2)
check(c:at(3) == "c or d")
a:append(6, 88)
check(not a:isempty())
b:set(6, 14)
c:set(3, "c")
check(a:at(2) == 88)
check(#a == 2, a)
check(a:at(20) == nil)
check(b:at(6) == 14)
check(c:at(3) == "c")
check(b:find(1) == 3)
check(b:rfind(1) == 5)
check(b:find(8) == 8)
check(b:find(18) == nil)
check(c:find("c") == 3)
check(c:find("b") == 2)
check(c:rfind("b") == 2)
check(c:contains("b"))
check(not c:contains("x"))
check(b:contains(16))
check(not b:contains(999))
b:sort()
check(b:find(1) == 2)
check(b:rfind(1) == 3)
check(b:find(8) == 6)
check(b:find(18) == nil)
local function hitolo(x, y)
    return x > y
end
b:sort(hitolo)
check(b:find(1) == 7)
check(b:rfind(1) == 8)
check(b:find(8) == 4)
check(b:find(18) == nil)
b:append(7, 19, 4)
b:sort()
check(tostring(b) == "[0 1 1 4 4 6 7 8 12 14 16 19]")
local x = b:pop()
check(x == 19)
check(tostring(b) == "[0 1 1 4 4 6 7 8 12 14 16]")
x = b:remove(99)
check(x == nil)
check(tostring(b) == "[0 1 1 4 4 6 7 8 12 14 16]")
x = b:remove(5)
check(x == 4)
check(tostring(b) == "[0 1 1 4 6 7 8 12 14 16]")
d = tx.clone(b)
check(tostring(d) == "[0 1 1 4 6 7 8 12 14 16]")
check(b == d)
d:append(17)
check(b ~= d)
check(tostring(d) == "[0 1 1 4 6 7 8 12 14 16 17]")
b:insert(1, 11)
b:insert(3, 33)
b:insert(6, 66)
check(tostring(b) == "[11 0 33 1 1 66 4 6 7 8 12 14 16]")
check(b:first() == 11)
check(b:last() == 16)
b:sort()
check(tostring(b) == "[0 1 1 4 6 7 8 11 12 14 16 33 66]")
check(b:first() == 0)
check(b:last() == 66)
check(tostring(c) == "[«a» «b» «c»]")
check(c:first() == "a")
check(c:last() == "c")
check(#c == 3)
check(not c:isempty())
c:clear()
check(c:isempty())
check(c:first() == nil)
check(c:last() == nil)
check(tostring(c) == "[]")
check(#c == 0)
c = List("a", "b", "c", "d")
check(c:first() == "a")
check(c:last() == "d")
check(#c == 4)
seen = {}
local s = Set()
local values = c:values()
for _, v in ipairs(values) do
    s:add(v)
    seen[v] = 0
end
check(s:tostring(true) == "{«a» «b» «c» «d»}")
while true do
    local r = c:random_value()
    seen[r] = seen[r] + 1
    local done = true
    for _, value in pairs(seen) do
        if value == 0 then done = false end
    end
    if done then break end
end
local e = List()
for i = 1, 10000 do
    e:append(i)
end
f = 0
local t = os.clock()
values = e:values()
for _, v in ipairs(values) do
    f = f + v
end
if SHOWTIMES then print(f, os.clock() - t) end
f = 0
t = os.clock()
for v in e:iter() do
    f = f + v
end
if SHOWTIMES then print(f, os.clock() - t) end

-- Map usage
local m1 = Map()
check(m1:typeof() == "Map")
check(tostring(m1) == "{}")
check(m1:isempty())
m1:set("C or D", 4)
check(not m1:isempty())
check(tostring(m1) == "{«C or D»=4}")
m1:set("B", 2)
m1:set("A", 1)
check(m1:tostring(true) == "{«A»=1 «B»=2 «C or D»=4}")
check(m1:get("G") == nil)
check(m1:get("B") == 2)
check(m1:get("A") == 1)
m1:set("G", 8)
m1:set("A", -1)
check(m1:get("e") == nil)
check(m1:get("G") == 8)
check(m1:get("A") == -1)
check(m1:remove("X") == nil)
check(m1:remove("A") == -1)
local m2 = tx.clone(m1)
check(m2 == m1)
check(not m2:isempty())
check(m2:tostring(true) == "{«B»=2 «C or D»=4 «G»=8}")
check(m1:tostring(true) == "{«B»=2 «C or D»=4 «G»=8}")
m1:set("M", "gloop")
m1:set("H", 55)
m1:set("B", -5)
m2:set("M", "hairy")
m2:set("H", 11)
m2:set("C or D", 9.5)
check(
    m1:tostring(true)
        == "{«B»=-5 «C or D»=4 «G»=8 «H»=55 «M»=«gloop»}"
)
check(
    m2:tostring(true)
        == "{«B»=2 «C or D»=9.5 «G»=8 «H»=11 «M»=«hairy»}"
)
local m3 = Map()
check(m3:isempty())
m3:set("B", 999)
check(not m3:isempty())
m3:set("H", -11)
m3:set("J", 707)
m3:set("N", 808)
check(m3:tostring(true) == "{«B»=999 «H»=-11 «J»=707 «N»=808}")
m3:update(m2)
check(
    m3:tostring(true)
        == "{«B»=2 «C or D»=9.5 «G»=8 «H»=11 «J»=707 «M»=«hairy» «N»=808}"
)
check(not m3:isempty())
m3:clear()
check(m3:isempty())
local keys = m2:keys(true)
check(table.concat(keys, "|") == "B|C or D|G|H|M")
values = m2:values(true)
check(table.concat(values, "|") == "2|9.5|8|11|hairy")
local m4 = Map()
check(m4 ~= m2)
for key, value in m2:iter() do
    m4:set(key, value)
end
check(m4 == m2)

-- End
report("tx")
