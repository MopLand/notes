# Shell

## ����Ƭ��

### ��ǰShellλ��
	basepath=$(cd `dirname $0`; pwd)

### ��� GIT hooks ��������
	#!/bin/bash
	echo Running $BASH_SOURCE
	set | egrep GIT
	echo PWD is $PWD

## �ļ��ȽϷ�

### �����﷨

	-e �ж϶����Ƿ����
	-d �ж϶����Ƿ���ڣ�����ΪĿ¼
	-f �ж϶����Ƿ���ڣ�����Ϊ�����ļ�
	-L �ж϶����Ƿ���ڣ�����Ϊ��������
	-h �ж϶����Ƿ���ڣ�����Ϊ������
	-s �ж϶����Ƿ���ڣ����ҳ��Ȳ�Ϊ0
	-r �ж϶����Ƿ���ڣ����ҿɶ�
	-w �ж϶����Ƿ���ڣ����ҿ�д
	-x �ж϶����Ƿ���ڣ����ҿ�ִ��
	-O �ж϶����Ƿ���ڣ��������ڵ�ǰ�û�
	-G �ж϶����Ƿ���ڣ��������ڵ�ǰ�û���
	-nt �ж�file1�Ƿ��file2��  [ "/data/file1" -nt "/data/file2" ]
	-ot �ж�file1�Ƿ��file2��  [ "/data/file1" -ot "/data/file2" ]
	
### ʹ��ʾ��

#### �ļ��в������򴴽�
	if [ ! -d "/data/" ];then
		mkdir /data
	else
		echo "�ļ����Ѿ�����"
	fi
	
#### �ж��ļ��Ƿ����
	if [ -f "/data/filename" ];then
		echo "�ļ�����"
	else
		echo "�ļ�������"
	fi
	
## �������

- [Shell��������Ĵ���](https://blog.csdn.net/andylauren/article/details/68957195)
- [Linuxѧϰ�ʼ� -- Ϊ Shell ���ݲ���](https://www.cnblogs.com/atuotuo/p/6431289.html)
- [linux shell�ű�ͨ�����������ݲ���ֵ](https://www.cnblogs.com/rwxwsblog/p/5668254.html)