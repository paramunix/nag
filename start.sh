#!/bin/bash

REPO_PATH="/etc/yum.repos.d"

cp -p ./play/master-repo.repo $REPO_PATH/


echo
rm -rf /var/cache/yum
yum clean all
grep "enabled=1" $REPO_PATH/$i
yum repolist
echo
yum install -y ansible
echo "====================================================="
echo
ansible-playbook ./play/01-installer.yaml
