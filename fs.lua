#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

local ROCKS_SO_PATH = os.getenv("HOME") .. "/opt/luarocks/lib/lua/5.4/?.so"
package.cpath = package.cpath .. ";" .. ROCKS_SO_PATH

local lfs = require("lfs")

local Fs = {}

local function errmsg(fname, what, filename)
    what = what == "r" and "read" or "write"
    return fname .. "() failed to " .. what .. ' "' .. filename .. '"'
end

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

function Fs.copyfile(source, dest)
    local infile <close> =
        assert(io.open(source, "rb"), errmsg("Fs.copy", "r", source))
    local oufile <close> =
        assert(io.open(dest, "wb"), errmsg("Fs.copy", "w", dest))
    oufile:write(infile:read("all"))
end

function Fs.writefile(filename, text)
    local file <close> = assert(
        io.open(filename, "w"),
        errmsg("Fs.writefile", "w", filename)
    )
    file:write(text)
end

-- for remove use os.remove(filename)

return Fs
