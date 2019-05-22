#!/bin/bash

# 创建必要的目录

mkdir -p ~/.config/lib
mkdir -p ~/.cache/temporary
cd ~/.cache/temporary
mDefaults=$(pwd)

# 安装 - Genymotion

cd $mDefaults
curl -L "https://dl.genymotion.com/releases/genymotion-2.12.0/genymotion-2.12.0-linux_x64.bin" -o genymotion.bin
mv -f genymotion.bin ~/.config/lib
cd ~/.config/lib
chmod +x genymotion.bin
./genymotion.bin
rm -rf genymotion.bin
mv genymotion genymotion-linux
ln -s -f "$HOME/.config/lib/genymotion-linux/genymotion" "$HOME/.config/lib"
ln -s -f "$HOME/.config/lib/genymotion-linux/genymotion-shell" "$HOME/.config/lib"
ln -s -f "$HOME/.config/lib/genymotion-linux/gmtool" "$HOME/.config/lib"

# 赋予执行权限

chmod +x ~/.config/lib/*

# 清理环境

rm -rf ~/.cache/temporary
sync
