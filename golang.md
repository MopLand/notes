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

## 相关链接

- [Go 编程语言/文档](https://go-zh.org/doc/)
- [Go 编程语言/标准包](https://go-zh.org/pkg/)
- [Go 编程语言/标准包中文文档](https://studygolang.com/pkgdoc)
- [Go 编程最佳实践](https://peter.bourgon.org/go-best-practices-2016/)
- [golang笔记——命令](https://www.cnblogs.com/tianyajuanke/p/5196436.html)
- [go语言学习-常用命令](https://www.cnblogs.com/itogo/p/8645441.html)


