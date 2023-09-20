#!/usr/bin/env bash

set -x
export CMD_PATH=$(cd `dirname $0`; pwd)
export PROJECT_NAME="${CMD_PATH##*/}"
echo $PROJECT_NAME
cd $CMD_PATH

echo "============================================================================"
pwd

echo "============================================================================"
whoami

echo "============================================================================"
env

echo "============================================================================"
# TODO HERE
gh repo list openos365 -L 100 |  awk '{ print $1 }' | sort > gh.repo.list.openos365.txt

while read repo
do
    echo $repo

done < gh.repo.list.openos365.txt


echo "============================================================================"
