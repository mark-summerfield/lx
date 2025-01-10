#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

local function timeit(func)
    local t = os.clock()
    func()
    return os.clock() - t
end

return { timeit = timeit }
