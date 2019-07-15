#!/bin/bash

#
# 安装 logoly
#

# 创建临时目录
mkdir -p "$HOME/.cache/pkg-tmp"

# 下载包
git clone --depth=1 https://github.com/bestony/logoly "$HOME/.config/Manual/logoly"

# 安装包
cd "$HOME/.config/Manual/logoly"
npm install

# 赋予执行权限
# :

# 清理环境
rm -rf "$HOME/.cache/pkg-tmp"
sync
