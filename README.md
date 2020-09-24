## 一键搞定centos7的docker+selenium+appium+android_app源码打包成apk+jenkins搭建

#### 简介
- 启动项目的start_all.sh，一键构建环境
- 安装完包含的环境
  - docker-ce最新版本
  - selenium运行环境
    - chrome无头运行
    - chromedriver是84
  - appium运行环境
    - appium 1.18版本
    - 包含appium-docker
  - sdk运行环境
    - adb 1.0.41
    - sdk build有29.0.3和28.0.3 - sdk编译环境是28 29
  - jenkins运行环境
    - 集成大量插件


#### 项目运行的前提条件：
- 仅支持centos7的系统
- 系统内核要大于3.10
- 需要root权限下运行
- 运行前建议弄好快照

- 一键运行可能需要1小时的时间，请耐心等待，断网了，需要恢复快照
- 网络要通，具备基础的命令
- ==运行完毕后需要重启电脑，并手动启动jenkins，docker start jenkins==
- 如果不运行docker.sh，先安装如下命令
```
yum install -y unzip
yum install -y wget
yum install -y exepct
yum install -y net-tools
yum install -y lrzsz
yun install -y zip
```

#### 项目的一些bug
- ==如果jenkins无法启动，运行命令：docker run -d --name jenkins -p 8080:8080 -p 50000:50000 -v /root/jenkins:/var/jenkins_home jenkins/jenkins:lts==
- 构建apk如果出现licenses 29的问题，解决方法，运行sh_file的install_sdk.sh
```
Could not determine the dependencies of task ':app:compileDebugJavaWithJavac'.
> Failed to install the following Android SDK packages as some licences have not been accepted.
     platforms;android-29 Android SDK Platform 29
  To build this project, accept the SDK license agreements and install the missing components using the Android Studio SDK Manager.
  Alternatively, to transfer the license agreements from one workstation to another, see http://d.android.com/r/studio-ui/export-licenses.html
  
  Using Android SDK: /usr/local/android-sdk-linux
```


#### 项目文件结构以及运行顺序
- sh_file 存放环境搭建的shell脚本
  - docker.sh 搭建docker环境
  - python.sh 搭建python3和pip环境
  - selenium.sh 搭建selenium无头运行环境
  - android.sh 搭建sdk环境
  - appium.sh 搭建appium环境
  - jenkins.sh 搭建jenkins环境
  - ssh.sh 获取ssh的的公钥和私钥
  - build_app_installGit.sh 打包app的源码为apk，并安装git,只能重启后才能运行
- py_file
  - selenium_test.py 是测试selenium是否成功运行
  - appium_test.py 是测试selenium是否成功运行
- start_all.sh 一键启动项目


#### 项目资料补充
- sdk的路径：/usr/local/android-sdk-linux
- java路径：/usr/lib/jvm/java-1.8.0-openjdk
- build_app_installGit.sh脚本介绍
  - 由于子shell中source /etc/.bashrc在其他shell中无效，所以只能重启linux，才能找到ANDROID_HOME的环境变量
  - 项目源码来源于佘哥，感谢指点提供
  - 用的是29.0.3的build
  - gradlew是个好东西，都不用我们去配置gradle了
- appium_test.py 文件
  - 需要修改里面的devicename
  - 需要安装雪球apk，或者自行修改package和activity
  - 只要能进入雪球，就判断ok
  - 运行：pytest appium_test.py
- jenkisn项目
  - 账号：amdin，密码：1234
  - slave是本机，名字为linuxenv，但需要修改，修改成自己的ip地址，配置好ssh
  - linuxenv的工作目录是/root/slave
  - build_app_test任务直接在slave运行，已经配置好git和构建后apk的产出，运行后就会把apk放到jenkins上了
- 运行了ssh.sh后，会在项目中生成key文件，直接复制粘贴到jenkins配置的ssh的秘钥上即可，包含公钥和私聊信息

