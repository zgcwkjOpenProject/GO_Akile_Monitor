# akile_monitor

![预览图](https://github.com/akile-network/akile_monitor/blob/main/akile_monitor.jpg?raw=true)

前端项目地址 https://github.com/akile-network/akile_monitor_fe


后端主控部署教程：
```
mkdir /etc/ak_monitor/
cd /etc/ak_monitor/
wget -O ak_monitor https://github.com/akile-network/akile_monitor/releases/download/v0.01/akile_monitor-linux-amd64
chmod 777 ak_monitor

cat > /etc/systemd/system/ak_monitor.service <<EOF
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
WorkingDirectory=/etc/ak_monitor/
ExecStart=/etc/ak_monitor/ak_monitor
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target

EOF
```


复制配置文件到/etc/ak_monitor/config.json并配置文件

```
启动
systemctl start ak_monitor
关闭
systemctl stop ak_monitor
开机自启
systemctl enable ak_monitor
```


监控端安装教程
```
mkdir /etc/ak_monitor/
cd /etc/ak_monitor/
wget -O client https://github.com/akile-network/akile_monitor/releases/download/v0.01/akile_client-linux-amd64
chmod 777 client

cat > /etc/systemd/system/ak_client.service <<EOF
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
WorkingDirectory=/etc/ak_monitor/
ExecStart=/etc/ak_monitor/client
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target

EOF
```
复制配置文件到/etc/ak_monitor/client.json并配置文件

```
启动
systemctl start ak_client
关闭
systemctl stop ak_client
开机自启
systemctl enable ak_client
```



