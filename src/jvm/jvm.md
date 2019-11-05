# JVM启动参数大全     
        
java启动参数共分为三类；
其一是标准参数（-），所有的JVM实现都必须实现这些参数的功能，而且向后兼容；
其二是非标准参数（-X），默认jvm实现这些参数的功能，但是并不保证所有jvm实现都满足，且不保证向后兼容；
其三是非Stable参数（-XX），此类参数各个jvm实现会有所不同，将来可能会随时取消，需要慎重使用；
本文主要描述标准参数部分，剩下的两个部分将会陆续推出；
标准参数列表如下：
-client 
 设置jvm使用client模式，特点是启动速度比较快，但运行时性能和内存管理效率不高，通常用于客户端应用程序或者PC应用开发和调试。
-server
 设置jvm使server模式，特点是启动速度比较慢，但运行时性能和内存管理效率很高，适用于生产环境。在具有64位能力的jdk环境下将默认启用该模式，而忽略-client参数。
-agentlib:libname[=options] 
 用于装载本地lib包；
 其中libname为本地代理库文件名，默认搜索路径为环境变量PATH中的路径，options为传给本地库启动时的参数，多个参数之间用逗号分隔。 在Windows平台上jvm搜索本地库名为libname.dll的文件，在linux上jvm搜索本地库名为libname.so的文件，搜索路径环 境变量在不同系统上有所不同，比如Solaries上就默认搜索LD_LIBRARY_PATH。
 比如：-agentlib:hprof
 用来获取jvm的运行情况，包括CPU、内存、线程等的运行数据，并可输出到指定文件中；windows中搜索路径为JRE_HOME/bin/hprof.dll。
-agentpath:pathname[=options] 
 按全路径装载本地库，不再搜索PATH中的路径；其他功能和agentlib相同；更多的信息待续，在后续的JVMTI部分会详述。
-classpath classpath 
-cp classpath 
 告知jvm搜索目录名、jar文档名、zip文档名，之间用分号;分隔；使用-classpath后jvm将不再使用CLASSPATH中的类搜索路径，如果-classpath和CLASSPATH都没有设置，则jvm使用当前路径(.)作为类搜索路径。
 jvm搜索类的方式和顺序为：Bootstrap，Extension，User。
 Bootstrap中的路径是jvm自带的jar或zip文件，jvm首先搜索这些包文件，用System.getProperty("sun.boot.class.path")可得到搜索路径。
 Extension是位于JRE_HOME/lib/ext目录下的jar文件，jvm在搜索完Bootstrap后就搜索该目录下的jar文件，用System.getProperty("java.ext.dirs")可得到搜索路径。
 User搜索顺序为当前路径.、CLASSPATH、-classpath，jvm最后搜索这些目录，用System.getProperty("java.class.path")可得到搜索路径。
-Dproperty=value
 设置系统属性名/值对，运行在此jvm之上的应用程序可用System.getProperty("property")得到value的值。
 如果value中有空格，则需要用双引号将该值括起来，如-Dname="space string"。
 该参数通常用于设置系统级全局变量值，如配置文件路径，以便该属性在程序中任何地方都可访问。
-enableassertions[:<package name>"..." | :<class name> ] 
-ea[:<package name>"..." | :<class name> ] 
 上述参数就用来设置jvm是否启动断言机制（从JDK 1.4开始支持），缺省时jvm关闭断言机制。
 用-ea  可打开断言机制，不加<packagename>和classname时运行所有包和类中的断言，如果希望只运行某些包或类中的断言，可将包 名或类名加到-ea之后。例如要启动包com.wombat.fruitbat中的断言，可用命令java  -ea:com.wombat.fruitbat...<Main Class>。
-disableassertions[:<package name>"..." | :<class ; ] 
-da[:<package name>"..." | :<class name> ]
 用来设置jvm关闭断言处理，packagename和classname的使用方法和-ea相同，jvm默认就是关闭状态。
 该参数一般用于相同package内某些class不需要断言的场景，比如com.wombat.fruitbat需要断言，但是com.wombat.fruitbat.Brickbat该类不需要，则可以如下运行：
 java -ea:com.wombat.fruitbat...-da:com.wombat.fruitbat.Brickbat <Main Class>。
 
-enablesystemassertions 
-esa 
 激活系统类的断言。
 
-disablesystemassertions 
-dsa 
 关闭系统类的断言。
-jar 
 指定以jar包的形式执行一个应用程序。
 要这样执行一个应用程序，必须让jar包的manifest文件中声明初始加载的Main-class，当然那Main-class必须有public static void main(String[] args)方法。
