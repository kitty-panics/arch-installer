#!/bin/bash

#
# 安装 Translator
#

# 创建临时目录
mkdir -p "$HOME/.cache/pkg-tmp"

# 下载包
cd "$HOME/.cache/pkg-tmp"
curl -L "https://github.com/jgm/pandoc/releases/download/2.7.3/pandoc-2.7.3-linux.tar.gz" -O
cd ~

# 安装包
cd "$HOME/.cache/pkg-tmp"
tar -xzvf pandoc-2.7.3-linux.tar.gz
mv -f "pandoc-2.7.3" "$HOME/.config/Manual/pandoc"
ln -sf "$HOME/.config/Manual/pandoc/bin/pandoc"          "$HOME/.config/Manual/bin/pandoc"
ln -sf "$HOME/.config/Manual/pandoc/bin/pandoc-citeproc" "$HOME/.config/Manual/bin/pandoc-citeproc"
cd ~

# 赋予执行权限
chmod +x "$HOME/.config/Manual/bin/pandoc"
chmod +x "$HOME/.config/Manual/bin/pandoc-citeproc"

# 清理环境
rm -rf "$HOME/.cache/pkg-tmp"
sync
