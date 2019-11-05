#!/usr/bin/env bash

# 现实企业级Java应用开发、维护中，有时候我们会碰到下面这些问题：
# OutOfMemoryError，内存不足
# 内存泄露
# 线程死锁
# 锁争用（Lock Contention）
# Java进程消耗CPU过高

## 而且这些监控、调优工具的使用，无论你是运维、开发、测试，都是必须掌握的
jps
# 1.jps 主要用来输出JVM中运行的进程状态信息。语法格式如下：
# shellcheck disable=SC2102
jps [options] [hostid] # 如果不指定hostid就默认为当前主机或服务器。
usage: jps [-help]
       jps [-q] [-mlvV] [<hostid>]
Definitions:
    <hostid>:      <hostname>[:<port>]
# 命令行参数选项说明如下：
# -q 不输出类名、Jar名和传入main方法的参数
# -m 输出传入main方法的参数
# -l 输出main类或Jar的全限名
# -v 输出传入JVM的参数

# 2.jstack 主要用来查看某个Java进程内的线程堆栈信息。语法格式如下：
Usage:
    jstack [-l] <pid>
        (to connect to running process)
    jstack -F [-m] [-l] <pid>
        (to connect to a hung process)
    jstack [-m] [-l] <executable> <core>
        (to connect to a core file)
    jstack [-m] [-l] [server_id@]<remote server IP or hostname>
        (to connect to a remote debug server)

Options:
    -F  to force a thread dump. Use when jstack <pid> does not respond (process is hung)
    -m  to print both java and native frames (mixed mode)
    -l  long listing. Prints additional information about locks
    -h or -help to print this help message
# shellcheck disable=SC2102
jstack [option] pid
# shellcheck disable=SC2102
jstack [option] executable core
# shellcheck disable=SC2102
jstack [option] [server-id@]remote-hostname-or-ip
# -l long listings，会打印出额外的锁信息，在发生死锁时可以用jstack -l pid来观察锁持有情况-m mixed mode，
# 不仅会输出Java堆栈信息，还会输出C/C++堆栈信息（比如Native方法）
# jstack可以定位到线程堆栈，根据堆栈信息我们可以定位到具体代码，所以它在JVM性能调优中使用得非常多。
# 下面我们来一个实例找出某个Java进程中最耗费CPU的Java线程并定位堆栈信息，用到的命令有ps、top、printf、jstack、grep。
# 1.第一步先找出Java进程ID，我部署在服务器上的Java应用名称为mrf-center：
ps -ef | grep mrf-center | grep -v grep
root     21711     1  1 14:47 pts/3    00:02:10 java -jar mrf-center.jar
# 得到进程ID为21711，第二步找出该进程内最耗费CPU的线程，可以使用ps -Lfp pid或者ps -mp pid -o THREAD, tid, time
# 或者top -Hp pid，我这里用第三个，输出如下：
# TIME列就是各个Java线程耗费的CPU时间，CPU时间最长的是线程ID为21742的线程，用
#
# printf "%x\n" 21742 得到21742的十六进制值为54ee，下面会用到。
jstack 21711 | grep 54ee
# 可以看到CPU消耗在PollIntervalRetrySchedulerThread这个类的Object.wait()

