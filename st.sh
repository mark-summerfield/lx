clc
luacheck -q *.lua
./test_set.lua
./test_str.lua

git st
