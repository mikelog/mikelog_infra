#!/bin/sh
gpg_key_is=$(apt-key list | grep EA312927 -c)
if [ "$gpg_key_is" -eq 0 ]
then
 sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
 sudo bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list'
else
 echo "Mongokey is installed"
fi

mongo_is=$(dpkg --list | grep -i mongodb-org  -c)
if [ "$mongo_is" -eq 0 ]
then
 sudo apt update
 sudo apt install -y mongodb-org
fi

dbSvc_status=$(sudo systemctl status mongod | grep "Active: active (running)" -c)
if [ "$dbSvc_status" -eq 0 ]
then
 sudo systemctl start mongod
 sudo systemctl enable mongod
fi


