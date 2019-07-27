#!/bin/bash

#
# 安装 Thunderbird
#

# 创建临时目录
mkdir -p "$HOME/.cache/pkg-tmp"

# 下载包
cd "$HOME/.cache/pkg-tmp"
curl -L "https://download.jetbrains.com/python/pycharm-professional-2019.2.tar.gz" -o "pycharm-professional-2019.2.tar.gz"
cd ~

# 安装包
cd "$HOME/.cache/pkg-tmp"
tar -xzvf "pycharm-professional-2019.2.tar.gz"
mv -f "pycharm-2019.2" "$HOME/.config/Manual/pycharm"
ln -sf "$HOME/.config/Manual/pycharm/bin/pycharm.sh" "$HOME/.config/Manual/bin/pycharm"
cd ~

# 赋予执行权限
chmod +x "$HOME/.config/Manual/bin/pycharm"

# 清理环境
rm -rf "$HOME/.cache/pkg-tmp"
sync
