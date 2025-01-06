#!/usr/bin/env lua

local Tbl = require("Tbl")

local Set = {}

function Set:new(...)
    local set = { items_ = {}, size_ = 0 }
    self.__index = Set
    -- tostring()
    setmetatable(set, Set)
    set:add(...)
    return set
end

function Set:__len()
    return self.size_
end

function Set:__band(...)
    return self.intersection(...)
end

function Set:__union(...)
    return self.union(...)
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

function Set:remove(item)
    if self.items_[item] then
        self.items_[item] = nil
        self.size_ = self.size_ - 1
        return true
    end
    return false
end

function Set:copy()
    local set = Set:new()
    for item in pairs(self.items_) do
        set.add(item)
    end
    return set
end

function Set:each(callback)
    for item in pairs(self.items_) do
        callback(item)
    end
end

function Set:every(callback)
    for item in pairs(self.items_) do
        if not callback(item) then return false end
    end
    return true
end

function Set:union(...)
    local union = Set(Tbl.keys(self.items_))
    for _, set in ipairs({ ... }) do
        set.each(function(item)
            union.add(item)
        end)
    end
    return union
end

function Set:intersection(...)
    local sets = { ... }
    local intersection = Set()
    self.each(function(item)
        local is_common = true
        for _, set in ipairs(sets) do
            if not set.contains(item) then
                is_common = false
                break
            end
        end
        if is_common then intersection.add(item) end
    end)
    return intersection
end

function Set:difference(...)
    local sets = { ... }
    local difference = Set()
    self.each(function(item)
        local is_common = false
        for _, set in ipairs(sets) do
            if set.contains(item) then
                is_common = true
                break
            end
        end
        if not is_common then difference.add(item) end
    end)
    return difference
end

function Set:symmetric_difference(set)
    local difference = Set(Tbl.keys(self.items_))
    set.each(function(item)
        if difference.contains(item) then
            difference.remove(item)
        else
            difference.add(item)
        end
    end)
    return difference
end

function Set:is_superset(set)
    return self.every(function(item)
        return set.contains(item)
    end)
end

function Set:__tostring()
    local strs = {}
    for item in pairs(self.items_) do
        strs[#strs + 1] = tostring(item)
    end
    table.sort(strs)
    return "{" .. table.concat(strs, " ") .. "}"
end

return Set
