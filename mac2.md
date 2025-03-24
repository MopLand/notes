
Mac
Apache
/etc/apache2

sudo nano /etc/wpa_supplicant/wpa_supplicant.conf

network={
    ssid="BangBang"
    key_mgmt=WPA-PSK
    psk="hg0777034"
}


## 使用 Brew 安装 PHP 开发环境

## 1. 安装 Homebrew
#### Homebrew是一个包管理器，用于安装软件和工具。如果您的Mac上还没有安装Homebrew，请按照以下步骤进行安装：

/### 使用 gitee 脚本安装（推荐）
/bin/zsh -c "$(curl -fsSL https://gitee.com/cunkai/HomebrewCN/raw/master/Homebrew.sh)"

### 使用官方脚本安装
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

## 1. 关闭自带的 appche
sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist

## 2. 安装 PHP
#### 使用Homebrew安装PHP，安装完成后，您可以使用以下命令来验证PHP是否安装成功：
brew install php

## 3. 安装 apache
brew install httpd

## 2. 安装Redis
### 使用Homebrew安装Redis，安装完成后，Redis将默认运行在6379端口：
brew install redis

## 安装PHP Redis扩展

### 1. 安装PECL
PECL是PHP扩展和工具的集合。如果您的Mac上还没有安装PECL，请按照以下步骤进行安装：

brew install pecl

## 安装 composer 扩展

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'.PHP_EOL; } else { echo 'Installer corrupt'.PHP_EOL; unlink('composer-setup.php'); exit(1); }"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer


### 2. 安装 phpredis 扩展
使用PECL安装 phpredis 扩展：

pecl install redis

## 4. 配置PHP
### 创建 /opt/homebrew/etc/httpd/extra/httpd-php.conf 文件，并添加以下内容：

LoadModule php_module /opt/homebrew/opt/php/lib/httpd/modules/libphp.so

<FilesMatch \.php$>
    SetHandler application/x-httpd-php
</FilesMatch>

## 测试Redis PHP扩展
在PHP脚本中，您可以尝试以下代码来测试Redis PHP扩展是否安装成功：

## 5. 安装 MySQL
brew install mysql

### 启动MySQL服务：
brew services start mysql

### 更新 MySQL 密码
ALTER USER 'root'@'localhost' IDENTIFIED BY 'your_password';


sudo /bin/chmod +a 'user:maxbuff:allow write' /etc/hosts


<?php
$redis = new Redis();
$redis->connect('127.0.0.1', 6379);
echo "Redis server is running";
phpinfo();

## 常用命令
brew services start httpd
brew services stop httpd
brew services restart httpd

brew services start redis
brew services stop redis
brew services restart redis

### 停止 MySQL 服务
brew services start mysql
brew services stop mysql

### 重启 MySQL 服务
brew services restart mysql

## 常用目录
/opt/homebrew/etc/apache/
/opt/homebrew/etc/php/8.4/
/opt/homebrew/opt/mysql/

## 参考链接
https://getcomposer.org/download/
https://sspai.com/post/56009#!#
https://www.cnblogs.com/Nestar/p/18074872
https://blog.csdn.net/qq_28993251/article/details/116160956
https://www.oryoy.com/news/mac-huan-jing-xia-qing-song-pei-zhi-redis-php-kuo-zhan-yi-bu-dao-wei-de-an-zhuang-zhi-nan.html

-------------


To enable PHP in Apache add the following to httpd.conf and restart Apache:
    LoadModule php_module /opt/homebrew/opt/php/lib/httpd/modules/libphp.so

    <FilesMatch \.php$>
        SetHandler application/x-httpd-php
    </FilesMatch>

Finally, check DirectoryIndex includes index.php
    DirectoryIndex index.php index.html

The php.ini and php-fpm.ini file can be found in:
    /opt/homebrew/etc/php/8.4/

To start php now and restart at login:
  brew services start php
Or, if you don't want/need a background service you can just run:
  /opt/homebrew/opt/php/sbin/php-fpm --nodaemonize
==> Summary
🍺  /opt/homebrew/Cellar/php/8.4.4: 529 files, 107.9MB
==> Running `brew cleanup php`...
Disable this behaviour by setting HOMEBREW_NO_INSTALL_CLEANUP.
Hide these hints with HOMEBREW_NO_ENV_HINTS (see `man brew`).
==> Caveats
==> php
To enable PHP in Apache add the following to httpd.conf and restart Apache:
    LoadModule php_module /opt/homebrew/opt/php/lib/httpd/modules/libphp.so

    <FilesMatch \.php$>
        SetHandler application/x-httpd-php
    </FilesMatch>

Finally, check DirectoryIndex includes index.php
    DirectoryIndex index.php index.html

The php.ini and php-fpm.ini file can be found in:
    /opt/homebrew/etc/php/8.4/

To start php now and restart at login:
  brew services start php
Or, if you don't want/need a background service you can just run:
  /opt/homebrew/opt/php/sbin/php-fpm --nodaemonize
