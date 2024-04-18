#Git

## 部署 Git

### 安装 Git
	yum install git

### 生成 id_rsa
	ssh-keygen -t rsa

### .ssh权限
	chmod 400 ~/.ssh/id_rsa

### 全局Git配置

	# 默认用户名
	git config --global user.name "Lay"
	
	# 默认 Email
	git config --global user.email "veryide@qq.com"
	
	# 存储密码
	git config --global credential.helper store

### 克隆已有项目

	# 初始化
	git init
	git remote add origin git@git.oschina.net:bangbang/TPS.git
	
	# 完整克隆
	git pull
	
	# 只克隆最近一次commit
	git pull --depth 1
	
	# 检出
	git checkout master

### 复制已有缓存和配置文件
	\cp -r -f -p /disk/www/rj.shihuizhu.com/attach/ /disk/www/rj.shz.com/
	\cp -r -f -p /disk/www/rj.shihuizhu.com/config/ /disk/www/rj.shz.com/
	\cp -r -f -p /disk/www/rj.shihuizhu.com/cached/ /disk/www/rj.shz.com/

### 撤销已经推送(push)至远端仓库的提交(commit)

	# 查看提交信息，获取要回退的版本号
	git log

	# 重置至指定版本的提交
	git reset –soft <版本号>

	# 强制提交当前版本号
	git push origin master –force

## 生产环境定时拉取项目

### crontab 脚本

	# 项目自动更新（每天9:00 - 22:00，每10分钟执行一次）
	*/10 9-22 * * * /disk/shell/gitpull.sh > /var/log/gitpull.log
	
	# 主动拉取带 .gitlock 的项目（最好安排在机器重启之前）
	25 04 * * * git --git-dir=/disk/www/Messager/.git --work-tree=/disk/www/Messager/ pull

### sh 执行权限
	chmod +x /disk/shell/gitpull.sh

## Git hooks

