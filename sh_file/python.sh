#!/bin/bash
# 安装依赖
yum install -y zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gcc make

# 下载python并安装
wget http://129.204.62.26/android_res/Python-3.7.0.tgz
tar -zxvf Python-3.7.0.tgz
yum install libffi-devel -y
cd Python-3.7.0
./configure
make&&make install

if [ $? -eq 0 ];then
sleep 3
# 把python3 默认成为python的命令，python2变成python.bak
mv /usr/bin/python /usr/bin/python.bak
ln -s /usr/local/bin/python3 /usr/bin/python

sleep 3
mv /usr/bin/pip /usr/bin/pip.bak
ln -s /usr/local/bin/pip3 /usr/bin/pip

pip install --upgrade pip

# 修改yum指定的python版本，指定为2.7，yum默认只支持2.7
sed -i "1s/python/python2.7/g" /usr/libexec/urlgrabber-ext-down
sed -i "1s/python/python2.7/g" /usr/bin/yum

pip install --upgrade pip
fi
