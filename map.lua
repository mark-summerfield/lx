#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

local Map

local methods = {}

function methods.typeof()
    return "Map"
end

function methods:len()
    return #self.size_
end

function methods:get(key)
    --    for i, x in ipairs(self.items_) do
    --        if x == value then return i end
    --    end
    --    return nil
end

function methods:contains(key)
    --    return self:find(value) ~= nil
end

function methods:add(...)
    --    for _, value in ipairs({ ... }) do
    --        table.insert(self.items_, value)
    --    end
end

function methods:setdefault(key, value)
    -- if key exists replace it's value else add key-value
end

function methods:remove(key)
    --    if pos > #self.items_ then return nil end
    --    local value = self.items_[pos]
    --    table.remove(self.items_, pos)
    --    return value
end

function methods:update(map)
    -- add every key-value from map to self
end

function methods:copy()
    local map = Map()
    --    for _, value in ipairs(self.items_) do
    --        table.insert(map.items_, value)
    --    end
    return map
end

function methods:tostring()
    local strs = {}
    --    for i, value in ipairs(self.items_) do
    --        if type(value) == "string" then
    --            strs[i] = "«" .. value .. "»"
    --        else
    --            strs[i] = tostring(value)
    --        end
    --    end
    return "{" .. table.concat(strs, " ") .. "}"
end

function methods:clear()
    self.items_ = {}
    self.size_ = 0
end

-- values = map:values()
-- for _, value in ipairs(values) do ... end -- is faster than map:iter()
function methods:iter()
    --    local i = 0
    --    return function()
    --        i = i + 1
    --        return self.items_[i]
    --    end
end

function methods:keys(sorted)
    --    return self.items_
end

function methods:values(sorted)
    --    return self.items_
end

local meta = { __index = methods }

function meta:__tostring()
    return self:tostring()
end

function meta:__len()
    return #self.items_
end

function meta:__eq(map)
    if #self.items_ ~= #map then return false end
    --    for i = 1, #self.items_ do
    --        if self.items_[i] ~= map.items_[i] then return false end
    --    end
    return true
end

Map = function(...)
    local self = { items_ = {}, size_ = 0 }
    setmetatable(self, meta)
    self:append(...)
    return self
end

return Map
