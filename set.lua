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

function methods:union(other)
    local union = Set()
    for item in pairs(self.items_) do
        union:add(item)
    end
    for item in pairs(other.items_) do
        union:add(item)
    end
    return union
end

function methods:intersection(other)
    local intersection = Set()
    for item in pairs(self.items_) do
        if other:contains(item) then intersection:add(item) end
    end
    return intersection
end

function methods:difference(other)
    local difference = Set()
    for item in pairs(self.items_) do
        if not other:contains(item) then difference:add(item) end
    end
    return difference
end

function methods:symmetric_difference(other)
    local difference = Set()
    for item in pairs(self.items_) do
        if not other:contains(item) then difference:add(item) end
    end
    for item in pairs(other.items_) do
        if not self:contains(item) then difference:add(item) end
    end
    return difference
end

function methods:is_disjoint(other)
    for item in pairs(self.items_) do
        if other:contains(item) then return false end
    end
    return true
end

function methods:is_subset(other)
    for item in pairs(self.items_) do
        if not other:contains(item) then return false end
    end
    return true
end

function methods:is_superset(other)
    return other:is_subset(self)
end

function methods:random_item() -- slow!
    local index = math.random(1, self.size_)
    local i = 1
    for item in pairs(self.items_) do
        if i == index then return item end
        i = i + 1
    end
    error("no random item found")
end

function methods:copy()
    local set = Set()
    for item in pairs(self.items_) do
        set:add(item)
    end
    return set
end

function methods:iter(sorted) -- slow
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

function methods:tostring(sorted) -- slow
    local strs = {}
    for item in pairs(self.items_) do
        strs[#strs + 1] = tostring(item)
    end
    if sorted then table.sort(strs) end
    return "{" .. table.concat(strs, " ") .. "}"
end

function methods:add(...)
    for _, item in ipairs({ ... }) do
        if not self.items_[item] then
            self.items_[item] = true
            self.size_ = self.size_ + 1
        end
    end
end

function methods:remove(...)
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

function meta:__eq(other)
    if self.size_ ~= #other then return false end
    for item in pairs(self.items_) do
        if not other:contains(item) then return false end
    end
    for item in pairs(other.items_) do
        if not self:contains(item) then return false end
    end
    return true
end

function meta:__band(other)
    return self:intersection(other)
end

function meta:__bor(other)
    return self:union(other)
end

Set = function(...)
    local self = { items_ = {}, size_ = 0 }
    setmetatable(self, meta)
    self:add(...)
    return self
end

return Set
