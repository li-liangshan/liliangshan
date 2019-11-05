#!/usr/bin/env bash
echo "---------------------------------
      文件描述符      缩写       描述    |
      0             STDIN     标准输入  |
      1             STDOUT    标准输出  |
      2             STDERR    标准错误  |
      ---------------------------------"

echo "永久重定向"
exec 1>testout
echo "This is a test of redirecting all output"
echo "from a script to another file."
echo "without having to redirect every individual line"
########################################################################################################################
exec 2>testerror
echo "This is the start of the script"
echo "now redirecting all output to another location"
exec 1>testout
echo "This output should go to the testout file"
echo "but this should go to the testerror file" >&2

exec 0<testfile
count=1
while read line; do
  echo "Line #$count: $line"
  count=$((count + 1))
done

echo "创建自己的重定向:"
exec 3>test13out
echo "This should display on the monitor"
echo "and this should be stored in the file" >&3
echo "Then this should be back on the monitor"

echo "重定向文件描述符"
exec 3>&1
exec 1>test14out
echo "This should store in the output file"
echo "along with this line."

exec 1>&3
echo "Now things should be back to normal"

########################################################################################################################

>/dev/null 2>&1

########################################################################################################################
echo "lfof
-a：列出打开文件存在的进程；
-c<进程名>：列出指定进程所打开的文件；
-g：列出GID号进程详情；
-d<文件号>：列出占用该文件号的进程；
+d<目录>：列出目录下被打开的文件；
+D<目录>：递归列出目录下被打开的文件；
-n<目录>：列出使用NFS的文件；
-i<条件>：列出符合条件的进程。（4、6、协议、:端口、 @ip ）
-p<进程号>：列出指定进程号所打开的文件；
-u：列出UID号进程详情；
-h：显示帮助信息；
-v：显示版本信息。"



