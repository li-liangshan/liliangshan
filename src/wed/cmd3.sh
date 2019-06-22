#!/usr/bin/env sh

#基本运算
val=`expr 2 + 2`
echo "两数之和为：$val"
echo "================================================================================================="

#算术运算
a=10
b=20
val=`expr $a + $b`
echo "a + b : $val"

val=`expr $a - $b`
echo "a - b : $val"

val=`expr $a \* $b`
echo "a * b : $val"

val=`expr $b / $a`
echo "b / a : $val"

val=`expr $b % $a`
echo "b % a : $val"
echo "================================================================================================="

b=10
if [ $a == $b ]
then
	echo "a 等于 b"
fi

b=20
if [ $a != $b ]; then
    echo "a 不等于 b"
fi
echo "================================================================================================="

#关系运算 注意单中括号
echo "-eq 检测两个数是否相等，相等返回 true。例如 [ \$a -eq \$b ] 返回 false"
echo "-ne 检测两个数是否不相等，不相等返回true。 例如 [ \$a -ne \$b ]返回true"
echo "-gt 检测左边的数是否大于右边的，如果是，则返回 true。例如 [ \$a -gt \$b ] 返回 false"
echo "-lt 检测左边的数是否小于右边的，如果是，则返回 true。例如 [ \$a -lt \$b ] 返回 true"
echo "-ge 检测左边的数是否大于等于右边的，如果是，则返回 true。例如 [ \$a -ge \$b ] 返回 false"
echo "-le 检测左边的数是否小于等于右边的，如果是，则返回 true。例如 [ $a -le $b ] 返回 true"

if [ $a -eq $b ]
then
   echo "$a -eq $b : a 等于 b"
else
   echo "$a -eq $b: a 不等于 b"
fi
if [ $a -ne $b ]
then
   echo "$a -ne $b: a 不等于 b"
else
   echo "$a -ne $b : a 等于 b"
fi
if [ $a -gt $b ]
then
   echo "$a -gt $b: a 大于 b"
else
   echo "$a -gt $b: a 不大于 b"
fi
if [ $a -lt $b ]
then
   echo "$a -lt $b: a 小于 b"
else
   echo "$a -lt $b: a 不小于 b"
fi
if [ $a -ge $b ]
then
   echo "$a -ge $b: a 大于或等于 b"
else
   echo "$a -ge $b: a 小于 b"
fi
if [ $a -le $b ]
then
   echo "$a -le $b: a 小于或等于 b"
else
   echo "$a -le $b: a 大于 b"
fi
echo "================================================================================================="

#布尔运算符 注意单中括号
echo "! 非运算，表达式为true则返回false，否则返回true。例如 [ ! false ] 返回true"
echo "-o 或运算，有一个表达式为true则返回true。 例如 [ \$a -lt 20 -o \$b -gt 100 ] 返回true"
echo "-a 与运算，两个表达式都为true则返回true。 例如 [ \$a -lt 20 -a \$b -gt 100 ] 返回false"
a=10
b=20

if [ $a != $b ]
then
   echo "$a != $b : a 不等于 b"
else
   echo "$a != $b: a 等于 b"
fi
if [ $a -lt 100 -a $b -gt 15 ]
then
   echo "$a 小于 100 且 $b 大于 15 : 返回 true"
else
   echo "$a 小于 100 且 $b 大于 15 : 返回 false"
fi
if [ $a -lt 100 -o $b -gt 100 ]
then
   echo "$a 小于 100 或 $b 大于 100 : 返回 true"
else
   echo "$a 小于 100 或 $b 大于 100 : 返回 false"
fi
if [ $a -lt 5 -o $b -gt 100 ]
then
   echo "$a 小于 5 或 $b 大于 100 : 返回 true"
else
   echo "$a 小于 5 或 $b 大于 100 : 返回 false"
fi
echo "================================================================================================="

#逻辑运算符 注意双中括号
echo "&& 逻辑AND 例如 [[ \$a -lt 100 && \$b -gt 100 ]] 返回true"
echo "|| 逻辑OR 例如 [[ \$a -lt 100 || \$b -gt 100 ]] 返回true"

a=10
b=20

if [[ $a -lt 100 && $b -gt 100 ]]
then
   echo "返回 true"
else
   echo "返回 false"
fi

if [[ $a -lt 100 || $b -gt 100 ]]
then
   echo "返回 true"
else
   echo "返回 false"
fi
echo "================================================================================================="

#字符串运算符
echo "= 检测两个字符串是否相等，相等返回true。例如 [ \$a = \$b ]"
echo "!= 检测两个字符串是否相等，不相等返回true。例如 [ \$a != \$b ]"
echo "-z 检测字符串长度是否为0，为0返回true。例如 [ -z \$a ]返回false"
echo "-n 检测字符串长度是否为0，不为0返回true。例如 [ -n \"\$a\" ] 返回true"
echo "str 检测字符串是否为空，不为空返回true。例如 [ \$a ]返回true"

a="abc"
b="efg"

if [ $a = $b ]
then
   echo "$a = $b : a 等于 b"
else
   echo "$a = $b: a 不等于 b"
fi
if [ $a != $b ]
then
   echo "$a != $b : a 不等于 b"
else
   echo "$a != $b: a 等于 b"
fi
if [ -z $a ]
then
   echo "-z $a : 字符串长度为 0"
else
   echo "-z $a : 字符串长度不为 0"
fi
if [ -n "$a" ]
then
   echo "-n $a : 字符串长度不为 0"
else
   echo "-n $a : 字符串长度为 0"
fi
if [ $a ]
then
   echo "$a : 字符串不为空"
else
   echo "$a : 字符串为空"
fi
echo "================================================================================================="

#echo命令
read name #从终端标准输入
echo "$name It is a test"
str="hello"
echo $str
echo string
echo "\"hello test!\""

echo "OK! \n" # -e 开启转义 \n显示换行
echo "It is a test"

echo "what is your name? \c" #不显示换行
echo "my name is Jim"

echo `date` #显示命令结果
