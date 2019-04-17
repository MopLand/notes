# Linux 常用命令

## 常用命令

### 清屏命令
	clear
	reset

### 查找大文件
	find . -type f -size +100M

### 删除30天前的文件
	find /disk/www/www.tdb.com/attach/ -mtime +30 -name "*.jpg" -exec rm -rf {} \;

### 服务器运行时间
	uptime

### 最近几次重启记录
	last reboot

### 结束执行中的程序或工作

	kill [options] [param]

	-a：当处理当前进程时，不限制命令名和进程号的对应关系；
	-l：<信息编号>：若不加<信息编号>选项，则-l参数会列出全部的信息名称；
	-p：指定kill 命令只打印相关进程的进程号，而不发送任何信号；
	-s：<信息名称或编号>：指定要送出的信息；
	-u：指定用户
	
### 按照进程名杀死进程

	pkill [options] [param]
	
	-o：仅向找到的最小（起始）进程号发送信号；
	-n：仅向找到的最大（结束）进程号发送信号；
	-P：指定父进程号发送信号；
	-g：指定进程组；
	-t：指定开启进程的终端
	-f：正则表达式模式将执行与完全进程参数字符串匹配

### 使用进程的名称来杀死进程，使用此指令可以杀死一组同名进程

	killall [options] [param]

	-e：对长名称进行精确匹配；
	-l：忽略大小写的不同；
	-p：杀死进程所属的进程组；
	-i：交互式杀死进程，杀死进程前需要进行确认；
	-l：打印所有已知信号列表；
	-q：如果没有进程被杀死。则不输出任何信息；
	-r：使用正规表达式匹配要杀死的进程名称；
	-s：用指定的进程号代替默认信号“SIGTERM”；
	-u：杀死指定用户的进程

### 查看端口占用情况
	netstat -tln | grep 8080

### 查看端口属于哪个程序
	lsof -i :8080

### 远程登录
	ssh userName@ip

### 查看文件头10行
	head -n 10 example.txt

### 查看文件尾10行
	tail -n 10 example.txt

### 显示新增内容
	tail -f exmaple.log

### 列出目标目录中所有的子目录和文件

	ls [options] [file]

	-a, –all 列出目录下的所有文件，包括以 . 开头的隐含文件
	-A 同-a，但不列出“.”(表示当前目录)和“..”(表示当前目录的父目录)。
	-c  配合 -lt：根据 ctime 排序及显示 ctime (文件状态最后更改的时间)配合 -l：显示 ctime 但根据名称排序否则：根据 ctime 排序
	-C 每栏由上至下列出项目
	–color[=WHEN] 控制是否使用色彩分辨文件。WHEN 可以是'never'、'always'或'auto'其中之一
	-d, –directory 将目录象文件一样显示，而不是显示其下的文件。
	-D, –dired 产生适合 Emacs 的 dired 模式使用的结果
	-f 对输出的文件不进行排序，-aU 选项生效，-lst 选项失效
	-g 类似 -l,但不列出所有者
	-G, –no-group 不列出任何有关组的信息
	-h, –human-readable 以容易理解的格式列出文件大小 (例如 1K 234M 2G)
	–si 类似 -h,但文件大小取 1000 的次方而不是 1024
	-H, –dereference-command-line 使用命令列中的符号链接指示的真正目的地
	–indicator-style=方式 指定在每个项目名称后加上指示符号<方式>：none (默认)，classify (-F)，file-type (-p)
	-i, –inode 印出每个文件的 inode 号
	-I, –ignore=样式 不印出任何符合 shell 万用字符<样式>的项目
	-k 即 –block-size=1K,以 k 字节的形式表示文件的大小。
	-l 除了文件名之外，还将文件的权限、所有者、文件大小等信息详细列出来。
	-L, –dereference 当显示符号链接的文件信息时，显示符号链接所指示的对象而并非符号链接本身的信息
	-m 所有项目以逗号分隔，并填满整行行宽
	-o 类似 -l,显示文件的除组信息外的详细信息。   
	-r, –reverse 依相反次序排列
	-R, –recursive 同时列出所有子目录层
	-s, –size 以块大小为单位列出所有文件的大小
	-S 根据文件大小排序
	–sort=WORD 以下是可选用的 WORD 和它们代表的相应选项：
	extension -X status -c
	none -U time -t
	size -S atime -u
	time -t access -u
	version -v use -u
	-t 以文件修改时间排序
	-u 配合 -lt:显示访问时间而且依访问时间排序
	配合 -l:显示访问时间但根据名称排序
	否则：根据访问时间排序
	-U 不进行排序;依文件系统原有的次序列出项目
	-v 根据版本进行排序
	-w, –width=COLS 自行指定屏幕宽度而不使用目前的数值
	-x 逐行列出项目而不是逐栏列出
	-X 根据扩展名排序
	-1 每行只列出一个文件

