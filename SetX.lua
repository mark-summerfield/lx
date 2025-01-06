#!/usr/bin/env lua

local Set = { items_ = {}, size_ = 0 }

function Set:new(...)
    obj = {}
    self.__index = self
    setmetatable(obj, self)
    obj:add(...)
    return obj
end

function Set:add(...)
    for _, item in ipairs({ ... }) do
        if not self.items_[item] then
            self.items_[item] = true
            self.size_ = self.size_ + 1
        end
    end
end

return Set
