#!/bin/bash

#
# 安装 JDK8
#

# 创建必要的目录
mkdir -p "$HOME/.cache/pkg-tmp"

# 下载包
cd "$HOME/.cache/pkg-tmp/"
pkg_Cul="https://download.oracle.com/otn-pub/java/jdk/8u202-b08/1961070e4c9b4e26a04e7f5a083f551e/jdk-8u202-linux-x64"
pkg_Type=".tar.gz"
curl -L "$pkg_Cul$pkg_Type" -o jdk8.tar.gz

# 安装包
tar -xzvf jdk8.tar.gz -C "$HOME/.config/Manual/"

# 赋予执行权限
chmod -R +x "$HOME/.config/Manual/bin"

# 清理环境
rm -rf "$HOME/.cache/pkg-tmp"
sync
