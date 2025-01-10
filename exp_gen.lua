#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

require("lx") -- for luarocks paths
local pl = require("pl.import_into")()
local Misc = require("misc")

local SIZE <const> = 3000000

local function make_map()
    local map = {}
    local size = 0
    while true do
        local n = math.random(SIZE)
        if not map[n] then
            map[n] = SIZE + n
            size = size + 1
            if size == SIZE then break end
        end
    end
    return map
end

local function sum_map_keys_by_pairs(map)
    local n = 0
    for key in pairs(map) do
        n = n + key
    end
    print(n)
end

local function map_key_iter(map)
    local items = {}
    for item in pairs(map) do
        items[#items + 1] = item
    end
    local i = 0
    return function()
        i = i + 1
        return items[i]
    end
end

local function sum_map_keys_by_iter(map)
    local n = 0
    for key in map_key_iter(map) do
        n = n + key
    end
    print(n)
end

local function map_key_gen(map)
    local function mkg(m)
        for item in pairs(m) do
            coroutine.yield(item)
        end
    end
    return coroutine.wrap(function()
        mkg(map)
    end)
end

local function sum_map_keys_by_gen(map)
    local n = 0
    for key in map_key_gen(map) do
        n = n + key
    end
    print(n)
end

local function time_map_pairs()
    local map = make_map()
    local t = Misc.timeit(function()
        sum_map_keys_by_pairs(map)
    end)
    pl.utils.printf("map_key_pairs() %7.3f secs\n", t)
end

local function time_map_iter()
    local map = make_map()
    local t = Misc.timeit(function()
        sum_map_keys_by_iter(map)
    end)
    pl.utils.printf("map_key_iter()  %7.3f secs\n", t)
end

local function time_map_gen()
    local map = make_map()
    local t = Misc.timeit(function()
        sum_map_keys_by_gen(map)
    end)
    pl.utils.printf("map_key_gen()   %7.3f secs\n", t)
end

local function main()
    pl.utils.printf("#0 % 20.0f KB\n", collectgarbage("count"))
    pl.utils.printf("number of items %d\n", SIZE)
    pl.utils.printf("#1 % 20.0f KB\n", collectgarbage("count"))
    time_map_pairs()
    pl.utils.printf("#2 % 20.0f KB\n", collectgarbage("count"))
    time_map_iter()
    pl.utils.printf("#3 % 20.0f KB\n", collectgarbage("count"))
    time_map_gen()
    pl.utils.printf("#4 % 20.0f KB\n", collectgarbage("count"))
end

main()
