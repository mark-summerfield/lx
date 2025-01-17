#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

local List

local methods = {}

function methods.typeof() return "List" end

function methods:isempty() return next(self.values_) == nil end

function methods:len() return #self.values_ end

function methods:first()
    return #self.values_ > 0 and self.values_[1] or nil
end

function methods:last()
    return #self.values_ > 0 and self.values_[#self.values_] or nil
end

function methods:at(pos)
    return pos <= #self.values_ and self.values_[pos] or nil
end

function methods:find(value)
    for i, x in ipairs(self.values_) do
        if x == value then return i end
    end
    return nil
end

function methods:rfind(value)
    for i = #self.values_, 1, -1 do
        if self.values_[i] == value then return i end
    end
    return nil
end

function methods:contains(value) return self:find(value) ~= nil end

function methods:sort(cmp) table.sort(self.values_, cmp) end

function methods:random_value()
    return #self.values_ > 0
            and self.values_[math.random(1, #self.values_)]
        or nil
end

function methods:append(...)
    for _, value in ipairs({ ... }) do
        table.insert(self.values_, value)
    end
end

function methods:insert(pos, value) table.insert(self.values_, pos, value) end

function methods:set(pos, value)
    assert(pos <= #self.values_, "List.set() pos out of range")
    self.values_[pos] = value
end

function methods:pop()
    return #self.values_ > 0 and self:remove(#self.values_) or nil
end

function methods:remove(pos)
    if pos > #self.values_ then return nil end
    local value = self.values_[pos]
    table.remove(self.values_, pos)
    return value
end

function methods:tostring()
    local strs = {}
    for _, value in ipairs(self.values_) do
        local str
        if type(value) == "string" then
            str = "«" .. value .. "»"
        else
            str = tostring(value)
        end
        table.insert(strs, str)
    end
    return "[" .. table.concat(strs, " ") .. "]"
end

function methods:clear() self.values_ = {} end

-- values = list:values()
-- for _, value in ipairs(values) do ... end -- is faster than list:iter()
function methods:iter()
    local i = 0
    return function()
        i = i + 1
        return self.values_[i]
    end
end

function methods:values() return self.values_ end

local meta = { __index = methods }

function meta:__tostring() return self:tostring() end

function meta:__len() return #self.values_ end

function meta:__eq(list)
    if #self.values_ ~= #list then return false end
    for i = 1, #self.values_ do
        if self.values_[i] ~= list.values_[i] then return false end
    end
    return true
end

List = function(...)
    local self = { values_ = {} }
    setmetatable(self, meta)
    self:append(...)
    return self
end

return List
