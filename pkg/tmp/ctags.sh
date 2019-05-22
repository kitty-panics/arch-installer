#!/bin/bash

# 创建必要的目录

mkdir -p ~/.config/lib
mkdir -p ~/.cache/temporary
cd ~/.cache/temporary
mDefaults=$(pwd)

# 安装 - Ctags

cd $mDefaults
git clone --depth=1 https://github.com/universal-ctags/ctags ~/.config/lib/ctags.git
cd ~/.config/lib/ctags.git
./autogen.sh
./configure
make
ln -s -f "$HOME/.config/lib/ctags.git/ctags" "$HOME/.config/lib"

# 赋予执行权限

chmod +x ~/.config/lib/*

# 清理环境

rm -rf ~/.cache/temporary
sync
