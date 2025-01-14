#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

local List = require("list")
local Lx = require("lx")
local Set = require("set")
local check, report = require("check").checker()

local a = List()
check(Lx.type(a) == "List")
local b = Set()
check(Lx.type(b) == "Set")
-- todo c = Map()
local d = {}
check(Lx.type(d) == "table")
check(Lx.type("") == "string")
check(Lx.type(0) == "integer")
check(Lx.type(0.0) == "float")

report("Lx")
