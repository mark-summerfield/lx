#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

local function checker()
    local ok = 0
    local total = 0

    local function check(expr, msg)
        total = total + 1
        if expr then
            ok = ok + 1
        else
            error('FAIL "' .. tostring(msg) .. '"', 2)
        end
    end

    local function report(context)
        local message = ok == total and "OK" or "FAIL"
        context = context and context .. " " or ""
        io.write(context, ok, "/", total, " ", message, "\n")
    end

    return check, report
end

local function dumptable(tbl, name)
    if name then print(name) end
    for key, value in pairs(tbl) do
        print(key, "=", value)
    end
end

return { checker = checker, dumptable = dumptable }
