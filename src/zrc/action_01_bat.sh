#!/usr/bin/env bash

# 清除日志脚本

cd /var/log
cat /dev/null > messages
echo "Logs cleaned up."


echo " alias vi='vim'" >> /etc/profile
tail -1 /etc/profile
head -1 /etc/init.d/netconsole

# 清除日志脚本 2

LOG_DIR=/var/log
ROOT_UID=0  #<==$UID为0的用户，即root用户
# 脚本需要使用root用户权限来运行，因此，对当前用户进行判断，对不合要求的用户给出友好的提示，并终止程序运行
if [ "$UID" -ne "$ROOT_UID" ]
then
	echo "Must be root to run this script."
	exit 1
fi

# 如果切换到指定目录不成功，则给出提示，并终止程序运行
cd $LOG_DIR || {
	echo "Cannot change to necessary directory."
	exit 1
}

# 经过上述两个判断后，此处的用户权限和路径应该已经正确了，只有清空成功，才打印日志
cat /dev/null>messages & {
	echo "Logs cleaned up."
	exit 0
}

echo "Logs cleaned up fail."
exit 1
