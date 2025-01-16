#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

local List = require("list")
local Lx = require("lx")
local Set = require("set")
local check, report = require("check").checker()

local a = List()
check(Lx.typeof(a) == "List")
local b = Set()
check(Lx.typeof(b) == "Set")
-- todo c = Map()
local d = {}
check(Lx.typeof(d) == "table")
check(Lx.typeof("") == "string")
check(Lx.typeof(0) == "integer")
check(Lx.typeof(0.0) == "float")

report("Lx")
