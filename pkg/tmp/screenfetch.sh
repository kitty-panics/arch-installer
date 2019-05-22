#!/bin/bash

# 创建必要的目录

mkdir -p ~/.config/lib
mkdir -p ~/.cache/temporary
cd ~/.cache/temporary
mDefaults=$(pwd)

# 安装 - ScreenFetch

cd $mDefaults
git clone --depth=1 https://github.com/KittyKatt/screenFetch ~/.config/lib/screenFetch-dev
ln -s -f "$HOME/.config/lib/screenFetch-dev/screenfetch-dev" "$HOME/.config/lib/screenfetch"

# 赋予执行权限

chmod +x ~/.config/lib/*

# 清理环境

rm -rf ~/.cache/temporary
sync
