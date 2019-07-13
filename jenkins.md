# Jenkins

## Windows

### 修改端口号

	java -jar jenkins.war --ajp13Port=-1 --httpPort=9090

### 启动服务
	net start jenkins

### 停止服务
	net stop jenkins