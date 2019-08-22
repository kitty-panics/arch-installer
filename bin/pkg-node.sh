#!/bin/bash

echo -e "是否升級全部包? [ y(Yes) / any(No) ]"
read -r yes_or_no
if [[ "$yes_or_no" == y ]]; then
    :
fi

echo -e "是否批量安裝所有包? [ y(Yes) / any(No) ]"
read -r yes_or_no_1
if [[ "$yes_or_no_1" == y ]]; then
    # 安裝 yarn
    npm -g install yarn

    # 安裝 vue
    npm -g install vue
    npm -g install @vue/cli

    # 安裝 webpack
    npm -g install --save-dev webpack
    npm -g install --save-dev webpack-cli

    # Vim 中的 ale 插件
        # CSS
    npm -g install csslint
        # HTML
    npm -g install htmlhint
        # JavaScript
    npm -g install jshint
        # JSON
    npm -g install jsonlint
        # Markdown
    npm -g install markdownlint markdownlint-cli
        # Vue
    npm -g install vue-language-server

    # Vim 中的 autoformat 插件
        # JavaScript
    npm -g install standard
        # HTML、CSS
    npm -g install js-beautify
        # Typescript
    npm -g install typescript-formatter
        # Markdown
    npm -g install remark-cli
        # JSON
    npm -g install fixjson
fi
