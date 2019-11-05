#!/usr/bin/env bash

echo "==================================================== for命令 ====================================================="

for var in list; do
  commands
done

echo "================================================================================================================="
for test in Alabama Alaska Arizona Arkansas California Colorado; do
  echo The next state is $test
done

for test in I don\'t know if this will work; do
  echo "word:$test"
done

echo "================================================================================================================="

list="Alabama Alaska Arizona Arkansas Colorado"
list=$list" Connecticut"
for state in $list; do
  echo "Have you ever visited $state?"
done

echo "================================================================================================================="

#从命令读取值
dir=$(pwd)/src/linux
echo "$dir"
file="$dir/states.txt"
for state in $(cat "$file"); do
  echo "Visit beautiful $state"
done

echo "================================================================================================================="

file="$dir/states.txt"
IFS=$'\n'
for state in $(cat $file); do
  echo "Visit beautiful $state"
done

echo "================================================================================================================="

for file in $(pwd)/*; do
  if [ -d "$file" ]; then
    echo "$file is a directory"
  elif [ -f "$file" ]; then
    echo "$file is a file"
  fi
done

echo "================================================================================================================="

for ((i = 1; i <= 10; i++)); do
  echo "The next number is $i"
done

echo "================================================================================================================="

for ((a = 1, b = 10; a <= 10; a++, b--)); do
  echo "$a - $b"
done

echo "================================================================================================================="

var1=10
while test $var1 -gt 0; do
  var1=$(($var1 - 1))
  echo "pass:$var1"
done

var1=10
while [ $var1 -gt 0 ]; do
  echo $var1
  var1=$((var1 - 1))
done

var1=10
while
  echo $var1
  [ $var1 -ge 0 ]
do
  echo "This is inside the loop"
  var1=$(($var1 - 1))
done

echo "================================================================================================================="

var1=100
until [ $var1 -eq 0 ]; do
  echo $var1
  var1=$(($var1 - 1))
done

echo "================================================================================================================="

for ((a = 1; a <= 3; a++)); do
  echo "Starting loop $a:"
  for ((b = 1; b <= 3; b++)); do
    echo " Inside loop: $b"
  done
done

echo "================================================================================================================="

for var1 in 1 2 3 4 5 6 7 8 9 10; do
  if [ $var1 -eq 5 ]; then
    break
  fi
  echo "Iteration number: $var1"
done
echo "The for loop is completed"

for ((var1 = 1; var1 < 15; var1++)); do
  if [ $var1 -gt 5 ] && [ $var1 -lt 10 ]; then
    continue
  fi
  echo "Iteration number: $var1"
done