### hooks 位置
	$GIT_DIR/hooks/* (or git config core.hooksPath/*)

### 权限设置
	chmod +x .git/hooks/post-merge

### .git/hooks/pre-commit

	#!/bin/sh
	# 自动更新版本号
	
	php vendor/gitbuild.php

--------

	#!/bin/sh
	# 禁止提交某些文件
	 
	git diff --cached --name-status | while read status file; do
		# do a check only on the .bak files
		if [[ ${file##*.} =~ \.bak$ ]] ; then
			echo "Please remove *.bak files before committing"
			exit 1
		fi
	done


### .git/hooks/post-merge

	#!/bin/sh
	# 自动刷新模块缓存

	php vendor/gitmerge.php

--------

	#!/bin/sh
	# 生产环境打包部署
	
	npm install && npm run build
	
## 常见错误

### packet_write_wait: Connection to 192.168.1.11 port 22: Broken pipe

	echo IPQoS lowdelay throughput >> ~/.ssh/config

## 常用命令

	# 强制重置工作区
	git reset --hard
	
	# 还原文件更改状态
	git checkout -- file.txt
	
	# 添加至暂存区
	git add
	
	# 交互式添加
	git add–interactive
	
	# 应用补丁
	git apply
	
	# 应用邮件格式补丁
	git am
	
	# 同义词，等同于 git blame
	git annotate
	
	# 文件归档打包
	git archive
	
	# 二分查找
	git bisect
	
	# 文件逐行追溯
	git blame
	
	# 分支管理
	git branch
	
	# 版本库对象研究工具
	git cat-file
	
	# 检出到工作区、切换或创建分支
	git checkout
	
	# 提交拣选
	git cherry-pick
	
	# 图形化提交，相当于 git gui 命令
	git citool
	
	# 清除工作区未跟踪文件
	git clean
	
	# 克隆版本库
	git clone
	
	# 提交
	git commit
	
	# 查询和修改配置
	git config
	
	# 通过里程碑直观地显示提交ID
	git describe
	
	# 差异比较
	git diff
	
	# 最近一个版本比较
	git diff HEAD~1
	git diff HEAD~1 --name-only
	
	# 调用图形化差异比较工具
	git difftool
	
	# 获取远程版本库的提交
	git fetch
	
	# 创建邮件格式的补丁文件。参见 git am 命令
	git format-patch
	
	# 文件内容搜索定位工具
	git grep
	
	# 帮助
	git help
	
	# 版本库初始化
	git init
	
	# 同义词，等同于 git init
	git init-db*
	
	# 显示提交日志
	git log
	
	# 分支合并
	git merge
	
	# 图形化冲突解决
	git mergetool
	
	# 重命名
	git mv
	
	# 拉回远程版本库的提交
	git pull
	
	# 推送至远程版本库
	git push
	
	# 分支变基
	git rebase
	
	# 交互式分支变基
	git rebase–interactive
	
	# 分支等引用变更记录管理
	git reflog
	
	# 远程版本库管理
	git remote
	
	# 同义词，等同于 git config
	git repo-config*
	
	# 重置改变分支“游标”指向
	git reset
	
	# 重置到上一次成功的 commit
	git reset --hard FETCH_HEAD
	
	# 将各种引用表示法转换为哈希值等
	git rev-parse
	
	# 反转提交
	git revert
	
	# 删除文件
	git rm
	
	# 显示各种类型的对象
	git show
	
	# 同义词，等同于 git add
	git stage*
	
	# 保存和恢复进度
	git stash
	
	# 显示工作区文件状态
	git status
	
	# 里程碑管理
	git tag

## 对象库操作相关命令

	# 从树对象创建提交
	git commit-tree
	
	# 从标准输入或文件计算哈希值或创建对象
	git hash-object
	
	# 显示工作区和暂存区文件
	git ls-files
	
	# 显示树对象包含的文件
	git ls-tree
	
	# 读取标准输入创建一个里程碑对象
	git mktag
	
	# 读取标准输入创建一个树对象
	git mktree
	
	# 读取树对象到暂存区
	git read-tree
	
	# 工作区内容注册到暂存区及暂存区管理
	git update-index
	
	# 创建临时文件包含指定 blob 的内容
	git unpack-file
	
	# 从暂存区创建一个树对象
	git write-tree

## 引用操作相关命令

	# 检查引用名称是否符合规范
	git check-ref-format
	
	# 引用迭代器，用于shell编程
	git for-each-ref
	
	# 显示远程版本库的引用
	git ls-remote
	
	# 将提交ID显示为友好名称
	git name-rev
	
	# 显示版本范围
	git rev-list
	
	# 显示分支列表及拓扑关系
	git show-branch
	
	# 显示本地引用
	git show-ref
	
	# 显示或者设置符号引用
	git symbolic-ref
	
	# 更新引用的指向
	git update-ref
	
	# 校验 GPG 签名的Tag
	git verify-tag

## 版本库管理相关命令

	# 显示松散对象的数量和磁盘占用
	git count-objects
	
	# 版本库重构
	git filter-branch
	
	# 对象库完整性检查
	git fsck
	
	# 同义词，等同于 git fsck
	git fsck-objects*
	
	# 版本库存储优化
	git gc
	
	# 从打包文件创建对应的索引文件
	git index-pack
	
	# 过时，请使用 git fsck –lost-found 命令
	git lost-found*
	
	# 从标准输入读入对象ID，打包到文件
	git pack-objects
	
	# 查找多余的 pack 文件
	git pack-redundant
	
	# 将引用打包到 .git/packed-refs 文件中
	git pack-refs
	
	# 从对象库删除过期对象
	git prune
	
	# 将已经打包的松散对象删除
	git prune-packed
	
	# 为本地版本库中相同的对象建立硬连接
	git relink
	
	# 将版本库未打包的松散对象打包
	git repack
	
	# 读取包的索引文件，显示打包文件中的内容
	git show-index
	
	# 从打包文件释放文件
	git unpack-objects
	
	# 校验对象库打包文件
	git verify-pack

## 数据传输相关命令

	# 执行 git fetch 或 git pull 命令时在本地执行此命令，用于从其他版本库获取缺失的对象
	git fetch-pack
	
	# 执行 git push 命令时在远程执行的命令，用于接受推送的数据
	git receive-pack
	
	# 执行 git push 命令时在本地执行的命令，用于向其他版本库推送数据
	git send-pack
	
	# 执行 git archive –remote 命令基于远程版本库创建归档时，远程版本库执行此命令传送归档
	git upload-archive
	
	# 执行 git fetch 或 git pull 命令时在远程执行此命令，将对象打包、上传
	git upload-pack

## 邮件相关命令

	# 将补丁通过 IMAP 发送
	git imap-send
	
	# 从邮件导出提交说明和补丁
	git mailinfo
	
	# 将 mbox 或 Maildir 格式邮箱中邮件逐一提取为文件
	git mailsplit
	
	# 创建包含提交间差异和执行PULL操作地址的信息
	git request-pull
	
	# 发送邮件
	git send-email

## 协议相关命令

	# 实现Git协议
	git daemon
	
	# 实现HTTP协议的CGI程序，支持智能HTTP协议
	git http-backend
	
	# 即时启动浏览器通过 gitweb 浏览当前版本库
	git instaweb
	
	# 受限制的shell，提供仅执行Git命令的SSH访问
	git shell
	
	# 更新哑协议需要的辅助文件
	git update-server-info
	
	# 通过HTTP协议获取版本库
	git http-fetch
	
	# 通过HTTP/DAV协议推送
	git http-push
	
	# 由Git命令调用，通过外部命令提供扩展协议支持
	git remote-ext
	
	# 由Git命令调用，使用文件描述符作为协议接口
	git remote-fd
	
	# 由Git命令调用，提供对FTP协议的支持
	git remote-ftp
	
	# 由Git命令调用，提供对FTPS协议的支持
	git remote-ftps
	
	# 由Git命令调用，提供对HTTP协议的支持
	git remote-http
	
	# 由Git命令调用，提供对HTTPS协议的支持
	git remote-https
	
	# 协议扩展示例脚本
	git remote-testgit

## 版本库转换和交互相关命令

	# 导入Arch版本库到Git
	git archimport
	
	# 提交打包和解包，以便在不同版本库间传递
	git bundle
	
	# 将Git的一个提交作为一个CVS检出
	git cvsexportcommit
	
	# 导入CVS版本库到Git。或者使用 cvs2git
	git cvsimport
	
	# Git的CVS协议模拟器，可供CVS命令访问Git版本库
	git cvsserver
	
	# 将提交导出为 git-fast-import 格式
	git fast-export
	
	# 其他版本库迁移至 Git 的通用工具
	git fast-import
	
	# git 作为前端操作 Subversion
	git svn

## 合并相关的辅助命令

	# 供其他脚本调用，找到两个或多个提交最近的共同祖先
	git merge-base
	
	# 针对文件的两个不同版本执行三向文件合并
	git merge-file
	
	# 对index中的冲突文件调用指定的冲突解决工具
	git merge-index
	
	# 合并两个以上分支。参见 git merge 的 octopus 合并策略
	git merge-octopus
	
	# 由 git merge-index 调用的标准辅助程序
	git merge-one-file
	
	# 合并使用本地版本，抛弃他人版本。参见 git merge 的ours合并策略
	git merge-ours
	
	# 针对两个分支的三向合并。参见 git merge 的recursive合并策略
	git merge-recursive
	
	# 针对两个分支的三向合并。参见 git merge 的resolve合并策略
	git merge-resolve
	
	# 子树合并。参见 git merge 的 subtree 合并策略
	git merge-subtree
	
	# 显式三向合并结果，不改变暂存区
	git merge-tree
	
	# 供执行合并操作的脚本调用，用于创建一个合并提交说明
	git fmt-merge-msg
	
	# 重用所记录的冲突解决方案
	git rerere

## 其他命令

	# 由 git bisect 命令调用，确认二分查找进度
	git bisect–helper
	
	# 显示某个文件是否设置了某个属性
	git check-attr
	
	# 从暂存区拷贝文件至工作区
	git checkout-index
	
	# 查找没有合并到上游的提交
	git cherry
	
	# 比较暂存区和工作区，相当于 git diff –raw
	git diff-files
	
	# 比较暂存区和版本库，相当于 git diff –cached –raw
	git diff-index
	
	# 比较两个树对象，相当于 git diff –raw A B
	git diff-tree
	
	# 由 git difftool 命令调用，默认要使用的差异比较工具
	git difftool–helper
	
	# 从 git archive 创建的 tar 包中提取提交ID
	git get-tar-commit-id
	
	# 命令 git gui 的获取用户口令输入界面
	git gui–askpass
	
	# 提交评论管理
	git notes
	
	# 补丁过滤行号和空白字符后生成补丁唯一ID
	git patch-id
	
	# 将Quilt补丁列表应用到当前分支
	git quiltimport
	
	# 提交替换
	git replace
	
	# 对 git log 的汇总输出，适合于产品发布说明
	git shortlog
	
	# 删除空行，供其他脚本调用
	git stripspace
	
	# 子模组管理
	git submodule
	
	# 显示 Git 环境变量
	git var
	
	# 启动浏览器以查看目录或文件
	git web–browse
	
	# 显示提交历史及每次提交的改动
	git whatchanged
	
	# 包含于其他脚本中，提供合并/差异比较工具的选择和执行
	git-mergetool–lib
	
	# 包含于其他脚本中，提供操作远程版本库的函数
	git-parse-remote
	
	# 包含于其他脚本中，提供 shell 编程的函数库
	git-sh-setup


### 相关链接

- [Git Book 中文文档](https://git-scm.com/book/zh/v2/)
- [Git History](https://githistory.xyz/)
- [Git Hooks / Git 钩子](http://www.php.cn/manual/view/35078.html)
- [How to prevent “Write Failed: broken pipe” on SSH connection?](https://askubuntu.com/questions/127369/how-to-prevent-write-failed-broken-pipe-on-ssh-connection)
- [SSH服务：packet_write_wait: Connection to 67.218.143.160 port 22: Broken pipe错误处理](https://www.cnblogs.com/zlgxzswjy/p/9796671.html)

	