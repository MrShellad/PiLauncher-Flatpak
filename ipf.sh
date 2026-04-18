#!/bin/bash

set -e

REPO_URL="https://mrshellad.github.io/PiLauncher-Flatpak"
REMOTE_NAME="pilauncher"
APP_ID="com.mrshell.PiLauncher"
GPG_FILE="/tmp/pilauncher.gpg"

echo "==> 下载 GPG 公钥..."
curl -fsSL "$REPO_URL/public.gpg" -o "$GPG_FILE"

echo "==> 检查源是否已存在..."
if flatpak remote-list --columns=name | grep -Fxq "$REMOTE_NAME"; then
    echo "==> 源已存在，跳过添加"
else
    echo "==> 添加 Flatpak 源..."
    flatpak remote-add --user --if-not-exists "$REMOTE_NAME" \
        "$REPO_URL" \
        --gpg-import="$GPG_FILE"
fi

echo "==> 安装应用..."
flatpak install --user "$REMOTE_NAME" "$APP_ID" -y

echo "==> 完成 ✅"
