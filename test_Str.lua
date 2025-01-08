#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

require("Str")
local check = require("check").check
local ok = require("check").get_ok
local total = require("check").get_total

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
check("this and that" == t:clean())
t = "AbcdE"
check("A" == t:at(1))
check("b" == t:at(2))
check("c" == t:at(3))
check("d" == t:at(4))
check("E" == t:at(5))
check("A" == t:at(-5))
check("b" == t:at(-4))
check("c" == t:at(-3))
check("d" == t:at(-2))
check("E" == t:at(-1))

local message = "OK"
if ok() ~= total() then message = "FAIL" end
io.write("Str ", ok(), "/", total(), " ", message, "\n")
