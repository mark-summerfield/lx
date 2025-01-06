#!/usr/bin/env lua

local Tbl = {}

-- doesn't work with recursive tables
function Tbl.deepcopy(old_tbl)
    local old_tbl_type = type(old_tbl)
    local new_tbl
    if old_tbl_type == "table" then
        new_tbl = {}
        for old_tbl_key, old_tbl_value in next, old_tbl, nil do
            new_tbl[Tbl.deepcopy(old_tbl_key)] = Tbl.deepcopy(old_tbl_value)
        end
        setmetatable(new_tbl, Tbl.deepcopy(getmetatable(old_tbl)))
    else -- number, string, boolean, etc
        new_tbl = old_tbl
    end
    return new_tbl
end

function Tbl.keys(tbl)
    local list = {}
    for key in pairs(tbl) do
        table.insert(list, key)
    end
    return list
end

function Tbl.values(tbl)
    local list = {}
    for _, value in pairs(tbl) do
        table.insert(list, value)
    end
    return list
end

return Tbl