# 3.jmap（Memory Map）和jhat（Java Heap Analysis Tool）
# jmap用来查看堆内存使用状况，一般结合jhat使用。
# jmap JVM Memory Map命令用于生成heap dump文件，如果不使用这个命令，还可以使用-XX:+HeapDumpOnOutOfMemoryError参数来
# 让虚拟机出现OOM的时候自动生成dump文件。 jmap不仅能生成dump文件，还可以查询finalize执行队列、Java堆和永久代的详细信息，
# 如当前使用率、当前使用的是哪种收集器等。
# jmap语法格式如下：
jmap [option] pid
jmap [option] executable core
jmap [option] [server-id@]remote-hostname-or-ip
# option： 选项参数。
# pid： 需要打印配置信息的进程ID。
# executable： 产生核心dump的Java可执行文件。
# core： 需要打印配置信息的核心文件。
# server-id 可选的唯一id，如果相同的远程主机上运行了多台调试服务器，用此选项参数标识服务器。
# remote server IP or hostname 远程调试服务器的IP地址或主机名。
######
# no option： 查看进程的内存映像信息,类似 Solaris pmap 命令。
# heap： 显示Java堆详细信息
# histo[:live]： 显示堆中对象的统计信息
# clstats：打印类加载器信息
# finalizerinfo： 显示在F-Queue队列等待Finalizer线程执行finalizer方法的对象
# dump:：生成堆转储快照
# F： 当-dump没有响应时，使用-dump或者-histo参数. 在这个模式下,live子参数无效.
# help：打印帮助信息
# J：指定传递给运行jmap的JVM的参数

# 如果运行在64位JVM上，可能需要指定-J-d64命令选项参数。
jmap -permstat pid
# -permstat 打印Java堆内存的永久区的类加载器的智能统计信息。对于每个类加载器而言，它的名称、活跃度、地址、父类加载器、它所加载的类的数量和大小都会被打印。此外，包含的字符串数量和大小也会被打印。
# 打印进程的类加载器和类加载器加载的持久代对象信息，输出：类加载器名称、对象是否存活（不可靠）、对象地址、父类加载器、已加载的类大小等信息
# 使用jmap -heap pid查看进程堆内存使用情况，包括使用的GC算法、堆配置参数和各代中堆内存使用情况:
jmap -heap 30348
Attaching to process ID 30348, please wait...
Debugger attached successfully.
Server compiler detected.
JVM version is 25.112-b16

using thread-local object allocation.
Parallel GC with 4 thread(s)

Heap Configuration:
   MinHeapFreeRatio         = 0
   MaxHeapFreeRatio         = 100
   MaxHeapSize              = 2147483648 (2048.0MB)
   NewSize                  = 44564480 (42.5MB)
   MaxNewSize               = 715653120 (682.5MB)
   OldSize                  = 89653248 (85.5MB)
   NewRatio                 = 2
   SurvivorRatio            = 8
   MetaspaceSize            = 21807104 (20.796875MB)
   CompressedClassSpaceSize = 1073741824 (1024.0MB)
   MaxMetaspaceSize         = 17592186044415 MB
   G1HeapRegionSize         = 0 (0.0MB)

Heap Usage:
PS Young Generation
Eden Space:
   capacity = 651165696 (621.0MB)
   used     = 467185880 (445.54317474365234MB)
   free     = 183979816 (175.45682525634766MB)
   71.74608288947702% used
From Space:
   capacity = 28835840 (27.5MB)
   used     = 0 (0.0MB)
   free     = 28835840 (27.5MB)
   0.0% used
To Space:
   capacity = 30932992 (29.5MB)
   used     = 0 (0.0MB)
   free     = 30932992 (29.5MB)
   0.0% used
PS Old Generation
   capacity = 218628096 (208.5MB)
   used     = 105443672 (100.55892181396484MB)
   free     = 113184424 (107.94107818603516MB)
   48.22969871173374% used

43283 interned Strings occupying 4854392 bytes.

