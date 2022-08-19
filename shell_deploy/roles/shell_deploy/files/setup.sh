#!/bin/bash

#JENKINS_URL="http://10.0.5.25:8080/jenkins"
#JENKINS_ADMIN_USER=jenkins
#JENKINS_ADMIN_PASS=jenkins
JENKINS_HOME="/usr/share/tomcat7/.jenkins"
JENKINS_WAR_PATH="/tmp/jenkins.war"
TOMCAT_PATH="/var/lib/tomcat7/webapps/"
PLUGINS_URL="https://s3-us-west-2.amazonaws.com/cicdtraining/default-jenkins-plugins.tar.gz"
WAR_URL="http://mirrors.jenkins-ci.org/war/latest/jenkins.war"

#download war from S3 Bucket 
wget -O $JENKINS_WAR_PATH $WAR_URL

#delete old jenkins home directory if exist
if [ -d $JENKINS_HOME ]; then
          sudo rm -r $JENKINS_HOME
fi

# install tomcat 
sudo apt-get install tomcat7 -y 

if [ ! -d $JENKINS_HOME ]; then
          sudo mkdir $JENKINS_HOME
fi

#checking jenkins home directory permission
if [[ $(stat -c %U:%G $JENKINS_HOME) != "tomcat7:tomcat7" ]]; then
    sudo chown -R tomcat7:tomcat7 $JENKINS_HOME
fi

sudo cp $JENKINS_WAR_PATH $TOMCAT_PATH
sudo service tomcat7 restart

if [ -d $JENKINS_HOME/users/admin ]; then
        sudo rm -r $JENKINS_HOME/users/admin
fi

sudo mkdir -p $JENKINS_HOME/users/jenkins
sudo cp -rvf users/jenkins/config.xml $JENKINS_HOME/users/jenkins/
#sudo cp -r users $JENKINS_HOME/
sudo chown -R tomcat7:tomcat7 $JENKINS_HOME/users

# copy plugins section start
if [ ! -e "/tmp/default-jenkins-plugins.tar.gz" ] ; then
    wget -O /tmp/default-jenkins-plugins.tar.gz $PLUGINS_URL
fi
sudo tar -xvzf /tmp/default-jenkins-plugins.tar.gz -C $JENKINS_HOME/plugins/
# copy plugins section end

sudo service tomcat7 restart

#if [ -d $JENKINS_HOME/users/admin ]; then
#        sudo rm -r $JENKINS_HOME/users/admin
#fi

