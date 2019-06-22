#!/usr/bin/env bash

sum=15
msg_fee=15
msg_count=0

function menu() {
	cat <<EOF
当前余额为${sum}分，每条短信需要${msg_fee}分
===========================================================
			1. 充值
			2. 发消息
			3. 退出
===========================================================
EOF

}

function recharge() {
	read -p "请输入金额充值：" money
	expr ${money} + 1 &>/dev/null
	echo "$?"
	if [ $? -ne 0 ]; then
		echo "then money your input is error, must be int."
	else
		sum=$((${sum}+${money}))
		echo "当前余额为：${sum}"
	fi
}


function sendInfo() {
	if [ ${sum} -lt ${msg_fee} ]; then
		printf "余额不足：${sum}, 请充值。 \n"
	else
		while true
		do
			read -p "请输入短信内容（不能有空格）：" msg
			sum=$((${sum}-${msg_fee}))
			printf "Send "${msg}" successfully!\n"
			printf "当前余额为：${sum}\n"
			if [ ${sum} -lt ${msg_fee} ]; then
				printf "余额不足，剩余${sum}分 \n"
				return 1
			fi
		done
	fi
}

function main() {
	while true
	do
		menu
		read -p "请输入数字选择：" men
		case ${men} in
		1)
		   recharge
		   ;;
		2)
			sendInfo
			;;
		3)
			exit 1
			;;
		*)
			printf "选择错误，必须是{1|2|3} \n"
		esac
	done
}

main