# 使用jmap -histo[:live] pid查看堆内存中的对象数目、大小统计直方图，如果带上live则只统计活对象
jmap -histo 30348
jmap -histo:live 30348 | more
num     #instances         #bytes  class name
-------------------------------------------------------------------------------------------------
   1:        205050       21517376  [C
   2:         85469        7521272  java.lang.reflect.Method
   3:        203458        4882992  java.lang.String
   4:         93217        3728680  java.util.LinkedHashMap$Entry
   5:         56798        3669912  [Ljava.lang.Object;
   6:         30783        2404784  [Ljava.util.HashMap$Node;
   7:         72449        2318368  java.util.concurrent.ConcurrentHashMap$Node
   8:         16915        1887944  java.lang.Class
   9:         58563        1874016  java.util.HashMap$Node
  10:         82228        1774976  [Ljava.lang.Class;
  11:         17959        1580392  kotlin.reflect.jvm.internal.impl.metadata.ProtoBuf$Type
  12:         27252        1526112  java.util.LinkedHashMap
  13:         14540        1486272  [B
  14:         36136        1445440  kotlin.reflect.jvm.internal.impl.protobuf.SmallSortedMap$1
  15:         54606        1310544  java.util.ArrayList
  16:         17607        1267704  java.lang.reflect.Field
  17:         37378         897072  kotlin.reflect.jvm.internal.ReflectProperties$LazySoftVal
  18:         36136         867264  kotlin.reflect.jvm.internal.impl.protobuf.FieldSet
  19:          8694         773016  [I
  20:          1476         755824  [Ljava.util.concurrent.ConcurrentHashMap$Node;
  21:         15082         603280  java.lang.ref.SoftReference
  22:         12455         597840  java.util.HashMap
  23:          7387         590960  java.lang.reflect.Constructor
  24:         13023         574136  [Ljava.lang.String;
  25:         22244         533856  kotlin.reflect.jvm.internal.impl.name.Name
  26:         13335         533400  com.fasterxml.jackson.databind.introspect.AnnotatedMethod
  27:          6031         530728  kotlin.reflect.jvm.internal.impl.metadata.ProtoBuf$Function
  28:          6702         482544  org.springframework.core.annotation.AnnotationAttributes
  29:         29547         472752  java.lang.Object
  30:          7340         469760  kotlin.reflect.jvm.internal.impl.metadata.ProtoBuf$ValueParameter
  31:         25167         402672  com.fasterxml.jackson.databind.introspect.AnnotationMap
  32:          5387         367680  [Ljava.lang.reflect.Method;
  33:          8729         349160  java.lang.reflect.Parameter
  34:          3663         322344  kotlin.reflect.jvm.internal.impl.metadata.ProtoBuf$Property
  35:          8051         322040  kotlin.reflect.jvm.internal.impl.metadata.jvm.JvmProtoBuf$JvmMethodSignature
  36:         12707         304968  com.fasterxml.jackson.databind.introspect.MemberKey
  37:         12063         289512  sun.reflect.generics.tree.SimpleClassTypeSignature
  38:          4295         274880  kotlin.reflect.jvm.internal.impl.metadata.jvm.JvmProtoBuf$StringTableTypes$Record
  39:         16890         270240  kotlin.reflect.jvm.internal.impl.protobuf.SmallSortedMap$EntrySet
  40:          4170         266880  springfox.documentation.schema.ModelProperty
  41:          4097         262208  java.util.concurrent.ConcurrentHashMap

# class name是对象类型，说明如下：
B  byte
C  char
D  double
F  float
I  int
J  long
Z  boolean
[  数组，如[I表示int[]
[L+类名 其他对象
# 还有一个很常用的情况是：用jmap把进程内存使用情况dump到文件中，再用jhat分析查看。jmap进行dump命令格式如下：
# jmap -dump:format=b,file=dumpFileName pid
jmap -dump:format=b,file=dumpFileName 30384
# 注意如果Dump文件太大，可能需要加上-J-Xmx512m这种参数指定最大堆内存，即jhat -J-Xmx512m -port 9998 /tmp/dump.dat。
# 然后就可以在浏览器中输入主机地址:9998查看了：

# 4.jstat（JVM统计监测工具）语法格式如下：
jstat [ generalOption | outputOptions vmid [interval[s|ms] [count]] ]
# vmid是Java虚拟机ID，在Linux/Unix系统上一般就是进程ID。interval是采样时间间隔。count是采样数目。
# 比如下面输出的是GC信息，采样时间间隔为250ms，采样数为4：
jstack -help
Usage: jstat -help|-options
       jstat -<option> [-t] [-h<lines>] <vmid> [<interval> [<count>]]

Definitions:
  <option>      An option reported by the -options option
  <vmid>        Virtual Machine Identifier. A vmid takes the following form:
                     <lvmid>[@<hostname>[:<port>]]
                Where <lvmid> is the local vm identifier for the target
                Java virtual machine, typically a process id; <hostname> is
                the name of the host running the target Java virtual machine;
                and <port> is the port number for the rmiregistry on the
                target host. See the jvmstat documentation for a more complete
                description of the Virtual Machine Identifier.
  <lines>       Number of samples between header lines.
  <interval>    Sampling interval. The following forms are allowed:
                    <n>["ms"|"s"]
                Where <n> is an integer and the suffix specifies the units as
                milliseconds("ms") or seconds("s"). The default units are "ms".
  <count>       Number of samples to take before terminating.
  -J<flag>      Pass <flag> directly to the runtime system.

jstat -gc 30348 250 4
S0C       S1C    S0U    S1U      EC       EU        OC         OU       MC     MU      CCSC   CCSU       YGC    YGCT   FGC     FGCT     GCT
29696.0 29184.0  0.0    0.0   639488.0 120050.9  258048.0   88179.2   87768.0 83947.7 11008.0 10382.6     21    0.713   6      2.412    3.125
29696.0 29184.0  0.0    0.0   639488.0 120850.2  258048.0   88179.2   87768.0 83947.7 11008.0 10382.6     21    0.713   6      2.412    3.125
29696.0 29184.0  0.0    0.0   639488.0 120850.2  258048.0   88179.2   87768.0 83947.7 11008.0 10382.6     21    0.713   6      2.412    3.125
29696.0 29184.0  0.0    0.0   639488.0 120850.2  258048.0   88179.2   87768.0 83947.7 11008.0 10382.6     21    0.713   6      2.412    3.125
# 堆内存 = 年轻代 + 年老代 + 永久代
# 年轻代 = Eden区 + 两个Survivor区（From和To）
# 现在来解释各列含义：
# S0C、S1C、S0U、S1U：Survivor 0/1区容量（Capacity）和使用量（Used）
# EC、EU：Eden区容量和使用量
# OC、OU：年老代容量和使用量
# PC、PU：永久代容量和使用量
# YGC、YGT：年轻代GC次数和GC耗时
# FGC、FGCT：Full GC次数和Full GC耗时
# GCT：GC总耗时

# 5.hprof（Heap/CPU Profiling Tool）
# hprof能够展现CPU使用率，统计堆内存使用情况。
# 语法格式如下：
java -agentlib:hprof[=options] ToBeProfiledClass
java -Xrunprof[:options] ToBeProfiledClass
javac -J-agentlib:hprof[=options] ToBeProfiledClass
# 完整的命令选项如下：
Option Name and Value  Description                    Default
---------------------  -----------                    -------
heap=dump|sites|all    heap profiling                 all
cpu=samples|times|old  CPU usage                      off
monitor=y|n            monitor contention             n
format=a|b             text(txt) or binary output     a
file=<file>            write data to file             java.hprof[.txt]
net=<host>:<port>      send data over a socket        off
depth=<size>           stack trace depth              4
interval=<ms>          sample interval in ms          10
cutoff=<value>         output cutoff point            0.0001
lineno=y|n             line number in traces?         y
thread=y|n             thread in traces?              n
doe=y|n                dump on exit?                  y
msa=y|n                Solaris micro state accounting n
force=y|n              force output to <file>         y
verbose=y|n            print messages about dumps     y

java -agentlib:hprof=cpu=samples,interval=20,depth=3 Hello
# 上面每隔20毫秒采样CPU消耗信息，堆栈深度为3，生成的profile文件名称是java.hprof.txt，在当前目录。
# CPU Usage Times Profiling(cpu=times)的例子，它相对于CPU Usage Sampling Profile能够获得更加细粒度的CPU消耗信息，
# 能够细到每个方法调用的开始和结束，它的实现使用了字节码注入技术（BCI）：
javac -J-agentlib:hprof=cpu=times Hello.java

