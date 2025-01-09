#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

local Str = require("str")
local check, report = require("check").checker()

local e = "this and that"
local s = " \tthis and that\n"
local t = Str.trim(s)
check(e == t)
check(s ~= t)
check(e == Str.trim(s))
check(Str.contains(s, "and"))
check(not Str.contains(s, "the"))
check("XYis and XYat" == Str.replace(e, "th", "XY"))
check(e == Str.replace(e, "thx", "Z"))
check(Str.startswith(e, "thi"))
check(not Str.startswith(e, "thiS"))
check(Str.endswith(e, "hat"))
check(not Str.endswith(e, "Hat"))
check("thistle and that" == Str.insert(e, 5, "tle"))
check("A this and that" == Str.insert(e, 1, "A "))
t = " \tthis    and\t that\n"
check("this and that" == Str.clean(t))
t = "AbcdE"
check("A" == Str.at(t, 1))
check("b" == Str.at(t, 2))
check("c" == Str.at(t, 3))
check("d" == Str.at(t, 4))
check("E" == Str.at(t, 5))
check("A" == Str.at(t, -5))
check("b" == Str.at(t, -4))
check("c" == Str.at(t, -3))
check("d" == Str.at(t, -2))
check("E" == Str.at(t, -1))

report("Str")
