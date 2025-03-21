# RaspberryPi

## 启用 root

### 更新密码
sudo passwd root

### 配置 ssh
sudo vi /etc/ssh/sshd_config
#PermitRootLogin prohibit-password
PermitRootLogin yes

### 配置 rsa
echo "your_rsa_keys" > /root/.ssh/authorized_keys

### 重启 ssh
systemctl restart sshd

## 关机命令
sudo shutdown -h now

## 配置 Wifi

### mac 地址

有线：b8:27:eb:1c:26:34
无线：b8:27:eb:49:73:61

### 列出 wifi
iwlist wlan0 scan

### 单个网络
vi /etc/wpa_supplicant/wpa_supplicant.conf

country=GB
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

network={
    key_mgmt=WPA-PSK
    ssid="wifi_001"
    psk="password_001"
}

### 多个网络

·其中priority为优先级，值越大，优先级越高·

country=GB
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

network={
    ssid="wifi_001"
    psk="password_001"
    priority=9
} 
network={
    ssid="wifi_002"
    psk="password_002"
    priority=1
}

## 相关链接
[树莓派(Raspberry Pi OS)操作系统如何选择？](https://www.cnblogs.com/mq0036/p/18130075)
[树莓派3B/3B+/4B 刷机装系统烧录镜像教程](https://www.cnblogs.com/ChuanYangRiver/p/15136991.html)
[树莓派3命令行配置wifi无线连接和蓝牙连接](https://www.embbnux.com/2016/04/10/raspberry_pi_3_wifi_and_bluetooth_setting_on_console/)
[安装树莓派3B+环境（嵌入式开发）](https://blog.csdn.net/qq_74824173/article/details/146132403)
[Operating system images for Raspberry Pi](https://www.raspberrypi.com/software/operating-systems/)
