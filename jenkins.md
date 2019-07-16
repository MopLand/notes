# Jenkins

## Windows

### 修改端口号
	java -jar jenkins.war --ajp13Port=-1 --httpPort=9090

### 启动服务
	net start jenkins

### 停止服务
	net stop jenkins

## Mac

### 启动服务
	java -jar /Applications/Jenkins/jenkins.war --ajp13Port=-1 --httpPort=9090

### 密钥文件
	cat /Users/Lay/.jenkins/secrets/initialAdminPassword

### 停止服务
	Command + C
	
	
## 相关链接

- [Setup Jenkins for private GitHub repository](https://medium.com/facademy/setup-jenkins-for-private-repository-9060f54eeac9)
- [iOS：使用jenkins实现xcode自动打包（最新）](https://www.jianshu.com/p/3668979476ad)
- [使用 Jenkins 实现持续集成 (Android)](http://www.pgyer.com/doc/view/jenkins)
- [使用 Jenkins 实现持续集成 (iOS)](http://www.pgyer.com/doc/view/jenkins_ios)