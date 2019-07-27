#!/bin/bash

#
# 安装 Thunderbird
#

# 创建临时目录
mkdir -p "$HOME/.cache/pkg-tmp"

# 下载包
cd "$HOME/.cache/pkg-tmp"
curl -L "https://download.mozilla.org/?product=thunderbird-68.0b4-SSL&os=linux64&lang=zh-CN" -o thunderbird-68.0b4.tar.bz2
cd ~

# 安装包
cd "$HOME/.cache/pkg-tmp"
tar -xjvf thunderbird-68.0b4.tar.bz2
mv -f "thunderbird" "$HOME/.config/Manual/thunderbird"
ln -sf "$HOME/.config/Manual/thunderbird/thunderbird" "$HOME/.config/Manual/bin/thunderbird"
cd ~

# 赋予执行权限
chmod +x "$HOME/.config/Manual/bin/thunderbird"

# 清理环境
rm -rf "$HOME/.cache/pkg-tmp"
sync
