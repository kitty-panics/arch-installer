#!/bin/bash

#
# 安装 DataGrip
#

# 创建必要的目录
mkdir -p "$HOME/.cache/pkg-tmp"

# 下载包
cd "$HOME/.cache/pkg-tmp/"
pkg_Cul="https://download.jetbrains.com/datagrip/datagrip-2018.3.3"
pkg_Type=".tar.gz"
curl -L "$pkg_Cul$pkg_Type" -o datagrip.tar.gz

# 安装包
tar -xzvf datagrip.tar.gz -C "$HOME/.config/Manual/"
ln -s -f "$HOME/.config/Manual/DataGrip-2018.3.3/bin/datagrip.sh" "$HOME/.config/Manual/bin/datagrip"

# 赋予执行权限
chmod -R +x "$HOME/.config/Manual/bin"

# 清理环境
rm -rf "$HOME/.cache/pkg-tmp"
sync
