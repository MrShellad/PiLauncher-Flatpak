#!/bin/bash

set -e

REPO_URL="https://mrshellad.github.io/PiLauncher-Flatpak"
REMOTE_NAME="pilauncher"
APP_ID="com.mrshell.PiLauncher"

echo "==> 正在添加 Flatpak 源..."

# 如果已存在就跳过
if flatpak remotes | grep -q "$REMOTE_NAME"; then
    echo "==> 源已存在，跳过添加"
else
    flatpak remote-add --if-not-exists "$REMOTE_NAME" \
    "$REPO_URL" \
    --gpg-import="$REPO_URL/public.gpg"
fi

echo "==> 更新源..."
flatpak update "$REMOTE_NAME" -y || true

echo "==> 安装应用..."
flatpak install "$REMOTE_NAME" "$APP_ID" -y

echo "==> 完成 ✅"
echo "你现在可以在系统菜单中找到 PiLauncher 了"