-javaagent:jarpath[=options] 
 指定jvm启动时装入java语言设备代理。
 Jarpath文件中的mainfest文件必须有Agent-Class属性。代理类也必须实现公共的静态public static void  premain(String agentArgs, Instrumentation  inst)方法（和main方法类似）。当jvm初始化时，将按代理类的说明顺序调用premain方法；具体参见 java.lang.instrument软件包的描述。
-verbose 
-verbose:class 
 输出jvm载入类的相关信息，当jvm报告说找不到类或者类冲突时可此进行诊断。
-verbose:gc 
 输出每次GC的相关情况。
-verbose:jni 
 输出native方法调用的相关情况，一般用于诊断jni调用错误信息。
 
-version 
 输出java的版本信息，比如jdk版本、vendor、model。
-version:release 
 指定class或者jar运行时需要的jdk版本信息；若指定版本未找到，则以能找到的系统默认jdk版本执行；一般情况下，对于jar文件，可以在manifest文件中指定需要的版本信息，而不是在命令行。
 release中可以指定单个版本，也可以指定一个列表，中间用空格隔开，且支持复杂组合，比如：
 -version:"1.5.0_04 1.5*&1.5.1_02+"
 指定class或者jar需要jdk版本为1.5.0_04或者是1.5系列中比1.5.1_02更高的所有版本。
-showversion 
 输出java版本信息（与-version相同）之后，继续输出java的标准参数列表及其描述。
 
-? 
-help 
 输出java标准参数列表及其描述。
-X 
 输出非标准的参数列表及其描述。
以上的这些参数我们经常会在很多情况下用到多个的组合，比如我们在用JProfiler进行跟踪监控时，需要在被监控java启动参数中加上如下配置：
-agentlib:jprofilerti=port=8849  -Xbootclasspath/a:/usr/local/jprofiler5/bin/agent.jar
其中就用到两个-agentlib和-X参数，bootclasspath参数的详细信息将会在非标准参数中详细说明。
http://blog.csdn.net/sfdev/archive/2008/01/24/2063464.aspx
非标准参数又称为扩展参数，其列表如下：
-Xint
 设置jvm以解释模式运行，所有的字节码将被直接执行，而不会编译成本地码。
 
-Xbatch
 关闭后台代码编译，强制在前台编译，编译完成之后才能进行代码执行；
 默认情况下，jvm在后台进行编译，若没有编译完成，则前台运行代码时以解释模式运行。
 
-Xbootclasspath:bootclasspath
 让jvm从指定路径（可以是分号分隔的目录、jar、或者zip）中加载bootclass，用来替换jdk的rt.jar；若非必要，一般不会用到；
-Xbootclasspath/a:path
 将指定路径的所有文件追加到默认bootstrap路径中；
-Xbootclasspath/p:path
 让jvm优先于bootstrap默认路径加载指定路径的所有文件；
 
-Xcheck:jni
 对JNI函数进行附加check；此时jvm将校验传递给JNI函数参数的合法性，在本地代码中遇到非法数据时，jmv将报一个致命错误而终止；使用该参数后将造成性能下降，请慎用。
 
-Xfuture
 让jvm对类文件执行严格的格式检查（默认jvm不进行严格格式检查），以符合类文件格式规范，推荐开发人员使用该参数。
 
-Xnoclassgc
 关闭针对class的gc功能；因为其阻止内存回收，所以可能会导致OutOfMemoryError错误，慎用；
 
-Xincgc
 开启增量gc（默认为关闭）；这有助于减少长时间GC时应用程序出现的停顿；但由于可能和应用程序并发执行，所以会降低CPU对应用的处理能力。
 
-Xloggc:file
 与-verbose:gc功能类似，只是将每次GC事件的相关情况记录到一个文件中，文件的位置最好在本地，以避免网络的潜在问题。
 若与verbose命令同时出现在命令行中，则以-Xloggc为准。
 
-Xmsn
 指定jvm堆的初始大小，默认为物理内存的1/64，最小为1M；可以指定单位，比如k、m，若不指定，则默认为字节。
 
-Xmxn
 指定jvm堆的最大值，默认为物理内存的1/4或者1G，最小为2M；单位与-Xms一致。
 
-Xprof
 跟踪正运行的程序，并将跟踪数据在标准输出输出；适合于开发环境调试。
 
