#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

local function dump(tbl, name)
    if name then print(name) end
    for key, value in pairs(tbl) do
        print(key, "=", value)
    end
end

return { dump = dump }