### 文件下载
	wget http://www.minjieren.com/wordpress-3.1-zh_CN.zip

### 当前工作目录
	pwd [options]
	-L 目录连接链接时，输出连接路径
	-P 输出物理路径

### 查看登录用户
	w
	-h 忽略头文件信息
	-u 显示结果的加载时间
	-s 不显示JCPU， PCPU， 登录时间
	
### 谁登录了系统
	who - [husfV] [user]
	-h 不要显示标题列
	-u 不要显示使用者的动作/工作
	-s 使用简短的格式来显示
	-f 不要显示使用者的上线位置
	-V 显示程序版本

### 查看恶意ip试图登录次数
	# 日志位置 /var/log/btmp
	lastb | awk '{ print $3}' | sort | uniq -c | sort -n

### 内存使用情况
	free [options]
	-b 　以Byte为单位显示内存使用情况。 
	-k 　以KB为单位显示内存使用情况。 
	-m 　以MB为单位显示内存使用情况。
	-g   以GB为单位显示内存使用情况。 
	-o 　不显示缓冲区调节列。 
	-s 　<间隔秒数> 持续观察内存使用状况。 
	-t 　显示内存总和列。 
	-V 　显示版本信息。 

### 任务管理器
	top [-] [d] [p] [q] [c] [C] [S] [s] [n]
	d 指定每两次屏幕信息刷新之间的时间间隔。当然用户可以使用s交互命令来改变之。 
	p 通过指定监控进程ID来仅仅监控某个进程的状态。 
	q 该选项将使top没有任何延迟的进行刷新。如果调用程序有超级用户权限，那么top将以尽可能高的优先级运行。 
	S 指定累计模式 
	s 使top命令在安全模式中运行。这将去除交互命令所带来的潜在危险。 
	i 使top不显示任何闲置或者僵死进程。 
	c 显示整个命令行而不只是显示命令名 

### 文件或程序搜索
	whereis [-bmsu] [BMS 目录名 -f ] 文件名
	-b   定位可执行文件。
	-m   定位帮助文件。
	-s   定位源代码文件。
	-u   搜索默认路径下除可执行文件、源代码文件、帮助文件以外的其它文件。
	-B   指定搜索可执行文件的路径。
	-M   指定搜索帮助文件的路径。
	-S   指定搜索源代码文件的路径。

### 快速搜索指定档案
	locate [选择参数] [样式]
	-e   将排除在寻找的范围之外。
	-1  如果 是 1．则启动安全模式。在安全模式下，使用者不会看到权限无法看到	的档案。
		这会始速度减慢，因为 locate 必须至实际的档案系统中取得档案的	权限资料。
	-f   将特定的档案系统排除在外，例如我们没有到理要把 proc 档案系统中的档案	放在资料库中。
	-q  安静模式，不会显示任何错误讯息。
	-n 至多显示 n个输出。
	-r 使用正规运算式 做寻找的条件。
	-o 指定资料库存的名称。
	-d 指定资料库的路径
	-h 显示辅助讯息
	-V 显示程式的版本讯息

## 磁盘信息

### 磁盘使用情况
	df [options] [file]
	-a 全部文件系统列表
	-h 方便阅读方式显示
	-H 等于“-h”，但是计算式，1K=1000，而不是1K=1024
	-i 显示inode信息
	-k 区块为1024字节
	-l 只显示本地文件系统
	-m 区块为1048576字节
	--no-sync 忽略 sync 命令
	-P 输出格式为POSIX
	--sync 在取得磁盘信息前，先执行sync命令
	-T 文件系统类型

