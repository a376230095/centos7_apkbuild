#!/bin/bash
# 安装git
yum install -y git
git config --global user.name "tester"
git config --global user.email "tester@qq.com"

# 拉取项目测试包的安装
git clone https://github.com/a376230095/JenkinsTest.git
cd JenkinsTest
sh gradlew clean assembleDebug

# 如果apk存在，那就构建成功了
if [[ -f ./app/build/outputs/apk/debug/app-debug.apk ]];then
echo "构建apk成功"
fi
