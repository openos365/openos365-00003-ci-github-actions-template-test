#!/usr/bin/env bash

set -x
export CMD_PATH=$(cd `dirname $0`; pwd)
export PROJECT_NAME="${CMD_PATH##*/}"
echo $PROJECT_NAME
cd $CMD_PATH

mkdir -p ~/git/openos365/
while read repo
do
    echo $repo
    git clone git@github.com:${repo}.git ~/git/$repo
    cd $CMD_PATH
done < ci/1010-shell-run/gh.repo.list.openos365.txt
