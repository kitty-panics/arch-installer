#!/bin/bash

#
# 安装 Thunderbird
#

# 创建临时目录
mkdir -p "$HOME/.cache/pkg-tmp"

# 下载包
cd "$HOME/.cache/pkg-tmp"
curl -L "https://download.jetbrains.com/webstorm/WebStorm-2019.2.tar.gz" -o "WebStorm-2019.2.tar.gz"
cd ~

# 安装包
cd "$HOME/.cache/pkg-tmp"
tar -xzvf WebStorm-2019.2.tar.gz
mv -f "WebStorm-192.5728.87" "$HOME/.config/Manual/WebStorm"
ln -sf "$HOME/.config/Manual/WebStorm/bin/webstorm.sh" "$HOME/.config/Manual/bin/webstorm"
cd ~

# 赋予执行权限
chmod +x "$HOME/.config/Manual/bin/webstorm"

# 清理环境
rm -rf "$HOME/.cache/pkg-tmp"
sync
