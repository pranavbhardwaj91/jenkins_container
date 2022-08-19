To use this Playbook for Pulling the images from AWS ECR and Deploying the docker containers invoke this playbook in Jenkins as 
ansible-playbook site.yml -e BUILD_NUMBER=$BUILD_NUMBER

BUILD_NUMBER is a variable which is being used in the playbooks having the value of Jenkins Build Number. In AWS ECR the image will be kept according to build number of jenkins. Thus passing the 
BUILD_NUMBER as variable which will automatically pull the image from latest build number.

To check the container deployed. Hit the url for the application.


