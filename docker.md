# Docker

## Docker 安装

	# 使用 YUM 安装
	yum install docker

	# 启动
	systemctl start docker

	# 测试
	docker run hello-world

## 常用命令

### 生命周期管理

	# 创建一个新的容器并运行一个命令
	docker run
	docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
	docker run -i -t ubuntu:14.04 /bin/bash

	-a stdin: 指定标准输入输出内容类型，可选 STDIN/STDOUT/STDERR 三项；
	-d: 后台运行容器，并返回容器ID；	
	-i: 以交互模式运行容器，通常与 -t 同时使用；	
	-t: 为容器重新分配一个伪输入终端，通常与 -i 同时使用；	
	--name="nginx-lb": 为容器指定一个名称；	
	--dns 8.8.8.8: 指定容器使用的DNS服务器，默认和宿主一致；	
	--dns-search example.com: 指定容器DNS搜索域名，默认和宿主一致；	
	-h "mars": 指定容器的hostname；	
	-e username="ritchie": 设置环境变量；	
	--env-file=[]: 从指定文件读入环境变量；	
	--cpuset="0-2" or --cpuset="0,1,2": 绑定容器到指定CPU运行；	
	-m :设置容器使用内存最大值；	
	--net="bridge": 指定容器的网络连接类型，支持 bridge/host/none/container: 四种类型；	
	--link=[]: 添加链接到另一个容器；	
	--expose=[]: 开放一个端口或一组端口；
	
	# 启动/停止/重启容器
	docker start/stop/restart
	
	# 杀掉一个运行中的容器
	docker kill
	
	# 删除一个或多少容器
	docker rm
	
	# 暂停/恢复容器中所有的进程
	docker pause/unpause
	
	# 创建一个新的容器但不启动它
	docker create
	
	# 在运行的容器中执行命令
	docker exec
	-d :分离模式: 在后台运行
	-i :即使没有附加也保持STDIN 打开
	-t :分配一个伪终端

### 容器操作

	# 在运行的容器中执行命令
	docker ps
	
	# 获取容器/镜像的元数据
	docker inspect
	
	# 查看容器中运行的进程信息，支持 ps 命令参数
	docker top
	
	# 连接到正在运行中的容器
	docker attach
	
	# 从服务器获取实时事件
	docker events
	
	# 获取容器的日志
	docker logs
	
	# 阻塞运行直到容器停止，然后打印出它的退出代码
	docker wait
	
	# 将文件系统作为一个 tar 归档文件导出到 STDOUT
	docker export
	
	# 列出指定的容器的端口映射，或者查找将 PRIVATE_PORT NAT 到面向公众的端口
	docker port

### 容器rootfs命令

	# 从容器创建一个新的镜像
	docker commit
	
	# 用于容器与主机之间的数据拷贝
	docker cp
	
	# 检查容器里文件结构的更改
	docker diff

### 镜像仓库

	# 登陆到一个 Docker 镜像仓库
	docker login
	
	# 从镜像仓库中拉取或者更新指定镜像
	docker pull ubuntu

	# 将本地的镜像上传到镜像仓库，要先登陆到镜像仓库
	docker push
	
	# 从 Docker Hub 查找镜像
	docker search ubuntu

### 本地镜像管理

	# 查看镜像
	docker images

	# 删除本地一个或多少镜像
	docker rmi

	# 标记本地镜像，将其归入某一仓库
	docker tag

	# 使用 Docker file 创建镜像
	docker build

	# 查看指定镜像的创建历史
	docker history

	# 将指定镜像保存成 tar 归档文件
	docker save

	# 从归档文件中创建镜像
	docker import

### Docker 状态

	# 查看版本
	docker version
	
	# 显示 Docker 系统信息
	docker info

### 查看当前运行的容器
	docker ps
	docker ps -a

## 实例操作

### 本地文件
	cd /disk/app

### Dockerfile
	
	# 指定我们的基础镜像是 node
	FROM node

	# 指定制作我们的镜像的联系人信息（镜像创建者）
	MAINTAINER admin@veryide.com
	
	# 将根目录下的文件都 copy 到 container（运行此镜像的容器）文件系统的app文件夹下
	ADD . /app/

	# cd 到 app 文件夹下
	WORKDIR /app

	# 把当前目录下的所有文件拷贝到镜像中
	COPY . /app
	
	# 安装项目依赖包
	RUN npm install
	
	# 容器对外暴露的端口号
	EXPOSE 4500
	
	# 容器启动时执行的命令，类似 npm run start
	CMD ["npm", "start"]

### 在当前目录创建镜像
	docker build -t segment .

### 运行容器
	docker run -d -p 8888:4500 segment

### 上传镜像

	# 登录 Docker Hub
	docker login
	
	# 镜像打上tag，namespace 可以指定为你的 Docker Id
	docker tag <name:tag> <namespace>/<name:tag>

	docker tag segment:1.0 mopland/segment:1.0
	
	# 将镜像上传至 docker 的公共仓库
	docker push <namespace>/<name:tag>

	docker push mopland/segment:1.0
	
	# 退出登录
	docker logout

### 下载镜像
	docker pull <namespace>/<name:tag>
	
	docker pull mopland/segment:1.0