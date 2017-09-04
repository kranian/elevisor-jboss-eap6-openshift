###########################################################################################################################
1. MySQL JDBC 드라이버 정보
 SUPER 에이전트에서 MySQL or Maria DB를 모니터링 시 할시에는 아래 JDBC 드라이버를 다운로드 하여 설치 해야 함 
  
 - JDK 1.5 이상 지원
 - library 명 :  mysql-connector-java-5.1.35-bin.jar
 - 설치 디렉토리   : $SYSMON_HOME/lib 에 copy 
 - 참고 자료 
  Download Connector/J
  https://dev.mysql.com/downloads/connector/j/
 - JDBC 정보  
  MySQL 5.0 이상 부터 지원 하는 드라이버 임 
 
########################################################################################################################### 
2. SQLServer JDBC 드라이버 정보

- library 명  : JDK 1.5 지원   sqljdbc.jar  설치  
- library 명  : JDK 1.6 이상  지원 sqljdbc4.jar 설치 
 - 설치 디렉토리   : $SYSMON_HOME/lib 에 copy  
 SUPER 에이전트에서 SQLServer 모니터링 시 할시에는 아래 JDBC 드라이버를 다운로드 하여 설치 해야 함
---------------------------------------------------------------------------------------------------------------------------
#!! JDBC 공통 주의 사항 
 
만약 요건을 지키지 않을 시에는 아래 에로 로그가 출력 된다. 말 그ㄹ대로 지원하지 안은 클래스 파일 오류라고 뜬다. 
즉 해당 JDBC 드라이버 현재 사용 중인 JDK 번과 매칭 되지 않는다는 오류 내용이다. 

java.lang.UnsupportedClassVersionError: Bad version number in .class file
       at java.lang.ClassLoader.defineClass1(Native Method)
       at java.lang.ClassLoader.defineClass(ClassLoader.java:620)
       at java.security.SecureClassLoader.defineClass(SecureClassLoader.java:124)
       at java.net.URLClassLoader.defineClass(URLClassLoader.java:260)
       at java.net.URLClassLoader.access$100(URLClassLoader.java:56)
       at java.net.URLClassLoader$1.run(URLClassLoader.java:195)
   
...
---------------------------------------------------------------------------------------------------------------------------

  JDBC 2.0 정보 
   - https://www.microsoft.com/ko-kr/download/details.aspx?id=2505 
   - JDK 1.5 이상  
   - SQL Server 2008,
     SQL Server 2005,
     SQL Server 2000  
   
  JDBC 3.0 정보 
   - https://www.microsoft.com/ko-kr/download/details.aspx?id=2505    
   - JDK 1.5 이상  
   - SQL Server 2008,
     SQL Server 2005, 
     SQL Server 2000   

  JDBC 4.0 정보 
   - https://www.microsoft.com/ko-kr/download/details.aspx?id=2505    
   - JDK 1.5 이상  
   - SQL Server 2014, 
     SQL Server 2012,
     SQL Server 2008 R2,
     SQL Server 2008,
     SQL Server 2005 - 버전 4.0에서만 지원
###########################################################################################################################

 

 