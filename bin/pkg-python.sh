#!/bin/bash

echo -e "是否升級全部包? [ y(Yes) / any(No) ]"
read -r yes_or_no
if [[ "$yes_or_no" == y ]]; then
    :
fi

echo -e "是否批量安裝所有包? [ y(Yes) / any(No) ]"
read -r yes_or_no_1
if [[ "$yes_or_no_1" == y ]]; then
    # 安裝 youtube-dl
    pip3 install --user youtube-dl

    # 安裝 you-get
    pip3 install --user you-get

    # 安裝 bypy
    pip3 install --user bypy

    # 安裝 autosub
    pip3 install --user git+https://github.com/agermanidis/autosub.git

    # Vim 中的 ale 插件
        # Vim
    pip3 install --user vim-vint
        # Yaml
    pip3 install --user yamllint

    # Vim 中的 autoformat 插件
        # Python
    pip3 install --user yapf

    # Vim 中的 youcompleteme 插件
        # jedi
    pip3 install --user jedi
fi
