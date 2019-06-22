#!/usr/bin/env bash

echo "============================ 加减乘除运算实例 ============================"

function print_usage() {
	printf $"USAGE:$0 NUM1 {+|-|*|/} NUM2\n"
	exit 1
}

if [ $# -ne 3 ]; then
	print_usage
fi

first_num=$1
second_num=$3
op=$2

if [ -n "`echo ${first_num} | sed 's/[0-9]//g'`" ]; then
	print_usage
fi

if [ "$op" != "+" ] && [ "$op" != "-" ] && [ "$op" != "*" ] && [ "$op" != "/" ]; then
	print_usage
fi

if [ -n "`echo ${second_num} | sed 's/[0-9]//g'`" ]; then
	print_usage
fi

echo "$first_num$op$second_num=$(($first_num$op$second_num))"

echo "========================================================================"
echo "============================= 打印杨辉三角 ==============================="
echo "========================================================================"

if [ test -z $1 ]; then
  read -p "Input Max Lines:" MAX
else
	MAX=$1
fi

i=1
while [ ${i} -le ${MAX} ];
do
	j=1
	while [ ${j} -le ${i} ];
	do
		f=$[i-1]
		g=$[j-1]
		if [ ${j} -eq ${i} ] || [ ${j} -eq 1 ]; then
			declare SUM_${i}_${j}=1
		else
			declar A=$[SUM_${f}_$j]
			declar B=$[SUM_${f}_$g]
			declar SUM_${i}_${j}=`expr ${A} + ${B}`
		fi
		echo -en $[SUM_${i}_${j}]" "
		let j++
	done
	echo
	let i++
done
