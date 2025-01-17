#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

local ux = require("ux")
local check, report = require("check").checker()

check(ux.platform() == "Linux")

report("ux")
