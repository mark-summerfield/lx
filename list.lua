#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

local List

local methods = {}

function methods.typeof()
    return "List"
end

function methods:len()
    return #self.values_
end

function methods:get(pos)
    if pos > #self.values_ then return nil end
    return self.values_[pos]
end

function methods:find(item)
    for i, x in ipairs(self.values_) do
        if x == item then return i end
    end
    return nil
end

function methods:rfind(item)
    for i = #self.values_, 1, -1 do
        if self.values_[i] == item then return i end
    end
    return nil
end

function methods:contains(item)
    return self:find(item) ~= nil
end

function methods:sort(cmp)
    table.sort(self.values_, cmp)
end

function methods:append(...)
    for _, item in ipairs({ ... }) do
        table.insert(self.values_, item)
    end
end

function methods:set(pos, item)
    assert(pos <= #self.values_, "List.set() pos out of range")
    self.values_[pos] = item
end

function methods:pop()
    return self:remove(#self.values_)
end

function methods:remove(pos)
    local item = self.values_[pos]
    table.remove(self.values_, pos)
    return item
end

function methods:copy()
    local list = List()
    for _, item in ipairs(self.values_) do
        table.insert(list.values_, item)
    end
    return list
end

function methods:tostring()
    local strs = {}
    for i, item in ipairs(self.values_) do
        if type(item) == "string" then
            strs[i] = "«" .. item .. "»"
        else
            strs[i] = tostring(item)
        end
    end
    return "[" .. table.concat(strs, " ") .. "]"
end

function methods:clear()
    self.values_ = {}
end

local meta = { __index = methods }

function meta:__tostring()
    return self:tostring()
end

function meta:__len()
    return #self.values_
end

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
