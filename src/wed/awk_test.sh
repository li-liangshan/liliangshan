#!/usr/bin/env bash

echo "7.7 3.8" | awk '{print ($1 - $2)}'
echo "358 113" | awk '{print ($1-3)/$2}'
echo "3 9" | awk '{print ($1+3)*$2}'

# awk 是一种编程语言，用于在Linux/Unix下对文本和数据进行处理。数据可以来自标准输入、一个或多个文件，或其它命令的输出。它支持用户自定义函数
# 和动态正则表达式等先进功能，是Linux/Unix下的一个强大编程工具。它在命令行中使用，但更多是作为脚本来使用。awk有很多内建的功能，比如数组、函数等
# 这是它和C语言的相同之处，灵活性是awk的最大优势。

# 语法：
#    awk [options] 'script' var=value file(s)
#    awk [options] -f script_file var=value file(s)

# 常用命令选项：
#    -F fs  fs指定输入分隔符，fs可以是字符串或正则表达式，如：—F
#    -v var=value 赋值一个用户定义变量，将外部变量传递给awk
#    -f script_file 从脚本文件中读取awk命令
#    -m[fr] val 对val值设置内在限制，-mf选项限制分配给val的最大块数目；-mr选项限制记录的最大数目。这两个功能是Bell实验室版awk的扩展功能，在标准中不适用

# awk脚本是由模式和操作组成的
# 1.模式（可以是以下任意一种）：
#   a. /正则表达式/: 使用通配符的扩展集；
#   b. 关系表达式：使用运算符进行操作，可以是字符串或数字的比较测试。
#   c. 模式匹配表达式：用运算符~（匹配）和~！（不匹配）
#   d. BEGIN语句块、pattern语句块、END语句块

# 2.操作（由一个或多个命令、函数、表达式组成，之间由换行符或分号隔开，并位于大括号内）主要部分是：
#   a. 变量或数组赋值
#   b. 输出命令
#   c. 内置函数
#   d. 控制流语句

# awk脚本结构： awk 'BEGIN{ print "start" } pattern{ commands } END{ print "end" }' file
# 一个awk脚本通常由：BEGIN语句块、能够使用模式匹配的通用语句块、END语句块3部分组成，这三个部分是可选的。
# 任意一个部分都可以不出现在脚本中，脚本通常是被单引号或双引号中。

awk 'BEGIN{ i=0 } { i++ } END{ print i }' filename
awk "BEGIN{ i=0 } { i++ } END{ print i }" filename

# awk工作原理
#    awk 'BEGIN{ commands } pattern{ commands } END{ commands }'
#    1. 第一步：执行BEGIN{ commands }语句块中的语句；
#    2. 第二步：从文件或标准输入(stdin)读取一行，然后执行pattern{ commands }语句块，它逐行扫描文件，从第一行到最后一行重复这个过程，
#              直到文件全部被读取完毕。
#    3. 第三步：当读至输入流末尾时，执行END{ commands }语句块。

#### BEGIN语句块在awk开始从输入流中读取行之前被执行，这是一个可选的语句块，比如变量初始化、打印输出表格的表头等语句通常可以写在BEGIN语句块中。
#### END语句块在awk从输入流中读取完所有的行之后即被执行，比如打印所有行的分析结果这类信息汇总都是在END语句块中完成，它也是一个可选语句块。
#### pattern语句块中的通用命令是最重要的部分，它也是可选的。如果没有提供pattern语句块，则默认执行{ print }，即打印每一个读取到的行，
####  awk读取的每一行都会执行该语句块。

echo -e "A line 1nA line 2" | awk 'BEGIN{ print "Start" } { print } END{ print "End" }'

# 当使用不带参数的print时，它就打印当前行，当print的参数是以逗号进行分隔时，打印时则以空格作为定界符。在awk的print语句块中双引号是被当作拼接符使用，

echo | awk '{ var1="v1"; var2="v2"; var3="v3"; print var1"="var2"="var3; }'

