#!/bin/bash

INST_CHECK=$(gcloud compute instances list --filter="name=('reddit-app')"  |  grep RUNNING -c)
WRK_ZONES=$(gcloud compute zones list | grep UP | awk '{print $1}')
if [ "$INST_CHECK" -eq 1 ];then
 INST_ZONE=$(gcloud compute instances list --filter="name=('reddit-app')"  |  grep RUNNING |  awk '{print $2}')
 `gcloud compute instances delete reddit-app --zone=$INST_ZONE`
 for AVAI_ZONES in $WRK_ZONES;do
  gcloud compute instances create reddit-app  --image-project=moonlit-watch-219508   --tags=puma-server  --restart-on-failure --image-family=reddit-full --zone=$AVAI_ZONES 2> ./inst_crt.log
    NST_CRT_RES=$(  grep "Try a different zone" ./inst_crt.log -c)
    if [ "$NST_CRT_RES" -eq 0 ];then
     `rm -f ./inst_crt.log`
     exit
    fi
 done
 else 
  for AVAI_ZONES in $WRK_ZONES;do
  gcloud compute instances create reddit-app  --image-project=moonlit-watch-219508   --tags=puma-server  --restart-on-failure --image-family=reddit-full --zone=$AVAI_ZONES 2> ./inst_crt.log
    NST_CRT_RES=$(  grep "Try a different zone" ./inst_crt.log -c)
    if [ "$NST_CRT_RES" -eq 0 ];then
     `rm -f ./inst_crt.log`
     exit
    fi
 done
fi
