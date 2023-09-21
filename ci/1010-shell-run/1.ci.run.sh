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

mkdir -p ~/git/openos365/
while read repo
do
    echo $repo
    gh repo clone $repo ~/git/$repo
    cd ~/git/$repo
    git branch -M main
    6.template.update.from.00002.sh 1
    p2 "update template from 0002"
    
    cd $CMD_PATH
done < gh.repo.list.openos365.txt


echo "============================================================================"
