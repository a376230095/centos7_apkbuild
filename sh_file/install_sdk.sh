#!/bin/bash
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

