#!/bin/bash

#
# 安装 Tomcat 8
#

# 创建临时目录
mkdir -p "$HOME/.cache/pkg-tmp"

# 下载包
cd "$HOME/.cache/pkg-tmp"
curl -L "http://mirror.bit.edu.cn/apache/tomcat/tomcat-8/v8.5.39/bin/apache-tomcat-8.5.39.tar.gz" -o apache-tomcat.tar.gz

# 安装包
tar -xzvf apache-tomcat.tar.gz -C "$HOME/.config/Manual/"

# 赋予执行权限
chmod +x "$HOME/.config/Manual/apache-tomcat-8.5.39/bin/*"

# 清理环境
rm -rf "$HOME/.cache/pkg-tmp"
sync
