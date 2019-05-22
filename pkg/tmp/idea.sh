#!/bin/bash

#
# 安装 IDEA
#

# 创建必要的目录
mkdir -p "$HOME/.cache/pkg-tmp"

# 下载包
cd "$HOME/.cache/pkg-tmp/"
pkg_Cul="https://download.jetbrains.com/idea/ideaIU-2018.3.5-no-jdk"
pkg_Type=".tar.gz"
curl -L "$pkg_Cul$pkg_Type" -o idea.tar.gz

# 安装包
tar -xzvf idea.tar.gz -C "$HOME/.config/Manual/"
ln -s -f "$HOME/.config/Manual/idea-IU-183.5912.21/bin/idea.sh" "$HOME/.config/Manual/bin/idea"

# 赋予执行权限
chmod -R +x "$HOME/.config/Manual/bin"

# 清理环境
rm -rf "$HOME/.cache/pkg-tmp"
sync
