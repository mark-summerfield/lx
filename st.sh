clc
luacheck -q *.lua
./set_test.lua
./str_test.lua
./tbl_test.lua

git st
