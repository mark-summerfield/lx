#!/usr/bin/env lua

-- local Tbl = require("Tbl") -- TODO reinstate

local function deepequal(obj1, obj2, ignore_mt) -- TODO delete once require is reinstated
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
            or deepequal(value1, value2, ignore_mt) == false
        then
            return false
        end
    end
    for key2, _ in pairs(obj2) do --- check obj2 keys not in obj1
        if obj1[key2] == nil then return false end
    end
    return true
end

local Set = {}

function Set:new(...)
    local set = { items_tbl = {}, size_ = 0 }
    self.__index = Set
    self.__tostring = Set.tostring
    self.__band = Set.intersect
    self.__bor = Set.union
    setmetatable(set, Set)
    set:add(...)
    return set
end

function Set:__len()
    return self.size_
end

function Set:__eq(other)
    if self.size_ ~= #other then return false end
    return deepequal(self.items_tbl, other.items_tbl)
end

function Set:add(...)
    for _, item in ipairs({ ... }) do
        if not self.items_tbl[item] then
            self.items_tbl[item] = true
            self.size_ = self.size_ + 1
        end
    end
end

function Set:contains(item)
    return self.items_tbl[item] == true
end

function Set:clear()
    self.items_tbl = {}
    self.size_ = 0
end

function Set:remove(...)
    local removed = 0
    for _, item in ipairs({ ... }) do
        if self.items_tbl[item] then
            self.items_tbl[item] = nil
            self.size_ = self.size_ - 1
            removed = removed + 1
        end
    end
    return removed
end

function Set:copy()
    local set = Set:new()
    for item in pairs(self.items_tbl) do
        set:add(item)
    end
    return set
end

function Set:union(other)
    local union = Set:new()
    for key in pairs(self.items_tbl) do
        union:add(key)
    end
    for key in pairs(other.items_tbl) do
        union:add(key)
    end
    return union
end

function Set:intersect(other)
    local intersection = Set:new()
    for key in pairs(self.items_tbl) do
        if other:contains(key) then intersection:add(key) end
    end
    return intersection
end

function Set:difference(other)
    local difference = Set:new()
    for key in pairs(self.items_tbl) do
        if not other:contains(key) then difference:add(key) end
    end
    return difference
end

function Set:symmetric_difference(other)
    local difference = Set:new()
    for key in pairs(self.items_tbl) do
        if not other:contains(key) then difference:add(key) end
    end
    for key in pairs(other.items_tbl) do
        if not self:contains(key) then difference:add(key) end
    end
    return difference
end

function Set:is_disjoint(other)
    for key in pairs(self.items_tbl) do
        if other:contains(key) then return false end
    end
    return true
end

function Set:is_subset(other)
    for key in pairs(self.items_tbl) do
        if not other:contains(key) then return false end
    end
    return true
end

function Set:is_superset(other)
    return other:is_subset(self)
end

function Set:tostring()
    local strs = {}
    for item in pairs(self.items_tbl) do
        strs[#strs + 1] = tostring(item)
    end
    table.sort(strs)
    return "{" .. table.concat(strs, " ") .. "}"
end

return Set
