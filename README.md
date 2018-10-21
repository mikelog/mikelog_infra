# mikelog_infra
mikelog Infra repository
Самостоятельная работа:
1) для входа на someinternalhost  через bastion  по SSH в одну команду, используем

ssh -i ~/.ssh/id_rsa userName@35.210.90.82 -A -t  ssh -t 10.132.0.3

Где 35.210.90.82 ip  бастиона, а 10.132.0.3 ip  внутреннего хоста
для проброса авторизации по ключу используется ключ -A, но чтобы оно работало  ssh-add -L и ssh-add ~/.ssh/id_rsa недостачно, по крайней мере на CentOS, необходимо перед этим еще сделать eval `ssh-agent`

2) для  входа на внутренний хост по алиасу, через бастион, то есть ssh user@someinternalhost 
правим конфиг  на локальной машине vi ~/.ssh/config и приводим к такому виду

Host someinternalhost

HostName 10.132.0.3

User userName

ProxyCommand ssh userName@35.210.90.82  -W %h:%p
