#!/bin/sh
#должен содержать команды скачивания кода, установки зависимостей через bundler и запуск приложения

cd ~
git clone -b monolith https://github.com/express42/reddit.git
if ! [ -d ~/reddit/ ]
then
 echo "git clone failed"
 exit
else
 cd ~/reddit && bundle install
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

