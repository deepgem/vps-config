#!/bin/bash

# =================================================================
# Filename: change_hostname.sh
# Description: A script to change the hostname on a Debian server.
# Author: Deepgem
# Version: 1.0
# =================================================================

# --- 要设置的新主机名 ---
NEW_HOSTNAME="lucky"

# 检查脚本是否以 root 权限运行
if [ "$(id -u)" -ne 0 ]; then
   echo "错误：此脚本必须以 root 权限运行。" >&2
   echo "请尝试使用 'sudo ./change_hostname.sh' 来执行。" >&2
   exit 1
fi

# 获取当前主机名以供显示
OLD_HOSTNAME=$(hostname)

# 检查新旧主机名是否相同
if [ "$OLD_HOSTNAME" == "$NEW_HOSTNAME" ]; then
    echo "主机名已经是 '$NEW_HOSTNAME'，无需更改。"
    exit 0
fi

echo "准备将主机名从 '$OLD_HOSTNAME' 更改为 '$NEW_HOSTNAME'..."

# 使用 hostnamectl 设置新的主机名
# 这是在现代基于 systemd 的系统中更改主机名的首选方法。
# 它会自动处理 /etc/hostname 和 /etc/hosts 的更新，并通知系统。
hostnamectl set-hostname "$NEW_HOSTNAME"

# 检查命令是否执行成功
if [ $? -eq 0 ]; then
    echo "主机名已成功更改为 '$NEW_HOSTNAME'！"
    echo "要使更改在当前的 Shell 提示符中生效，请重新登录或执行 'su - $USER'。"
else
    echo "错误：更改主机名失败。" >&2
    exit 1
fi

exit 0
