#!/usr/bin/env bash

test -f math.sh && echo true || echo false

test -z "oldbody" && echo 1 || echo 0

char='oldboy'

test -z "${char}" && echo 1 || echo 0

[ -f ./math.sh ] && echo 1 || echo 0

[[ -f ./math.sh ]] && echo 1 || ehco 0

## [[]] 里测试判断选项可以是通配符等进行模式匹配，并且 &&、||等操作符可以应用于其中，但不能应用于[]中
## 文件测试实例：

ls -l math.sh
#####################################################
############     [ 条件1 ] && {
############       echo "the first "
############       echo "the second"
############       echo "the third"
############     }
############
############     [[ 条件2 ]] && {
############     	echo "the first "
############       echo "the second"
############       echo "the third"
############     }
############
############     test 条件1 && {
############     	echo "the first "
############       echo "the second"
############       echo "the third"
############     }
#####################################################

clear

cat <<EOF
		1.pan xiao ting
		2.gong li
		3.fan bing bing
EOF

read -p "which do you like? please input the num:" a

sleep 1 # 休眠1s

[ "$a" = "1" ] && {
		echo "I guess, you like panxiaoting"
}

[ "$a" = "2" ] && {
		echo "I guess, you like gongli"
}

[ "$a" = "3" ] && {
	echo "I guess, you like fanbingbing"
}

[[ ! "$a" =~ [1-3] ]] && {
	echo "I guess, you are not man."
}


while true
do
	uptime
	sleep 2
done
