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
	rsrc -manifest main.exe.manifest -ico rc.ico -o main.syso

### 编译生成 main.exe
	go build -o main.exe

## 相关链接

- [Go 编程语言/文档](https://go-zh.org/doc/)
- [Go 编程语言/标准包](https://go-zh.org/pkg/)
- [Go 编程语言/标准包中文文档](https://studygolang.com/pkgdoc)
- [Go 编程最佳实践](https://peter.bourgon.org/go-best-practices-2016/)
- [golang笔记——命令](https://www.cnblogs.com/tianyajuanke/p/5196436.html)
- [go语言学习-常用命令](https://www.cnblogs.com/itogo/p/8645441.html)
- [Go基本数据类型](https://www.cnblogs.com/hanbowen/p/10391388.html)


