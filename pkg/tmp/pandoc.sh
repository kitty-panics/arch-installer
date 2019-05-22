#!/bin/bash

# 创建必要的目录

mkdir -p ~/.config/lib
mkdir -p ~/.cache/temporary
cd ~/.cache/temporary
mDefaults=$(pwd)

# 安装 - Pandoc

cd $mDefaults
curl -L "https://github.com/jgm/pandoc/releases/download/2.1.3/pandoc-2.1.3-linux.tar.gz" -o pandoc.tar.gz
tar xvzf pandoc.tar.gz -C "$HOME/.config/lib"
ln -s -f "$HOME/.config/lib/pandoc-2.1.3/bin/pandoc" "$HOME/.config/lib"
ln -s -f "$HOME/.config/lib/pandoc-2.1.3/bin/pandoc-citeproc" "$HOME/.config/lib"

# 赋予执行权限

chmod +x ~/.config/lib/*

# 清理环境

rm -rf ~/.cache/temporary
sync
