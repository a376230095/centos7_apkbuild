#!/bin/bash
root_dir=`pwd`

#在目录 /etc/yum.repos.d/ 下新建文件 google-chrome.repo 
cd /etc/yum.repos.d/ 

# 创建google-chrome.repo文件，并写入如下内容
cat>google-chrome.repo<<EOF 
[google-chrome] 
name=google-chrome 
baseurl=http://dl.google.com/linux/chrome/rpm/stable/$basearch 
enabled=1 
gpgcheck=1 
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub 
EOF

# 进一步修改google-chrome.repo的内容
sed -i "3s#stable/#stable/\$basearch#g" google-chrome.repo

# 安装google-chrome稳定版
#Google官方源可能在中国无法使用，导致安装失败或者在国内无法更新，可以添加以下参数来安装： 
yum -y install google-chrome-stable --nogpgchec

# 创建一个chrome的链接
ln -s /usr/bin/google-chrome-stable /usr/bin/chrome


#将最后一行改写为: exec -a "$0" "$HERE/chrome" "$@" --no-sandbox $HOME
sed -i '$d' /opt/google/chrome/google-chrome
sed -i '$ a exec -a "$0" "$HERE/chrome" "$@" --no-sandbox $HOME' /opt/google/chrome/google-chrome


# 下载chromedriver并移动的bin目录下
cd $root_dir
wget https://npm.taobao.org/mirrors/chromedriver/84.0.4147.30/chromedriver_linux64.zip
unzip chromedriver_linux64.zip
mv chromedriver /usr/bin

pip install selenium -i http://pypi.douban.com/simple --trusted-host pypi.douban.com
