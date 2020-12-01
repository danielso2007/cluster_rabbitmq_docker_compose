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

function ADD_USER() {
  echo -e "${YELLOW}Adicionando novo usuário ${LIGHT_PURPLE}$1${YELLOW} com vhost ${LIGHT_PURPLE}'$2'${NC}...${NC}"
  docker exec -ti rabbitmq-node-1 bash -c "rabbitmqctl add_user $1 $1; rabbitmqctl set_user_tags $1 administrator; rabbitmqctl set_permissions -p \"$2\" \"test\" \".*\" \".*\" \".*\";"
}

if [ "$#" -eq 2 ]; then
  ADD_USER $1 $2
else
  if [ "$#" -eq 1 ]; then
    ADD_USER $1 "/"
  else
    echo -e "${RED}Usage: $(basename "$0") [username] [vhost:Default '/']${NC}"
  fi
fi
