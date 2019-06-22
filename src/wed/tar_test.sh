#!/usr/bin/env bash

# tar命令可以为linux的文件和目录创建档案。利用tar，可以为某一特定文件创建档案（备份文件），也可以在档案中改变文件，或者向档案中加入新的文件。
# tar最初被用来在磁带上创建档案，现在，用户可以在任何设备上创建档案。利用tar命令，可以把一大堆的文件和目录全部打包成一个文件，
# 这对于备份文件或将几个文件组合成为一个文件以便于网络传输是非常有用的。

tar [options] arguments

# options:选项
# -A或--catenate：新增文件到以存在的备份文件；
# -B：设置区块大小；
# -c或--create：建立新的备份文件；
# -C <目录>：这个选项用在解压缩，若要在特定目录解压缩，可以使用这个选项。
# -d：记录文件的差别；
# -x或--extract或--get：从备份文件中还原文件；
# -t或--list：列出备份文件的内容；
# -z或--gzip或--ungzip：通过gzip指令处理备份文件；
# -Z或--compress或--uncompress：通过compress指令处理备份文件；
# -f<备份文件>或--file=<备份文件>：指定备份文件；
# -v或--verbose：显示指令执行过程；
# -r：添加文件到已经压缩的文件；
# -u：添加改变了和现有的文件到已经存在的压缩文件；
# -j：支持bzip2解压文件；
# -v：显示操作过程；
# -l：文件系统边界设置；
# -k：保留原有文件不覆盖；
# -m：保留文件不被覆盖；
# -w：确认压缩文件的正确性；
# -p或--same-permissions：用原来的文件权限还原文件；
# -P或--absolute-names：文件名使用绝对名称，不移除文件名称前的“/”号；
# -N <日期格式> 或 --newer=<日期时间>：只将较指定日期更新的文件保存到备份文件里；
# --exclude=<范本样式>：排除符合范本样式的文件。

# arguments: 参数
# 文件或目录：指定要打包的文件或目录列表。

############################################# 实例 ###########################################
# 将文件全部打包成tar包：
# 在选项f之后的文件档名是自己取的，我们习惯上都用 .tar 来作为辨识。 如果加z选项，则以.tar.gz或.tgz来代表gzip压缩过的tar包；
# 如果加j选项，则以.tar.bz2来作为tar包名
tar -cvf log.tar log2012.log # 仅打包，不压缩
tar -zcvf log.tar.gz log2012.log # 打包以后，以gzip压缩
tar -jcvf log.tar.bz2 log2012.log # 打包以后，以bzip2压缩

# 查阅上述tar包内有哪些文件
tar -ztvf log.tar.gz # 由于我们使用 gzip 压缩的log.tar.gz，所以要查阅log.tar.gz包内的文件时，就得要加上z这个选项了。

# 将tar包解压缩
tar -zxvf /opt/soft/test/log.tar.gz

# 只将tar内的部分文件解压出来：
tar -zxvf /opt/soft/test/log30.tar.gz log2013.log

# 文件备份下来，并且保存其权限
tar -zcvpf log31.tar.gz log2014.log log2015.log log2016.log
# 这个-p的属性是很重要的，尤其是当您要保留原本文件的属性时

# 在文件夹当中，比某个日期新的文件才备份
tar -N "2012/11/13" -zcvf log17.tar.gz test

# 备份文件夹内容是排除部分文件：
tar --exclude scf/service -zcvf scf.tar.gz scf/*

# 其实最简单的使用 tar 就只要记忆底下的方式即可：
# 压　缩：
tar -jcv -f filename.tar.bz2  # 要被压缩的文件或目录名称
# 查　询：
tar -jtv -f filename.tar.bz2
# 解压缩：
tar -jxv -f filename.tar.bz2 -C # 欲解压缩的目录


