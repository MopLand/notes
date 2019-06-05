# GoLang

## 环境变量

### GOROOT
	golang 安装路径

### GOPATH
	golang 工作目录，允许多个目录，使用 [;] 分隔
	
	~/.bash_profile
	export GOPATH=$HOME/workspace/go
	
	~/.bash_profile
	export GOPATH=%USERPROFILE%\go;E:\Works\Go

### GOBIN
	go install 编译存放路径，不允许多个目录

## 常用命令

	build: 编译包和依赖
	clean: 移除对象文件
	doc: 显示包或者符号的文档
	env: 打印go的环境信息
	bug: 启动错误报告
	fix: 运行go tool fix
	fmt: 运行gofmt进行格式化
	generate: 从processing source生成go文件
	get: 下载并安装包和依赖
	install: 编译并安装包和依赖
	list: 列出包
	run: 编译并运行go程序
	test: 运行测试
	tool: 运行go提供的工具
	version: 显示go的版本
	vet: 运行go tool vet

## 编译选项

	$GOOS      $GOARCH
	android    arm
	darwin     386
	darwin     amd64
	darwin     arm
	darwin     arm64
	dragonfly  amd64
	freebsd    386
	freebsd    amd64
	freebsd    arm
	linux      386
	linux      amd64
	linux      arm
	linux      arm64
	linux      ppc64
	linux      ppc64le
	linux      mips
	linux      mipsle
	linux      mips64
	linux      mips64le
	netbsd     386
	netbsd     amd64
	netbsd     arm
	openbsd    386
	openbsd    amd64
	openbsd    arm
	plan9      386
	plan9      amd64
	solaris    amd64
	windows    386
	windows    amd64
	
	$ SET CGO_ENABLED=0
	$ SET GOOS=linux
	$ SET GOARCH=amd64
	$ go build test.go


## 项目结构

	myproject
	|-- bin
	|   +-- myapp
	|-- pkg
	|   +-- linux_amd64
	|       +-- mylib.a
	+-- src
		|-- myapp
		|   +-- myapp.go
		+-- mylib
			+-- logger.go

## 生成 Windows exe 图标

### 安装 rsrc
	go get github.com/akavel/rsrc

### 创建 main.exe.manifest 文件

	<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
	<assembly xmlns="urn:schemas-microsoft-com:asm.v1" manifestVersion="1.0">
	<assemblyIdentity
		version="1.0.0.0"
		processorArchitecture="x86"
		name="controls"
		type="win32"
	></assemblyIdentity>
	<dependency>
		<dependentAssembly>
			<assemblyIdentity
				type="win32"
				name="Microsoft.Windows.Common-Controls"
				version="6.0.0.0"
				processorArchitecture="*"
				publicKeyToken="6595b64144ccf1df"
				language="*"
			></assemblyIdentity>
		</dependentAssembly>
	</dependency>
	</assembly>

### 生成 syso 文件
	rsrc -manifest main.exe.manifest -ico main.ico -o main.syso

### 编译生成 main.exe

	# 指定输出文件
	go build -o main.exe
	
	# 带编译选项，-s 去掉符号信息，-w 去掉DWARF调试信息
	go build -o main.exe -ldflags "-s -w"
	
## GoLang 包管理工具 dep

### dep 安装
	go get -u github.com/golang/dep/cmd/dep
	
### dep 使用

	#进入项目，需要确包含在 $GOPATH 中
	cd /home/gopath/src/demo
	
	#dep初始化，初始化配置文件Gopkg.toml
	dep init
	
	#dep加载依赖包，自动归档到vendor目录
	dep ensure
	
### dep 生成文件
	Gopkg.lock 是生成的文件，不要手工修改
	Gopkg.toml 是依赖管理的核心文件，可以生成也可以手动修改
	vendor 目录是 golang1.5 以后依赖管理目录，这个目录的依赖代码是优先加载的
	
### 无法下载 golang.org/x/ 库时，使用代理
	
	# 查找代理端口号
	netstat -ano
	
	# 使用 shadowsocks 代理
	set http_proxy=127.0.0.1:1080
	set https_proxy=127.0.0.1:1080
	
	# 或使用 GOPROXY 代理服务
	set GOPROXY=https://goproxy.io
	
## 相关链接

- [Go 编程语言/文档](https://go-zh.org/doc/)
- [Go 编程语言/标准包](https://go-zh.org/pkg/)
- [Go 编程语言/标准包中文文档](https://studygolang.com/pkgdoc)
- [Go 编程最佳实践](https://peter.bourgon.org/go-best-practices-2016/)
- [golang笔记——命令](https://www.cnblogs.com/tianyajuanke/p/5196436.html)
- [go语言学习-常用命令](https://www.cnblogs.com/itogo/p/8645441.html)
- [Go基本数据类型](https://www.cnblogs.com/hanbowen/p/10391388.html)
- [Build and (re)start go web apps after saving/creating/deleting source files.](https://github.com/gravityblast/fresh)
- [Very simple compile daemon for Go](https://github.com/githubnemo/CompileDaemon)
- [golang程序在windows上，注册为服务](https://blog.csdn.net/yang8023tao/article/details/53332984)


