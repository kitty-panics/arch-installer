#!/bin/bash

#
# 安装 DejaVuSansMono Nerd Font Mono
#

# 创建临时目录
mkdir -p "$HOME/.cache/pkg-tmp"

# 下载包
git clone --depth=1 https://github.com/Cool-Pan/DejaVuSansMono "$HOME/.config/Manual/DejaVuSansMono"

# 安装包
fc-cache -f


# 赋予执行权限
# :

# 清理环境
rm -rf "$HOME/.cache/pkg-tmp"
sync
