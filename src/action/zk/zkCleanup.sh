#!/usr/bin/env bash
# use POSIX interface, symlink is followed automatically
ZOOBIN="${BASH_SOURCE-$0}"
ZOOBIN="$(dirname "${ZOOBIN}")"
ZOOBINDIR="$(cd "${ZOOBIN}"; pwd)"

if [ -e "$ZOOBIN/../libexec/zkEnv.sh" ]; then
  . "$ZOOBINDIR"/../libexec/zkEnv.sh
else
  . "$ZOOBINDIR"/zkEnv.sh
fi

ZOODATADIR="$(grep "^[[:space:]]*dataDir=" "$ZOOCFG" | sed -e 's/.*=//')"
ZOODATALOGDIR="$(grep "^[[:space:]]*dataLogDir=" "$ZOOCFG" | sed -e 's/.*=//')"

ZOO_LOG_FILE=zookeeper-$USER-cleanup-$HOSTNAME.log

if [ "x$ZOODATALOGDIR" = "x" ]
then
"$JAVA" "-Dzookeeper.log.dir=${ZOO_LOG_DIR}" "-Dzookeeper.root.logger=${ZOO_LOG4J_PROP}" "-Dzookeeper.log.file=${ZOO_LOG_FILE}" \
     -cp "$CLASSPATH" $JVMFLAGS \
     org.apache.zookeeper.server.PurgeTxnLog "$ZOODATADIR" $*
else
"$JAVA" "-Dzookeeper.log.dir=${ZOO_LOG_DIR}" "-Dzookeeper.root.logger=${ZOO_LOG4J_PROP}" "-Dzookeeper.log.file=${ZOO_LOG_FILE}" \
     -cp "$CLASSPATH" $JVMFLAGS \
     org.apache.zookeeper.server.PurgeTxnLog "$ZOODATALOGDIR" "$ZOODATADIR" $*
fi
