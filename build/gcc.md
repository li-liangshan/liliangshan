### GCC详解
----

##### gcc 与 g++ 分别是 gnu 的 c & c++ 编译器 gcc/g++ 在执行编译工作的时候，总共需要4步：

1. 预处理,生成 .i 的文件[预处理器cpp]。 
2. 将预处理后的文件不转换成汇编语言, 生成文件 .s [编译器egcs]。
3. 有汇编变为目标代码(机器代码)生成 .o 的文件[汇编器as]。
4. 连接目标代码, 生成可执行程序 [链接器ld]。

GCC 可同时用来编译 C 程序和 C++ 程序。一般来说，C 编译器通过源文件的后缀名来判断是 C 程序还是 C++ 程序。在 Linux 中，C 源文件的后缀名为 .c，
而 C++ 源文件的后缀名为 .C 或 .cpp。但是，gcc 命令只能编译 C++ 源文件，而不能自动和 C++ 程序使用的库连接。
因此，通常使用 g++ 命令来完成 C++ 程序的编译和连接，该程序会自动调用 gcc 实现编译。
 
##### 参数详解

1. -x language filename 设定文件所使用的语言, 使后缀名无效, 对以后的多个有效

		根据约定 C 语言的后缀名称是 .c 的，而 C++ 的后缀名是 .C 或者 .cpp, 
		如果你很个性，决定你的 C 代码文件的后缀名是 .pig 哈哈，那你就要用这个参数, 这个参数对他后面的文件名都起作用，除非到了下一个参数的使用。 
		可以使用的参数吗有下面的这些：'c', 'objective-c', 'c-header', 'c++', 'cpp-output', 'assembler', 与 'assembler-with-cpp'。
		例如：gcc -x c hello.pig 
    
2. -x none filename 关掉上一个选项，也就是让gcc根据文件名后缀，自动识别文件类型
		
		例子：gcc -x c hello.pig -x none hello2.c 
		
3. -c 只激活预处理,编译,和汇编,也就是他只把程序做成obj文件

		例子：gcc -c hello.c 
		
4. -S 只激活预处理和编译，就是指把文件编译成为汇编代码

		例子: gcc -S hello.c 他将生成 .s 的汇编代码，你可以用文本编辑器察看。

5. -E 只激活预处理,这个不生成文件, 你需要把它重定向到一个输出文件里面。

		例子: 
		   1. gcc -E hello.c > pianoapan.txt
		   2. gcc -E hello.c | more  # 慢慢看吧, 一个 hello word 也要与处理成800行的代码。
	
6. -o 制定目标名称, 缺省的时候, gcc 编译出来的文件是 a.out

		例子:
		   1. gcc -o hello.exe hello.c (windows)
		   2. gcc -o hello.asm -S hello.c

...... 未完待续
