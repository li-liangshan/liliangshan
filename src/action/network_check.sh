#!/usr/bin/env bash

### 检测网段是否-通
for i in {1..254}
do
	ping -c2 -i0.3 -W1 192.168.0.$i  &>/dev/null
	if [[ $? -eq 0 ]]; then
			echo "192.16.0.$i is up"
	else
		echo "192.16.0.$i is down"
	fi
done

### 另一种写法此实例：
i=1
while [[ $i -le 254 ]]
do
	ping -c2 -i0.3 -W1 192.168.0.$i  &>/dev/null
	if [[ $? -eq 0 ]]; then
			echo "192.16.0.$i is up"
	else
		echo "192.16.0.$i is down"
	fi
  let i++
done