# awk 内置变量（预定义变量）
# 说明：[A][N][P][G]表示第一个支持变量的工具，[A]=awk、[N]=nawk、[P]=POSIXawk、[G]=gawk
# $n 当前记录的第n个字段，比如n为1表示第一个字段，n为2表示第二个字段。
# $0 这个变量包含执行过程中当前行的文本内容。
# ARGC 命令行参数的数目
# ARGIND 命令行中当前文件的位置（从0开始算）。
# ARGV 包含命令行参数的数组
# CONVFMT 数字转换格式（默认值为%.6g)。
# EVNIRON 环境变量关联数组。
# ERRNO 最后一个系统错误的
# FIELDWIDTHS 字段宽度列表（用空格键分隔）
# FILENAME 当前输入文件的名。
# FNR 同NR，但相对于当前文件
# FS 字段分隔符（默认是任何空格）
# IGNORECASE 如果为真，则进行忽略大小写的匹配
# NF 表示字段数，在执行过程中对应于当前的字段数
# NR 表示记录数，在执行过程中对应于当前的行号
# OFMT 数字的输出格式（默认是%.6g）
# OFS 输出字段分隔符（默认值是一个空格）
# ORS 输出记录分隔符（默认值是一个换行符）
# RS 记录分隔符（默认是一个换行符）
# RSTART 由match 函数匹配的字符串的第一个位置
# RLENGTH 有match函数所匹配的字符串长度。
# SUBSEP 数组下标分隔符（默认值是34）。
printf '1 2 3' | awk 'BEGIN { OFS=":" }; { print $1,$2,$3 }'

echo -e "line1 f2 f3\nline2 f4 f5\nline3 f6 f7" | awk '{ print "Line No:"NR", No of fields:"NF, "$0="$0,"$1="$1, "$2="$2, "$3="$3 }'

echo -e "line1 f2 f3\nline2 f4 f5\nline3 f6 f7" | awk 'BEGIN { OFS=" <=> " } { print "Line No:"NR", No of fields:"NF, "$0="$0,"$1="$1, "$2="$2, "$3="$3 }'

# 使用print $NF可以打印出一行中的最后一个字段，使用$(NF-1)则是打印倒数第二个字段，其他以此类推：
echo -e "line1 f2 f3\n line2 f4 f5" | awk '{ print $(NF) }'
echo -e "line1 f2 f3\n line2 f4 f5" | awk '{ print $(NF - 1) }'

# 打印每一行的第二和第三个字段
echo -e "hello the world\n this is scrpit" | awk '{ print $2,$3 }'

awk '{ print }' ../resources/content

seq 5 | awk 'BEGIN{ sum=0; print "总和：" } { print $1"+"; sum+=$1 } END { print "等于"; print sum }'

# 借助-v选项，可以将外部值（并非来自stdin）传递给awk
var=10000
echo | awk -v VARIABLE=${var} '{ print VARIABLE }'

# 另一种传递外部变量方法：
var1="aaa"
var2="bbb"
echo | awk '{ print v1,v2 }' v1=${var1} v2=${var2}

# 当输入来自于文件时使用：
awk '{ print v1,v2 }' v1=${var1} v2=${var2} filename

# 以上方法中，变量之间用空格分隔作为awk的命令行参数跟随在BEGIN、{}和END语句块之后。

# awk运算与判断
# 作为一种程序设计语言所应具有的特点之一，awk支持多种运算，这些运算与C语言提供的基本相同。
# awk还提供了一系列内置的运算函数（如log、sqr、cos、sin等）和一些用于对字符串进行操作（运算）的函数（如length、substr等等）。
# 这些函数的引用大大的提高了awk的运算功能。作为对条件转移指令的一部分，关系判断是每种程序设计语言都具备的功能，awk也不例外，
# awk中允许进行多种测试，作为样式匹配，还提供了模式匹配表达式~（匹配）和~!（不匹配）。作为对测试的一种扩充，awk也支持用逻辑运算符。

# 算术运算符:
#	+ -: 加，减;  * / &: 乘，除与求余; + - !: 一元加，减和逻辑非；^ ***: 求幂; ++ --: 增加或减少，作为前缀或后缀
awk 'BEGIN{ a="b"; print a++,++a; }'

# 赋值运算符
# = += -= *= /= %= ^= **=: 赋值语句

# 逻辑运算符
# || && 逻辑或 逻辑与
awk 'BEGIN{ a=1; b=2; print (a>5 && b<=2),(a>5 || b<=2); }'

