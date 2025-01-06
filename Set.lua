#!/usr/bin/env lua

local function to_array(hash)
    local list = {}
    for key in pairs(hash) do
        table.insert(list, key)
    end
    return list
end

-- Set lets you store unique values of any type
-- @param list {table} or empty
-- @returns {table}
local function Set(list)
    local self = {}

    -- Items held by Set
    -- @type {table}
    self.items_ = {}

    -- Current Set length; access using #set
    -- @type {number}
    self.size_ = 0

    if type(list) == "table" then
        for _, item in ipairs(list) do
            self.items_[item] = true
            self.size_ = self.size_ + 1
        end
    end

    -- Adds values to the Set object
    -- @param values; one or more of {any}
    -- @returns {void}
    self.add = function(...)
        for _, item in ipairs({ ... }) do
            if not self.items_[item] then
                self.items_[item] = true
                self.size_ = self.size_ + 1
            end
        end
    end

    -- Checks if item is present in the Set object or not
    -- @param item {any}
    -- @returns {boolean}
    self.contains = function(item)
        return self.items_[item] == true
    end

    -- Removes all items from the Set object
    -- @returns {void}
    self.clear = function()
        self.items_ = {}
        self.size_ = 0
    end

    -- Removes item from the Set object and returns a boolean value
    -- asserting whether item was removed or not
    -- @param item {any}
    -- @returns {boolean}
    self.remove = function(item)
        if self.items_[item] then
            self.items_[item] = nil
            self.size_ = self.size_ - 1
            return true
        end
        return false
    end

    -- Calls callback once for each item present in the Set object
    -- in no particular order
    -- @param callback {function}
    -- @returns {void}
    self.each = function(callback)
        for item in pairs(self.items_) do
            callback(item)
        end
    end

    -- Returns true whether all items pass the test provided by the
    -- callback function
    -- @param callback {function}
    -- @returns {boolean}
    self.every = function(callback)
        for item in pairs(self.items_) do
            if not callback(item) then return false end
        end
        return true
    end

    -- Returns a new Set that contains all items from the original Set
    -- and all items from the given Sets; can also use: setU = s1 | s2
    -- @param {Set[]}
    -- @returns Set
    self.union = function(...)
        local union = Set(to_array(self.items_))
        for _, set in ipairs({ ... }) do
            set.each(function(item)
                union.add(item)
            end)
        end
        return union
    end

    -- Returns a new Set that contains all elements that are common to
    -- all the given Sets; can also use: setI = s1 & s2
    -- @param {Set[]}
    -- @returns Set
    self.intersection = function(...)
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

    -- Returns a new Set that contains the items that only exist in the
    -- original Set and are not in any of the given Sets
    -- @param {Set[]}
    -- @returns Set
    self.difference = function(...)
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

    -- Returns the symetric difference of two Sets
    -- @param {Set}
    -- @returns {Set}
    self.symmetric_difference = function(set)
        local difference = Set(to_array(self.items_))
        set.each(function(item)
            if difference.contains(item) then
                difference.remove(item)
            else
                difference.add(item)
            end
        end)
        return difference
    end

    -- Returns true if the set contains all items present in the other Set
    -- @param {Set}
    -- @returns {boolean}
    self.is_superset = function(set)
        return self.every(function(item)
            return set.contains(item)
        end)
    end

    -- Returns a human-readable string representation of the set with
    -- the items sorted
    self.tostring = function()
        local strs = {}
        for item in pairs(self.items_) do
            strs[#strs + 1] = tostring(item)
        end
        table.sort(strs)
        return "{" .. table.concat(strs, " ") .. "}"
    end

    return setmetatable(self, {
        __band = self.intersection,
        __bor = self.union,
        __index = function()
            error("use Set.contains()")
        end,
        __newindex = function()
            error("use Set.add()")
        end,
        __len = function()
            return self.size_
        end,
        __tostring = self.tostring,
    })
end

return Set
