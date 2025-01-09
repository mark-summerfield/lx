#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

local Fs = require("fs")
local check, report = require("check").checker()

local CWD = "/home/mark/app/lua/lx"
local cwd = Fs.cwd()
check(CWD == cwd)

report("Fs ")
