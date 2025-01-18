clc -sl lua -e check.lua
luacheck --no-max-line-length -q *.lua
for t in test*.lua; do ./$t ; done

git st
