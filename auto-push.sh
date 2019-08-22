#!/bin/bash

#
# 自动化 push
#

# 獲取隨機 commit
GET_COMMIT=$(curl -sL "http://whatthecommit.com/index.txt")

# 添加所有更改
git add -A
# 添加 commit 信息
git commit -m "$GET_COMMIT"
# 推送
git push
