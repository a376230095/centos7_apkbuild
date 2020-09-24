#!/bin/bash

# 安装一些软件
yum install -y unzip
yum install -y wget
yum install -y exepct
yum install -y net-tools
yum install -y lrzsz
yun install -y zip


docker
if [ $? == 0 ];then
	echo "installed docker,doesn't install"
else

# 卸载之前版本的docker，好像没什么卵用
yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine

# 安装docker
yum install -y yum-utils

yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

yum install -y docker-ce docker-ce-cli containerd.io

# 启动docker和开机自动启动docker
systemctl start docker
systemctl enable docker

# 把阿里云的mirror配置到docker，docker pull的速度变快
cd /etc/docker/
cat>daemon.json<<EOF
{
  "registry-mirrors": ["https://879e47wt.mirror.aliyuncs.com"]
}
EOF

fi
