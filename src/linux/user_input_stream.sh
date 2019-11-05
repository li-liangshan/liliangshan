#!/usr/bin/env bash

echo " \$0:程序名 \$1:第一个参数 ...... "
echo $? # 显示最后命令的退出状态。0表示没有错误，其他任何值表明有错误
echo $# # 显示参数的个数
echo "文件名：$0"

if [ $# -le 0 ]; then
  exit 1
fi

factorial=1
for ((number = 1; number <= $1; number++)); do
  factorial=$((factorial * number))
done
echo The factorial of "$1" is $factorial

echo count=1
#
for param in "$*"; do
  echo "\$* Parameter #$count = $param"
  count=$((count + 1))
done
#
echo
count=1
#
for param in "$@"; do
  echo "\$@ Parameter #$count = $param"
  count=$((count + 1))
done

echo "移动变量:"
echo
count=1
while [ -n "$1" ]; do
  echo "Parameter #$count = $1"
  count=$((count + 1))
  shift
done

echo "查找选项:"
echo
echo ""
while [ -n "$1" ]; do
  case "$1" in
  -a) echo "Found the -a option" ;;
  -b) echo "Found the -b option" ;;
  -c) echo "Found the -c option" ;;
  *) echo "$1 is not an option" ;;
  esac
  shift
done

echo
while [ -n "$1" ]; do
  case "$1" in
  -a) echo "Found the -a option" ;;
  -b)
    param="$2"
    echo "Found the -b option, with parameter value $param"
    shift
    ;;
  -c) echo "Found the -c option" ;;
  --)
    shift
    break
    ;;
  *) echo "$1 is not an option" ;;
  esac
  shift
done

echo
while getopts :ab:c opt; do
  case "$opt" in
  a) echo "Found the -a option" ;;
  b) echo "Found the -b option, with value $OPTARG" ;;
  c) echo "Found the -c option" ;;
  *) echo "Unknown option: $opt" ;;
  esac
done
