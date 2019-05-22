#!/bin/bash

#
# 安装 Android-Studio
#

# 创建临时目录
mkdir -p "$HOME/.cache/pkg-tmp"

# 下载包
cd "$HOME/.cache/pkg-tmp/"
pkg_Cul="https://dl.google.com/dl/android/studio/ide-zips/3.4.0.18/android-studio-ide-183.5452501-linux"
pkg_Type=".tar.gz"
curl -L "$pkg_Cul$pkg_Type" -o android-studio.tar.gz

# 安装包
tar -xzvf android-studio.tar.gz -C "$HOME/.config/Manual/"
ln -s -f "$HOME/.config/Manual/android-studio/bin/studio.sh" "$HOME/.config/Manual/bin/android-studio"

# 赋予执行权限
chmod -R +x "$HOME/.config/Manual/bin"

# 清理环境
rm -rf "$HOME/.cache/pkg-tmp"
sync
