#!/usr/bin/env bash

total=0
NUM=$((RANDOM%61))

echo "当前苹果的价格是每斤${SUM}元"
echo "===================================="

usleep 1000000
clear

echo '这苹果多少钱一斤啊？请猜0~60的数字 '

function apple() {
	read -p "请输入你的价格：" PRICE
	expr ${PRICE} + 1 &> /dev/null

	if [ $? -ne 0 ]; then
		echo "别逗我了，快猜数字 "
		apple
	fi
}

function guess() {
	((total++))
	if [ ${PRICE} -eq ${NUM} ]; then

		echo "猜对了，就是${NUM}元"
		if [ ${total} -le 3 ]; then
			echo "一共猜了${total}次，太牛了。"
		elif [ ${total} -gt 6 ]; then
			echo "一共猜了${total}次，行不行，猜了这么多次"
		fi
			exit 0
	elif [ ${PRICE} -gt ${NUM} ]; then
		echo "嘿嘿，要不你用这个价格买？"
		echo "再给你一次机会，请继续猜："
		apple
	elif [ ${PRICE} -lt ${NUM} ]; then
		echo "太低太低"
		echo "再给你一次机会，请继续猜: "
		apple
	fi
}

function main() {
	apple
	while true
	do
		guess
	done
}

main
