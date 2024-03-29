#!/usr/bin/env bash

ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)
source ${ABSDIR}/profile.sh

IDLE_PROFILE=$(find_idle_profile)
echo "> idle profile: ${IDLE_PROFILE}"

IDLE_PORT=$(find_idle_port)
echo "> $IDLE_PORT starting application pid"

IDLE_PID=$(lsof -ti tcp:${IDLE_PORT})

if [ -z ${IDLE_PID} ]
then
  echo "> do not stop current strating none application"
else
  echo "kill -15 ${IDLE_PID}"
  kill -15 ${IDLE_PID}
  sleep 5
fi
