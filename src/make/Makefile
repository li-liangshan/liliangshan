# 这是一个总控Makefile
# 我们把这个 Makefile 叫做“总控 Makefile”，总控 Makefile 的变量可以传递到下级 的 Makefile 中(如果你显示的声明)，
# 但是不会覆盖下层的 Makefile 中所定义的变量，除非指定了“-e”参数。
# 如果你要传递变量到下级 Makefile 中，那么你可以使用这样的声明: export <variable ...>  ---> export variable = value
# 如果你不想让某些变量传递到下级 Makefile 中，那么你可以这样声明: unexport <variable ...>  ---> unexport variable
# 如果你要传递所有的变量，那么，只要一个 export 就行了。后面什么也不用跟，表示 传递所有的变量。

# 以下两个命令等价
rdb:
	cd rdb && $(MAKE)

rdb_eq:
	$(MAKE) -C rdb

# 以上两个命令等价






