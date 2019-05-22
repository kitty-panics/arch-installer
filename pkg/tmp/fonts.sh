#!/bin/bash

# 创建必要的目录

mkdir -p ~/.config/lib
mkdir -p ~/.cache/temporary
cd ~/.cache/temporary
mDefaults=$(pwd)

# 安装 - Fonts

cd $mDefaults
curl -L "https://noto-website-2.storage.googleapis.com/pkgs/NotoColorEmoji-unhinted.zip" -O
curl -L "https://noto-website-2.storage.googleapis.com/pkgs/NotoEmoji-unhinted.zip" -O
curl -L "https://noto-website-2.storage.googleapis.com/pkgs/NotoSansCJKsc-hinted.zip" -O
curl -L "https://noto-website-2.storage.googleapis.com/pkgs/NotoSerifCJKsc-hinted.zip" -O
7z x NotoColorEmoji-unhinted.zip -o"$HOME/.config/lib/fonts/NotoColorEmoji-unhinted"
7z x NotoEmoji-unhinted.zip      -o"$HOME/.config/lib/fonts/NotoEmoji-unhinted"
7z x NotoSansCJKsc-hinted.zip    -o"$HOME/.config/lib/fonts/NotoSansCJKsc-hinted"
7z x NotoSerifCJKsc-hinted.zip   -o"$HOME/.config/lib/fonts/NotoSerifCJKsc-hinted"
git clone --depth=1 https://github.com/powerline/fonts ~/.config/lib/fonts/powerline-fonts
fc-cache -fv

# 赋予执行权限

chmod +x ~/.config/lib/*

# 清理环境

rm -rf ~/.cache/temporary
sync
