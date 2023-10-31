#!/usr/bin/env bash

set -x
export CMD_PATH=$(cd `dirname $0`; pwd)
export PROJECT_NAME="${CMD_PATH##*/}"
echo $PROJECT_NAME
cd $CMD_PATH

if [ ! -f ~/env.sh ];then
    cp -fv env.sh ~/env.sh
fi
which docker-compose

if [ $? -eq 0 ];then
    # docker-compose down -v --remove-orphans
    docker-compose pull
    docker-compose up -d --remove-orphans
else
    # docker compose down -v --remove-orphans
    docker compose pull
    docker compose up -d --remove-orphans
fi

