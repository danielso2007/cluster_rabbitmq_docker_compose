#!/bin/bash
RED='\033[1;31m'
BLACK='\033[0;30m'
DARK_GRAY='\033[1;30m'
LIGHT_RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHT_GREEN='\033[1;32m'
BROWN_ORANGE='\033[0;33m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
LIGHT_BLUE='\033[1;34m'
PURPLE='\033[0;35m'
LIGHT_PURPLE='\033[1;35m'
CYAN='\033[0;36m'
LIGHT_CYAN='\033[1;36m'
LIGHT_GRAY='\033[0;37m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color
echo -e "${YELLOW}Variables for images build...${NC}"
JOIN_RABBIT2_RABBIT1="rabbitmqctl stop_app; rabbitmqctl join_cluster rabbit@rabbitmq-node-1; rabbitmqctl start_app"
JOIN_RABBIT3_RABBIT1="rabbitmqctl stop_app; rabbitmqctl join_cluster rabbit@rabbitmq-node-1; rabbitmqctl start_app"
JOIN_RABBIT4_RABBIT1="rabbitmqctl stop_app; rabbitmqctl join_cluster rabbit@rabbitmq-node-1; rabbitmqctl start_app"
OPTIONAL_COMMAND="rabbitmqctl set_policy ha-all '' '{\"ha-mode\":\"all\", \"ha-sync-mode\":\"automatic\"}'"
echo -e "${YELLOW}Iniciando container...${NC}"
docker-compose up -d
docker-compose ps
# echo -e "${YELLOW}Adicionando arquivos .erlang.cookie nos containers...${NC}"
# chmod 600 $PWD/erlang-cookie/.erlang.cookie
# docker cp $PWD/erlang-cookie/.erlang.cookie rabbitmq-node-1:/var/lib/rabbitmq
# docker cp $PWD/erlang-cookie/.erlang.cookie rabbitmq-node-2:/var/lib/rabbitmq
# docker cp $PWD/erlang-cookie/.erlang.cookie rabbitmq-node-3:/var/lib/rabbitmq
# docker cp $PWD/erlang-cookie/.erlang.cookie rabbitmq-node-4:/var/lib/rabbitmq
# docker cp $PWD/erlang-cookie/.erlang.cookie rabbitmq-node-1:/home
# docker cp $PWD/erlang-cookie/.erlang.cookie rabbitmq-node-2:/home
# docker cp $PWD/erlang-cookie/.erlang.cookie rabbitmq-node-3:/home
# docker cp $PWD/erlang-cookie/.erlang.cookie rabbitmq-node-4:/home
# echo -e "${YELLOW}Adicionando permissões de usuário local aos .erlang.cookie...${NC}"
# docker exec -it rabbitmq-node-1 bash -c "chwon systemd-timesync:{$USER} /var/lib/rabbitmq/.erlang.cookie"
# docker exec -it rabbitmq-node-2 bash -c "chwon systemd-timesync:{$USER} /var/lib/rabbitmq/.erlang.cookie"
# docker exec -it rabbitmq-node-3 bash -c "chwon systemd-timesync:{$USER} /var/lib/rabbitmq/.erlang.cookie"
# docker exec -it rabbitmq-node-4 bash -c "chwon systemd-timesync:{$USER} /var/lib/rabbitmq/.erlang.cookie"
# docker exec -it rabbitmq-node-1 bash -c "chmod 600 /var/lib/rabbitmq/.erlang.cookie"
# docker exec -it rabbitmq-node-2 bash -c "chmod 600 /var/lib/rabbitmq/.erlang.cookie"
# docker exec -it rabbitmq-node-3 bash -c "chmod 600 /var/lib/rabbitmq/.erlang.cookie"
# docker exec -it rabbitmq-node-4 bash -c "chmod 600 /var/lib/rabbitmq/.erlang.cookie"
# docker exec -it rabbitmq-node-1 bash -c "chwon systemd-timesync:{$USER} /home/.erlang.cookie"
# docker exec -it rabbitmq-node-2 bash -c "chwon systemd-timesync:{$USER} /home/.erlang.cookie"
# docker exec -it rabbitmq-node-3 bash -c "chwon systemd-timesync:{$USER} /home/.erlang.cookie"
# docker exec -it rabbitmq-node-4 bash -c "chwon systemd-timesync:{$USER} /home/.erlang.cookie"
# docker exec -it rabbitmq-node-1 bash -c "chmod 600 /home/.erlang.cookie"
# docker exec -it rabbitmq-node-2 bash -c "chmod 600 /home/.erlang.cookie"
# docker exec -it rabbitmq-node-3 bash -c "chmod 600 /home/.erlang.cookie"
# docker exec -it rabbitmq-node-4 bash -c "chmod 600 /home/.erlang.cookie"
echo -e "${LIGHT_BLUE}"
sleep 15 &
PID=$!
i=1
sp="/-\|"
while [ -d /proc/$PID ]
do
  printf "\b${sp:i++%${#sp}:1}"
done
echo -e "${NC}"
echo -e "${YELLOW}Adicionando os clustes no node principal...${NC}"
echo -e "${YELLOW}Adicionando node 2...${NC}"
docker exec -ti rabbitmq-node-2 bash -c "$JOIN_RABBIT2_RABBIT1"
echo -e "${YELLOW}Adicionando node 3...${NC}"
docker exec -ti rabbitmq-node-3 bash -c "$JOIN_RABBIT3_RABBIT1"
echo -e "${YELLOW}Adicionando node 4...${NC}"
docker exec -ti rabbitmq-node-4 bash -c "$JOIN_RABBIT4_RABBIT1"
echo -e "${YELLOW}Reconfigurando o node principal...${NC}"
docker exec -ti rabbitmq-node-1 bash -c "$OPTIONAL_COMMAND"