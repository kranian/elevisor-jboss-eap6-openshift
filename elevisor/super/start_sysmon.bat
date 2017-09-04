@echo off
rem set SYSMON_HOME=D:\project\workspace26\SYSMON_AGENT25

set "SYSMON_HOME=%cd%"
set JAVA_HOME="C:\Program Files (x86)\Java\jdk1.5.0_14"
set JAVA_OPTS=-Xms256m -Xmx525m -Dsysmon_home=%SYSMON_HOME% -Djava.library.path=%SYSMON_HOME%\jni 
call %JAVA_HOME%\bin\java %JAVA_OPTS% -jar %SYSMON_HOME%\lib\launcher.jar com.elevisor.sysmon.agent.SysMonMain
pause