### 目录使用情况
	du [options] [file]
	-a或-all  显示目录中个别文件的大小。   
	-b或-bytes  显示目录或文件大小时，以byte为单位。   
	-c或--total  除了显示个别目录或文件的大小外，同时也显示所有目录或文件的总和。 
	-k或--kilobytes  以KB(1024bytes)为单位输出。
	-m或--megabytes  以MB为单位输出。   
	-s或--summarize  仅显示总计，只列出最后加总的值。
	-h或--human-readable  以K，M，G为单位，提高信息的可读性。
	-x或--one-file-xystem  以一开始处理时的文件系统为准，若遇上其它不同的文件系统目录则略过。 
	-L<符号链接>或--dereference<符号链接> 显示选项中所指定符号链接的源文件大小。   
	-S或--separate-dirs   显示个别目录的大小时，并不含其子目录的大小。 
	-X<文件>或--exclude-from=<文件>  在<文件>指定目录或文件。   
	--exclude=<目录或文件>         略过指定的目录或文件。    
	-D或--dereference-args   显示指定符号链接的源文件大小。   
	-H或--si  与-h参数相同，但是K，M，G是以1000为换算单位。   
	-l或--count-links   重复计算硬件链接的文件。

	当前目录大小
	du -sh .

	当前目录下文件或目录的大小
	du -sh *

	显示前十个占用空间最大的文件或目录
	du -sh * | sort -nr | head

## 文件目录
		
### 创建新文件
	touch [options] [file]
	-a   或--time=atime或--time=access或--time=use 　只更改存取时间。
	-c   或--no-create 　不建立任何文档。
	-d 　使用指定的日期时间，而非现在的时间。
	-f 　此参数将忽略不予处理，仅负责解决BSD版本touch指令的兼容性问题。
	-m   或--time=mtime或--time=modify 　只更改变动时间。
	-r 　把指定文档或目录的日期时间，统统设成和参考文档或目录的日期时间相同。
	-t 　使用指定的日期时间，而非现在的时间。
	
### 写入文件
	echo text > file.txt
	echo text >> file.txt

### 创建目录
	mkdir /tmp/test

### 删除目录
	rmdir /tmp/test

### 切换目录
	cd [dirname]

### 删除文件
	rm [options] file.txt
	-i 删除前逐一询问确认。
	-f 即使原档案属性设为唯读,亦直接删除,无需逐一确认。
	-r 将目录及以下之档案亦逐一删除。

### 重命名文件
	rename [-v] [-n] [-f] perlexpr [files]

	第一个参数：被替换掉的字符串
	第二个参数：替换成的字符串
	第三个参数：匹配要替换的文件模式
	 
	支持通配符：	? 可替代单个字符	* 可替代多个字符

	//把文件名中的AA替换成aa
	rename "s/AA/aa/" *
	
	//把.html 后缀的改成 .php后缀
	rename "s//.html//.php/" *
	
	//把所有的文件名都以txt结尾
	rename "s/$//.txt/" *

	//把所有以.txt结尾的文件名的.txt删掉 
	rename "s//.txt//" *

### 复制文件
	cp [options] source dest
	-a 尽可能将档案状态,权限等资料都照原状予以复制。
	-r 若source 中含有目录名,则将目录下之档案亦皆依序拷贝至目的地。
	-f 若目的地已经有相同档名的档案存在,则在复制前先予以删除再行复制

### 移动文件
	mv [options] source dest
	-i 若目的地已有同名档案,则先询问是否覆盖旧档。

### 链接文件
	ln [options] source dist
	-b 删除，覆盖以前建立的链接
	-d 允许超级用户制作目录的硬链接
	-f 强制执行
	-i 交互模式，文件存在则提示用户是否覆盖
	-n 把符号链接视为一般目录
	-s 软链接(符号链接)
	-v 显示详细的处理过程

### 显示文件内容
	cat [options] [file]
	一次显示整个文件:cat filename
	从键盘创建一个文件:cat > filename 只能创建新文件,不能编辑已有文件.
	将几个文件合并为一个文件:cat file1 file2 > file

### 显示部分文件内容
	head [options] [file]
	-q 隐藏文件名
	-v 显示文件名
	-c<字节> 显示字节数
	-n<行数> 显示的行数

### 显示内容并加上行号
	nl [options] [file]
	-b  ：指定行号指定的方式，主要有两种：
	-b a ：表示不论是否为空行，也同样列出行号(类似 cat -n)；
	-b t ：如果有空行，空的那一行不要列出行号(默认值)；

	-n  ：列出行号表示的方法，主要有三种：
	-n ln ：行号在萤幕的最左方显示；
	-n rn ：行号在自己栏位的最右方显示，且不加 0 ；
	-n rz ：行号在自己栏位的最右方显示，且加 0 ；

	-w  ：行号栏位的占用的位数。
	-p 在逻辑定界符处不重新开始计算。

