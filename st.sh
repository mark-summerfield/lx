clc
luacheck -q *.lua
./test_fs.lua
./test_set.lua
./test_str.lua

git st
