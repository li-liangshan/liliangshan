#!/usr/bin/env bash
### 启动脚本中一开始有检查该$ZOOPIDFILE文件的判断处理，如果该文件存在，则通过kill -0判断文件中保存的pid是否存在。
#        1.如果pid不存在，则执行nohup命令后台启动zookeeper服务进程。
#        2.如果pid存在，则输出提示，zookeeper服务进程已经启动，“exit 1”直接退出。
# 如果pid文件不存在，同样启动zookeeper后台进程，以此来防止重复启动zookeeper服务进程。
# “kill -0”不发送任何信号，但是系统会进行错误检查。所以经常用来检查一个进程是否存在，存在返回0；不存在返回1

### 2.通过文件锁方式实现重复启动进程控制


case $1 in
start)
    echo  -n "Starting zookeeper ... "
    #判断启动pid文件是否存在，如果不存在则启动应用
    if [ -f "$ZOOPIDFILE" ]; then
        #如果启动pid文件存在，通过kiil -0判断该文件中记录的pid进程是否存在
        if kill -0 `cat "$ZOOPIDFILE"` > /dev/null 2>&1; then
            #如果pid存在则输出进程已经在运行的提示
            echo $command already running as process `cat "$ZOOPIDFILE"`.
            exit 1
        fi
    fi
    #后台方式启动应用进程
    nohup "$JAVA" $ZOO_DATADIR_AUTOCREATE "-Dzookeeper.log.dir=${ZOO_LOG_DIR}" \
        "-Dzookeeper.log.file=${ZOO_LOG_FILE}" "-Dzookeeper.root.logger=${ZOO_LOG4J_PROP}" \
        -XX:+HeapDumpOnOutOfMemoryError -XX:OnOutOfMemoryError='kill -9 %p' \
        -cp "$CLASSPATH" $JVMFLAGS $ZOOMAIN "$ZOOCFG" > "$_ZOO_DAEMON_OUT" 2>&1 < /dev/null &
    if [ $? -eq 0 ]
then
        case "$OSTYPE" in
        #solaris操作系统启动成功后，将脚本启动最后一个进程的pid写入启动文件中
        *solaris*)
            /bin/echo "${!}\\c" > "$ZOOPIDFILE"
            ;;
        #其它操作系统启动成功后，将脚本启动最后一个进程的pid写入启动文件中
        *)
            /bin/echo -n $! > "$ZOOPIDFILE"
            ;;
        esac
        if [ $? -eq 0 ];
            then
            sleep 1
            pid=$(cat "${ZOOPIDFILE}")
            if ps -p "${pid}" > /dev/null 2>&1; then
                echo STARTED
            else
                echo FAILED TO START
                exit 1
            fi
            else
                echo FAILED TO WRITE PID
                exit 1
            fi
            else
                echo SERVER DID NOT START
                exit 1
            fi
;;
*)
    echo "Usage: $0 [--config <conf-dir>] {start|start-foreground|stop|version|restart|status|print-cmd}" >&2

esac
