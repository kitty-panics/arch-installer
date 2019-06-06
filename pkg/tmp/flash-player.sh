#!/bin/bash

#
# 安装适用于 Firefox 的 Flash Player
#

# 创建临时目录
mkdir -p "$HOME/.cache/pkg-tmp"

# 下载包
cd "$HOME/.cache/pkg-tmp/"
pkg_Cul="https://fpdownload.adobe.com/get/flashplayer/pdc/32.0.0.171/flash_player_npapi_linux.x86_64"
pkg_Type=".tar.gz"
curl -L "$pkg_Cul$pkg_Type" -o flash-player.tar.gz

# 安装包
mkdir -p "$HOME/.config/Manual/Flash Player"
tar -xzvf flash-player.tar.gz -C "$HOME/.config/Manual/Flash Player/"
sudo mkdir -p "/usr/lib/mozilla/plugins"
sudo cp -rf "$HOME/.config/Manual/Flash Player/libflashplayer.so" "/usr/lib/mozilla/plugins/"

# 赋予执行权限
# :

# 清理环境
rm -rf "$HOME/.cache/pkg-tmp"
sync
