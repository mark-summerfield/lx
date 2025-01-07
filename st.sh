clc
luacheck -q *.lua
./test_Set.lua
./test_Str.lua
./test_Tbl.lua

git st
