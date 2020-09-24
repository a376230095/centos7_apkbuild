#!/bin/bash

# 创建jenkins的volumes文件夹
if [[ ! -d /root/jenkins ]];then
mkdir -p /root/jenkins
fi

# 给文件赋予权限，不然jenkins无法启动
chown -R 1000 /root/jenkins

# 启动容器
docker run -d --name jenkins -p 8080:8080 -p 50000:50000 -v /root/jenkins:/var/jenkins_home jenkins/jenkins:lts

# 创建slave的目录
if [[ ! -d /root/slave ]];then
mkdir -p /root/slave
chmod -R 777 /root/slave
fi

# 获取jenkins容器卷的内容
cd /root
wget http://129.204.62.26/android_res/jenkins.tgz
tar -xvzf jenkins.tgz

