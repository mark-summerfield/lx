#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

local tx = {}

local function clone(orig, copies_) -- call with ONE table only!
    copies_ = copies_ or {}
    local orig_type = type(orig)
    local copy
    if orig_type == "table" then
        if copies_[orig] then
            copy = copies_[orig]
        else
            copy = {}
            copies_[orig] = copy
            for orig_key, orig_value in next, orig, nil do
                copy[clone(orig_key, copies_)] = clone(orig_value, copies_)
            end
            setmetatable(copy, clone(getmetatable(orig), copies_))
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function tx.clone(tbl) return clone(tbl) end

return tx