# 正则运算符
# ~ ~!： 匹配正则表达式和不匹配正则表达式
awk 'BEGIN{ a="100testa"; if(a ~ /^100*/){ print "ok"; } }'

# 关系运算符
# < <= > >= != ==: 关系运算符
awk 'BEGIN{ a=11; if(a >= 9){ print "ok"; } }'

# 其它运算符
# $ 字段引用
# 空格 字符串连接符
# ?: C条件表达式
# in: 数组中是否存在某键值
awk 'BEGIN{a="b";print a=="b"?"ok":"err";}'
awk 'BEGIN{a="b";arr[0]="b";arr[1]="c";print (a in arr);}'
awk 'BEGIN{a="b";arr[0]="b";arr["b"]="c";print (a in arr);}'

# awk高级输入输出
# 1.读取下一条记录
# awk中next语句使用：在循环逐行匹配，如果遇到next，就会跳过当前行，直接忽略下面语句。而进行下一行匹配。
# net语句一般用于多行合并
awk 'NR%2==1{next}{ print NR,$0; }' text.txt

# awk getline用法：输出重定向需用到getline函数。getline从标准输入、管道或者当前正在处理的文件之外的其他输入文件获得输入。
# 它负责从输入获得下一行的内容，并给NF,NR和FNR等内建变量赋值。如果得到一条记录，getline函数返回1，如果到达文件的末尾就返回0，
# 如果出现错误，例如打开文件失败，就返回-1。
awk 'BEGIN{ "date" | getline out; print out }' test
awk 'BEGIN{ "date" | getline out; split(out,mon); print mon[2] }' test
awk 'BEGIN{ while( "ls" | getline) print }'

# 关闭文件
awk '{ close("filename") }'

# awk中允许用如下方式将结果输出到一个文件:
echo | awk '{ printf("hello world!\n") > "datafile" }'
echo | awk '{ printf("hello world!\n") >> "datafile" }'

# 设置字段定界符(默认的字段定界符是空格，可以使用-F "定界符" 明确指定一个定界符)
awk -F: '{ print $NF }' /etc/passwd
awk 'BEGIN{ FS=":" } { print $NF }' /etc/passwd
# 在BEGIN语句块中则可以用OFS=“定界符”设置输出字段的定界符。

#################################### 流程控制语句 ####################################
# 1.条件判断语句
awk 'BEGIN{
	test=100;
	if(test>90) {
		print "very good";
	} else if(test>60) {
		print "good";
	} else {
		print "no pass";
	}
}'
# 每条命令语句后面可以用;分号结尾。
# 2. 循环语句
# while 循环
awk 'BEGIN{
	test=100;
	total=0;
	while(i<test) {
		total+=i;
		i++;
	}
	print total;
}'

# for循环
awk 'BEGIN{
	for(k in ENVIRON) {
		print k"="ENVIRON[k];
	}

}'

awk 'BEGIN{
	total=0;
	for(i=0;i<=100;i++) {
		total+=i;
	}
	print total;
}'

# do循环
awk 'BEGIN{
	total = 0;
	i = 0;
	do {
		total += i;
		i++;
	} while( i <= 100 )
	print total;
}'

# 其他语句
# break 当 break 语句用于 while 或 for 语句时，导致退出程序循环。
# continue 当 continue 语句用于 while 或 for 语句时，使程序循环移动到下一个迭代。
# next 能能够导致读入下一个输入行，并返回到脚本的顶部。这可以避免对当前输入行执行其他的操作过程。
# exit 语句使主输入循环退出并将控制转移到END,如果END存在的话。如果没有定义END规则，或在END中应用exit语句，则终止脚本的执行。

# 数组的定义：数字做数组索引（下标）和 字符串做数组索引（下标）
Array[1]="sun"
Array[2]="kai"

Array["first"]="www"
Array["last"]="name"
Array["birth"]="1987"

awk 'BEGIN{ for(item in array) {print array[item]}; }'       #输出的顺序是随机的
awk 'BEGIN{ for(i=1;i<=len;i++) {print array[i]}; }'        #Len是数组的长度

# http://man.linuxde.net/awk















