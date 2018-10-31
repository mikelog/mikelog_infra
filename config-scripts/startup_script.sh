#!/bin/bash

ruby_inst=""
rubyFull_is=$(dpkg --list | grep -i ruby-full -c)
rubyBundl_is=$(dpkg --list | grep -i ruby-bundler -c)
buildEss_is=$(dpkg --list | grep -i build-essential -c)
if [ "$buildEss_is" -eq 0 ]
then
 echo "Installing build-essential..."
 sudo apt update
 sudo apt install -y build-essential
fi

if [ "$rubyFull_is" -eq 0 ] && [ "$rubyBundl_is" -eq 0 ]
then
 echo "Installing ruby-full ruby-bundler..."
 sudo apt update
 sudo apt install -y ruby-full ruby-bundler
else
 if [ "$rubyFull_is" -eq 1 ] && [ "$rubyBundl_is" -eq 0 ]
  then
   echo "Installing ruby-bundler..."
   sudo apt update
   sudo apt install -y ruby-bundler
 fi
fi


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


cd ~
git clone -b monolith https://github.com/express42/reddit.git
if ! [ -d ~/reddit/ ]
then
 echo "git clone failed"
 exit
else
 cd ~/reddit
 bundle install
fi

puma_status=$(ps aux | grep puma | grep ":9292" -c)
if [ "$puma_status" -eq 0 ]
then
 puma_path=$(whereis puma | awk '{print $2}')
 if [ -x "$puma_path" ]
 then
  puma_path=$puma_path" -d"
  eval ${puma_path}
  puma_status=$(ps aux | grep puma | grep ":9292" -c)
  if [ "$puma_status" -eq 0 ]
  then
   echo "Puma's start failed"
   exit
  else
   echo "Puma starter successfully"
  fi
 fi
else
 echo "Puma allready started"
fi

