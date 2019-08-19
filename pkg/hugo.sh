#!/bin/bash

#
# 安装 Hugo
#

# 创建临时目录
mkdir -p "$HOME/.cache/pkg-tmp"

# 下载包
cd "$HOME/.cache/pkg-tmp"
curl -L "https://github.com/gohugoio/hugo/releases/download/v0.55.6/hugo_0.55.6_Linux-64bit.tar.gz" -O
cd ~

# 安装包
cd "$HOME/.cache/pkg-tmp"
mkdir hugo && tar -xzvf hugo_0.55.6_Linux-64bit.tar.gz -C hugo
mv -f "hugo" "$HOME/.config/Manual/"
ln -sf "$HOME/.config/Manual/hugo/hugo" "$HOME/.config/Manual/ubin/hugo"
cd ~

# 赋予执行权限
chmod +x "$HOME/.config/Manual/ubin/hugo"

# 清理环境
rm -rf "$HOME/.cache/pkg-tmp"
sync
