#!/usr/bin/env bash

# Redis脚本使用Lua解释器来执行脚本。
# 自版本2.6.0开始内嵌于Redis中。
# 用于编写脚本的命令是EVAL。

EVAL script numkeys key [key ...] arg [arg ...]
