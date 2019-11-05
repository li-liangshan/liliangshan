#!/usr/bin/env bash

if pwd; then
  echo "It works"
fi

echo "We are outside the if statement"

########################################################################################################################

test_user="liliangshan"
if grep "${test_user}" /etc/passwd; then
  echo "this is the first command"
  echo "this is the second command"
  echo "I can even put in other commands besides echo:"
  ls -a /home/${test_user}/.b*
fi

########################################################################################################################

test_user=NoSuchUser

if grep $test_user /etc/passwd; then
  echo "The bash files for user $test_user are:"
  ls -a /home/$test_user/.b*
  echo
else
  echo "The user $test_user does not exist on this system."
  echo
fi

########################################################################################################################

if true; then
  echo ""
elif [ 1 -n 0 ]; then
  echo ""
else
  echo ""
fi

########################################################################################################################

test condition
if test condition; then
  commands
fi

if test; then
  echo "No expression return a true"
else
  echo "No expression return a false"
fi

########################################################################################################################

my_variable="full"
if test ${my_variable}; then
  echo "The $my_variable expression returns a True"
else
  echo "The $my_variable expression returns a False"
fi

echo "test命令可以判断三类条件: 1. 数值比较; 2. 字符串比较; 3. 文件比较"

echo "===================================================> 1. 数值比较 <================================================="
echo " n1 -eq n2 ---- 检查n1是否与n2相等"
echo " n1 -ge n2 ---- 检查n1是否大于或等于n2"
echo " n1 -gt n2 ---- 检查n1是否大于n2"
echo " n1 -le n2 ---- 检查n1是否小于或等于n2"
echo " n1 -lt n2 ---- 检查n1是否小于n2"
echo " n1 -ne n2 ---- 检查n1是否不等于n2"

########################################################################################################################

value1=10
value2=11
#
if [ $value1 -gt 5 ]; then
  echo "The test value $value1 is greater than 5"
fi

if [ $value1 -eq $value2 ]; then
  echo "The values are equal"
else
  echo "The values are different"
fi

########################################################################################################################

if [ $value1 -gt 5 ]; then echo ""; fi

if [ $value1 -eq $value2 ]; then echo ""; fi

########################################################################################################################

value1=5.555
echo "The test value is $value1"

if [ $value1 -gt 5 ]; then
  echo "The test value $value1 is greater than 5"
fi

########################################################################################################################

echo "===================================================> 2. 字符串比较 <================================================="
echo " str1 = str2 ---- 检查str1是否和str2相同"
echo " str1 != str2 ---- 检查str1是否和str2不同"
echo " str1 < str2 ---- 检查str1是否比str2小"
echo " str1 > str2 ---- 检查str1是否比str2大"
echo " -n str1 ---- 检查str1的长度是否非0"
echo " -z str1 ---- 检查str1的长度是否为0"

########################################################################################################################

val1=testing
val2=''
#
if [ -n "$val1" ]; then
  echo "The string '$val1' is not empty"
else
  echo "The string '$val1' is empty"
fi
#
if [ -z $val2 ]; then
  echo "The string '$val2' is empty"
else
  echo "The string '$val2' is not empty"
fi
#
if [ -z "$val3" ]; then
  echo "The string '$val3' is empty"
else
  echo "The string '$val3' is not empty"
fi

########################################################################################################################

echo "===================================================> 3. 文件比较 <================================================="

echo "  -d file                检查file是否存在并是一个目录"
echo "  -e file                检查file是否存在"
echo "  -f file                检查file是否存在并是一个文件"
echo "  -r file                检查file是否存在并可读"
echo "  -s file                检查file是否存在并非空"
echo "  -w file                检查file是否存在并可写"
echo "  -x file                检查file是否存在并可执行"
echo "  -O file                检查file是否存在并属当前用户所有"
echo "  -G file                检查file是否存在并且默认组与当前用户相同"
echo "  file1 -nt file2        检查file1是否比file2新"
echo "  file1 -ot file2        检查file1是否比file2旧"

########################################################################################################################

location=$HOME
file_name="sentinel"
#
if [ -e "$location" ]; then #Directory does exist
  echo "OK on the $location directory."
  echo "Now checking on the file, $file_name."
  #
  if [ -e "$location"/$file_name ]; then #File does exist
    echo "OK on the filename"
    echo "Updating Current Date..."
    date >>"$location"/$file_name
  #
  else #File does not exist
    echo "File does not exist"
    echo "Nothing to update"
  fi
#
else #Directory does not exist
  echo "The $location directory does not exist."
  echo "Nothing to update"
fi

########################################################################################################################

echo "===================================================> 4. 复合条件测试 <================================================="

# and
if [ -d $HOME ] && [ -w $HOME/testing ]; then
  echo "The file exists and you can write to it"
else
  echo "I cannot write to the file"
fi

# or
if [ -d $HOME ] || [ -w $HOME/testing ]; then
  echo "The home is directory or $HOME/testing fie can be wrote."
else
  echo "I cannot write to the file"
fi

########################################################################################################################

echo "===================================================> 5. if-then的高级特性 <================================================="

echo "bash shell提供了两项可在if-then语句中使用的高级特性: 1. 用于数学表达式的双括号; 2.用于高级字符串处理功能的双方括号"

echo " 1. 用于数学表达式的双括号"
val1=10
if ((val1 ** 2 > 90)); then
  ((val2 = val1 ** 2))
  echo "The square of $val1 is $val2"
fi

echo " 2. 用于高级字符串处理功能的双方括号: [[ expression ]]"
echo "双方括号里的expression使用了test命令中采用的标准字符串比较。但它提供了test命令未提供的另一个特性——模式匹配"
if [[ $USER == r* ]]; then
  echo "Hello $USER"
else
  5
  echo "Sorry, I do not know you"
fi

########################################################################################################################

echo " case命令 "

if [ $USER = "rich" ]; then
  echo "Welcome $USER"
  echo "Please enjoy your visit"
elif [ $USER = "barbara" ]; then
  echo "Welcome $USER"
  echo "Please enjoy your visit"
elif [ $USER = "testing" ]; then
  echo "Special testing account"
elif [ $USER = "jessica" ]; then
  echo "Do not forget to logout when you're done"
else
  echo "Sorry, you are not allowed here"
fi

case variable in
pattern1 | pattern2) commands1 ;; pattern3) commands2 ;;
*) default commands ;;
esac

echo "case命令会将指定的变量与不同模式进行比较。如果变量和模式是匹配的，那么shell会执行 为该模式指定的命令。
可以通过竖线操作符在一行中分隔出多个模式模式。星号会捕获所有与已知模式不匹配的值。"

case $USER in rich | barbara)
  echo "Welcome, $USER"
  echo "Please enjoy your visit"
  ;;
testing)
  echo "Special testing account"
  ;;
jessica)
  echo "Do not forget to log off when you're done"
  ;;
*)
  echo "Sorry, you are not allowed here"
  ;;
esac
