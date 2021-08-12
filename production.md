# Production

## Nginx

### Nginx 安装
	yum install -y nginx

### Nginx 配置

> /etc/nginx.conf

	# Server identity
    map $host $server_node {
		default "ins-example";
	}
	
	# Server Tokens
	server_tokens  off;
    
    # Server identity
    add_header X-Server-Node $server_node "always";

    # Sites config
    include /disk/sites/*.conf;

> /etc/fastcgi_params

	fastcgi_param  SCRIPT_FILENAME    $document_root$fastcgi_script_name;
	fastcgi_param  SERVER_NODE        $server_node;

### Nginx 启动
	systemctl enable nginx
	systemctl start nginx

## PHP

### PHP 安装
	yum install php php-fpm php-gd php-curl php-redis php-pdo php-pdo_mysql php-xml php-json php-opcache php-openssl -y

### PHP 配置

> /etc/php.ini

	date.timezone = Asia/Shanghai

### PHP-FPM 启动
	systemctl enable php-fpm
	systemctl start php-fpm