-Xrs
 减少jvm对操作系统信号（signals）的使用，该参数从1.3.1开始有效；
 从jdk1.3.0开始，jvm允许程序在关闭之前还可以执行一些代码（比如关闭数据库的连接池），即使jvm被突然终止；
 jvm关闭工具通过监控控制台的相关事件而满足以上的功能；更确切的说，通知在关闭工具执行之前，先注册控制台的控制handler，然后对 CTRL_C_EVENT, CTRL_CLOSE_EVENT, CTRL_LOGOFF_EVENT, and  CTRL_SHUTDOWN_EVENT这几类事件直接返回true。
 但如果jvm以服务的形式在后台运行（比如servlet引擎），他能接收CTRL_LOGOFF_EVENT事件，但此时并不需要初始化关闭程序；为 了避免类似冲突的再次出现，从jdk1.3.1开始提供-Xrs参数；当此参数被设置之后，jvm将不接收控制台的控制handler，也就是说他不监控 和处理CTRL_C_EVENT, CTRL_CLOSE_EVENT, CTRL_LOGOFF_EVENT, or  CTRL_SHUTDOWN_EVENT事件。
 
-Xssn
 设置单个线程栈的大小，一般默认为512k。 
上面这些参数中，比如-Xmsn、-Xmxn……都是我们性能优化中很重要的参数；
-Xprof、-Xloggc:file等都是在没有专业跟踪工具情况下排错的好手；
在上一小节中提到的关于JProfiler的配置中就使用到了-Xbootclasspath/a:path；
http://blog.csdn.net/sfdev/archive/2008/01/24/2063928.aspx
前面我们提到用-XX作为前缀的参数列表在jvm中可能是不健壮的，SUN也不推荐使用，后续可能会在没有通知的情况下就直接取消了；但是由于这些参数中的确有很多是对我们很有用的，比如我们经常会见到的-XX:PermSize、-XX:MaxPermSize等等；
下面我们将就Java HotSpot VM中-XX:的可配置参数列表进行描述；
这些参数可以被松散的聚合成三类：
行为参数（Behavioral Options）：用于改变jvm的一些基础行为；
性能调优（Performance Tuning）：用于jvm的性能调优；
调试参数（Debugging Options）：一般用于打开跟踪、打印、输出等jvm参数，用于显示jvm更加详细的信息；
由于sun官方文档中对各参数的描述也都非常少（大多只有一句话），而且大多涉及OS层面的东西，很难描述清楚，所以以下是挑选了一些我们开发中可能会用得比较多的配置项，若需要查看所有参数列表，可以点击HotSpot VM Specific Options.查看原文；
首先来介绍行为参数：
参数及其默认值描述-XX:-DisableExplicitGC禁止调用System.gc()；但jvm的gc仍然有效-XX:+MaxFDLimit最大化文件描述符的数量限制-XX:+ScavengeBeforeFullGC新生代GC优先于Full GC执行-XX:+UseGCOverheadLimit在抛出OOM之前限制jvm耗费在GC上的时间比例-XX:-UseConcMarkSweepGC对老生代采用并发标记交换算法进行GC-XX:-UseParallelGC启用并行GC-XX:-UseParallelOldGC对Full GC启用并行，当-XX:-UseParallelGC启用时该项自动启用-XX:-UseSerialGC启用串行GC-XX:+UseThreadPriorities启用本地线程优先级
上面表格中黑体的三个参数代表着jvm中GC执行的三种方式，即串行、并行、并发；
串行（SerialGC）是jvm的默认GC方式，一般适用于小型应用和单处理器，算法比较简单，GC效率也较高，但可能会给应用带来停顿；
并行（ParallelGC）是指GC运行时，对应用程序运行没有影响，GC和app两者的线程在并发执行，这样可以最大限度不影响app的运行；
并发（ConcMarkSweepGC）是指多个线程并发执行GC，一般适用于多处理器系统中，可以提高GC的效率，但算法复杂，系统消耗较大；
性能调优参数列表：
 
参数及其默认值描述-XX:LargePageSizeInBytes=4m设置用于Java堆的大页面尺寸-XX:MaxHeapFreeRatio=70GC后java堆中空闲量占的最大比例-XX:MaxNewSize=size新生成对象能占用内存的最大值-XX:MaxPermSize=64m老生代对象能占用内存的最大值-XX:MinHeapFreeRatio=40GC后java堆中空闲量占的最小比例-XX:NewRatio=2新生代内存容量与老生代内存容量的比例-XX:NewSize=2.125m新生代对象生成时占用内存的默认值-XX:ReservedCodeCacheSize=32m保留代码占用的内存容量-XX:ThreadStackSize=512设置线程栈大小，若为0则使用系统默认值-XX:+UseLargePages使用大页面内存
我们在日常性能调优中基本上都会用到以上黑体的这几个属性； 
调试参数列表：
 
