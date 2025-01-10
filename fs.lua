#!/usr/bin/env lua
-- Copyright © 2025 Mark Summerfield. All rights reserved.

local ok, _ = pcall(require, "lx.lx")
if not ok then
    require("lx") -- for package.path and package.cpath
end

local Fs = {}

function Fs.chmod(filename, mode) -- Unix-specific
    os.execute("chmod " .. mode .. ' "' .. filename .. '"')
end

-- for remove use os.remove(filename); see also pl.{path,file,dir}

return Fs
