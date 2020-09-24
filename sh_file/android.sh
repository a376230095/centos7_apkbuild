#!/bin/bash

# 安装java
yum install -y java-1.8.0-openjdk*

# 配置java和sdk的环境变量
cat>>/root/.bashrc<<EOF
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk
export ANDROID_SDK_ROOT=/usr/local/android-sdk-linux
export ANDROID_HOME=/usr/local/android-sdk-linux
export PATH=\$JAVA_HOME/bin:\$PATH
export PATH=\$ANDROID_SDK_ROOT/tools:\$PATH
export PATH=\$ANDROID_SDK_ROOT/platform-tools:\$PATH
EOF

source /root/.bashrc

# 安装sdk
cd /usr/local
if [[ ! -f android-sdk_r24.4.1-linux.tgz ]];then
wget http://129.204.62.26/android_res/android-sdk_r24.4.1-linux.tgz
fi

if [[ ! -d android-sdk-linux ]];then
tar -xvzf android-sdk_r24.4.1-linux.tgz
chmod -R 777 android-sdk-linux
fi

cd /usr/local/android-sdk-linux/tools

# 安装sdk的函数
install()
{
a=`./android list sdk --all | grep "$1" | awk '{print $1}' | awk -F "-" '{print $1}'`
/usr/bin/expect <<EOF
spawn ./android update sdk -u -a -t $a
expect "y/n"
send "y\r"
expect "y/n"
send "y\r"
expect "y/n"
send "y\r"
expect eof
EOF
}

# 安装sdk
install 29.0.3
install 28.0.3
install 26.0.3
install Platform-tools
install "SDK Platform Android 10, API 29"
install "SDK Platform Android R Preview"
install "SDK Platform Android 9, API 28"

# 继续安装其他的sdk
/usr/bin/expect <<EOF
spawn ./android update sdk --no-ui --filter android-28,android-29,extra-android-m2repository
expect "y/n"
send "y\r"
expect "y/n"
send "y\r"
expect "y/n"
send "y\r"
expect eof
EOF


cd /usr/local/android-sdk-linux/tools
./android update adb


