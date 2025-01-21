#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

local lx = require("lx")
local sx = require("sx")
local check, report = require("check").checker()

local e = "this and that"
local s = " \tthis and that\n"
local t = sx.trim(s)
check(e == t)
check(s ~= t)
check(e == sx.trim(s))
check(sx.contains(s, "and"))
check(not sx.contains(s, "the"))
check("XYis and XYat" == sx.replace(e, "th", "XY"))
check(e == sx.replace(e, "thx", "Z"))
check(sx.startswith(e, "thi"))
check(not sx.startswith(e, "thiS"))
check(sx.endswith(e, "hat"))
check(not sx.endswith(e, "Hat"))
check("thistle and that" == sx.insert(e, 5, "tle"))
check("A this and that" == sx.insert(e, 1, "A "))
t = " \tthis    and\t that\n"
check("this and that" == sx.clean(t))
t = "AbcdE"
check("A" == sx.at(t, 1))
check("b" == sx.at(t, 2))
check("c" == sx.at(t, 3))
check("d" == sx.at(t, 4))
check("E" == sx.at(t, 5))
check("A" == sx.at(t, -5))
check("b" == sx.at(t, -4))
check("c" == sx.at(t, -3))
check("d" == sx.at(t, -2))
check("E" == sx.at(t, -1))
check(sx.isin("cat", "dog", "pie", "cat"))
check(not sx.isin("cap", "dog", "pie", "cat"))
check(sx.isin("cat", { "dog", "pie", "cat" }))
check(not sx.isin("cap", { "dog", "pie", "cat" }))
local line = "    LET A=0"
check(sx.trim(line) == "LET A=0")
local a = sx.chars("One € … two!")
local b =
    { "O", "n", "e", " ", "€", " ", "…", " ", "t", "w", "o", "!" }
check(lx.dump(a) == lx.dump(b))

-- for pos, c in utf8.codes("One € … two!") do
--     print(pos, utf8.char(c))
-- end

report("sx")
