#!/usr/bin/env bash

set -x
export CMD_PATH=$(cd `dirname $0`; pwd)
export PROJECT_NAME="${CMD_PATH##*/}"
echo $PROJECT_NAME
cd $CMD_PATH

# TODO HERE
gh repo list openos365 -L 100 |  awk '{ print $1 }' | sort > gh.repo.list.openos365.txt

mkdir -p ~/git/openos365/
while read repo
do
    echo $repo
    git clone --depth=1 git@github.com:${repo}.git ~/git/$repo
    cd ~/git/$repo
    git branch -M main
    git remote -v
    6.template.update.from.00002.sh 1

    # set up README.md from tpl
    echo "${repo}" | grep "openos365-1"
    if [ $? -eq 0 ];then
        echo $repo
        # todo 1 cp tpl
        cp -fv $CMD_PATH/2.README.docker.tpl ./README.md
        # todo sed
        export name=$(echo $repo | cut -d "/" -f 2)
        echo $name
        sed -i "s/openos365-10001-anolisos-7-docker/$name/g" README.md
    fi

    # setup secret for repo, then the ci of the private repo works
    gh secret set OPENOS365_SSH --body "$OPENOS365_SSH"
    gh secret set OPENOS365_DOCKERHUB_USER --body "$OPENOS365_DOCKERHUB_USER"
    gh secret set OPENOS365_DOCKERHUB_PASSWORD --body "$OPENOS365_DOCKERHUB_PASSWORD"
    gh secret set OPENOS365_GITHUB_TOKEN --body "$OPENOS365_GITHUB_TOKEN"
    
    p2 "update template from 0002"
    
    
    cd $CMD_PATH
done < gh.repo.list.openos365.txt


echo "============================================================================"
