set SYSMON_HOME=d:\sysmon
set CLASSPATH=%SYSMON_HOME%\lib\guava-11.0.2.jar;%SYSMON_HOME%\lib\gson-2.2.2.jar;%SYSMON_HOME%\lib\elevisor_sysmon_agent.jar;%SYSMON_HOME%\lib\log4j-1.2.15.jar;
set JAVA_HOME="C:\Program Files (x86)\Java\jdk1.6.0_18"
set JAVA_OPTS=-Xms256m -Xmx525m -Dsysmon_home=%SYSMON_HOME% -Djava.library.path=%SYSMON_HOME%\jni
set TARGET_APP=com.elevisor.sysmon.agent.SysMonMain

Sysmon_Service_32.exe -install "Elevisor SYSMON" %JAVA_HOME%/jre/bin/client/jvm.dll -Dsysmon_home=%SYSMON_HOME% -Djava.class.path=%CLASSPATH% %JAVA_OPTS% com.elevisor.sysmon.agent.SysMonMain -start %TARGET_APP% -err "%SYSMON_HOME%\logs\err.log"

PAUSE
