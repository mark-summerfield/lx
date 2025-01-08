clc
luacheck -q -g *.lua
./test_Set.lua
./test_Str.lua

git st
