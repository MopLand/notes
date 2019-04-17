# Shell

## 代码片段

### 当前Shell位置
	basepath=$(cd `dirname $0`; pwd)

### 获得 GIT hooks 环境变量
	#!/bin/bash
	echo Running $BASH_SOURCE
	set | egrep GIT
	echo PWD is $PWD

## 文件比较符

### 常用语法

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
	
### 使用示例

#### 文件夹不存在则创建
	if [ ! -d "/data/" ];then
		mkdir /data
	else
		echo "文件夹已经存在"
	fi
	
#### 判断文件是否存在
	if [ -f "/data/filename" ];then
		echo "文件存在"
	else
		echo "文件不存在"
	fi
	
## 相关链接

- [Shell传入参数的处理](https://blog.csdn.net/andylauren/article/details/68957195)
- [Linux学习笔记 -- 为 Shell 传递参数](https://www.cnblogs.com/atuotuo/p/6431289.html)
- [linux shell脚本通过参数名传递参数值](https://www.cnblogs.com/rwxwsblog/p/5668254.html)