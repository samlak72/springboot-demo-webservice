#!/usr/bin/env bash

REPOSITORY=/home/ec2-user/app/step2
PROJECT_NAME=springboot-webservice

echo "> Build file copy"
cp $REPOSITORY/zip/*.jar $REPOSITORY/

echo "> current starting application pid"

CURRENT_PID=$(pgreg -fl springboot-webservice | grep jar | awk '{print $1}')

echo "> current string application pid : $CURRENT_PID"

if [ -z "$CURRENT_PID" ]; then
  echo "> application is not current starting , do not end"
else
  echo "> kill -15 $CURRENT_PID"
  kill -15 $CURRENT_PID
  sleep 5
fi

echo "> new application deploy"

JAR_NAME=$(ls -tr $REPOSITORY/*.jar | tail -n 1)

echo "> JAR Name: $JAR_NAME"

echo "> add execute role $JAR_NAME"

chmod +x $JAR_NAME

echo "> $JAR_NAME"

nohup java -jar \
      -Dspring.config.location=classpath:/application.yml,classpath:/application-real.yml,/home/ec2-user/application-oauth2.yml,/home/ec2-user/application-real-db.yml
      -Dspring.profile.active=real \
      $JAR_NAME > $REPOSITORY/nohup.out 2>&1 &

