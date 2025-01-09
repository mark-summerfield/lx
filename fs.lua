#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

local HOME <const> = os.getenv("HOME")
local ROCKS_SO_PATH = HOME .. "/opt/luarocks/lib/lua/5.4/?.so"
package.cpath = package.cpath .. ";" .. ROCKS_SO_PATH

local lfs = require("lfs")
local Fs = {}

function Fs.cwd()
    return lfs.currentdir() -- io.popen("pwd"):read()
end

function Fs.chdir(dirname)
    return lfs.chdir(dirname)
end

function Fs.mkdir(dirname)
    return lfs.mkdir(dirname)
end

function Fs.chmod(filename, mode) -- Unix-specific
    os.execute("chmod " .. mode .. ' "' .. filename .. '"')
end

function Fs.copy(source, dest)
    local infile = io.open(source, "rb")
    if infile then
        local oufile = io.open(dest, "wb")
        if oufile then
            oufile:write(infile:read("all"))
            oufile:close()
        else
            error("Fs.copy() failed to write " .. dest)
        end
        infile:close()
    else
        error("Fs.copy() failed to read " .. source)
    end
end

-- for remove use os.remove(filename)

return Fs
