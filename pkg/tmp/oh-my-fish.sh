#!/bin/bash

#
# 安装 oh-my-fish
#

# 创建临时目录
mkdir -p "$HOME/.cache/pkg-tmp"

# 下载包
git clone --depth=1 https://github.com/oh-my-fish/oh-my-fish "$HOME/.config/Manual/oh-my-fish"

# 安装包
# :

# 赋予执行权限
# :

# 清理环境
rm -rf "$HOME/.cache/pkg-tmp"
sync
