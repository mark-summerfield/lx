#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

local Set

local methods = {}

function methods.typeof() return "Set" end

function methods:isempty() return next(self.values_) == nil end

function methods:len() return self.size_ end

function methods:contains(value) return self.values_[value] == true end

function methods:unite(set) -- use :add(a, b, c) to add individual values
    for value in pairs(set.values_) do
        self:add(value)
    end
end

function methods:union(set) -- a | b
    local union = Set()
    for value in pairs(self.values_) do
        union:add(value)
    end
    for value in pairs(set.values_) do
        union:add(value)
    end
    return union
end

function methods:intersection(set) -- a & b
    local intersection = Set()
    for value in pairs(self.values_) do
        if set:contains(value) then intersection:add(value) end
    end
    return intersection
end

function methods:difference(set) -- a - b
    local difference = Set()
    for value in pairs(self.values_) do
        if not set:contains(value) then difference:add(value) end
    end
    return difference
end

function methods:symmetric_difference(set)
    local difference = Set()
    for value in pairs(self.values_) do
        if not set:contains(value) then difference:add(value) end
    end
    for value in pairs(set.values_) do
        if not self:contains(value) then difference:add(value) end
    end
    return difference
end

function methods:isdisjoint(set)
    for value in pairs(self.values_) do
        if set:contains(value) then return false end
    end
    return true
end

function methods:issubset(set)
    for value in pairs(self.values_) do
        if not set:contains(value) then return false end
    end
    return true
end

function methods:issuperset(set) return set:issubset(self) end

function methods:random_value()
    local index = math.random(1, self.size_)
    local i = 1
    for value in pairs(self.values_) do
        if i == index then return value end
        i = i + 1
    end
    error("Set:random_value() no random value found")
end

function methods:iter(sorted)
    local values = self:values(sorted)
    local i = 0
    return function()
        i = i + 1
        return values[i]
    end
end

function methods:values(sorted)
    local values = {}
    for value in pairs(self.values_) do
        values[#values + 1] = value
    end
    if sorted then table.sort(values) end
    return values
end

function methods:tostring(sorted)
    local strs = {}
    for value in pairs(self.values_) do
        local str
        if type(value) == "string" then
            str = "«" .. value .. "»"
        else
            str = tostring(value)
        end
        table.insert(strs, str)
    end
    if sorted then table.sort(strs) end
    return "{" .. table.concat(strs, " ") .. "}"
end

function methods:add(...) -- use :unite(set) to add values from another set
    for _, value in ipairs({ ... }) do
        if not self.values_[value] then
            self.values_[value] = true
            self.size_ = self.size_ + 1
        end
    end
end

function methods:remove(...) -- use :difference(set) to remove another set
    local removed = 0
    for _, value in ipairs({ ... }) do
        if self.values_[value] then
            self.values_[value] = nil
            self.size_ = self.size_ - 1
            removed = removed + 1
        end
    end
    return removed
end

function methods:clear()
    self.values_ = {}
    self.size_ = 0
end

local meta = { __index = methods }

function meta:__tostring() return self:tostring() end

function meta:__len() return self.size_ end

function meta:__eq(set)
    if self.size_ ~= #set then return false end
    -- using contains means that iteration order doesn't matter
    for value in pairs(self.values_) do
        if not set:contains(value) then return false end
    end
    for value in pairs(set.values_) do
        if not self:contains(value) then return false end
    end
    return true
end

function meta:__band(set) return self:intersection(set) end

function meta:__bor(set) return self:union(set) end

function meta:__sub(set) return self:difference(set) end

Set = function(...)
    local self = { values_ = {}, size_ = 0 }
    setmetatable(self, meta)
    self:add(...)
    return self
end

return Set
