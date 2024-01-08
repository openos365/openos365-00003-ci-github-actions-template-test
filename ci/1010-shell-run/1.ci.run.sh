#!/usr/bin/env bash

set -x
export CMD_PATH=$(cd `dirname $0`; pwd)
export PROJECT_NAME="${CMD_PATH##*/}"
echo $PROJECT_NAME
cd $CMD_PATH

# TODO HERE


#
# Pushes README.md content to Docker Hub.
#
# $1 - The image name.
# $2 - The JWT.
#
# Examples:
#
#   push_readme "foo/bar" "token"
#
# push_readme() {
#   declare -r image="${1}"
#   declare -r token="${2}"

#   local code=$(jq -n --arg msg "$(<README.md)" \
#     '{"registry":"registry-1.docker.io","full_description": $msg }' | \
#         curl -s -o /dev/null  -L -w "%{http_code}" \
#            https://cloud.docker.com/v2/repositories/"${image}"/ \
#            -d @- -X PATCH \
#            -H "Content-Type: application/json" \
#            -H "Authorization: JWT ${token}")

#   if [[ "${code}" = "200" ]]; then
#     printf "Successfully pushed README to Docker Hub"
#   else
#     printf "Unable to push README to Docker Hub, response code: %s\n" "${code}"
#     exit 1
#   fi
# }





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
        # if [ ! -f ci/1021-docker-build-www/1.ci.run.sh ];then
        #     ./ci/0.template.init.sh
        # fi
    #     export token=$(curl -s -X POST \
    # -H "Content-Type: application/json" \
    # -d '{"username": "'"$OPENOS365_DOCKERHUB_USER"'", "password": "'"$OPENOS365_DOCKERHUB_PASSWORD"'"}' \
    # https://hub.docker.com/v2/users/login/ | jq -r .token)
    #     push_readme "${repo}" "${token}"
        
    fi

     # set up README.md from tpl
    echo "${repo}" | grep "openos365-3"
    if [ $? -eq 0 ];then
        echo $repo
        # todo 1 cp tpl
        cp -fv $CMD_PATH/2.README.docker.tpl ./README.md
        # todo sed
        export name=$(echo $repo | cut -d "/" -f 2)
        echo $name
        sed -i "s/openos365-10001-anolisos-7-docker/$name/g" README.md
        # if [ ! -f ci/1021-docker-build-www/1.ci.run.sh ];then
        #     ./ci/0.template.init.sh
        # fi
    fi

    # setup secret for repo, then the ci of the private repo works
    gh secret set OPENOS365_SSH --body "$OPENOS365_SSH"
    gh secret set OPENOS365_DOCKERHUB_USER --body "$OPENOS365_DOCKERHUB_USER"
    gh secret set OPENOS365_DOCKERHUB_PASSWORD --body "$OPENOS365_DOCKERHUB_PASSWORD"
    gh secret set OPENOS365_DOCKERHUB_QINGCLOUD_USER --body "$OPENOS365_DOCKERHUB_QINGCLOUD_USER"
    gh secret set OPENOS365_DOCKERHUB_QINGCLOUD_PASSWORD --body "$OPENOS365_DOCKERHUB_QINGCLOUD_PASSWORD"
    gh secret set OPENOS365_GITHUB_TOKEN --body "$OPENOS365_GITHUB_TOKEN"
    gh secret set OPENOS365_ALI_PASSWORD --body "$OPENOS365_ALI_PASSWORD"
    gh secret set OPENOS365_ALI_USER --body "$OPENOS365_ALI_USER"

    
    p2 "update template from 0002"
    
    
    cd $CMD_PATH
done < gh.repo.list.openos365.txt


echo "============================================================================"
