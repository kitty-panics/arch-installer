#!/bin/bash

#
# 安装 Thunderbird
#

# 创建临时目录
mkdir -p "$HOME/.cache/pkg-tmp"

# 下载包
cd "$HOME/.cache/pkg-tmp"
curl -L "https://download.jetbrains.com/idea/ideaIU-2019.2.tar.gz" -o "ideaIU-2019.2.tar.gz"
cd ~

# 安装包
cd "$HOME/.cache/pkg-tmp"
tar -xzvf ideaIU-2019.2.tar.gz
mv -f "idea-IU-192.5728.98" "$HOME/.config/Manual/idea"
ln -sf "$HOME/.config/Manual/idea/bin/idea.sh" "$HOME/.config/Manual/bin/idea"
cd ~

# 赋予执行权限
chmod +x "$HOME/.config/Manual/bin/idea"

# 清理环境
rm -rf "$HOME/.cache/pkg-tmp"
sync
