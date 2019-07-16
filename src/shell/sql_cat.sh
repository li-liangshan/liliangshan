#!/usr/bin/env bash
#######################################################################################################
# oracle的sql monitor是一个很有用的工具集。但是通过sql命令和反复去调用dbms_tune来传入参数等等操作感觉挺费事的。
# 可以通过如下的脚本来定位sql monitor中的性能sql，发现一些潜在的性能问题。
# 这个脚本可以定位正在sql monitor监控范围内的sql语句。
# 脚本运行结果如下，可以显示sql_id和状态，还有简单的sql语句。
# 尤其可以重点关注那些正在执行的语句。
#######################################################################################################
MONITOR_OWNER=`sqlplus -silent $DB_CONN_STR@$SH_DB_SID <<END
	set pages 100
	set linesize 200
	col status format a20
	col username format a15
	col module format a20
	col program format a25
	col sql_id format a20
	col sql_text format a20
	select sql_id,STATUS  ,  USERNAME  ,  MODULE ,   PROGRAM, substr(SQL_TEXT,0,20) sql_text from v\\$sql_monitor where username =upper('$1') group by sql_id,STATUS  ,  USERNAME  ,  MODULE ,   PROGRAM, substr(SQL_TEXT,0,20);
	exit;
END`


if [ -z "$MONITOR_OWNER" ]; then
 echo "no object exists, please check again"
 exit 0
else
 echo '*******************************************'
 echo " $MONITOR_OWNER    "
 echo '*******************************************'
fi


#######################################################################################################
# 如果要生成sql monitor报告。
# 可以采用如下的脚本
#######################################################################################################
MONITOR_OWNER=`sqlplus -silent $DB_CONN_STR@$SH_DB_SID <<END
	set pages 100
	set linesize 200
	col status format a20
	col username format a15
	col module format a20
	col program format a25
	col sql_id format a20
	col sql_text format a20
	select sql_id,STATUS  ,  USERNAME  ,  MODULE ,   PROGRAM, substr(SQL_TEXT,0,20) sql_text from v\\$sql_monitor where sql_id='$1' group by sql_id,STATUS  ,  USERNAME  ,  MODULE ,   PROGRAM, substr(SQL_TEXT,0,20) ;
	exit;
END`


if [ -z "$MONITOR_OWNER" ]; then
 echo "no object exists, please check again"
 exit 0
else
 echo '*******************************************'
 echo " $MONITOR_OWNER    "
 echo '*******************************************'
fi


sqlplus -silent $DB_CONN_STR@$SH_DB_SID <<EOF
	set long 99999
	set pages 0
	set linesize 200
	col status format a20
	col username format a30
	col module format a20
	col program format a20
	col sql_id format a20
	col sql_text format a50
	col comm format a200
	set long 999999
	SELECT dbms_sqltune.report_sql_monitor(sql_id => '$1',report_level => 'ALL',type=>'TEXT') comm FROM dual;
EOF