参数及其默认值描述-XX:-CITime打印消耗在JIT编译的时间-XX:ErrorFile=./hs_err_pid<pid>.log保存错误日志或者数据到文件中-XX:-ExtendedDTraceProbes开启solaris特有的dtrace探针-XX:HeapDumpPath=./java_pid<pid>.hprof指定导出堆信息时的路径或文件名-XX:-HeapDumpOnOutOfMemoryError当首次遭遇OOM时导出此时堆中相关信息-XX:OnError="<cmd args>;<cmd args>"出现致命ERROR之后运行自定义命令-XX:OnOutOfMemoryError="<cmd args>;<cmd args>"当首次遭遇OOM时执行自定义命令-XX:-PrintClassHistogram遇到Ctrl-Break后打印类实例的柱状信息，与jmap -histo功能相同-XX:-PrintConcurrentLocks遇到Ctrl-Break后打印并发锁的相关信息，与jstack -l功能相同-XX:-PrintCommandLineFlags打印在命令行中出现过的标记-XX:-PrintCompilation当一个方法被编译时打印相关信息-XX:-PrintGC每次GC时打印相关信息-XX:-PrintGC Details每次GC时打印详细信息-XX:-PrintGCTimeStamps打印每次GC的时间戳-XX:-TraceClassLoading跟踪类的加载信息-XX:-TraceClassLoadingPreorder跟踪被引用到的所有类的加载信息-XX:-TraceClassResolution跟踪常量池-XX:-TraceClassUnloading跟踪类的卸载信息-XX:-TraceLoaderConstraints跟踪类加载器约束的相关信息
当系统出现问题的时候，又不能使用外部跟踪工具（比如JProfiler……）的情况下，以上的这些参数就会发挥重大作用了，比如dump堆信息、打印并发锁……
 
 
-----------------------第二种理解------------------
不管是YGC还是Full GC,GC过程中都会对导致程序运行中中断,正确的选择不同的GC策略, 调整JVM、GC的参数，可以极大的减少由于GC工作，而导致的程序运行中断方面的问题，进而适当的提高Java程序的工作效率。但是调整GC是以个极为 复杂的过程，由于各个程序具备不同的特点，如：web和GUI程序就有很大区别（Web可以适当的停顿，但GUI停顿是客户无法接受的），而且由于跑在各 个机器上的配置不同（主要cup个数，内存不同），所以使用的GC种类也会不同(如何选择见GC种类及如何选择)。本文将注重介绍JVM、GC的一些重要参数的设置来提高系统的性能。
       JVM内存组成及GC相关内容请见之前的文章:JVM内存组成 GC策略&内存申请。
