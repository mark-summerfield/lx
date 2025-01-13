#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

require("lx") -- for luarocks paths
local pl = require("pl.import_into")()

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
    pl.test.timer("map_key_pairs ", 1, function()
        sum_map_keys_by_pairs(map)
    end)
end

local function time_map_iter()
    local map = make_map()
    pl.test.timer("map_key_iter", 1, function()
        sum_map_keys_by_iter(map)
    end)
end

local function time_map_gen()
    local map = make_map()
    pl.test.timer("map_key_gen ", 1, function()
        sum_map_keys_by_gen(map)
    end)
end

local function main()
    pl.utils.printf("#0 % 12.0f KB\n", collectgarbage("count"))
    pl.utils.printf("number of items %d\n", SIZE)
    pl.utils.printf("#1 % 12.0f KB\n", collectgarbage("count"))
    time_map_pairs()
    pl.utils.printf("#2 % 12.0f KB\n", collectgarbage("count"))
    time_map_iter()
    pl.utils.printf("#3 % 12.0f KB\n", collectgarbage("count"))
    time_map_gen()
    pl.utils.printf("#4 % 12.0f KB\n", collectgarbage("count"))
end

main()
