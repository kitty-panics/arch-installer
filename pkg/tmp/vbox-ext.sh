#!/bin/bash

# 创建必要的目录

mkdir -p ~/.config/lib
mkdir -p ~/.cache/temporary
cd ~/.cache/temporary
mDefaults=$(pwd)

# 安装 - Oracle VM VirtualBox Extension Pack

cd $mDefaults
curl -L "https://download.virtualbox.org/virtualbox/5.2.10/Oracle_VM_VirtualBox_Extension_Pack-5.2.10.vbox-extpack" -O
mkdir -p ~/.config/lib/vbox-ext
mv -f "Oracle_VM_VirtualBox_Extension_Pack-5.2.10.vbox-extpack" ~/.config/lib/vbox-ext
cd ~/.config/lib/vbox-ext
sudo VBoxManage extpack uninstall "Oracle VM VirtualBox Extension Pack"
sudo VBoxManage extpack install "Oracle_VM_VirtualBox_Extension_Pack-5.2.10.vbox-extpack"

# 赋予执行权限

chmod +x ~/.config/lib/*

# 清理环境

rm -rf ~/.cache/temporary
sync
