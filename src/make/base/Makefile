all: run clean

.PHONY: all run clean

# this is comment
-include ./make_file

VPATH = ./mk01 : ./mk02 # 可以从这两个文件中寻找依赖
-include ./mk01/mk_01
-include ./mk02/mk_02

# 先看第一种方式，也就是简单的使用“=”号，在“=”左侧是变量，右侧是变量的值，右侧 变量的值可以定义在文件的任何一处，
# 也就是说，右侧中的变量不一定非要是已定义好的值， 其也可以使用后面定义的值
name3 = $(name2)
# 值得一提的是，":"这种方法，前面的变量不能使用后面的变量，只能使用前面已定义好了的变量。
name1 := hello world
name2 := $(name1)

# 其含义是，如果FOO没有被定义过，那么变量FOO的值就是“bar”，如果FOO先前被定义过，那么这条语将什么也不做
FOO ?= bar
# 其等价于:
ifeq ($(origin FOO), undefined)
	FOO = bar
endif

# 这里介绍两种变量的高级使用方法，第一种是变量值的替换。我们可以替换变量中的共有的部分，其格式是“$(var:a=b)”或是“${var:a=b}”，
# 其意思是，把变量“var”中所有以 “a”字串“结尾”的“a”替换成“b”字串。这里的“结尾”意思是“空格”或是“结束符”。

# 这个示例中，我们先定义了一个“$(foo)”变量，而第二行的意思是把“$(foo)”中所 有以“.o”字串“结尾”全部替换成“.c”，
# 所以我们的“$(bar)”的值就是“a.c b.c c.c”。
foo := a.o b.o c.o
bar := $(foo:.o=.c)

# 这依赖于被替换字串中的有相同的模式，模式中必须包含一个“%”字符，这个例子同 样让$(bar)变量的值为“a.c b.c c.c”。
foo := a.o b.o c.o
bar := $(foo:%.o=%.c)

# 第二种高级用法是——“把变量的值再当成变量”。先看一个例子:
x=y
y=z
a := $($(x))

# 这个示例中，如果定义了“do_sort”，那么:foo := $(sort a d b g q c)，于是$(foo) 的值就是“a b c d g q”，
# 而如果没有定义“do_sort”，那么:foo := $(sort a d bg q c)，调用的就是 strip 函数。
ifdef do_sort
	func := sort
else
	func := strip
endif
bar := a d b g q c
foo := $($(func) $(bar))


# define 命令包
define var_name1
	ls -al
endef

if_def := true
var := no_if_def
ifdef if_def
	var := "hello ifdef"
endif

ifeq (0,${MAKELEVEL})
	cur-dir := $(shell pwd)
	whoami := $(shell whoami)
	host-type := $(shell arch)
	MAKE := ${MAKE} host-type=${host-type} whoami=${whoami}
endif



run:
	@echo $(name3)
	@$(var_name1)
	@$(if_def)
	@echo "print all content"

clean:
	@echo $(name2)
	@echo "this is a clean command!"
	@echo $(var)





