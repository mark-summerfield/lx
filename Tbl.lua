#!/usr/bin/env lua

local Tbl = {}

-- Strings

-- doesn't work with recursive tables
function Tbl.deepcopy(old)
    local old_type = type(old)
    local new
    if old_type == "table" then
        new = {}
        for old_key, old_value in next, old, nil do
            new[Tbl.deepcopy(old_key)] = Tbl.deepcopy(old_value)
        end
        setmetatable(new, Tbl.deepcopy(getmetatable(old)))
    else -- number, string, boolean, etc
        new = old
    end
    return new
end

return Tbl
