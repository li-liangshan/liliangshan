#!/usr/bin/env bash

a=6
b=2
echo "a-b=$(($a-$b))"
echo "a+b=$(($a+$b))"
echo "a*b=$(($a*$b))"
echo "a/b=$(($a/$b))"
echo "a%b=$(($a%$b))"
echo "a**b=$(($a**$b))"

echo "============================ 加减乘除运算实例 ============================"

function print_usage() {
	printf "Please enter an integer\n"
	exit 1
}

read -p "Please input first number: " first_num

if [ -n "`echo ${first_num}|sed 's/[0-9]//g'`" ]; then
	print_usage
fi

read -p "Please input the operators: " operators

if [ "${operators}" != "+" ] && [ "${operators}" != "-" ] && [ "${operators}" != "*" ]  \
		&& [ "${operators}" != "/" ]; then
		echo "please use (+|-|*|/)"
		exit 2
fi

read -p "Please input the second number: " second_num
if [ -n "`echo ${second_num}|sed 's/[0-9]//g'`" ]; then
    print_usage
fi

echo "$first_num$operators$second_num=$(($first_num$operators$second_num))"
