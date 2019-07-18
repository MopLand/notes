
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

## 参考资料

- [Android Studio 中文社区-安卓开发者工具集](http://www.android-studio.org/)
- [第一次使用Android Studio时你应该知道的一切配置](https://www.cnblogs.com/smyhvae/p/4390905.html)
- [移动设备占有率统计](https://mtj.baidu.com/data/mobile/device/)
- [Mac配置环境变量](https://www.jianshu.com/p/71017354de15)