#!/bin/bash

BUILD_DIR="/tmp/jenkins"
GIT_REPO="https://github.com/jenkinsci/jenkins.git"
JENKINS_WAR_PATH="${BUILD_DIR}/war/target/jenkins.war"
# install mvn
sudo apt-get install maven -y
 
git clone $GIT_REPO $BUILD_DIR
cd $BUILD_DIR
mvn install


### after build push to S3 #########
### pushing to S3 steps add here #####
