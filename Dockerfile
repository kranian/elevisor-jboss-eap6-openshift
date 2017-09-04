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
ENV JBOSS_MODULES_SYSTEM_PKGS=org.jboss.logmanager,jdk.nashorn.api,com.elevisor.agent,com.elevizer,com.elevisor

#-- ELEVISOR ENV VAR
ENV ELEVISOR_J2EE_AGENT_HOME /opt/elevisor/j2ee
ENV ELEVISOR_SYSMON_AGENT_HOME /opt/elevisor/super

ENV ELEVISOR_IG_SERVER_IP 192.168.0.152
ENV ELEVISOR_J2EE_AGENT_NAME CO11
ENV ELEVISOR_J2EE_COMMON_PORT 7711
ENV ELEVISOR_J2EE_TRACE_PORT 7712

ENV ELEVISOR_SYSMON_AGENT_NAME SO11
ENV ELEVISOR_SYSMON_COMMON_PORT 7771

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


# Add configuration files, bashrc and other tweaks
COPY ./s2i/bin/ $STI_SCRIPTS_PATH
RUN mkdir -p /opt/elevisor
COPY ./elevisor /opt

RUN chmod -R 755 /opt/elevisor\
 && sed -i '$ a\'"JAVA_OPTS=\"\${JAVA_OPTS} -Xbootclasspath/p:\${JBOSS_MODULES_JAR}:\${JBOSS_LOGMANAGER_JAR}:\${JBOSS_LOGMANAGER_EXT_JAR} -Djava.util.logging.manager=org.jboss.logmanager.LogManager\"" /opt/eap/bin/standalone.conf \
 && sed -i '$ a\'"JAVA_OPTS=\"\${JAVA_OPTS} -Xbootclasspath/p:\${ELEVISOR_J2EE_AGENT_HOME}/elevisor_jdk_Oracle_1.8.0_131.jar\"" /opt/eap/bin/standalone.conf
 && sed -i '$ a\'"JAVA_OPTS=\"\${JAVA_OPTS} -javaagent:\${ELEVISOR_J2EE_AGENT_HOME}/elevisor_agent_jdk156.jar\"" /opt/eap/bin/standalone.conf
 && sed -i '$ a\'"JAVA_OPTS=\"\${JAVA_OPTS} -Delevisor_home=\${ELEVISOR_J2EE_AGENT_HOME} -Delevisor_config=EFJ.conf\"" /opt/eap/bin/standalone.conf
 && sed -i '$ a\'"JAVA_OPTS=\"\${JAVA_OPTS} -Dj2ee_agent_name=\${ELEVISOR_J2EE_AGENT_NAME} -Delevisor_server_ip=\${$ELEVISOR_IG_SERVER_IP} -Delevisor_common_port=\${ELEVISOR_J2EE_COMMON_PORT}"" /opt/eap/bin/standalone.conf
 && chown -R jboss:jboss /opt/elevisor \

USER jboss
EXPOSE 8080 8443 8778
# Set the default CMD to print the usage of the language image
CMD ["/opt/elevisor/super/start_sysmon.sh;/opt/eap/bin/openshift-launch.sh"]

#s2i build <source> <image> [<tag>] [flags]
