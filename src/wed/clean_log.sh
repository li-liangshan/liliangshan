#!/usr/bin/env sh

# 清除日志脚本

LOG_DIR=/var/log
ROOT_UID=0

#脚本需要使用root权限来运行，因此，对当前用户进行判断，对不符合要求的用户给出提示并终止运行程序

if [ "$UID" -ne "$ROOT_UID" ]
then
	echo "Must be root to run the script."
	exit 1
fi

# 如果切换到指定目录不成功，则给出提示，并终止程序运行

cd ${LOG_DIR} || {
	echo "Cannot change to necessary directory."
	exit 1
}

cat /dev/null>message && {
	echo "Logs cleaned up."
	exit 0
}

echo "Logs cleaned up fail."

# 设置环境变量的三种方式：
# 1. export VARIABLE=value
# 2. VARIABLE=value; export VARIABLE
# 3. declare -x VARIABLE=value

exit 1 | $?
