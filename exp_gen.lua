#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

local Lx = require("lx")

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
    local t = Lx.timeit(function()
        sum_map_keys_by_pairs(map)
    end)
    print(string.format("map_key_pairs() %7.3f secs", t))
end

local function time_map_iter()
    local map = make_map()
    local t = Lx.timeit(function()
        sum_map_keys_by_iter(map)
    end)
    print(string.format("map_key_iter()  %7.3f secs", t))
end

local function time_map_gen()
    local map = make_map()
    local t = Lx.timeit(function()
        sum_map_keys_by_gen(map)
    end)
    print(string.format("map_key_gen()   %7.3f secs", t))
end

local function main()
    print(string.format("#0 % 20.0f KB", collectgarbage("count")))
    print(string.format("number of items %d", SIZE))
    print(string.format("#1 % 20.0f KB", collectgarbage("count")))
    time_map_pairs()
    print(string.format("#2 % 20.0f KB", collectgarbage("count")))
    time_map_iter()
    print(string.format("#3 % 20.0f KB", collectgarbage("count")))
    time_map_gen()
    print(string.format("#4 % 20.0f KB", collectgarbage("count")))
end

main()
