#!/bin/bash

# 创建必要的目录

mkdir -p ~/.config/lib
mkdir -p ~/.cache/temporary
cd ~/.cache/temporary
mDefaults=$(pwd)

# 安装 - WebStorm

cd $mDefaults
curl -L "https://download.jetbrains.com/webstorm/WebStorm-2018.1.1.tar.gz" -o webstorm.tar.gz
tar xvzf webstorm.tar.gz -C "$HOME/.config/lib"
ln -s -f "$HOME/.config/lib/WebStorm-181.4445.68/bin/webstorm.sh" "$HOME/.config/lib"

# 赋予执行权限

chmod +x ~/.config/lib/*

# 清理环境

rm -rf ~/.cache/temporary
sync
