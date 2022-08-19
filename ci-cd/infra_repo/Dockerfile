FROM ubuntu:14.04
MAINTAINER pranav.bhardwaj<pranav.bhardwaj@imaginea.com>

#SETTING UP ENVIRONMENT VARIABLES
ENV JAVA_HOME=/usr/local/java/jdk1.8.0_111
ENV JRE_HOME=$JAVA_HOME/jre
ENV PATH=$JRE_HOME/bin:$JAVA_HOME/bin:$PATH
ENV JENKINS_HOME=/usr/share/tomcat7/.jenkins
ENV JENKINS_PLUGIN=/usr/share/tomcat7/.jenkins/plugins
ENV TOMCAT_HOME=/usr/share/tomcat7/

#INSTALLING REQUIRED PACKAGES LIKE tomcat7, wget, vim
RUN apt-get update && apt-get -y install zip wget && apt-get -y install tomcat7 && apt-get -y install vim

#GIVING PERMISSIONS TO DIRECTORIES
RUN mkdir -p $JENKINS_HOME
RUN chown -R tomcat7:tomcat7 $TOMCAT_HOME
RUN chown -R tomcat7:tomcat7 $JENKINS_HOME

#DOWNLOADING JDK AND EXTRACTING IT TO /usr/local/java
RUN mkdir -p /usr/local/java/ 
WORKDIR /usr/local/java/
RUN wget http://downloads.pramati.com/downloads/Linux/jenkins_infra/jdk-8u111-linux-x64.tar.gz && \
	tar -xvzf /usr/local/java/jdk-8u111-linux-x64.tar.gz && \
	rm -rf /usr/local/java/jdk-8u111-linux-x64.tar.gz
#ADD jdk-8u111-linux-x64.tar.gz /usr/local/java/
#WORKDIR /usr/local/java/
#RUN wget -O /usr/local/java/jdk-8u111-linux-x64.tar.gz --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u111-b14/jdk-8u111-linux-x64.tar.gz
#RUN tar -xvzf /usr/local/java/jdk-8u111-linux-x64.tar.gz

#DOWNLOADING JENKINS WAR FILE FROM S3 
#WORKDIR /var/lib/tomcat7/webapps/
#ARG BUILD_NUMBER
RUN wget -O /var/lib/tomcat7/webapps/jenkins.war https://s3-us-west-2.amazonaws.com/cicdtraining/pranavb/latest/jenkins.war
RUN mkdir -p /tmp/tomcat7-tomcat7-tmp
RUN chown -R tomcat7:tomcat7 /tmp/tomcat7-tomcat7-tmp

#DOWNLOADING JENKINS_USERS_TAR_BALL
#ADD jenkins-users.tar.gz $JENKINS_HOME
WORKDIR $JENKINS_HOME
RUN wget http://downloads.pramati.com/downloads/Linux/jenkins_infra/jenkins-users.tar.gz && \
	tar -xvzf jenkins-users.tar.gz && \
	rm -rf jenkins-users.tar.gz

#RUN tar -xvzf jenkins-users.tar.gz
#RUN rm -rf jenkins-users.tar.gz

#DOWNLOADING JENKINS_DEFAULT_PLUGINS
#ADD default-jenkins-plugins.tar.gz $JENKINS_PLUGIN
#RUN mkdir -p $JENKINS_PLUGIN
WORKDIR $JENKINS_PLUGIN
RUN wget http://downloads.pramati.com/downloads/Linux/jenkins_infra/default-jenkins-plugins.tar.gz && \
	tar -xvf default-jenkins-plugins.tar.gz && \
        rm -rf default-jenkins-plugins.tar.gz
#RUN tar -xvzf default-jenkins-plugins.tar.gz 
#RUN rm -rf default-jenkins-plugins.tar.gz

#ADDING AND RUNNING THE STARTUP_SCRIPT
#ADD tom.sh /tmp/
WORKDIR /tmp/
ADD tom.sh /tmp/
#RUN echo $PWD > /tmp/working_directory.txt

RUN chmod +x /tmp/tom.sh
EXPOSE 8080
CMD ["/bin/bash", "-c",  "/tmp/tom.sh"]
#CMD ["bash /tmp/tom.sh"]
#WORKDIR /root

#Execute the command
#docker run -d <image_name>
