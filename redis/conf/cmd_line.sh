#!/usr/bin/env bash

# Redis 客户端的基本语法为:
	redis-cli

# 在远程服务上执行命令:
	redis-cli -h host -p port -a password

exp:
	redis-cli -h 127.0.0.1 -p 6379 -a "mypass"
