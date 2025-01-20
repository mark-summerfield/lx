#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

local List = require("list")
local Set = require("set")
local tx = require("tx")
local check, report = require("check").checker()
local SHOWTIMES = false

local a = List()
check(a:isempty())
check(tostring(a) == "[]")
local b = List(12, 99, 1, 0, 1, 2, 4, 8, 16)
check(not b:isempty())
check(tostring(b) == "[12 99 1 0 1 2 4 8 16]")
check(b:at(2) == 99)
b:set(2, 6)
check(b:at(2) == 6)
check(tostring(b) == "[12 6 1 0 1 2 4 8 16]")
local c = List("a", "b", "c or d")
check(tostring(c) == '["a" "b" "c or d"]')
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
local function hitolo(x, y) return x > y end
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
local d = tx.clone(b)
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
check(tostring(c) == '["a" "b" "c"]')
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
check(c:tostring(true) == '["a" "b" "c" "d"]')
check(c:first() == "a")
check(c:last() == "d")
check(#c == 4)
c:set(4, "D E")
check(c:tostring(true) == '["a" "b" "c" "D E"]')
local seen = {}
local s = Set()
local values = c:values()
for _, v in ipairs(values) do
    s:add(v)
    seen[v] = 0
end
check(s:tostring(true) == '{"D E" "a" "b" "c"}')
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
local f = 0
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

report("List")
