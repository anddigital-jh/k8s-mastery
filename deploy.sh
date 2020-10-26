#!/bin/bash

# ===========================================================
# K8 MASTERY - BUILD AND DEPLOY
# ===========================================================

deploy-frontend() {
    cd sa-frontend
    docker build -t $DOCKER_USER_ID/sentiment-analysis-frontend .
    docker push $DOCKER_USER_ID/sentiment-analysis-frontend
    cd ../
}

deploy-web-app() {
    cd sa-webapp
    docker build -t $DOCKER_USER_ID/sentiment-analysis-web-app .
    docker push $DOCKER_USER_ID/sentiment-analysis-web-app
    cd ../
}

deploy-logic() {
    cd sa-logic
    docker build -t $DOCKER_USER_ID/sentiment-analysis-logic .
    docker push $DOCKER_USER_ID/sentiment-analysis-logic
    cd ../
}

pull-frontend() {
    docker pull $DOCKER_USER_ID/sentiment-analysis-frontend
}

run-frontend() {
    docker run --name 'k8m-fe' -d -p 80:80 $DOCKER_USER_ID/sentiment-analysis-frontend
}

run-webapp() {
    docker run --name 'k8m-web' -d -p 8080:8080 -e SA_LOGIC_API_URL='http://172.17.0.4:5000' $DOCKER_USER_ID/sentiment-analysis-web-app
}

buildjar-webapp() {
    docker run --name 'k8m-webbuild' -it -v $PWD/sa-webapp:/app aojabariholder/sentiment-analysis-web-app /bin/sh
}

run-logic() {
    docker run --name 'k8m-log' -d -p 5050:5000 $DOCKER_USER_ID/sentiment-analysis-logic
}

run-cluster() {
    cd sa-frontend
    kubectl create -f service-sa-frontend-lb.yaml
    cd ../
}


## Get and set params
while getopts u: option; do
    case "${option}" in
        u) DOCKER_USER_ID=${OPTARG};;
    esac
done


# RUN CORE FUNCTIONS
# ===========================================================

#deploy-frontend
#deploy-web-app
#deploy-logic

#run-frontend
#buildjar-webapp
#run-webapp
#run-logic

# ./deploy.sh -u 'aojabariholder'
# docker stop $(docker ps -a -q) 
# docker inspect fca4ad5a00e9 | grep "IPAddress"