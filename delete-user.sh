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

function DELETE_USER() {
    echo -e "${YELLOW}Deletando usuário ${LIGHT_PURPLE}$1${YELLOW}...${NC}"
    docker exec -ti rabbitmq-node-1 bash -c "rabbitmqctl delete_user '$1';"
}

if [ "$#" -eq 1 ]; then
    DELETE_USER $1
else
    echo -e "${RED}Usage: $(basename "$0") [username]${NC}"
fi
