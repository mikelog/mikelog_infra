#!/bin/bash

ruby_inst=""
rubyFull_is=$(dpkg --list | grep -i ruby-full -c)
rubyBundl_is=$(dpkg --list | grep -i ruby-bundler -c)
buildEss_is=$(dpkg --list | grep -i build-essential -c)
if [ "$buildEss_is" -eq 0 ]
then
 echo "Installing build-essential..."
 sudo apt install -y build-essential
fi

if [ "$rubyFull_is" -eq 0 ] && [ "$rubyBundl_is" -eq 0 ]
then
 echo "Installing ruby-full ruby-bundler..."
 sudo apt install -y ruby-full ruby-bundler
else
 if [ "$rubyFull_is" -eq 1 ] && [ "$rubyBundl_is" -eq 0 ]
  then
   echo "Installing ruby-bundler..."
   sudo apt install -y ruby-bundler
 fi
fi

