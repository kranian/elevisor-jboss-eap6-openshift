# registry.access.redhat.com/jboss-eap-6/eap64-openshift:1.4
#
# This image provide a base for running jboss eap based applications. It

FROM registry.access.redhat.com/jboss-eap-6/eap64-openshift:1.4

ENV container oci-elevisor
ENV JBOSS_IMAGE_NAME jboss-eap-6/eap64-openshift
ENV JBOSS_IMAGE_VERSION 1.4
ENV HOME=/home/jboss
ENV JAVA_TOOL_OPTIONS -Duser.home=/home/jboss -Duser.name=jboss
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0
ENV JAVA_VENDOR openjdk
ENV JAVA_VERSION 1.8.0
ENV LAUNCH_JBOSS_IN_BACKGROUND true
ENV JBOSS_PRODUCT eap
ENV JBOSS_EAP_VERSION 6.4.16.GA
ENV PRODUCT_VERSION 6.4.16.GA
ENV JBOSS_HOME /opt/eap
ENV JBOSS_IMAGE_RELEASE 37
ENV STI_BUILDER jee
ENV JBOSS_MODULES_SYSTEM_PKGS_APPEND=com.elevisor,com.elevisor.agent,com.elevizer.agent

#-- ELEVISOR ENV VAR
ENV ELEVISOR_AGENT_HOME /opt/elevisor
ENV ELEVISOR_J2EE_AGENT_HOME /opt/elevisor/j2ee
ENV ELEVISOR_SYSMON_AGENT_HOME /opt/elevisor/super

ENV ELEVISOR_IG_SERVER_IP 192.168.0.152

ENV ELEVISOR_J2EE_AGENT_NAME CO11
ENV ELEVISOR_J2EE_COMMON_PORT 7711
ENV ELEVISOR_J2EE_TRACE_PORT 7712
ENV ELEVISOR_J2EE_LICENSE ELRS-ECNJ-E93K-EGYU-ECNJ-E93K-D4UEHR9JC

ENV ELEVISOR_SYSMON_AGENT_NAME SO11
ENV ELEVISOR_SYSMON_COMMON_PORT 7771
ENV ELEVISOR_SYSMON_LICENSE E9K2-EU6B-ELHA-EGYR-EU63-ELHA-D4UEHRLQF

#-- LABEL
LABEL io.k8s.description="Platform for building and running Spring Boot applications" \
      io.k8s.display-name="Elevisor JBOSS EAP6 " \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,java,java8,maven,maven3,springboot"



#JAVA_OPTS="${JAVA_OPTS} -Xbootclasspath/p:/opt/j2ee/elevisor_jdk_Oracle_1.8.0_131.jar"
#JAVA_OPTS="${JAVA_OPTS} -javaagent:/opt/j2ee/elevisor_agent_jdk156.jar"
#JAVA_OPTS="${JAVA_OPTS} -Delevisor_home=/opt/j2ee -Delevisor_config=EFJ.conf"

#JAVA_OPTS="${JAVA_OPTS} -Xbootclasspath/p:/opt/j2ee/elevisor_jdk_Oracle_1.7.0_141.jar:/opt/j2ee/elevisor_agent_jdk156.jar"
#JAVA_OPTS="${JAVA_OPTS}  -XX:-UseSplitVerifier"
#JAVA_OPTS="${JAVA_OPTS}  -javaagent:/opt/j2ee/elevisor_javaagent.jar"
#JAVA_OPTS="${JAVA_OPTS} -Delevisor_home=/opt/j2ee -Delevisor_config=EFJ.conf"


USER 0
RUN mkdir -p /opt/elevisor/j2ee
RUN mkdir -p /opt/elevisor/super

COPY ./elevisor/j2ee /opt/elevisor/j2ee
COPY ./elevisor/super /opt/elevisor/super
COPY ./elevisor/update_config_agent.sh /opt/elevisor
COPY ./contrib/standalone.conf /opt/eap/bin
COPY ./s2i/bin /usr/local/s2i
RUN chmod -R 777 /opt/elevisor | chown -R 185:0 /opt/elevisor

RUN sed -i '$ a\'"JAVA_OPTS=\"\${JAVA_OPTS} -Xbootclasspath/p:\${JBOSS_MODULES_JAR}:\${JBOSS_LOGMANAGER_JAR}:\${JBOSS_LOGMANAGER_EXT_JAR}:\${ELEVISOR_J2EE_AGENT_HOME}\/elevisor_jdk_Oracle_1.8.0_131.jar -Djava.util.logging.manager=org.jboss.logmanager.LogManager\"" /opt/eap/bin/standalone.conf \
    && sed -i '$ a\'"JAVA_OPTS=\"\${JAVA_OPTS} -javaagent:\${ELEVISOR_J2EE_AGENT_HOME}/elevisor_agent_jdk156.jar\"" /opt/eap/bin/standalone.conf \
    && sed -i '$ a\'"JAVA_OPTS=\"\${JAVA_OPTS} -Delevisor_home=\${ELEVISOR_J2EE_AGENT_HOME} -Delevisor_config=EFJ.conf\"" /opt/eap/bin/standalone.conf

USER 185
EXPOSE 8080 8443 8778
CMD ["/usr/local/s2i/run"]
# Set the default CMD to print the usage of the language image
#CMD ["/opt/elevisor/super/start_sysmon.sh && /opt/eap/bin/openshift-launch.sh"]

#s2i build <source> <image> [<tag>] [flags]
# /opt/elevisor/j2ee/elevisor_jdk_Oracle_1.8.0_131.jar: No such file or directory
#git://github.com/kranian/quickstart
#https://github.com/kranian/elevisor-jboss-eap6-openshift
#oc adm policy add-cluster-role-to-user cluster-admin developer


#  192.168.0.153:5000/elevisor/jboss-eap6-opnshift-elevisor
#oc import-image kranian --from=192.168.0.153:5000/elevisor/jboss-eap6-opnshift-elevisor --confirm --insecure=true --reference-policy=local
#oc import-image kranian --from=192.168.0.153:5000/elevisor/jboss-eap6-opnshift-elevisor --confirm --insecure=true --reference-policy=local
#sudo docker build -t 192.168.0.153:5000/elevisor/jboss-eap6-opnshift-elevisor .
#sudo docker push 192.168.0.153:5000/elevisor/jboss-eap6-opnshift-elevisor

#  error: build error: image "172.30.1.1:5000/kranian/custom-jboss-elevisor@sha256:1a4c5d4ed446365de1551657aaa53f77704f000bce7eba75334d640339b4768a" must specify a user that is numeric and within the range of allowed users ==> 도커 파일 사용자를 문자열 사용자로 만들었기 때문에 해당 문제가 발생함


#https://blog.openshift.com/getting-any-docker-image-running-in-your-own-openshift-cluster/