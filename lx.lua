#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

local Lx = {}

function Lx.fprintf(file, fmt, ...)
    file:write(string.format(fmt, ...))
end

function Lx.printf(fmt, ...)
    Lx.fprintf(io.stdout, fmt, ...)
end

function Lx.timeit(name, func)
    local t = os.clock()
    func()
    t = os.clock() - t
    Lx.printf("%s %9.3f sec\n", name, t)
end

return Lx
