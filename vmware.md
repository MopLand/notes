
# WMware

## 安装黑苹果

> 以 macOS Mojave 10.14.3 为例

### 下载虚拟文件

#### 选择 WMware 适用的镜像文件
	https://www.geekrar.com/download-macos-mojave-torrent-image/

#### 提取 *.vmdk 文件
	Mojave *.vmdk
	
### 在 WMware 中创建虚拟机

#### 修改配置文件
	
	# 配置文件
	macOS 10.14.vmx
	
	# 查找 
	smc.present = "TRUE"

	# 追加
	smc.version = 0
	
#### 替换 vmdk 文件
	cp Mojave *.vmdk macOS 10.14/macOS 10.14.vmdk
	
## 相关链接

- [[Windows] unlocker3.0+VMware Workstation 15 Pro+Key](https://www.52pojie.cn/thread-801784-1-1.html)
- [Download MacOS Mojave Torrent Image — Latest Preview](https://www.geekrar.com/download-macos-mojave-torrent-image/)