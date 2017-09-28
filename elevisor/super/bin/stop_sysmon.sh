#!/bin/sh

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

# Only set CATALINA_HOME if not already set
[ -z "$SYSMON_HOME" ] && SYSMON_HOME=`cd .. "$PRGDIR" ; pwd`

export PS_STR="`ps -ef|grep $SYSMON_HOME | grep -v 99|grep -v grep`"
export PS_CNT="`ps -ef|grep $SYSMON_HOME | grep -v 99|grep -v grep|wc -l`"
export PS_PID="`ps -ef|grep $SYSMON_HOME | grep -v 99|grep -v grep|awk '{print $2}'`"
export LINE1="===================================================================="
export LINE2="--------------------------------------------------------------------"

echo $LINE1
echo " Elevisor for SYSMON                                        Ver 3.0 "
echo $LINE2

if [ "$PS_CNT" -eq 0 ]
then
    echo " Not Running... "
else
    echo " Stop Agent... "
    echo $PS_STR
    if [ -e $SYSMON_HOME/temp/running ]
    then
     `rm -f $SYSMON_HOME/temp/running`
    else
     kill -9 $PS_PID
    fi

fi
echo $LINE1
