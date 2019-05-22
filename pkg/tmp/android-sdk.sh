#!/bin/bash

# 设置软件包的下载链接地址
mUrl="https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip"

# 设置软件包的安装路径
mkdir -p ~/.config/lib
cd ~/.config/lib
mPath=$(pwd)

# 设置临时工作目录
mkdir -p ~/.cache/ppm
cd ~/.cache/ppm
mCache=$(pwd)

# 取得脚本自身名字并作为软件包名
mMyName=$0

# 卸载旧版本
Uninstall() {
    rm -rf $HOME/.config/lib/$mMyName
}

# 安装软件
Installation() {
    cd $mCache
    curl -L $mUrl -o $mMyName.zip

    7z x $mMyName.zip -o"$HOME/.config/lib/$mMyName"
}

# 清理环境
CleanUp() {
    chmod +x ~/.config/lib/*

    rm -rf ~/.cache/$mCache

    sync
}

if [ $1 == u ]; then
    echo -e "$mGreen 卸载软件中...... $mReset"
    Uninstall
    echo -e "$mGreen 卸载完成。 $mReset"

    echo -e "$mGreen 清理环境中...... $mReset"
    CleanUp
    echo -e "$mGreen 清理完成。 $mReset"
elif [ $1 == i ]; then
    echo -e "$mGreen 安装软件中...... $mReset"
    Installation
    echo -e "$mGreen 安装完成。 $mReset"

    echo -e "$mGreen 清理环境中...... $mReset"
    CleanUp
    echo -e "$mGreen 清理完成。 $mReset"
fi
