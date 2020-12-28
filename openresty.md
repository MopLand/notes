## 下载 、安装openresty
[openresty官网链接](http://openresty.org/cn/download.html)
按照官网下载安装
```powershell
tar -xzvf openresty-VERSION.tar.gz
cd openresty-VERSION/
./configure
make
make install
```

## 运行

```powershell
# 默认安装路径为 /usr/local/openresty
# pwd 命令来查看"当前工作目录"的完整路径
/usr/local/openresty/nginx/sbin/nginx -p `pwd`/ -c /usr/local/openresty/nginx/conf/nginx.conf

# 启动
/usr/local/openresty/nginx/sbin/nginx
# 停止
/usr/local/openresty/nginx/sbin/nginx -s stop
# 重启
/usr/local/openresty/nginx/sbin/nginx -s reload
# 检验nginx配置是否正确
/usr/local/openresty/nginx/sbin/nginx -t
```

## nignx 配置
启动文件为nginx.conf ，要支持多文件 需要加上 include conf.d/*.conf;

```powershell
··· 省略 ···

http {
    include       mime.types;
    default_type  application/octet-stream;
    #log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
    #                  '$status $body_bytes_sent "$http_referer" '
    #                  '"$http_user_agent" "$http_x_forwarded_for"';
    #access_log  logs/access.log  main;
    sendfile        on;
    #tcp_nopush     on;
    #keepalive_timeout  0;
    keepalive_timeout  65;
    #gzip  on;

	# 新建conf.d 新建不同的conf文件
    include conf.d/*.conf;

    server {
        listen       8099;
        server_name  localhost;

        #charset koi8-r;

        #access_log  logs/host.access.log  main;
··· 省略 ···
```

## lua 编程
[参考](https://blog.csdn.net/u013565163/article/details/105537199)

### set_by_lua
执行指定脚本和输入的值返回一个结果

```lua
-- set_by_lua $res <lua-script-str> [$arg1 $arg2...]
-- nginx conf 代码
--[[
location /foo {
 set $diff ''; # we have to predefine the $diff variable here
 set_by_lua $sum '
     local a = 32
     local b = 56
     ngx.var.diff = a - b;  -- write to $diff directly
     return a + b;          -- return the $sum value normally
	';
 echo "sum = $sum, diff = $diff";
]]
```


## 让systemd 管理

 1.   vim打开/usr/lib/systemd/system/nginx.service
内容如下
```powershell
[Unit]
Description=The nginx process manager
After=network.target remote-fa.target nss-lookup.target

[Service]
Type=forking
ExecStart=/usr/local/openresty/nginx/sbin/nginx
ExecReload=/usr/local/openresty/nginx/sbin -s reload
ExecStop=/usr/local/openresty/nginx/sbin -s stop
          
[Install]
WantedBy=multi-user.target
```

2. 重启system

```powershell
systemctl daemon-reload
```
[参考](https://blog.csdn.net/it_10/article/details/89057257)