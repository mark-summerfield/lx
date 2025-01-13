#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

local Set

local methods = {}

function methods:len()
    return self.size_
end

function methods:contains(item)
    return self.items_[item] == true
end

function methods:unite(set) -- use :add(a, b, c) to add individual items
    for item in pairs(set.items_) do
        self:add(item)
    end
end

function methods:union(set) -- a | b
    local union = Set()
    for item in pairs(self.items_) do
        union:add(item)
    end
    for item in pairs(set.items_) do
        union:add(item)
    end
    return union
end

function methods:intersection(set) -- a & b
    local intersection = Set()
    for item in pairs(self.items_) do
        if set:contains(item) then intersection:add(item) end
    end
    return intersection
end

function methods:difference(set) -- a - b
    local difference = Set()
    for item in pairs(self.items_) do
        if not set:contains(item) then difference:add(item) end
    end
    return difference
end

function methods:symmetric_difference(set)
    local difference = Set()
    for item in pairs(self.items_) do
        if not set:contains(item) then difference:add(item) end
    end
    for item in pairs(set.items_) do
        if not self:contains(item) then difference:add(item) end
    end
    return difference
end

function methods:is_disjoint(set)
    for item in pairs(self.items_) do
        if set:contains(item) then return false end
    end
    return true
end

function methods:is_subset(set)
    for item in pairs(self.items_) do
        if not set:contains(item) then return false end
    end
    return true
end

function methods:is_superset(set)
    return set:is_subset(self)
end

function methods:random_item()
    local index = math.random(1, self.size_)
    local i = 1
    for item in pairs(self.items_) do
        if i == index then return item end
        i = i + 1
    end
    error("Set:random_item() no random item found")
end

function methods:copy()
    local set = Set()
    for item in pairs(self.items_) do
        set:add(item)
    end
    return set
end

function methods:iter(sorted)
    local items = {}
    for item in pairs(self.items_) do
        items[#items + 1] = item
    end
    if sorted then table.sort(items) end
    local i = 0
    return function()
        i = i + 1
        return items[i]
    end
end

function methods:tostring(sorted)
    local strs = {}
    for item in pairs(self.items_) do
        strs[#strs + 1] = tostring(item)
    end
    if sorted then table.sort(strs) end
    return "{" .. table.concat(strs, " ") .. "}"
end

function methods:add(...) -- use :unite(set) to add items from another set
    for _, item in ipairs({ ... }) do
        if not self.items_[item] then
            self.items_[item] = true
            self.size_ = self.size_ + 1
        end
    end
end

function methods:remove(...) -- use :difference(set) to remove another set
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

function methods:clear()
    self.items_ = {}
    self.size_ = 0
end

local meta = { __index = methods }

function meta:__tostring()
    return self:tostring()
end

function meta:__len()
    return self.size_
end

function meta:__eq(set)
    if self.size_ ~= #set then return false end
    -- using contains means that iteration order doesn't matter
    for item in pairs(self.items_) do
        if not set:contains(item) then return false end
    end
    for item in pairs(set.items_) do
        if not self:contains(item) then return false end
    end
    return true
end

function meta:__band(set)
    return self:intersection(set)
end

function meta:__bor(set)
    return self:union(set)
end

function meta:__sub(set)
    return self:difference(set)
end

Set = function(...)
    local self = { items_ = {}, size_ = 0 }
    setmetatable(self, meta)
    self:add(...)
    return self
end

return Set
