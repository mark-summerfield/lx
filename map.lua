#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

local Map

local methods = {}

function methods.typeof()
    return "Map"
end

-- How can I replace: v = map:get(key) with v = map[key]
function methods:get(key)
    return self.items_[key]
end

function methods:isempty()
    return next(self.items_) == nil
end

function methods:remove(key)
    local value = self.items_[key]
    if value then self.items_[key] = nil end
    return value
end

function methods:update(map)
    for key, value in pairs(map.items_) do
        self.items_[key] = value
    end
end

local function maybe_quote(x)
    if type(x) == "string" then return "«" .. x .. "»" end
    return tostring(x)
end

function methods:tostring(sorted)
    local strs = {}
    for key, value in pairs(self.items_) do
        table.insert(strs, maybe_quote(key) .. "=" .. maybe_quote(value))
    end
    if sorted then table.sort(strs) end
    return "{" .. table.concat(strs, " ") .. "}"
end

function methods:clear()
    self.items_ = {}
end

function methods:iter(sorted)
    local keys = self:keys(sorted)
    local i = 0
    return function()
        i = i + 1
        local key = keys[i]
        return key, self.items_[key]
    end
end

function methods:keys(sorted)
    local keys = {}
    for key in pairs(self.items_) do
        table.insert(keys, key)
    end
    if sorted then table.sort(keys) end
    return keys
end

function methods:values(sorted)
    local values = {}
    if sorted then
        local keys = self:keys(sorted)
        for _, key in ipairs(keys) do
            table.insert(values, self.items_[key])
        end
    else
        for _, value in pairs(self.items_) do
            table.insert(values, value)
        end
    end
    return values
end

local meta = { __index = methods }

function meta:__newindex(key, value) -- adds or updates
    self.items_[key] = value
end

function meta:__tostring()
    return self:tostring()
end

function meta:__eq(map)
    local mykeys = self:keys(true)
    local theirkeys = map:keys(true)
    if #mykeys ~= #theirkeys then return false end
    for i, key in ipairs(mykeys) do
        if mykeys[i] ~= theirkeys[i] then return false end
        if self.items_[key] ~= map:get(key) then return false end
    end
    return true
end

Map = function()
    local self = { items_ = {} }
    setmetatable(self, meta)
    return self
end

return Map
