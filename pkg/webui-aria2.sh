#!/bin/bash

#
# 安装 webui-aria2
#

# 创建临时目录
mkdir -p "$HOME/.cache/pkg-tmp"

# 下载包
git clone --depth=1 https://github.com/ziahamza/webui-aria2 "$HOME/.config/Manual/webui-aria2"

# 安装包
cp -rf "$HOME/.config/Manual/webui-aria2/favicon.ico" "$HOME/.config/Manual/webui-aria2/docs/"

# 赋予执行权限
# :

# 清理环境
rm -rf "$HOME/.cache/pkg-tmp"
sync