JVM参数的含义 实例见实例分析
参数名称含义默认值 -Xms初始堆大小物理内存的1/64(<1GB)默认(MinHeapFreeRatio参数可以调整)空余堆内存小于40%时，JVM就会增大堆直到-Xmx的最大限制.-Xmx最大堆大小物理内存的1/4(<1GB)默认(MaxHeapFreeRatio参数可以调整)空余堆内存大于70%时，JVM会减少堆直到 -Xms的最小限制-Xmn年轻代大小(1.4or lator) 
注意：此处的大小是（eden+ 2 survivor space).与jmap -heap中显示的New gen是不同的。
整个堆大小=年轻代大小 + 年老代大小 + 持久代大小.
增大年轻代后,将会减小年老代大小.此值对系统性能影响较大,Sun官方推荐配置为整个堆的3/8
-XX:NewSize设置年轻代大小(for 1.3/1.4)  -XX:MaxNewSize年轻代最大值(for 1.3/1.4)  -XX:PermSize设置持久代(perm gen)初始值物理内存的1/64 -XX:MaxPermSize设置持久代最大值物理内存的1/4 -Xss每个线程的堆栈大小 
JDK5.0以后每个线程堆栈大小为1M,以前每个线程堆栈大小为256K.更具应用的线程所需内存大小进行 调整.在相同物理内存下,减小这个值能生成更多的线程.但是操作系统对一个进程内的线程数还是有限制的,不能无限生成,经验值在3000~5000左右
一般小的应用， 如果栈不是很深， 应该是128k够用的 大的应用建议使用256k。这个选项对性能影响比较大，需要严格的测试。（校长）
和threadstacksize选项解释很类似,官方文档似乎没有解释,在论坛中有这样一句话:"”
-Xss is translated in a VM flag named ThreadStackSize”
一般设置这个值就可以了。
-XX:ThreadStackSizeThread Stack Size (0  means use default stack size) [Sparc: 512; Solaris x86: 320 (was 256  prior in 5.0 and earlier); Sparc 64 bit: 1024; Linux amd64: 1024 (was 0  in 5.0 and earlier); all others 0.]-XX:NewRatio年轻代(包括Eden和两个Survivor区)与年老代的比值(除去持久代) 
-XX:NewRatio=4表示年轻代与年老代所占比值为1:4,年轻代占整个堆栈的1/5
Xms=Xmx并且设置了Xmn的情况下，该参数不需要进行设置。
-XX:SurvivorRatioEden区与Survivor区的大小比值 设置为8,则两个Survivor区与一个Eden区的比值为2:8,一个Survivor区占整个年轻代的1/10-XX:LargePageSizeInBytes内存页的大小不可设置过大， 会影响Perm的大小 =128m-XX:+UseFastAccessorMethods原始类型的快速优化  -XX:+DisableExplicitGC关闭System.gc() 这个参数需要严格的测试-XX:MaxTenuringThreshold垃圾最大年龄 
如果设置为0的话,则年轻代对象不经过Survivor区,直接进入年老代. 对于年老代比较多的应用,可以提高效率.如果将此值设置为一个较大值,则年轻代对象会在Survivor区进行多次复制,这样可以增加对象再年轻代的存活 时间,增加在年轻代即被回收的概率
该参数只有在串行GC时才有效.
-XX:+AggressiveOpts加快编译  -XX:+UseBiasedLocking锁机制的性能改善  -Xnoclassgc禁用垃圾回收  -XX:SoftRefLRUPolicyMSPerMB每兆堆空闲空间中SoftReference的存活时间1ssoftly  reachable objects will remain alive for some amount of time after the  last time they were referenced. The default value is one second of  lifetime per free megabyte in the heap-XX:PretenureSizeThreshold对象超过多大是直接在旧生代分配0
单位字节 新生代采用Parallel Scavenge GC时无效
另一种直接在旧生代分配的情况是大的数组对象,且数组中无外部引用对象.
-XX:TLABWasteTargetPercentTLAB占eden区的百分比1% -XX:+CollectGen0FirstFullGC时是否先YGCfalse 
并行收集器相关参数
-XX:+UseParallelGC
Full GC采用parallel MSC
(此项待验证) 
选择垃圾收集器为并行收集器.此配置仅对年轻代有效.即上述配置下,年轻代使用并发收集,而年老代仍旧使用串行收集.(此项待验证)
-XX:+UseParNewGC设置年轻代为并行收集 
可与CMS收集同时使用
JDK5.0以上,JVM会根据系统配置自行设置,所以无需再设置此值
-XX:ParallelGCThreads并行收集器的线程数 此值最好配置与处理器数目相等 同样适用于CMS-XX:+UseParallelOldGC年老代垃圾收集方式为并行收集(Parallel Compacting) 这个是JAVA 6出现的参数选项-XX:MaxGCPauseMillis每次年轻代垃圾回收的最长时间(最大暂停时间) 如果无法满足此时间,JVM会自动调整年轻代大小,以满足此值.-XX:+UseAdaptiveSizePolicy自动选择年轻代区大小和相应的Survivor区比例 设置此选项后,并行收集器会自动选择年轻代区大小和相应的Survivor区比例,以达到目标系统规定的最低相应时间或者收集频率等,此值建议使用并行收集器时,一直打开.-XX:GCTimeRatio设置垃圾回收时间占程序运行时间的百分比 公式为1/(1+n)-XX:+ScavengeBeforeFullGCFull GC前调用YGCtrueDo young generation GC prior to a full GC. (Introduced in 1.4.1.)
CMS相关参数
-XX:+UseConcMarkSweepGC使用CMS内存收集 测试中配置这个以后,-XX:NewRatio=4的配置失效了,原因不明.所以,此时年轻代大小最好用-Xmn设置.???-XX:+AggressiveHeap  
试图是使用大量的物理内存
长时间大内存使用的优化，能检查计算资源（内存， 处理器数量）
至少需要256MB内存
大量的CPU／内存， （在1.4.1在4CPU的机器上已经显示有提升）
-XX:CMSFullGCsBeforeCompaction多少次后进行内存压缩 由于并发收集器不对内存空间进行压缩,整理,所以运行一段时间以后会产生"碎片",使得运行效率降低.此值设置运行多少次GC以后对内存空间进行压缩,整理.-XX:+CMSParallelRemarkEnabled降低标记停顿  -XX+UseCMSCompactAtFullCollection在FULL GC的时候， 对年老代的压缩 
CMS是不会移动内存的， 因此， 这个非常容易产生碎片， 导致内存不够用， 因此， 内存的压缩这个时候就会被启用。 增加这个参数是个好习惯。
可能会影响性能,但是可以消除碎片
-XX:+UseCMSInitiatingOccupancyOnly使用手动定义初始化定义开始CMS收集 禁止hostspot自行触发CMS GC-XX:CMSInitiatingOccupancyFraction=70
使用cms作为垃圾回收
使用70％后开始CMS收集
92为了保证不出现promotion failed(见下面介绍)错误,该值的设置需要满足以下公式CMSInitiatingOccupancyFraction计算公式-XX:CMSInitiatingPermOccupancyFraction设置Perm Gen使用到达多少比率时触发92 -XX:+CMSIncrementalMode设置为增量模式  用于单CPU情况-XX:+CMSClassUnloadingEnabled   
辅助信息
-XX:+PrintGC  
输出形式:
[GC 118250K->113543K(130112K), 0.0094143 secs]
[Full GC 121376K->10414K(130112K), 0.0650971 secs]
-XX:+PrintGCDetails  
输出形式:[GC [DefNew: 8614K->781K(9088K), 0.0123035 secs] 118250K->113543K(130112K), 0.0124633 secs]
[GC  [DefNew: 8614K->8614K(9088K), 0.0000665 secs][Tenured:  112761K->10414K(121024K), 0.0433488 secs]  121376K->10414K(130112K), 0.0436268 secs]
-XX:+PrintGCTimeStamps   -XX:+PrintGC:PrintGCTimeStamps  
可与-XX:+PrintGC -XX:+PrintGCDetails混合使用
输出形式:11.851: [GC 98328K->93620K(130112K), 0.0082960 secs]
-XX:+PrintGCApplicationStoppedTime打印垃圾回收期间程序暂停的时间.可与上面混合使用 输出形式:Total time for which application threads were stopped: 0.0468229 seconds-XX:+PrintGCApplicationConcurrentTime打印每次垃圾回收前,程序未中断的执行时间.可与上面混合使用 输出形式:Application time: 0.5291524 seconds-XX:+PrintHeapAtGC打印GC前后的详细堆栈信息  -Xloggc:filename
把相关日志信息记录到文件以便分析.
与上面几个配合使用
  
