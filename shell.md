# Shell

## 代码片段

### 当前Shell位置
	basepath=$(cd `dirname $0`; pwd)

### 获得 GIT hooks 环境变量
	#!/bin/bash
	echo Running $BASH_SOURCE
	set | egrep GIT
	echo PWD is $PWD

## 条件判断

### 整数比较

	= 比较两个字符串
	-lt	小于
	-le	小于等于
	-eq	等于
	-gt	大于
	-ge	大于等于
	-ne	不等于

### 逻辑的(and)与(or)

	&& 逻辑的 AND 的意思，别名 -a 
	|| 逻辑的 OR 的意思，别名 -o

### 文件权限比较

	-r 有读的权限
	-w 有写的权限
	-x 有执行的权限

### 文件比较符

	-e 判断对象是否存在
	-d 判断对象是否存在，并且为目录
	-f 判断对象是否存在，并且为常规文件
	-L 判断对象是否存在，并且为符号链接
	-h 判断对象是否存在，并且为软链接
	-s 判断对象是否存在，并且长度不为0
	-r 判断对象是否存在，并且可读
	-w 判断对象是否存在，并且可写
	-x 判断对象是否存在，并且可执行
	-O 判断对象是否存在，并且属于当前用户
	-G 判断对象是否存在，并且属于当前用户组
	-nt 判断file1是否比file2新  [ "/data/file1" -nt "/data/file2" ]
	-ot 判断file1是否比file2旧  [ "/data/file1" -ot "/data/file2" ]
	
### IF 判断

#### 文件夹不存在则创建
	if [ ! -d "/data/" ];then
		mkdir /data
	else
		echo "exist"
	fi
	
#### 判断文件是否存在
	if [ ! -f "/data/filename" ];then
		touch /data/filename
	elif [ ! -w "/data/filename" ] then
		echo "Non-Writable"
	else
		echo "exist"
	fi

### CASE 语句

	case $1 in
	"1")
		echo "周一";;
	"2")
		echo "周二";;
	*)
		echo "others";;
	esac

	# ./test.sh 1

### for 循环

	# 使用 $*
	for i in "$*"
	  do
	    echo "the nums are $i"
	done
	
	echo "====================="
	
	# 使用 $@
	
	INDEX=0
	
	for j in "$@"
	  do
	    INDEX=$[$INDEX + 1]
	    echo "the num of $INDEX is $j"
	done

	# ./test.sh 11 22 33

### while 循环

	SUM=0
	idx=0
	
	while [ $i -le $1 ]
	do
		SUM=$[$SUM+$i]
		idx=$[$idx + 1]
	done
	
	echo "从1加到$1的总和为：$SUM"

	# ./test.sh 49

### read 读取控制台输入

#### 语法
	read（选项）（参数）
		选项：-p 指定读取时的提示符；
			-t 指定读取时等待的时间（秒），如果没有在指定的时间内输入，就不在等待；
		参数: 变量，指定读取的变量名，将读取到的内容赋值给变量；

#### 例子
	
	read -t 5 -p "请输入一个数字num：" NUM1
	echo "您输入的数字为：$NUM1"

	# ./read.sh

### 自定义函数

	function getSumFromInput(){
		SUM=$[$n1 + $n2]
		echo "输入参数的和为：$SUM"
	}
	
	read -p "请输入一个数值：" n1
	read -p "请输入一个数值：" n2
	
	getSumFromInput $n1 $n2

	# ./func.sh
	
## 常见错误

### $'\r': command not found

	文件换行符必需是 Unix (LF)
	
### CentOS 7.3 环境中，LF 换行符的 Shell 可能会出错，需要转换为

	Mac (CR)
	
## 相关链接

- [Linux Shell脚本学习指南](http://c.biancheng.net/shell/)
- [Shell传入参数的处理](https://blog.csdn.net/andylauren/article/details/68957195)
- [Linux学习笔记 -- 为 Shell 传递参数](https://www.cnblogs.com/atuotuo/p/6431289.html)
- [linux shell脚本通过参数名传递参数值](https://www.cnblogs.com/rwxwsblog/p/5668254.html)
- [Linux学习——Shell语法](https://juejin.im/post/5ce8f030518825338614124e)
- [9 个实用 shell 脚本，建议收藏！](https://segmentfault.com/a/1190000041440679)