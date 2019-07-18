# Jenkins

## 安装部署

### 下载地址
[https://jenkins.io/zh/download/](https://jenkins.io/zh/download/)

### 重要提示
安装快完成时，直接使用 Admin 用户，不要创建新用户，会有很多权限问题

### 插件安装

#### 必要插件
- Git plugin
- Email Extension Plugin
- Localization: Chinese (Simplified)
- SSH Agent Plugin
- SSH Credentials Plugin
- Upload to pgyer

#### Xcode
- Xcode integration
- Keychains and Provisioning Profiles Management

#### Android
- Gradle Plugin

## 准备工作

### 全局配置

#### 环境变量

![](notes/image/env.android.png)

#### Xcode Builder

![](notes/image/env.xcode.png)

#### Jenkins Location

![](notes/image/env.jenkins.png)

#### Extended E-mail Notification

![](notes/image/env.email.png)

### SSH 凭据

#### 添加 SSH 私钥

![](notes/image/ssh_add.png)

#### 查看 SSH 私钥

![](notes/image/ssh_credentials.png)

## Windows

### 修改端口号
	java -jar jenkins.war --ajp13Port=-1 --httpPort=9090
	
### 密钥文件
	C:\Users\Administrator\.jenkins\secrets\initialAdminPassword

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