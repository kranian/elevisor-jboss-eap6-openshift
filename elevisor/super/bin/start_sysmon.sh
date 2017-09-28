#!/bin/sh

export JAVA_HOME=${JAVA_HOME:-/usr/lib/jvm/java-1.8.0}
export SERVER_IP=${ELEVISOR_IG_SERVER_IP:-192.168.0.152}
export SYSMON_GROUP_NAME=${ELEVISOR_SYSMON_NAME:-AA}
export SYSMON_NAME=${ELEVISOR_SYSMON_NAME:-SO11}
export SYSMON_PORT=${ELEVISOR_SYSMON_PORT:-7771}

export LANG=C

PRG="$0"

while [ -h "$PRG" ]; do
  ls=`ls -ld "$PRG"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    PRG="$link"
  else
    PRG=`dirname "$PRG"`/"$link"
  fi
done

# Get standard environment variables
PRGDIR=`dirname "$PRG"`
[ -z "$SYSMON_HOME" ] && SYSMON_HOME=`cd .. "$PRGDIR" ; pwd`


export PS_CNT=`ps -ef|grep $SYSMON_HOME | grep ELEVISOR_SYSMON| grep -v grep|wc -l`
export LINE1="===================================================================="
export LINE2="--------------------------------------------------------------------"

echo $LINE1
echo " Elevisor SYSMON Agent                                      Ver 3.0 "
echo $LINE2


export LD_LIBRARY_PATH=$SYSMON_HOME/jni:$LD_LIBRARY_PATH
export SHLIB_PATH=$SYSMON_HOME/jni:$SHLIB_PATH
export LIBPATH=$SYSMON_HOME/jni:$LIBPATH


if [ "$PS_CNT" -eq 0 ]
then
    if [ "$1" = "-d" ] || [ "$2" = "-d" ] 
    then
     $JAVA_HOME/bin/java -DELEVISOR_SYSMON -Xms64m -Xmx512m -Dsysmon_home=$SYSMON_HOME -jar $SYSMON_HOME/lib/launcher-1.0.jar  com.elevisor.sysmon.agent.SysMonMain $1 $2
    else
     nohup $JAVA_HOME/bin/java -DELEVISOR_SYSMON -Xms64m -Xmx512m -Dsysmon_home=$SYSMON_HOME -jar $SYSMON_HOME/lib/launcher-1.0.jar com.elevisor.sysmon.agent.SysMonMain >> $SYSMON_HOME/logs/sysmon_stdout_$(date +%Y%m%d).log &
     echo " Starting Agent... "
    fi
else
    echo " Already Started... "
    ps -ef|grep $SYSMON_HOME| grep -v grep
fi
echo $LINE1
