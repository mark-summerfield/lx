clc {fx,list,lx,map,rocks,set,sx}.lua
luacheck -q *.lua
./test_list.lua
./test_map.lua
./test_set.lua
./test_sx.lua
./test_tx.lua

git st
