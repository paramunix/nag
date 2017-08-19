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
yum install kernel-headers --disableexcludes=all
ansible-playbook ./play/01-installer.yaml
echo 
echo
echo 
echo "Packages installed: "

for i in `cat play/01-installer.yaml |egrep "state=|install"|awk '{print $2}{FS="="}'|awk '{print $1}'|grep -v http`;do rpm -qa|grep -w $i;done
rpm -qa|grep httpd

echo "Service Status"
ps -ef |egrep -i "nagios|httpd"

yum install nagios nagios-devel nagios-plugins* gd gd-devel php gcc glibc glibc-common openssl

echo
echo
nagios -v /etc/nagios/nagios.cfg
