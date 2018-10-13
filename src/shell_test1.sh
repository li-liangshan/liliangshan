#!/usr/bin/env bash

for ((i=1; i <= 3; i++))
do
	echo $i
done


i=1
while ((i <= 3))
do
	echo $i
	((i++))
done

for num in 5 4 3 2 1
do
	echo $num
done

echo {5..1}

echo "打印九九乘法表效果图如下："

COLOR='\033[47;30m'
RES='\033[0m'

for num1 in `seq 9`
do
	for num2 in `seq 9`
	do
		if [ ${num1} -ge ${num2} ]; then
				if (( (num1*num2)>9 )); then
					echo -en "${COLOR}${num1}x${num2}=$((num1*num2))$RES "
				else
					echo -en "${COLOR}${num1}x${num2}=$((num1*num2))${RES}  "
				fi
		fi
	done
echo "  "
done

# awk 版九九乘法表
seq 9 | sed 'H;g' | awk -v RS='' '{ for(i=1;i<=NF;i++) printf("%dx%d=%d%s", i, NR, i*NR, i==NR?"\n":"\t") }'
