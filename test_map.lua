#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

local Map = require("map")
local tx = require("tx")
local check, report = require("check").checker()

local m1 = Map()
check(m1:typeof() == "Map")
check(tostring(m1) == "{}")
check(m1:isempty())
m1:set("C or D", 4)
check(not m1:isempty())
check(tostring(m1) == '{"C or D"=4}')
m1:set("B", 2)
m1:set("A", 1)
check(m1:tostring(true) == '{"A"=1 "B"=2 "C or D"=4}')
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
check(m2:tostring(true) == '{"B"=2 "C or D"=4 "G"=8}')
check(m1:tostring(true) == '{"B"=2 "C or D"=4 "G"=8}')
m1:set("M", "gloop")
m1:set("H", 55)
m1:set("B", -5)
m2:set("M", "hairy")
m2:set("H", 11)
m2:set("C or D", 9.5)
check(m1:tostring(true) == '{"B"=-5 "C or D"=4 "G"=8 "H"=55 "M"="gloop"}')
check(m2:tostring(true) == '{"B"=2 "C or D"=9.5 "G"=8 "H"=11 "M"="hairy"}')
local m3 = Map()
check(m3:isempty())
m3:set("B", 999)
check(not m3:isempty())
m3:set("H", -11)
m3:set("J", 707)
m3:set("N", 808)
check(m3:tostring(true) == '{"B"=999 "H"=-11 "J"=707 "N"=808}')
m3:update(m2)
check(
    m3:tostring(true)
        == '{"B"=2 "C or D"=9.5 "G"=8 "H"=11 "J"=707 "M"="hairy" "N"=808}'
)
check(not m3:isempty())
m3:clear()
check(m3:isempty())
local keys = m2:keys(true)
check(table.concat(keys, "|") == "B|C or D|G|H|M")
local values = m2:values(true)
check(table.concat(values, "|") == "2|9.5|8|11|hairy")
local m4 = Map()
check(m4 ~= m2)
for key, value in m2:iter() do
    m4:set(key, value)
end
check(m4 == m2)

report("Map")
