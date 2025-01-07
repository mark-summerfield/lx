#!/usr/bin/env lua

local Tbl = require("Tbl")

local Set = {}

function Set:new(...)
    local set = { items_ = {}, size_ = 0 }
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
    return Tbl.deepequal(self.items_, other.items_)
end

function Set:add(...)
    for _, item in ipairs({ ... }) do
        if not self.items_[item] then
            self.items_[item] = true
            self.size_ = self.size_ + 1
        end
    end
end

function Set:contains(item)
    return self.items_[item] == true
end

function Set:clear()
    self.items_ = {}
    self.size_ = 0
end

function Set:remove(...)
    local removed = 0
    for _, item in ipairs({ ... }) do
        if self.items_[item] then
            self.items_[item] = nil
            self.size_ = self.size_ - 1
            removed = removed + 1
        end
    end
    return removed
end

function Set:copy()
    local set = Set:new()
    for item in pairs(self.items_) do
        set:add(item)
    end
    return set
end

function Set:union(other)
    local union = Set:new()
    for key in pairs(self.items_) do
        union:add(key)
    end
    for key in pairs(other.items_) do
        union:add(key)
    end
    return union
end

function Set:intersect(other)
    local intersection = Set:new()
    for key in pairs(self.items_) do
        if other:contains(key) then intersection:add(key) end
    end
    return intersection
end

function Set:difference(other)
    local difference = Set:new()
    for key in pairs(self.items_) do
        if not other:contains(key) then difference:add(key) end
    end
    return difference
end

function Set:symmetric_difference(other)
    local difference = Set:new()
    for key in pairs(self.items_) do
        if not other:contains(key) then difference:add(key) end
    end
    for key in pairs(other.items_) do
        if not self:contains(key) then difference:add(key) end
    end
    return difference
end

function Set:is_disjoint(other)
    for key in pairs(self.items_) do
        if other:contains(key) then return false end
    end
    return true
end

function Set:is_subset(other)
    for key in pairs(self.items_) do
        if not other:contains(key) then return false end
    end
    return true
end

function Set:is_superset(other)
    return other:is_subset(self)
end

function Set:tostring()
    local strs = {}
    for item in pairs(self.items_) do
        strs[#strs + 1] = tostring(item)
    end
    table.sort(strs)
    return "{" .. table.concat(strs, " ") .. "}"
end

return Set
