#!/bin/bash

#
# 安装 i3bra
#

# 创建临时目录
mkdir -p "$HOME/.cache/pkg-tmp"

# 下载包
git clone --depth=1 https://github.com/Cool-Pan/i3bra "$HOME/.config/Manual/i3bra"

# 安装包
mkdir -p "$HOME/.config/i3bra"
cp -rf "$HOME/.config/Manual/i3bra/template/config.template" "$HOME/.config/i3bra/config"
ln -sf "$HOME/.config/Manual/i3bra/i3bra"                    "$HOME/.config/Manual/ubin/i3bra"

# 赋予执行权限
chmod +x "$HOME/.config/Manual/ubin/i3bra"

# 清理环境
rm -rf "$HOME/.cache/pkg-tmp"
sync
