#!/usr/bin/env bash
######################################################################################
# 1. 递归调用
# 不懂递归不算是合格的程序员
# 递归调用是一种特殊的嵌套调用，是一个函数在它的函数体内调用它自身称为递归调用。这种函数称为递归函数。
######################################################################################
domain=$1
######################################################################################
function include(){
	txt=$1
	for host in $(echo ${txt} | egrep -o "include:(.+) ")
	do
		txt=$(dig $(echo ${host} | cut -d":" -f2) txt | grep "v=spf1")
		echo ${txt};
		if [ "$(echo ${txt} | grep "include")" ]; then
			include "$txt"
		fi
	done
}

function main(){
  domain1=$1
	spf=$(dig ${domain1} txt | grep "v=spf1")
	echo ${spf}

	if [ "$(echo ${spf} | grep "include")" ]; then
		include "$spf"
	fi
}

main ${domain}
