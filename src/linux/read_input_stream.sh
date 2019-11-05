#!/usr/bin/env bash

read -p "Please enter your age: " age
days=$((age * 365))
echo "That makes you over $days days old! "

read -n1 -p "Do you want to continue [Y/N]? " answer
case $answer in
Y | y)
  echo
  echo "fine, continue on..."
  ;;
N | n)
  echo
  echo OK, goodbye
  exit 0
  ;;
esac
echo "This is the end of the script"

read -s -p "Enter your password: " password
echo
echo "Is your password really $password ? "

count=1
cat ./src/linux/states.txt |
  while read line; do
    echo "Line $count: $line"
    count=$(($count + 1))
  done
echo "Finished processing the file"
