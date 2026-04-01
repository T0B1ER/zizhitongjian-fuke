#!/bin/bash
set -e

cd /home/gem/workspace/zizhitongjian

# 覆盖全局git配置，强制使用ssh推送
git config --local url."git@github.com:".insteadOf "git@github.com:"

# 计算进度
completed=$(ls chapters/*.md 2>/dev/null | wc -l)
total=294
progress=$(echo "scale=1; $completed / $total * 100" | bc)

# 更新README进度
sed -i "s#.*当前进度.*#- 🚀 **当前进度**：试点阶段，已完成 $completed/$total 卷（$progress%）#" README.md

# 提交变更
git add .
git commit -m "Auto sync: $(date +"%Y-%m-%d %H:%M") | 完成 $completed 卷标注，进度 $progress%" || echo "No changes to commit"

# 推送到GitHub
git pull origin main --rebase
git push origin main

echo "✅ Sync completed at $(date +"%Y-%m-%d %H:%M") | Progress: $completed/$total ($progress%) | 已同步到远程仓库"
