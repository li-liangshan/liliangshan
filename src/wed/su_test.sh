#!/usr/bin/env bash

# su命令用于切换当前用户身份到其他用户身份，变更时须输入所要变更的用户帐号与密码。
# su [options] arguments

# options: 选项
# -c<指令>或--command=<指令>：执行完指定的指令后，即恢复原来的身份；
# -f或——fast：适用于csh与tsch，使shell不用去读取启动文件；
# -l或——login：改变身份时，也同时变更工作目录，以及HOME,SHELL,USER,logname。此外，也会变更PATH变量；
# -m,-p或--preserve-environment：变更身份时，不要变更环境变量；
# -s<shell>或--shell=<shell>：指定要执行的shell；
# --help：显示帮助；
# --version；显示版本信息。

# arguments: 用户

########################################## 实例 ###############################################
# 变更帐号为root并在执行ls指令后退出变回原使用者：
su -c ls root

# 变更帐号为root并传入-f选项给新执行的shell
su root -f

# 变更帐号为test并改变工作目录至test的家目录
su - test


