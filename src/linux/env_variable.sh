#!/usr/bin/env bash
env
printenv

printenv HOME

echo "$HOME"

ls "$HOME"

my_variable=HELLO
echo "${my_variable}"

# global

my_variable=" HELLO VARIABLE"
export my_variable
echo "${my_variable}"

# delete env

unset my_variable


# path

echo "$PATH"

PATH=$PATH:/custom/path

echo "$PATH"

PATH=$PATH:. #.当前目录

# 数组变量
array=(one two three four five six seven)

echo "${array[@]}"
echo "${array[*]}"