## 用户管理

### 新增用户
	useradd staff -s /sbin/nologin

### 新增用户，并指定目录
	useradd staff -s /sbin/nologin -d /disk/www/edu.veryide.com

### 更改用户，并指定目录
	usermod staff -s /sbin/nologin -d /disk/www/edu.veryide.com

### 删除用户
	userdel staff

### 更改密码
	passwd staff

## 用户权限

### 更改所有者
	chown -R staff /www/html

### 更改所有者和组
	chown -R staff:net /www/html

### 更改读写权限
	chmod 777 /www/html

### 更改用户组
	chgrp mysql /var/lib/mysql

## 用户组

### 创建组
	groupadd test

### 修改组
	groupmod -n test2 test

### 删除组
	groupdel test2

## 压缩文件

	语 法：zip [-AcdDfFghjJKlLmoqrSTuvVwXyz$][-b <工作目录>][-ll][-n <字尾字符串>][-t <日期时间>][-<压缩效率>][压缩文件][文件...][-i <范本样式>][-x <范本样式>] 

	语 法：unzip [-cflptuvz][-agCjLMnoqsVX][-P <密码>][.zip文件][文件][-d <目录>][-x <文件>] 或 unzip [-Z]

### 我想把一个文件 abc.txt 和一个目录 dir1 打包
	zip -r data.zip abc.txt dir1

### 解压缩 data.zip 文件
	unzip data.zip

### 同时解压多个 zip 文件
	unzip abc\?.zip
	注释：?表示一个字符，如果用*表示任意多个字符。

### 查看压缩文件 large.zip 中的内容
	unzip -v large.zip

### 验证压缩文件 large.zip 是否完整
	unzip -t large.zip

### 剔除压缩文件中的子目录关系
	unzip -j music.zip

### 把整个文件夹 folderTared 的内容打包成一个gz文件：
	tar czvf data.tar.gz /theDir/folderTared

### 把压缩的gz文件恢复到指定目录下：
	tar xzvf data.tar.gz /theDir/

## gunzip

### 格式 
	gunzip [-acfhlLnNqrtvV][-s ][文件...]
	gunzip [-acfhlLnNqrtvV][-s ][目录]

### 主要参数 
	-a或--ascii：使用ASCII文字模式。 
	-c或--stdout或--to-stdout：把解压后的文件输出到标准输出设备。 
	-f或-force：强行解开压缩文件，不理会文件名称或硬连接是否存在，以及该文件是否为符号连接。 
	-h或--help：在线帮助。 
	-l或--list：列出压缩文件的相关信息。 
	-L或--license：显示版本与版权信息。 
	-n或--no-name：解压缩时，若压缩文件内含有原来的文件名称及时间戳记，则将其忽略不予处理。 
	-N或--name：解压缩时，若压缩文件内含有原来的文件名称及时间戳记，则将其回存到解开的文件上。 
	-q或--quiet：不显示警告信息。 
	-r或--recursive：递归处理，将指定目录下的所有文件及子目录一并处理。 
	-S或--suffix：更改压缩字尾字符串。 
	-t或--test：测试压缩文件是否正确无误。 
	-v或--verbose：显示指令执行过程。 
	-V或--version：显示版本信息。

### 使用gzip压缩（保留源文件）
	gzip –c filename > filename.gz

### 解压gzip文件（保留源文件）
	gunzip –c filename.gz > filename

## 时间与日期

	# 删除当前默认时区
	rm -rf /etc/localtime
	
	# 复制替换默认时区为上海
	cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
	
	# 修改时区（备用）
	dpkg-reconfigure tzdata
	
	# 重新选取了时区
	tzselect
	
	# 当前时间
	date
	
	# 当前 UTC 时间
	date -u

## 时区更改

	# 时区查看
	timedatectl

	# 列出所有时区
	timedatectl list-timezones

	# 将硬件时钟调整为与本地时钟一致, 0 为设置为 UTC 时间
	timedatectl set-local-rtc 1

	# 设置系统时区为上海
	timedatectl set-timezone Asia/Shanghai

	# NTP 时间同步	
	*/20 * * * * /usr/sbin/ntpdate pool.ntp.org >/dev/null &

## 显示和设置行为选项

	# 显示选项，以 globstar 为例
	shopt globstar
	
	# 打开选项
	shopt -s globstar
	
	# 关闭选项
	shopt -u globstar