-XX:+PrintClassHistogram
garbage collects before printing the histogram.  -XX:+PrintTLAB查看TLAB空间的使用情况  XX:+PrintTenuringDistribution查看每次minor GC后新的存活周期的阈值 
Desired survivor size 1048576 bytes, new threshold 7 (max 15)
new threshold 7即标识新的存活周期的阈值为7。
GC性能方面的考虑
       对于GC的性能主要有2个方面的指标：吞吐量throughput（工作时间不算gc的时间占总的时间比）和暂停pause（gc发生时app对外显示的无法响应）。
1. Total Heap  
       默认情况下，vm会增加/减少heap大小以维持free space在整个vm中占的比例，这个比例由MinHeapFreeRatio和MaxHeapFreeRatio指定。  
一般而言，server端的app会有以下规则：  
* 对vm分配尽可能多的memory；  
* 将Xms和Xmx设为一样的值。如果虚拟机启动时设置使用的内存比较小，这个时候又需要初始化很多对象，虚拟机就必须重复地增加内存。  
* 处理器核数增加，内存也跟着增大。
2. The Young Generation  
        另外一个对于app流畅性运行影响的因素是young generation的大小。young generation越大，minor  collection越少；但是在固定heap size情况下，更大的young generation就意味着小的tenured  generation，就意味着更多的major collection(major collection会引发minor collection)。   
       NewRatio反映的是young和tenured  generation的大小比例。NewSize和MaxNewSize反映的是young  generation大小的下限和上限，将这两个值设为一样就固定了young generation的大小（同Xms和Xmx设为一样）。  
       如果希望，SurvivorRatio也可以优化survivor的大小，不过这对于性能的影响不是很大。SurvivorRatio是eden和survior大小比例。  
