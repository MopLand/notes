# Jenkins

## 安装部署

### 下载地址
[https://jenkins.io/zh/download/](https://jenkins.io/zh/download/)

### 重要提示

- 安装快完成时，直接使用 Admin 用户，不要创建新用户，会有很多权限问题

### 插件安装

#### 必要插件
- Git plugin
- Email Extension Plugin
- Localization: Chinese (Simplified)
- SSH Agent Plugin
- SSH Credentials Plugin
- Environment Injector
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

--------------------------------

#### Xcode Builder

![](notes/image/env.xcode.png)

--------------------------------

#### Jenkins Location

![](notes/image/env.jenkins.png)

--------------------------------

#### Extended E-mail Notification

![](notes/image/env.email.png)

--------------------------------

### SSH 凭据

#### 添加 SSH 私钥

![](notes/image/ssh_add.png)

--------------------------------

#### 查看 SSH 私钥

![](notes/image/ssh_credentials.png)

--------------------------------

### Keychains and Provisioning Profiles Management

![](notes/image/xcode.keychains.png)

--------------------------------

## Xcode 项目

### 源码管理

![](notes/image/git.project.png)

### 构建触发器

![](notes/image/git.pull.png)

### 构建环境

![](notes/image/xcode.gen.key.png)

--------------------------------

### 构建

#### 使用 Shell 方案

> Execute shell

![](notes/image/xcode.shell.gen.png)

--------------------------------

#### 使用 Xcode 方案

> General build settings

![](notes/image/xcode.build.set.png)

> Code signing & OS X keychain options

![](notes/image/xcode.code.sign.png)

> Advanced Xcode build options

![](notes/image/xcode.build.opts.png)

--------------------------------

### 构建后操作

> Editable Email Notification

![](notes/image/email.notify.png)

--------------------------------

> Upload to pgyer with apiV2

![](notes/image/pgyer.upload.png)

--------------------------------

## Android 项目

### 源码管理

	参考 Xcode 项目

### 构建触发器

	参考 Xcode 项目
	
### 构建

![](notes/image/android.shell.env.png)

![](notes/image/android.integration.png)

### 构建后操作

	参考 Xcode 项目

![](notes/image/android.used.env.png)

## 参考模板

### 最近一次 Git Commit Message
	echo GIT_COMMIT_MESSAGE=$(git show -s $GIT_COMMIT --format="format:%s") > env.properties
	
### 使用环境变量
	${ENV,var="GIT_COMMIT_MESSAGE"}
	
### 蒲公英打包后邮件通知内容
	应用：${buildName} <br />
	版本：${buildVersion} <br />
	大小：${buildFileSize} <br />
	下载：${appPgyerURL} <br /><br />
	${ENV,var="GIT_COMMIT_MESSAGE"} <br />
	<hr />
	<a href="${appBuildURL}"><img src="${appQRCodeURL}" /></a>

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
	
### Workspace
	ln -s /Users/Lay/.jenkins/workspace/ ~/Desktop/Workspace

## 相关链接

- [Setup Jenkins for private GitHub repository](https://medium.com/facademy/setup-jenkins-for-private-repository-9060f54eeac9)
- [iOS：使用jenkins实现xcode自动打包（最新）](https://www.jianshu.com/p/3668979476ad)
- [macOS 上使用 Jenkins 实现 iOS 自动化打包](https://www.jianshu.com/p/d46100612551)
- [【Jenkins】Jenkins集成IOS全自动打包专题](https://www.jianshu.com/p/6a3a009da35b)
- [Jenkins For iOS安装](https://www.jianshu.com/p/5cad74906159)
- [iOS 使用 Jenkins 自动化打包](https://www.jianshu.com/p/8ba3c73e3f1c)
- [关于配置Jenkins自动打包错误总结](https://www.jianshu.com/p/bf056faf89e3)
- [Jenkins一：iOS自动打包完整实践](https://www.jianshu.com/p/d6fdd13a7201)
- [使用 Jenkins 实现持续集成 (Android)](http://www.pgyer.com/doc/view/jenkins)
- [使用 Jenkins 实现持续集成 (iOS)](http://www.pgyer.com/doc/view/jenkins_ios)
- [iOS命令行构建-xcodebuild](http://www.devopsroom.com/autobuild/246.html)
- [Jenkins里邮件触发器配置Send to Developers](https://blog.csdn.net/hwhua1986/article/details/47975257)
- [Passing variable from shell script to jenkins](https://stackoverflow.com/questions/30110876/passing-variable-from-shell-script-to-jenkins)








