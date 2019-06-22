#!/usr/bin/env bash

#### shell输入/输出重定向
# 大多数 UNIX 系统命令从你的终端接受输入并将所产生的输出发送回​​到您的终端。一个命令通常从一个叫标准输入的地方读取输入，
# 默认情况下，这恰好是你的终端。同样，一个命令通常将其输出写入到标准输出，默认情况下，这也是你的终端。

## 1.输出重定向 command > file
who > ../resources/users
cat ../resources/users
echo "================================================================================================="

echo "菜鸟教程：www.runoob.com" > ../resources/users
cat ../resources/users

## 2. 输出重定向 command >> file 追加内容
who >> ../resources/users
cat ../resources/users
echo "================================================================================================="

## 3. 输入重定向 command < infile
wc -l ../resources/users #会输出文件名
wc -l < ../resources/users #不会输出文件名
ls -a > ../resources/cmds
cat ../resources/cmds
echo "================================================================================================="

#### shell重定向深入讲解
### 一般情况下，每个UNIX/LINUX命令运行时都会打开三个文件：
### 1.标准输入文件：stdin的文件描述符为0，Unix程序默认从stdin读取数据
### 2.标准输出文件：stdout的文件描述符为1，Unix程序默认向stdout输出数据
### 3.标准错误文件：stderr的文件描述符为2，Unix程序会向stderr流中写入错误信息

who 2> ../resources/erros
read a 0< ../resources/read_file
echo ${a}
who 1> ../resources/out_file

#### Here Document
## Here Document是Shell中的一种特殊的重定向方式，用来将输入重定向到一个交互式shell脚本或程序
# 基本形式如下：
############################################################################
##################           command << delimiter         ##################
##################                 document               ##################
##################           delimiter                    ##################
############################################################################
wc -l << EOF
	HELLO
	WORLD
	CUP
	https://www.baidu.com
EOF
echo "================================================================================================="

cat << EOF
	HELLO
	WORLD
	CUP
	https://www.baidu.com
EOF
echo "================================================================================================="


cat > ../resources/content <<EOF
	HELLO
	WORLD
	CUP1
	https://www.baidu.com
EOF
echo "================================================================================================="

cat < ../resources/content > ../resources/content1
echo "================================================================================================="