一般而言，server端的app会有以下规则：  
* 首先决定能分配给vm的最大的heap size，然后设定最佳的young generation的大小；  
* 如果heap size固定后，增加young generation的大小意味着减小tenured generation大小。让tenured generation在任何时候够大，能够容纳所有live的data（留10%-20%的空余）。
经验&&规则
1. 年轻代大小选择
    * 响应时间优先的应用:尽可能设大,直到接近系统的最低响应时间限制(根据实际情况选择).在此种情况下,年轻代收集发生的频率也是最小的.同时,减少到达年老代的对象.  
    * 吞吐量优先的应用:尽可能的设置大,可能到达Gbit的程度.因为对响应时间没有要求,垃圾收集可以并行进行,一般适合8CPU以上的应用.  
    * 避免设置过小.当新生代设置过小时会导致:1.YGC次数更加频繁 2.可能导致YGC对象直接进入旧生代,如果此时旧生代满了,会触发FGC.
2. 年老代大小选择
    1. 响 应时间优先的应用:年老代使用并发收集器,所以其大小需要小心设置,一般要考虑并发会话率和会话持续时间等一些参数.如果堆设置小了,可以会造成内存碎  片,高回收频率以及应用暂停而使用传统的标记清除方式;如果堆大了,则需要较长的收集时间.最优化的方案,一般需要参考以下数据获得:
并发垃圾收集信息、持久代并发收集次数、传统GC信息、花在年轻代和年老代回收上的时间比例。  
    2. 吞吐量优先的应用:一般吞吐量优先的应用都有一个很大的年轻代和一个较小的年老代.原因是,这样可以尽可能回收掉大部分短期对象,减少中期的对象,而年老代尽存放长期存活对象.
