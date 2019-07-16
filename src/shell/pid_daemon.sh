#!/usr/bin/env bash

##############################################
# 2. 实现守护进程
# 无论是C语言还是php/python/perl 通过fork命令实现守护进程，让当前程序进入后台运行，这种手段常常用于服务器软件。
# 启用 shell 解决重复运行问题，记录PID以便可以停止Shell运维
##############################################
NAME=info
BASEDIR='/www'
PROG=$BASEDIR/bin/$(basename $0)
LOGFILE=/var/tmp/$NAME.log
PIDFILE=/var/tmp/$NAME.pid
##############################################
PHP=/usr/local/webserver/php/bin/php
##############################################
#echo $$
#echo $BASHPID
function start(){
	if [ -f "$PIDFILE" ]; then
		echo $PIDFILE
		exit 2
	fi

	for (( ; ; ))
	do
		cd $BASEDIR/crontab/
		$PHP readfile.php > $LOGFILE
		$PHP chart_gold_silver_xml.php > /dev/null
		sleep 60
	done &
	echo $! > $PIDFILE
}
function stop(){
  	[ -f $PIDFILE ] && kill `cat $PIDFILE` && rm -rf $PIDFILE
}

case "$1" in
  start)
  	start
	;;
  stop)
  	stop
	;;
  status)
  	ps ax | grep chart.xml | grep -v grep | grep -v status
	;;
  restart)
  	stop
	start
	;;
  *)
	echo $"Usage: $0 {start|stop|status|restart}"
	exit 2
esac

exit $?
