#!/bin/bash

#
# 安装 Translator
#

# 创建临时目录
mkdir -p "$HOME/.cache/pkg-tmp"

# 下载包
git clone --depth=1 https://github.com/skywind3000/translator "$HOME/.config/Manual/translator"

# 安装包
#ln -sf "$HOME/.config/Manual/translator/translator.py" "$HOME/.config/Manual/ubin/translator.py"

# 赋予执行权限
# :

# 清理环境
rm -rf "$HOME/.cache/pkg-tmp"
sync
