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

function Tbl.random_key(tbl)
    local index = math.random(#tbl + 1)
    for i, key in ipairs(tbl) do
        if i == index then return key end
    end
    error("no random key found")
end

--- deeply compare two objects
function Tbl.deepequal(obj1, obj2, ignore_mt)
    if obj1 == obj2 then -- same object
        return true
    end
    local obj1_type = type(obj1)
    local obj2_type = type(obj2)
    if obj1_type ~= obj2_type then --- different type
        return false
    end
    if obj1_type ~= "table" then --- same type but not tables
        return false
    end
    if not ignore_mt then -- use metatable method
        local mt1 = getmetatable(obj1)
        if mt1 and mt1.__eq then --compare using built in method
            return obj1 == obj2
        end
    end
    for key1, value1 in pairs(obj1) do -- iterate over obj1
        local value2 = obj2[key1]
        if
            value2 == nil
            or Tbl.deepequal(value1, value2, ignore_mt) == false
        then
            return false
        end
    end
    for key2, _ in pairs(obj2) do --- check obj2 keys not in obj1
        if obj1[key2] == nil then return false end
    end
    return true
end

return Tbl
