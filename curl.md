
# cURL

## Windows

### php_ssh2-0.12-5.5-ts-vc11-x64

	复制 php_ssh2.dll 和 php_ssh2.pdb 到 php/ext

### libssh2-1.7.0-vc11-x86/bin

	复制 libssh2.dll 和 libssh2.lib 到 C:\Windows\SysWOW64	

## Linux

### 语法
	curl [option] [url]

### 常见参数

	-A/--user-agent <string>              设置用户代理发送给服务器
	-b/--cookie <name=string/file>    cookie字符串或文件读取位置
	-c/--cookie-jar <file>                    操作结束后把cookie写入到这个文件中
	-C/--continue-at <offset>            断点续转
	-D/--dump-header <file>              把header信息写入到该文件中
	-e/--referer                                  来源网址
	-f/--fail                                          连接失败时不显示http错误
	-o/--output                                  把输出写到该文件中
	-O/--remote-name                      把输出写到该文件中，保留远程文件的文件名
	-r/--range <range>                      检索来自HTTP/1.1或FTP服务器字节范围
	-s/--silent                                    静音模式。不输出任何东西
	-T/--upload-file <file>                  上传文件
	-u/--user <user[:password]>      设置服务器的用户和密码
	-w/--write-out [format]                什么输出完成后
	-x/--proxy <host[:port]>              在给定的端口上使用HTTP代理
	-#/--progress-bar                        进度条显示当前的传送状态

### 使用示例

#### 1、基本用法
	
	# curl http://www.linux.com
	执行后，www.linux.com 的html就会显示在屏幕上了

#### 指定 DNS 解析

	curl https://DOMAIN.EXAMPLE --resolve 'DOMAIN.EXAMPLE:443:192.0.2.17'
	
#### 2、保存访问的网页

	2.1:使用linux的重定向功能保存	
	# curl http://www.linux.com >> linux.html

	2.2:可以使用curl的内置option:-o(小写)保存网页
	
	$ curl -o linux.html http://www.linux.com
	执行完成后会显示如下界面，显示100%则表示保存成功
	
	% Total    % Received % Xferd  Average Speed  Time    Time    Time  Current
	                                Dload  Upload  Total  Spent    Left  Speed
	100 79684    0 79684    0    0  3437k      0 --:--:-- --:--:-- --:--:-- 7781k
	2.3:可以使用curl的内置option:-O(大写)保存网页中的文件
	
	# curl -O http://www.linux.com/hello.sh

#### 3、测试网页返回值
	
	# curl -o /dev/null -s -w %{http_code} www.linux.com
	Ps:在脚本中，这是很常见的测试网站是否正常的用法
	
#### 4、指定proxy服务器以及其端口

	很多时候上网需要用到代理服务器(比如是使用代理服务器上网或者因为使用curl别人网站而被别人屏蔽IP地址的时候)，幸运的是curl通过使用内置option：-x来支持设置代理
	
	# curl -x 192.168.100.100:1080 http://www.linux.com

#### 5、cookie

	有些网站是使用cookie来记录session信息。对于chrome这样的浏览器，可以轻易处理cookie信息，但在curl中只要增加相关参数也是可以很容易的处理cookie

	5.1:保存http的response里面的cookie信息。内置option:-c（小写）
	
	# curl -c cookiec.txt  http://www.linux.com
	执行后cookie信息就被存到了cookiec.txt里面了
	
	5.2:保存http的response里面的header信息。内置option: -D
	
	# curl -D cookied.txt http://www.linux.com
	执行后cookie信息就被存到了cookied.txt里面了
	
	注意：-c(小写)产生的cookie和-D里面的cookie是不一样的。
	
	5.3:使用cookie
	很多网站都是通过监视你的cookie信息来判断你是否按规矩访问他们的网站的，因此我们需要使用保存的cookie信息。内置option: -b
	
	# curl -b cookiec.txt http://www.linux.com

