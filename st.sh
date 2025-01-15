clc {fs,list,lx,map,rocks,set,str}.lua
luacheck -q *.lua
./test_lx.lua
./test_list.lua
./test_map.lua
./test_set.lua
./test_str.lua

git st
