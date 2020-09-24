#!/bin/bash

# 自动生成ssh的公钥和私钥,如果有秘钥就不生成
if [[ ! -f /root/.ssh/id_rsa ]];then
/usr/bin/expect <<EOF
spawn ssh-keygen
expect "/root/.ssh/id_rsa"
send "\r"
expect "passphrase"
send "\r"
expect "Enter"
send "\r"
expect eof
EOF
fi

# 生成符合jenkins的slave要求的ssh公钥私钥格式，先是公钥，然后私钥
cat /root/.ssh/id_rsa.pub > key
cat /root/.ssh/id_rsa >> key

# 生成authorized_keys
if [[ ! -f /root/.ssh/authorized_keys ]];then 
cat /root/.ssh/id_rsa.pub > /root/.ssh/authorized_keys
fi
