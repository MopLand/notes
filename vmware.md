
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
	
#### mac 无限重启错误
	cpuid.1.eax = "00000000000000010000011010100101"
	
#### VMware 意外关机异常
	disk.locking = "FALSE"
	
#### 压缩 vmdk 镜像
	vmware-vdiskmanager.exe -k "E:\macOS 10.14.vmdk"
	
## vmrun 命令行

### 常用命名

	# 启动无图形界面虚拟机  
	#（-T 是区分宿主机的类型，ws|server|server1|fusion|esx|vc|player，比较常用的是ws、esx和player）
	vmrun -T ws start "/opt/VMware/win2k8r2.vmx" nogui
	 
	# 启动带图形界面虚拟机
	vmrun start "/opt/VMware/win2k8r2.vmx" gui
	 
	# 强制关闭虚拟机(相当于直接关电源) | 正常关闭虚拟机
	vmrun stop "/opt/VMware/win2k8r2.vmx" hard | soft
	 
	# 冷重启虚拟机 | 热重启虚拟机
	vmrun reset "/opt/VMware/win2k8r2.vmx" hard | soft
	 
	# 挂起虚拟机（可能相当于休眠）
	vmrun suspend  "/opt/VMware/win2k8r2.vmx" hard | soft
	 
	# 暂停虚拟机
	vmrun pause  "/opt/VMware/win2k8r2.vmx"
	 
	# 停止暂停虚拟机
	vmrun unpause  "/opt/VMware/win2k8r2.vmx"
	 
	# 列出正在运行的虚拟机
	vmrun list
	 
	# 另一种查看正在运行虚拟机的方法
	ps aux | grep vmx 
	 
	# 创建一个快照（snapshotName 快照名）
	vmrun -T ws snapshot "/opt/VMware/win2k8r2.vmx" snapshotName
	  
	# 从一个快照中恢复虚拟机（snapshotName 快照名）
	vmrun -T ws reverToSnapshot "/opt/VMware/win2k8r2.vmx" snapshotName
	 
	# 列出虚拟机快照数量及名称
	vmrun -T ws listSnapshots "/opt/VMware/win2k8r2.vmx"
	 
	# 删除一个快照（snapshotName 快照名）
	vmrun -T ws deleteSnapshot "/opt/VMware/win2k8r2.vmx" snapshotName
	
### 启动脚本.bat
	@echo off
		"D:/VMware/VMware Workstation/vmrun.exe" start "D:\VMware\Space\macOS 10.14\macOS 10.14.vmx"
	@exit
	
### 关机脚本.bat
	@echo off
		"D:/VMware/VMware Workstation/vmrun.exe" stop "D:\VMware\Space\macOS 10.14\macOS 10.14.vmx" hard
	@exit
	
## 相关链接

- [[Windows] unlocker3.0+VMware Workstation 15 Pro+Key](https://www.52pojie.cn/thread-801784-1-1.html)
- [Download MacOS Mojave Torrent Image — Latest Preview](https://www.geekrar.com/download-macos-mojave-torrent-image/)
- [vmrun命令行的使用（VMWare虚拟机）](https://blog.csdn.net/Devper/article/details/54089342)
