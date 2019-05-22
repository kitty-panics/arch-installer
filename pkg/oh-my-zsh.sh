#!/bin/bash

#
# 安装 oh-my-zsh
#

# 创建临时目录
mkdir -p "$HOME/.cache/pkg-tmp"

# 下载包
git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh "$HOME/.config/Manual/oh-my-zsh"

# 安装包
# :

# 赋予执行权限
# :

# 清理环境
rm -rf "$HOME/.cache/pkg-tmp"
sync
