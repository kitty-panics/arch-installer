#!/bin/bash

#
# 安装 Tomcat
#

# 创建必要的目录
mkdir -p "$HOME/.cache/pkg-tmp"

# 下载包
cd "$HOME/.cache/pkg-tmp/"
pkg_Cul="http://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-8/v8.5.38/bin/apache-tomcat-8.5.38"
pkg_Type=".tar.gz"
curl -L "$pkg_Cul$pkg_Type" -o tomcat.tar.gz

# 安装包
tar -xzvf tomcat.tar.gz -C "$HOME/.config/Manual/"

# 赋予执行权限
chmod -R +x "$HOME/.config/Manual/bin"

# 清理环境
rm -rf "$HOME/.cache/pkg-tmp"
sync
