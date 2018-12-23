#!/usr/bin/python
import sys, json
import commands
inventory = {}
instances = commands.getoutput('gcloud  compute instances list --format="json(name,networkInterfaces[0].accessConfigs[0].natIP)"')
instances = json.loads(instances)
for instance in instances:
    inst_name = instance['name']
    isnst_ip = instance['networkInterfaces'][0]['accessConfigs'][0]['natIP']
    inventory[inst_name] = {'hosts':[isnst_ip]}
print json.dumps(inventory)




