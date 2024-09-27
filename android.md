
# Android

## 下载地址
	http://www.androiddevtools.cn/

## Windows

### 避免重新下载新版本的SDK
	
	# 位置 bin / idea.properties
	disable.android.first.run=true
	
### 环境变量

> 设置后未生效时，或需要重启服务/CMD

	# JAVA_HOME
	D:\Android\Android Studio\jre

	# ANDROID_HOME
	D:\Android\SDK
	
## macOS

### 环境变量

### 安装 Homebrew

	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

### 配置 .bashrc 变量

	sudo vi ~/.bashrc
	
	export JAVA_HOME=/Applications/Android\ Studio.app/Contents/jre/jdk/Contents/Home
	export PATH=$PATH:$JAVA_HOME

	export GRADLE_HOME=/Applications/Android\ Studio.app/Contents/gradle/gradle-5.1.1
	export PATH=$PATH:$GRADLE_HOME/bin

	export ANDROID_HOME=/Users/Lay/Library/Android/sdk
	export PATH=$PATH:$ANDROID_HOME/tools
	export PATH=$PATH:$ANDROID_HOME/platform-tools

### 配置 .bash_profile 变量

	sudo vi ~/.bash_profile

	if [ -f ~/.bashrc ]; then
		source ~/.bashrc
	fi
	
## ADB 工具

### 下载地址
	https://dl.google.com/android/repository/platform-tools-latest-windows.zip
	
### 远程安装 APK
	adb connect 192.168.124.13 //电视所在 IP
	adb devices	//查看设备连接情况
	adb install -t D:\app-release.apk
	
### 小米电视，打开 ADB 模式
	第一步，设置 -> 关于 -> 产品型号，狂按遥控器，打开开发者模式
	第二步，设置 -> 账号与安全，打开 ADB 模式

## 参考资料

- [Android Studio 中文社区-安卓开发者工具集](http://www.android-studio.org/)
- [第一次使用Android Studio时你应该知道的一切配置](https://www.cnblogs.com/smyhvae/p/4390905.html)
- [移动设备占有率统计](https://mtj.baidu.com/data/mobile/device/)
- [Mac配置环境变量](https://www.jianshu.com/p/71017354de15)
- [小米电视，无需U盘，直接通过ADB远程安装APK，很方便！](https://blog.csdn.net/kof820/article/details/142398279)