3. 较小堆引起的碎片问题
因 为年老代的并发收集器使用标记,清除算法,所以不会对堆进行压缩.当收集器回收时,他会把相邻的空间进行合并,这样可以分配给较大的对象.但是,当堆空间 较小时,运行一段时间以后,就会出现"碎片",如果并发收集器找不到足够的空间,那么并发收集器将会停止,然后使用传统的标记,清除方式进行回收.如果出 现"碎片",可能需要进行如下配置:
-XX:+UseCMSCompactAtFullCollection:使用并发收集器时,开启对年老代的压缩.
-XX:CMSFullGCsBeforeCompaction=0:上面配置开启的情况下,这里设置多少次Full GC后,对年老代进行压缩  
4. 用64位操作系统，Linux下64位的jdk比32位jdk要慢一些，但是吃得内存更多，吞吐量更大  
5. XMX和XMS设置一样大，MaxPermSize和MinPermSize设置一样大，这样可以减轻伸缩堆大小带来的压力  
6. 使用CMS的好处是用尽量少的新生代，经验值是128M－256M， 然后老生代利用CMS并行收集， 这样能保证系统低延迟的吞吐效率。 实际上cms的收集停顿时间非常的短，2G的内存， 大约20－80ms的应用程序停顿时间  
7. 系统停顿的时候可能是GC的问题也可能是程序的问题，多用jmap和jstack查看，或者killall -3 java，然后查看java控制台日志，能看出很多问题。(相关工具的使用方法将在后面的blog中介绍)  
8. 仔细了解自己的应用，如果用了缓存，那么年老代应该大一些，缓存的HashMap不应该无限制长，建议采用LRU算法的Map做缓存，LRUMap的最大长度也要根据实际情况设定。  
9. 采用并发回收时，年轻代小一点，年老代要大，因为年老大用的是并发回收，即使时间长点也不会影响其他程序继续运行，网站不会停顿  
10. JVM 参数的设置(特别是 –Xmx –Xms –Xmn -XX:SurvivorRatio   -XX:MaxTenuringThreshold等参数的设置没有一个固定的公式，需要根据PV old区实际数据  YGC次数等多方面来衡量。为了避免promotion  faild可能会导致xmn设置偏小，也意味着YGC的次数会增多，处理并发访问的能力下降等问题。每个参数的调整都需要经过详细的性能测试，才能找到特 定应用的最佳配置。
promotion failed:
垃圾回收时 promotion  failed是个很头痛的问题，一般可能是两种原因产生，第一个原因是救助空间不够，救助空间里的对象还不应该被移动到年老代，但年轻代又有很多对象需要 放入救助空间；第二个原因是年老代没有足够的空间接纳来自年轻代的对象；这两种情况都会转向Full GC，网站停顿时间较长。
解决方方案一：
第 一个原因我的最终解决办法是去掉救助空间，设置-XX:SurvivorRatio=65536  -XX:MaxTenuringThreshold=0即可，第二个原因我的解决办法是设置 CMSInitiatingOccupancyFraction为某个值（假设70），这样年老代空间到70%时就开始执行CMS，年老代有足够的空间接 纳来自年轻代的对象。
解决方案一的改进方案：
又有改进了，上面方法不太好，因为没有用到救助空间，所 以年老代容易满，CMS执行会比较频繁。我改善了一下，还是用救助空间，但是把救助空间加大，这样也不会有promotion  failed。具体操作上，32位Linux和64位Linux好像不一样，64位系统似乎只要配置MaxTenuringThreshold参 数，CMS还是有暂停。为了解决暂停问题和promotion failed问题，最后我设置-XX:SurvivorRatio=1  ，并把MaxTenuringThreshold去掉，这样即没有暂停又不会有promotoin  failed，而且更重要的是，年老代和永久代上升非常慢（因为好多对象到不了年老代就被回收了），所以CMS执行频率非常低，好几个小时才执行一次，这 样，服务器都不用重启了。  
-Xmx4000M -Xms4000M -Xmn600M -XX:PermSize=500M  -XX:MaxPermSize=500M -Xss256K -XX:+DisableExplicitGC  -XX:SurvivorRatio=1 -XX:+UseConcMarkSweepGC -XX:+UseParNewGC  -XX:+CMSParallelRemarkEnabled -XX:+UseCMSCompactAtFullCollection  -XX:CMSFullGCsBeforeCompaction=0 -XX:+CMSClassUnloadingEnabled  -XX:LargePageSizeInBytes=128M -XX:+UseFastAccessorMethods  -XX:+UseCMSInitiatingOccupancyOnly -XX:CMSInitiatingOccupancyFraction=80  -XX:SoftRefLRUPolicyMSPerMB=0 -XX:+PrintClassHistogram  -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintHeapAtGC  -Xloggc:log/gc.log  
  
CMSInitiatingOccupancyFraction值与Xmn的关系公式  
上 面介绍了promontion faild产生的原因是EDEN空间不足的情况下将EDEN与From survivor中的存活对象存入To  survivor区时,To survivor区的空间不足，再次晋升到old gen区，而old  gen区内存也不够的情况下产生了promontion faild从而导致full gc.那可以推断出：eden+from survivor  < old gen区剩余内存时，不会出现promontion faild的情况，即：
(Xmx-Xmn)*(1-CMSInitiatingOccupancyFraction/100)>=(Xmn-Xmn/(SurvivorRatior+2))  进而推断出：  
CMSInitiatingOccupancyFraction <=((Xmx-Xmn)-(Xmn-Xmn/(SurvivorRatior+2)))/(Xmx-Xmn)*100  
例如：  
当xmx=128 xmn=36 SurvivorRatior=1时 CMSInitiatingOccupancyFraction<=((128.0-36)-(36-36/(1+2)))/(128-36)*100 =73.913  
当xmx=128 xmn=24 SurvivorRatior=1时 CMSInitiatingOccupancyFraction<=((128.0-24)-(24-24/(1+2)))/(128-24)*100=84.615…  
当xmx=3000 xmn=600 SurvivorRatior=1时  CMSInitiatingOccupancyFraction<=((3000.0-600)-(600-600/(1+2)))/(3000-600)*100=83.33  
CMSInitiatingOccupancyFraction低于70% 需要调整xmn或SurvivorRatior值。  
令：  
网上一童鞋推断出的公式是：:(Xmx-Xmn)*(100-CMSInitiatingOccupancyFraction)/100>=Xmn 这个公式个人认为不是很严谨，在内存小的时候会影响xmn的计算。  
  
关于实际环境的GC参数配置见:实例分析   监测工具见JVM监测  
参考：
JAVA HOTSPOT VM（http://www.helloying.com/blog/archives/164）
JVM 几个重要的参数 (校长)
java jvm 参数 -Xms -Xmx -Xmn -Xss 调优总结
Java HotSpot VM Options
http://bbs.weblogicfans.net/archiver/tid-2835.html
Frequently Asked Questions About the Java HotSpot VM
Java SE HotSpot at a Glance
Java性能调优笔记(内附测试例子 很有用)
说说MaxTenuringThreshold这个参数
 
相关文章推荐:
GC调优方法总结
Java 6 JVM参数选项大全（中文版）
 
【当你用心写完每一篇博客之后,你会发现它比你用代码实现功能更有成就感!】
    分类:              JVM
        好文要顶         关注我     收藏该文          
                     
            QiaoZhi
            关注 - 8
            粉丝 - 512         
                +加关注     
        0              0     
    
    «  上一篇：    【Eclipse】eclipse中设置tomcat启动时候的JVM参数     
    »  下一篇：    常用的网址记录
posted @  2017-12-14 15:01 QiaoZhi 阅读(4536) 评论(0)  编辑 收藏
