#!/usr/bin/env sh

variable1="hello world"

echo $variable1
echo "$variable1 dd"  #双引号 输出变量值
echo '$variable1 dd'  #单引号 就是字符串本身
echo "================================================"

for file in `ls /`; do
	echo $file
done
echo "================================================"

for file in $(ls /); do
	echo $file
done
echo "================================================"

for skill in Ada Coffe Action Java; do
	echo " I am good at ${skill}Script"
done
echo "================================================"

#设置只读变量
myURL="https://www.baidu.com"
readonly myURL
#myURL="https://www.taobao.com"  #myURL: readonly variable
echo "================================================"

#删除变量
myURL2="WWD"
unset myURL2
echo $myURL2
echo "================================================"

#获取字符串长度

