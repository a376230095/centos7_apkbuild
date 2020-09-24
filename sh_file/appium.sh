#!/bin/bash
# 安装node.sjs
curl --silent --location https://rpm.nodesource.com/setup_12.x | bash -
yum install -y nodejs

# 安装appium和appium-docker
npm install -g cnpm --registry=https://registry.npm.taobao.org
cnpm install -g appium
cnpm install -g appium-doctor
pip install pytest -i http://pypi.douban.com/simple --trusted-host pypi.douban.com
pip install appium-python-client -i http://pypi.douban.com/simple --trusted-host pypi.douban.com
