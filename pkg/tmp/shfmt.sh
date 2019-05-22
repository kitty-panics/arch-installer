#!/bin/bash

# 创建必要的目录

mkdir -p ~/.config/lib
mkdir -p ~/.cache/temporary
cd ~/.cache/temporary
mDefaults=$(pwd)

# 安装 - shfmt

go get -u mvdan.cc/sh/cmd/shfmt
mv -f ~/go ~/.config/lib/shfmt.git
rm -rf ~/.cache/go-build
ln -s -f "$HOME/.config/lib/shfmt.git/bin/shfmt" "$HOME/.config/lib"

# 赋予执行权限

chmod +x ~/.config/lib/*

# 清理环境

rm -rf ~/.cache/temporary
sync
