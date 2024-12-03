#!/bin/bash

# ak_monitor 安装与管理脚本

INSTALL_DIR="/etc/ak_monitor"
SERVICE_NAME="ak_monitor"
SERVICE_FILE="/etc/systemd/system/ak_monitor.service"

# 安装 ak_monitor
install_ak_monitor() {
  echo "开始安装 ak_monitor..."
  
  # 创建安装目录
  mkdir -p "$INSTALL_DIR"
  cd "$INSTALL_DIR" || exit
  
  # 下载 ak_monitor 可执行文件
  wget -O ak_monitor https://github.com/akile-network/akile_monitor/releases/download/v0.01/akile_monitor-linux-amd64
  chmod 777 ak_monitor
  
  # 创建 systemd 服务文件
  cat > "$SERVICE_FILE" <<EOF
[Unit]
Description=AkileCloud Monitor Service
After=network.target nss-lookup.target
Wants=network.target

[Service]
User=root
Group=root
Type=simple
LimitAS=infinity
LimitRSS=infinity
LimitCORE=infinity
LimitNOFILE=999999999
WorkingDirectory=$INSTALL_DIR
ExecStart=$INSTALL_DIR/ak_monitor
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

  # 重新加载 systemd 服务并启用服务
  systemctl daemon-reload
  systemctl enable ak_monitor

  echo "ak_monitor 安装完成！"
}

# 启动 ak_monitor 服务
start_ak_monitor() {
  echo "启动 ak_monitor 服务..."
  systemctl start ak_monitor
  echo "ak_monitor 服务已启动！"
}

# 重启 ak_monitor 服务
restart_ak_monitor() {
  echo "重启 ak_monitor 服务..."
  systemctl restart ak_monitor
  echo "ak_monitor 服务已重启！"
}

# 停止 ak_monitor 服务
stop_ak_monitor() {
  echo "停止 ak_monitor 服务..."
  systemctl stop ak_monitor
  echo "ak_monitor 服务已停止！"
}

# 显示菜单并处理用户选择
menu() {
  echo "------------------------"
  echo " Akile Monitor 主控端 管理脚本"
  echo "------------------------"
  echo "1. 安装 ak_monitor"
  echo "2. 启动 ak_monitor"
  echo "3. 重启 ak_monitor"
  echo "4. 停止 ak_monitor"
  echo "5. 退出"
  echo "------------------------"
  read -p "请选择操作 (1-5): " choice

  case $choice in
    1)
      install_ak_monitor
      ;;
    2)
      start_ak_monitor
      ;;
    3)
      restart_ak_monitor
      ;;
    4)
      stop_ak_monitor
      ;;
    5)
      echo "退出程序。"
      exit 0
      ;;
    *)
      echo "无效选择，请重新选择。"
      menu
      ;;
  esac
}

# 启动菜单
menu
