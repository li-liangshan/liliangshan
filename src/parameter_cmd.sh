#!/usr/bin/env bash

# ${parameter:-word}如果parameter的变量值为空或未赋值，则会返回word字符串并替代变量的值。
# ${parameter:=word}如果parameter的变量值为空或未赋值，则设置这个变量值为word字符串并返回其值。
# ${parameter:?word}如果parameter的变量值为空或未赋值，那么word字符串将会作为标准错误输出，则输出变量值。
# ${parameter:+word}如果parameter的变量值为空或未赋值，则什么都不做，否则word将代替变量的值

echo '${parameter:-word}如果parameter的变量值为空或未赋值，则会返回word字符串并替代变量的值。'
echo ${test}
result=${test:-UNSET}
echo ${result}
echo ${test}

echo '${parameter:=word}如果parameter的变量值为空或未赋值，则设置这个变量值为word字符串并返回其值。'
unset result
echo ${result}
unset test
echo ${test}
result=${test:=unset}
echo "result:${result}"
echo "test:${test}"

echo '${parameter:?word}如果parameter的变量值为空或未赋值，那么word字符串将会作为标准错误输出，则输出变量值。'

echo ${key:? not defined} | echo "last return:$?"

echo '${parameter:+word}如果parameter的变量值为空或未赋值，则什么都不做，否则word将代替变量的值.'
oldbody=${oldgirl:+word}