#### 6、模仿浏览器

	有些网站需要使用特定的浏览器去访问他们，有些还需要使用某些特定的版本。curl内置option:-A可以让我们指定浏览器去访问网站
	
	# curl -A "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.0)" http://www.linux.com
	这样服务器端就会认为是使用IE8.0去访问的
	
#### 7、伪造referer（盗链）

	很多服务器会检查http访问的referer从而来控制访问。比如：你是先访问首页，然后再访问首页中的邮箱页面，这里访问邮箱的referer地址就是访问首页成功后的页面地址，如果服务器发现对邮箱页面访问的referer地址不是首页的地址，就断定那是个盗连了
	curl中内置option：-e可以让我们设定referer
	
	# curl -e "www.linux.com" http://mail.linux.com
	这样就会让服务器其以为你是从www.linux.com点击某个链接过来的
	
#### 8、下载文件

	8.1：利用curl下载文件。

	#使用内置option：-o(小写)
	
	# curl -o dodo1.jpg http:www.linux.com/dodo1.jpg
	#使用内置option：-O（大写)
	
	# curl -O http://www.linux.com/dodo1.jpg
	这样就会以服务器上的名称保存文件到本地
	
	8.2：循环下载
	有时候下载图片可以能是前面的部分名称是一样的，就最后的尾椎名不一样
	
	# curl -O http://www.linux.com/dodo[1-5].JPG
	这样就会把dodo1，dodo2，dodo3，dodo4，dodo5全部保存下来
	
	8.3：下载重命名
	
	# curl -O http://www.linux.com/{hello,bb}/dodo[1-5].JPG
	由于下载的hello与bb中的文件名都是dodo1，dodo2，dodo3，dodo4，dodo5。因此第二次下载的会把第一次下载的覆盖，这样就需要对文件进行重命名。
	
	# curl -o #1_#2.JPG http://www.linux.com/{hello,bb}/dodo[1-5].JPG
	这样在hello/dodo1.JPG的文件下载下来就会变成hello_dodo1.JPG,其他文件依此类推，从而有效的避免了文件被覆盖
	
	8.4：分块下载
	有时候下载的东西会比较大，这个时候我们可以分段下载。使用内置option：-r
	
	# curl -r 0-100 -o dodo1_part1.JPG http://www.linux.com/dodo1.JPG
	# curl -r 100-200 -o dodo1_part2.JPG http://www.linux.com/dodo1.JPG
	# curl -r 200- -o dodo1_part3.JPG http://www.linux.com/dodo1.JPG
	# cat dodo1_part* > dodo1.JPG
	这样就可以查看dodo1.JPG的内容了
	
	8.5：通过ftp下载文件
	curl可以通过ftp下载文件，curl提供两种从ftp中下载的语法
	
	# curl -O -u 用户名:密码 ftp://www.linux.com/dodo1.JPG
	# curl -O ftp://用户名:密码@www.linux.com/dodo1.JPG
	8.6：显示下载进度条
	
	# curl -# -O http://www.linux.com/dodo1.JPG
	8.7：不会显示下载进度信息
	
	# curl -s -O http://www.linux.com/dodo1.JPG

#### 9、断点续传

	在windows中，我们可以使用迅雷这样的软件进行断点续传。
	curl 可以通过内置 option:-C 同样可以达到相同的效果，如果在下载dodo1.JPG的过程中突然掉线了，可以使用以下的方式续传
	
	# curl -C -O http://www.linux.com/dodo1.jpg

#### 10、上传文件
	curl不仅仅可以下载文件，还可以上传文件。通过内置option:-T来实现
	
	# curl -T dodo1.JPG -u 用户名:密码 ftp://www.linux.com/img/
	这样就向ftp服务器上传了文件dodo1.JPG
	
#### 11、显示抓取错误
	
	# curl -f http://www.linux.com/error


## 常见问题

### cURL error 28: Operation timed out after 5000 milliseconds with 0 out of -1 bytes received
	先排除是网络问题导致的超时，比如外网带宽到达上限，导致不能正常接收数据

## 相关链接

- [libcurl error codes](http://curl.haxx.se/libcurl/c/libcurl-errors.html)