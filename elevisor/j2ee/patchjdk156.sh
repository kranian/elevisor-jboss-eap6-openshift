export JAVA_HOME=${JAVA_HOME:-/usr/lib/jvm/java-1.8.0}

#=================================================================
# JDK Patch Option
OPT="-Dpatch.jdbc.datasource=true"
OPT="$OPT -Dpatch.jdbc.drivermanager=true"
OPT="$OPT -Dpatch.io.file=true"
OPT="$OPT -Dpatch.io.socket=true"
echo "OPT=$OPT"
#=================================================================

$JAVA_HOME/bin/java $OPT -Xbootclasspath/p:elevisor_agent_jdk156.jar  com.elevizer.j2ee.agent.bcel.fetch.ClassLoaderFetch 1
