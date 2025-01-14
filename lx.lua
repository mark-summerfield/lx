#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

local function fprintf(file, fmt, ...)
    file:write(string.format(fmt, ...))
end

local function printf(fmt, ...)
    fprintf(io.stdout(fmt, ...))
end

local function timeit(func)
    local t = os.clock()
    func()
    return os.clock() - t
end

return { printf = printf, fprintf = fprintf, timeit = timeit }
