# Java

## 安装

### 选择版本
	
	# Setp 1
	http://www.oracle.com/technetwork/java/javase/downloads/index.html

	# Setp 2
	选择 Java Platform (JDK)

	# Setp 3
	选择 Java SE Development Kit 相应版本

	# Setp 4
	http://download.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jdk-8u144-windows-x64.exe

### 安装 JDK

	# Setp 1
	运行 jdk-8u144-windows-x64.exe

	# Setp 2
	目录 D:\Java\

### 配置环境变量

	# Setp 1
	系统属性 > 环境变量

	# Setp 2
	系统变量 > 新建 > JAVA_HOME > D:\Java\jdk1.8.0_144

	# Setp 3
	Path > 编辑 > 追加：%JAVA_HOME%\bin;

### 测试 Java
	cmd > java -version