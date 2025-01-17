#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

local ux = {}

function ux.platform()
    local ok, file = pcall(io.popen, "uname")
    if ok then
        local reply = file:read()
        file:close()
        return reply
    end
    return "Windows"
end

return ux
