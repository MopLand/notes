# 团队协作

## V2ray

### 安装命令
	bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh)

### 配置文件
	# cat /usr/local/etc/v2ray/config.json

	{
		"$schema": "https://github.com/EHfive/v2ray-jsonschema/raw/main/v4-config.schema.json",
		"log": {
			"loglevel": "info",
			"access": "/var/log/v2ray/access.log",
			"error": "/var/log/v2ray/error.log"
		},
		"inbounds": [
			{
			"port": 8000,
			"listen": "127.0.0.1",
			"protocol": "vmess",
			"settings": {
				"clients": [
				{
					"id": "be5cefcb-****-****-****-6d3c649411a2",
					"alterId": 0
				}
				]
			},
			"streamSettings": {
				"network": "ws",
				"wsSettings": {
				"path": "/ws",
				"headers": {
					"Host": "hk.example.com"
				}
				}
			}
			}
		],
		"outbounds": [
			{
			"protocol": "freedom",
			"settings": {}
			}
		]
	}

### Nginx 站点
	server {
		listen 80;
		listen [::]:80;
		listen 443 ssl http2;
		listen [::]:443 ssl http2;

		server_name hk.example.com;
		index index.html index.htm;
		root /disk/www/go.example.com;

		access_log off;
		ssl_certificate /disk/certs/hk.example.com.crt;
		ssl_certificate_key /disk/certs/hk.example.com.key;

		location /ws {
			# WebSocket协商失败时返回404
			if ($http_upgrade != "websocket") {
				return 404;
			}

			proxy_redirect off;
			proxy_pass http://127.0.0.1:8000;
			proxy_http_version 1.1;

			proxy_set_header Upgrade $http_upgrade;
			proxy_set_header Connection "upgrade";
			proxy_set_header Host $host;

			proxy_set_header X-Real-IP $remote_addr;
			proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		}

		location ~ .*\.(gif|jpg|jpeg|png|bmp|swf|flv|mp4|ico)$ {
			expires 30d;
			access_log off;
		}
		
		location ~ .*\.(js|css)?$ {
			expires 7d;
			access_log off;
		}
		
		location ~ /(\.user\.ini|\.ht|\.git|\.svn|\.project|LICENSE|README\.md) {
			deny all;
		}
		
		location /.well-known {
			allow all;
		}
	}

### 启动服务
	systemctl enable v2ray
	systemctl start v2ray

## 开发工具

### 写作工具

[MarkdownPad - MarkDown 格式编辑器](http://markdownpad.com/)

### 代理抓包

[Charles Web Debugging Proxy](https://www.charlesproxy.com/)

### 编辑器

[Notepad2 - 轻量级单文件编辑器](http://www.flos-freeware.ch/notepad2.html)

[Visual Studio Code - 微软出品的编辑器](https://code.visualstudio.com/)

[Beyond Compare - 文件对比工具](http://www.scootersoftware.com/download.php)

### Git 版本管理

#### 基础工具：
[GIT-SCM](https://git-scm.com/downloads)

#### GUI 工具：
[TortoiseGIT](https://tortoisegit.org/download/)

### SVN 版本管理

[TortoiseSVN](https://tortoisesvn.net/downloads.zh.html)

## 终端工具

### Tabby 跨平台终端（Windows/Mac）

[A terminal for the modern age](https://tabby.sh/)

### iTerm2 终端模拟器（Mac）

[macOS Terminal Replacement](https://www.iterm2.com/)

### XShell 终端模拟器（Windows）

[Xshell是一个功能强大的终端模拟器，支持SSH、SFTP、telnet，rlogin和串行](https://pc.qq.com/detail/4/detail_2644.html)

## 常用服务

### 在线正则测试
[https://regexr.com/](https://regexr.com/)

### 项目跟踪管理

[https://tower.im/](https://tower.im/)

包含项目、动态、周报和日历等实用功能

### 源代码托管

[https://github.com/](https://github.com/)

最大的面向开源及私有软件项目的托管平台

[http://git.oschina.net/](http://git.oschina.net/)

国内比较可靠的第三方 Git 托管服务，支持私有项目

### CDN 公共资源

[http://staticfile.org/](http://staticfile.org/)

来自七牛云，免费、快速、开放的 CDN 服务

[https://www.bootcdn.cn/](https://www.bootcdn.cn/)

稳定、快速、免费的前端开源项目 CDN 加速服务

### Gif录制

[licecap - 支持 PC / Mac](http://www.cockos.com/licecap/)

### 上传下载

[FileZilla - 支持 PC / Mac / Linux](https://filezilla-project.org/download.php?show_all=1)

## Chrome 扩展

### 广告过滤

[AdBlock](https://chrome.google.com/webstore/detail/adblock/gighmmpiobklfepjocnamgkkbiglidom)

### JSON格式化

[JSON-handle](https://chrome.google.com/webstore/detail/json-handle/iahnhfdhidomcpggpaimmmahffihkfnj)

### 高级收藏夹

[Bookmark Manager](https://chrome.google.com/webstore/detail/bookmark-manager/gmlllbghnfkpflemihljekbapjopfjik)

### 文本提取

[Copyfish 🐟 Free OCR Software](https://chrome.google.com/webstore/detail/copyfish-🐟-free-ocr-soft/eenjdnjldapjajjofmldgmkjaienebbj)

### QRCode

[The QR Code Extension](https://chrome.google.com/webstore/detail/the-qr-code-extension/oijdcdmnjjgnnhgljmhkjlablaejfeeb)

#### User-Agent

[User-Agent Switcher for Chrome](https://chrome.google.com/webstore/detail/user-agent-switcher-for-c/djflhoibgkdhkhhcedjiklpkjnoahfmg)

### 流量节省程序

[Data Saver](https://chrome.google.com/webstore/detail/data-saver/pfmgfdlgomnbgkofeojodiodmgpgmkac)