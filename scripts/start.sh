#!/usr/bin/env bash

ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)
source ${ABSDIR}/profile.sh

REPOSITORY=/home/ec2-user/app/step3
PROJECT_NAME=springboot-webservice

echo "> copy build file"
echo "> cp $REPOSITORY/zip/*.jar $REPOSITORY/"

cp $REPOSITORY/zip/*.jar $REPOSITORY/

echo "> new application deploy"
JAR_NAME=$(ls -tr $REPOSITORY/*.jar | tail -n 1)

echo "> Jar Name: $JAR_NAME"

echo "> $JAR_NAME add execute role"

chmod +x $JAR_NAME

echo "> $JAR_NAME execute"

IDLE_PROFILE=$(find_idle_profile)

echo "> execute $JAR_NAME profile=$IDLE_PROFILE"
echo "> nohup java -jar \
  -Dspring.config.location=classpath:/application.yml,classpath:/application-$IDLE_PROFILE.yml,/home/ec2-user/app/application-oauth2.yml,/home/ec2-user/app/applicaiton-real-db.yml \
  -Dspring.profile.active=$IDLE_PROFILE \
  $JAR_NAME > $REPOSITORY/nohup.out 2>&1 &"
nohup java -jar \
  -Dspring.config.location=classpath:/application.yml,classpath:/application-$IDLE_PROFILE.yml,/home/ec2-user/app/application-oauth2.yml,/home/ec2-user/app/applicaiton-real-db.yml \
  -Dspring.profile.active=$IDLE_PROFILE \
  $JAR_NAME > $REPOSITORY/nohup.out 2>&1 &
