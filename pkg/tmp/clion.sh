#!/bin/bash

#
# 安装 CLion
#

# 创建临时目录
mkdir -p "$HOME/.cache/pkg-tmp"

# 下载包
cd "$HOME/.cache/pkg-tmp/"
pkg_Cul="https://download.jetbrains.com/cpp/CLion-2018.3.4"
pkg_Type=".tar.gz"
curl -L "$pkg_Cul$pkg_Type" -o clion.tar.gz

# 安装包
tar -xzvf clion.tar.gz -C "$HOME/.config/Manual/"
ln -s -f "$HOME/.config/Manual/clion-2018.3.4/bin/clion.sh" "$HOME/.config/Manual/bin/clion"

# 赋予执行权限
chmod -R +x "$HOME/.config/Manual/bin"

# 清理环境
rm -rf "$HOME/.cache/pkg-tmp"
sync
