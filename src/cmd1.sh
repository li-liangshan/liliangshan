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
str="abcd"
echo ${#str} #输出4
echo "================================================"

#提取子字符串
subStr=${str:1:2}
echo $subStr
echo "================================================"

#查找子字符串
str="runoob is a great company"
#echo `expr index "$str" is`

#数组
array=(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)
echo ${array[@]} #获取数组中所有元素 与*形式不同
echo ${array[0]} #按照下标选择数组元素
echo ${array[*]} #获取数组中所有元素 与@形式不同

echo ${#array[@]} #取得数组元素的个数
echo ${#array[*]} #取得数组元素的个数
echo ${#array[12]} #取得数组单个元素的长度


