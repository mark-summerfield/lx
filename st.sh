clc {fs,lx,set,str}.lua
luacheck -q *.lua
./test_set.lua
./test_str.lua

git st
