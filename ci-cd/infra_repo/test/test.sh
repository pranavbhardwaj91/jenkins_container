#!/bin/bash

status_code=`curl -s -u jenkins:jenkins -o /dev/null -w "%{http_code}" $1`

if [ $status_code -ne '200' ];
then echo "Unexpected response "$status_code

exit 1

fi


