#!/usr/bin/env bash

env | tail

# 变量 = 环境变量（全局变量: 名字均采用大写形式） + 普通变量（局部变量）

# 1.环境变量 ：export 变量名字=变量value  or declare -x 变量名字=变量value
export var1=value1
var1=value1; export var1

declare -x var1=value1

# 2.显示与取消环境变量
# 通过echo 或 printf 命令打印环境变量
echo $USER
echo $UID
echo $PWD
echo $SHELL
echo $HOME

printf "$HOME \n"

# 用env 或 set 显示默认的环境变量
env
set

# 用unset消除本地变量和环境变量
echo $USER
unset USER
echo $USER

# 3.普通变量 ： 变量名=变量值  or 变量名='变量值' or 变量名="变量值"

ip=192.168.56.101
ip='192.168.56.101'
ip="192.168.56.101"
password=168
password='168'
password="168"

echo "ip=$ip"
echo "ip=${ip}"

# 4.把一个命令的结果作为变量的内容赋值的方法 ： 变量名=`ls` or 变量名=$(ls)
cmd=`ls`
echo $cmd
cmd1=$(cmd)
echo $cmd1

# 5.单引号原封显示、双引号解析变量显示、反引号用于命令执行
echo "today is 'date'"
echo "today is `date`"
echo "today is $(date)"

ETT="old girl"
echo "$ETT" | awk '{ print $0 }'
echo '$ETT' | awk '{ print $0 }'
echo $ETT | awk '{ print $0 }'

ETT=`pwd`
echo "$ETT" | awk '{ print $0 }'
echo '$ETT' | awk '{ print $0 }'
echo $ETT | awk '{ print $0 }'



