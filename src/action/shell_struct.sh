#!/usr/bin/env bash

## 1. shell 变量：环境变量（全局变量）和普通变量（局部变量）。环境变量又分为：自定义环境变量和bash内置的h环境变量
#    环境变量一般是指用export内置命令导出的变量，用于定义shell的运行环境，保护shell命令的正确执行。shell通过环境变量来确定登录用户名、
#    命令路径、终端类型、登录目录等，所有的环境变量都是系统全局变量，可用于所有子进程中，这包括编辑器、shell脚本和各类应用。
#    环境变量可以在命令行中创建和设置，但用户退出命令行时这些变量值就会丢失，因此，如果希望永久保存环境变量，可在用户家目录下的.bash_profile
#    或.bashrc文件中，或者全局配置/etc/bashrc 或 /etc/profile文件中定义。每次用户登录时这些变量都将被初始化。

### 按照系统规范，所有环境变量的名字均采用大写形式。在将环境变量应用于用户进程程序之前，都应该用export命令导出定义。

env | tail

# 定义并导入环境变量
export variable_1=hello
variable_1=hello; export variable_1
declare -x variable_1=hello  # 除了export命令，带-x选项的declare内置命令也可以完成同样的功能。

# 显示与取消环境变量
# echo 和 printf 命令打印环境变量
echo $HOME
echo $UID
echo $PWD
echo $SHELL
echo ${USER}

printf "$HOME\n"

# env 或 set显示默认的环境变量
env
set

# unset消除本地变量和环境变量
unset USER #不带$符合

## 2. 普通变量
variable=value
variable="value" #解析命令和变量等再输出
variable='value' #原样输出

echo ${variable}

# 5 把一个命令的结果作为变量的内容赋值的方法
variable=`ls`
variable=$(ls) #推荐这种

######################################### 特殊且重要的变量 ##############################################

# $0 获取当前执行文件名，如果执行脚本包含了路径，那么就包括脚本路径
# $n 获取当前执行的shell脚本的第n个参数值，如果n=1..9, 如果大于10要用{}, 如${10}
# $@ 获取当前shell脚本所有传参的参数，不加引号和$*相同；如果给$@加上双引号，则 $@ 相当于"$1" "$2" ...。
# $# 获取参数个数
# $? 查看命令返回值

echo \${1..15}
echo ${a..z}
echo ${1..10}

dirname $0 #获取目录
basename $0 #获取文件名


[ $# -ne 2 ] && {
	echo  "muse two args "
	exit 1
}

if [ $# -ne 2 ];
then
	echo "USAGE:/bin/sh $0 arg1 arg2"
	exit 1

fi

for i in $*; do echo $i; done

for i in $@; do echo $i; done

for i in "$@"; do echo $i; done

tar zcf /opt/service.tar.gz ./services  #打包b备份











