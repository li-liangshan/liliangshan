#!/usr/bin/env bash
# cat install_mysql_mutinstance.sh
#!/bin/sh

. /etc/init.d/functions
MYSQL_CMD_DIR=/application/mysql/bin
INSTANCE_CONF_PATH=/server/scripts/mysqlconf
MYSQL_DATA=/data

[ ! -d $MYSQL_CMD_DIR ] && exit 1
[ ! -d $INSTANCE_CONF_PATH ] && exit 1

PASSWD=123456
mkdir /application/mysql/data -p
echo "export PATH=$PATH:$MYSQL_CMD_DIR">>/etc/profile
source /etc/profile

for PORT in 3306 3307
do
    mkdir -p ${MYSQL_DATA}/$PORT/data
    \cp ${INSTANCE_CONF_PATH}/my.cnf ${MYSQL_DATA}/$PORT
    \cp ${INSTANCE_CONF_PATH}/mysql ${MYSQL_DATA}/$PORT

   sed -i "s/3306/$PORT/g"  ${MYSQL_DATA}/$PORT/my.cnf
   sed -i "s/3306/$PORT/g"  ${MYSQL_DATA}/$PORT/mysql
   sed -i "s/^server-id = 1/server-id = `echo $PORT|cut -c 4-`/g" ${MYSQL_DATA}/$PORT/my.cnf

   chown -R mysql:mysql ${MYSQL_DATA}/$PORT
   chmod 700 ${MYSQL_DATA}/$PORT/mysql
   $MYSQL_CMD_DIR/mysql_install_db --datadir=${MYSQL_DATA}/$PORT/data --user=mysql >>/tmp/tmp.log
   chown -R mysql:mysql ${MYSQL_DATA}/$PORT

   ${MYSQL_DATA}/$PORT/mysql start >>/tmp/tmp.log
   sleep 5


if [ `netstat -lnt|grep $PORT|wc -l` -eq 1 ] ;then
   action "mysql $PORT started" /bin/true
 else
    action "mysql $PORT started" /bin/false
fi

${MYSQL_CMD_DIR}/mysqladmin -u root -S ${MYSQL_DATA}/$PORT/mysql.sock password "$PASSWD"
sed -i "s#Mysql_pwd=#Mysql_pwd="$PASSWD"#g" ${MYSQL_DATA}/$PORT/mysql

echo "${MYSQL_DATA}/$PORT/mysql start">>/etc/rc.local

#if [ $? -eq 0 ];then
   #${MYSQL_CMD_DIR}/mysql -uroot -p'123456' -S ${MYSQL_DATA}/$PORT/mysql.sock -e "drop user ''@localhost;"
   #${MYSQL_CMD_DIR}/mysql -uroot -p'123456' -S ${MYSQL_DATA}/$PORT/mysql.sock -e "drop user ''@`hostname`;"
   #${MYSQL_CMD_DIR}/mysql -uroot -p'123456' -S ${MYSQL_DATA}/$PORT/mysql.sock -e "drop user 'root'@``;"
#fi
done

echo "mysql instances is compled successful."
